# TWGCB-01-008-0086
# ▪  這項原則設定決定是否檢查/etc/passwd檔案設定的群組，是否都存在於/etc/group檔案中
# ▪  在/etc/passwd檔案中，使用者帳號設定的群組，若不存在於/etc/group檔案中，代表群組權限管理不恰當，將可能對系統安全構成威脅
# ▪  若有帳號的群組不存在於/etc/group檔案中，則編輯/etc/passwd檔案，或執行以下指令，修改帳號的群組(GID)：
# #usermod -g (群組名稱或GID) (帳號名稱)
# ▪  開啟終端機，執行以下腳本，檢查/etc/passwd檔案中帳號的群組是否都存在於/etc/group檔案中：
#!/bin/bash
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
grep -q -P "^.*?:[^:]*:$i:" /etc/group
if [ $? -ne 0 ]; then
echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
fi
done
