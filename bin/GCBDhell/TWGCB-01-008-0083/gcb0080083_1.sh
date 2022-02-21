# TWGCB-01-008-0083
# ▪  這項原則設定決定是否移除使用者家目錄的「.forward」檔案
# ▪  「.forward」檔案用於設定將使用者郵件轉發到指定的電子郵件信箱
# ▪  移除「.forward」檔案以停用郵件轉發功能，避免機敏資料洩漏
# ▪  若存在「.forward」檔案，則可執行以下指令移除檔案：
# #rm (檔案名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業
# ▪  開啟終端機，執行以下腳本，檢查每個使用者家目錄是否存在「.forward」檔案：
#!/bin/bash
grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
echo ".forward file $dir/.forward exists"
fi
fi
done
