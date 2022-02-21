# TWGCB-01-008-0084
# ▪  這項原則設定決定是否移除使用者家目錄的「.netrc」檔案
# ▪  「.netrc」檔案包含用於登入遠端FTP主機進行檔案傳輸之帳號與明文密碼，移除「.netrc」檔案以避免對遠端FTP主機造成之風險
# ▪  若存在「.netrc」檔案，則可執行以下指令移除檔案：
# #rm (檔案名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業
# ▪  開啟終端機，執行以下腳本，檢查每個使用者家目錄是否存在「.netrc」檔案：
#!/bin/bash
grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
echo ".netrc file $dir/.netrc exists"
fi
fi
done
