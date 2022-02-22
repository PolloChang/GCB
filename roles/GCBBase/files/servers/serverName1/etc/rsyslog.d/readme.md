# 查調資料

# TWGCB-01-008-0176

編輯/etc/rsyslog.conf檔案與 /etc/rsyslog.d/目錄下的「.conf」檔案，設定參數「$FileCreateMode」為0640或更低權限，範例如下：
$FileCreateMode 0640

查調完請新增task