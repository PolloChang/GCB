# TWGCB-01-008-0080
# ▪  這項原則設定決定使用者家目錄擁有者是否為使用者
# ▪  使用者家目錄是系統預設的使用者主目錄，目錄下存放使用者的環境設定與個人檔案
# ▪  設定使用者家目錄為使用者擁有，以確保使用者個人資料安全
# ▪  若出現使用者的家目錄非使用者擁有，則可執行以下指令，變更家目錄擁有者為使用者：
# ▪  #chown (使用者帳號名稱) /home/(使用者帳號名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業

#!/bin/bash
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
owner=$(stat -L -c "%U" "$dir")
if [ "$owner" != "$user" ]; then
echo "The home directory ($dir) of user $user is owned by $owner."
fi
fi
done
