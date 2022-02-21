# TWGCB-01-008-0081
# ▪  這項原則設定決定是否設定使用者家目錄的「.」檔案權限，使用者家目錄的「.」檔案包含使用者的初始化檔案與其他設定檔
# ▪  限制使用者家目錄的「.」檔案寫入權限，以避免惡意人士藉由竊取或修改使
# ▪  若出現具有world-writable或group-writable權限之「.」檔案，則可執行以下指令，移除群組與其他身分之寫入權限或更低權限：
# #chmod go-w (檔案名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業用者資料，進而取得該使用者之系統權限
# ▪  開啟終端機，執行以下腳本，檢查每個使用者家目錄的「.」檔案權限：
#!/bin/bash
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
for file in $dir/.[A-Za-z0-9]*; do
if [ ! -h "$file" -a -f "$file" ]; then
fileperm=$(ls -ld $file | cut -f1 -d" ")
if [ $(echo $fileperm | cut -c6) != "-" ]; then
echo "Group Write permission set on file $file"
fi
if [ $(echo $fileperm | cut -c9) != "-" ]; then
echo "Other Write permission set on file $file"
fi
fi
done
fi
done
