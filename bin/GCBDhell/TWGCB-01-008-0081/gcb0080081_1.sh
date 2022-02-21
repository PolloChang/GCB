# TWGCB-01-008-0081
# ▪  這項原則設定決定使用者家目錄擁有群組是否為使用者群組
# ▪  使用者家目錄是系統預設的使用者主目錄，目錄下存放使用者的環境設定與個人檔案
# ▪  若使用者家目錄擁有群組GID與使用者群組GID不同，將導致其他使用者可存取該使用者的檔案
# ▪  設定使用者家目錄為使用者群組擁有，以確保使用者個人資料安全
# ▪  若出現使用者家目錄非使用者群組所擁有，則可執行以下指令，變更家目錄擁有者為使用者群組：
# #chgrp (使用者群組名稱或GID) /home/(使用者帳號名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業
# ▪  開啟終端機，執行以下腳本，檢查每個使用者家目錄的擁有群組GID：

#!/bin/bash
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $4 " " $6 }' | while read user gid dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
owner=$(stat -L -c "%g" "$dir")
if [ "$owner" != "$gid" ]; then
echo "The home directory ($dir) of group $gid is owned by group $owner."
fi
fi
done
