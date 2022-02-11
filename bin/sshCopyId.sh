#!/bin/bash

# 上傳 ssh-keygen

export userName

export check='0'

export apListFile="./configs/apList.txt"

echo "讀取AP清單..."

cat $apListFile

while read line ; do
    apListL[$listN]="$line"
    listN=$[ $listN + 1 ]
done < $apListFile

while getopts u: arg
do
    case $arg in
        u) #user
            userName="$OPTARG"
            check='1'
            ;;
    esac
done

if check=='1'
then
    echo "$userName"
    
    for apListI in ${apListL[@]}
    do
     echo "正在複製"$apListI

        ssh-copy-id -i ../.ssh/id_rsa $userName@$apListI
     echo "複製完成"$apListI
    done
fi
