# TWGCB-01-008-0087
# ▪  這項原則設定決定是否檢查/etc/passwd檔案的使用者帳號UID(User Identifier，使用者識別碼)皆不相同
# ▪  儘管透過useradd指令新增使用者帳號時，不允許建立重複的UID，但系統管理者可手動編輯/etc/passwd檔案並更改UID，造成UID重複之情形
# ▪  為每個使用者帳號設定唯一的UID，以提供適當的存取防護
# ▪  若有不同帳號使用相同的UID，則編輯/etc/passwd檔案，或執行以下指令，為帳號設定唯一的UID：
# #usermod -u (UID) (帳號名稱)
# ▪  開啟終端機，執行以下腳本，尋找是否有不同帳號使用相同的UID：
#!/bin/bash
cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
[ -z "$x" ] && break
set - $x
if [ $1 -gt 1 ]; then
users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
echo "Duplicate UID ($2): $users"
fi
done
