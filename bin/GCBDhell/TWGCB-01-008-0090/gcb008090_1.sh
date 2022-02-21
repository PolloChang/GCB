# TWGCB-01-008-0090
# ▪  這項原則設定決定是否檢查/etc/group檔案的群組名稱，並確認每個群組名稱皆不相同
# ▪  儘管透過groupadd指令新增群組時，不允許建立重複的群組名稱，但系統管理者可手動編輯/etc/group檔案並更改群組名稱，造成群組名稱重複之情形
# ▪  為每個群組設定唯一的群組名稱，以提供適當的存取防護
# ▪  若有群組使用相同的群組名稱，則編輯/etc/group檔案，為每個群組設定唯一的群組名稱
# ▪  開啟終端機，執行以下腳本，尋找是否有不同群組使用相同的群組名稱：
#!/bin/bash
cut -d: -f1 /etc/group | sort | uniq -d | while read x
do echo "Duplicate group name ${x} in /etc/group"
done
