# TWGCB-01-008-0085
# ▪  這項原則設定決定是否移除使用者家目錄的「.rhosts」檔案
# ▪  「.rhosts」檔案用於指定那個使用者可以不需要輸入密碼即可執行rsh遠端連線，移除「.rhosts」檔案以避免遭惡意人士取得可攻擊其他遠端主機之資訊
# ▪  若存在「.rhosts」檔案，則可執行以下指令移除檔案：
# #rm (檔案名稱)
# ▪  注意：請先通知使用者再變更家目錄相關設定，以避免影響使用者作業
# ▪  開啟終端機，執行以下腳本，檢查每個使用者家目錄是否存在「.rhosts」檔案：
#!/bin/bash
grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
if [ ! -d "$dir" ]; then
echo "The home directory ($dir) of user $user does not exist."
else
for file in $dir/.rhosts; do
if [ ! -h "$file" -a -f "$file" ]; then
echo ".rhosts file in $dir"
fi
done
fi
done
