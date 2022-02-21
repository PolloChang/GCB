# TWGCB-01-008-0089
# ▪  這項原則設定決定是否檢查/etc/passwd檔案的使用者帳號名稱，並確認每個使用者帳號名稱皆不相同
# ▪  儘管透過useradd指令新增使用者帳號時，不允許建立重複的帳號名稱，但系統管理者可手動編輯/etc/passwd檔案並更改帳號名稱，造成帳號名稱重複之情形
# ▪  為每個使用者帳號設定唯一的名稱，以提供適當的存取防護
# ▪  開啟終端機，執行以下腳本，尋找是否有帳號使用重複的帳號名稱：
#!/bin/bash
cut -d: -f1 /etc/passwd | sort | uniq -d | while read x
do echo "Duplicate login name ${x} in /etc/passwd"
done
