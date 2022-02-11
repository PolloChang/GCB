#!/bin/bash

# 上傳 ssh-keygen

export userName

export sshPort

export check='0'

export apListFile="./configs/apList.txt"

echo "讀取AP清單..."

while read line ; do
    apListL[$listN]="$line"
    listN=$[ $listN + 1 ]
done < $apListFile


echo "Enter the user Name: "  
read userName  

echo "Enter the your ssh Port: "  
read sshPort  

if check=='1'
then
    
    for apListI in ${apListL[@]}
    do
     echo "正在複製"$apListI
        ssh-copy-id  -p $sshPort -i ../.ssh/id_rsa $userName@$apListI 
     echo "複製完成"$apListI
    done
fi
