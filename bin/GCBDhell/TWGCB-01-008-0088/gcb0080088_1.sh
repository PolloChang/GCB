# TWGCB-01-008-0088
# ▪  這項原則設定決定是否檢查/etc/group檔案的群組GID(Group Identifier，群組識別碼)皆不相同
# ▪  儘管透過groupadd指令新增群組時，不允許建立重複的GID，但系統管理者可手動編輯/etc/group檔案並更改GID，造成GID重複之情形
# ▪  為每個群組設定唯一的GID，以提供適當的存取防護
# ▪  若有不同群組使用相同GID，則編輯/etc/group檔案，或執行以下指令，為群組設定唯一的GID：
# #groupmod -g (GID) (群組名稱)
# ▪  開啟終端機，執行以下腳本，尋找是否有群組使用相同的GID：
#!/bin/bash
cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
echo "Duplicate GID ($x) in /etc/group"
done
