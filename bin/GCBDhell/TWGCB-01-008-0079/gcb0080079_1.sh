# TWGCB-01-008-0079
# ▪  這項原則設定決定使用者家目錄權限
# ▪  使用者家目錄是系統預設的使用者主目錄，目錄下存放使用者的環境設定與個人檔案，因此任何使用者皆不應具有可寫入其他使用者家目錄的權限
# ▪  使用者家目錄應限制群組不具寫入(g-w)權限，其他使用者不具讀取、寫入及執行(o-rwx)權限，避免遭未經授權存取與竊取資料
# ▪  若出現群組具寫入權限，其他使用者具讀取、寫入及執行權限之家目錄，則可執行以下指令，變更目錄權限為700或更低權限：
# #chmod 700 /home/(使用者帳號名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業
#!/bin/bash
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
dirperm=$(ls -ld $dir | cut -f1 -d" ")
if [ $(echo $dirperm | cut -c6) != "-" ]; then
echo "Group Write permission set on the home directory ($dir) of user
$user"
fi
if [ $(echo $dirperm | cut -c8) != "-" ]; then
echo "Other Read permission set on the home directory ($dir) of user
$user"
fi
if [ $(echo $dirperm | cut -c9) != "-" ]; then
echo "Other Write permission set on the home directory ($dir) of user
$user"
fi
if [ $(echo $dirperm | cut -c10) != "-" ]; then
echo "Other Execute permission set on the home directory ($dir) of user
$user"
fi
fi
done
