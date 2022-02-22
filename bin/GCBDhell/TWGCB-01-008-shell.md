# TWGCB-01-008-shell

手動執行

## TWGCB-01-008-0119

```shell
grep -Els "^\s*net\.ipv4\.icmp_echo_ignore_broadcasts\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv4\.icmp_echo_ignore_broadcasts\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1; sysctl -w net.ipv4.route.flush=1
```

## TWGCB-01-008-0120

```shell
grep -Els "^\s*net\.ipv4\.icmp_ignore_bogus_error_responses\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv4\.icmp_ignore_bogus_error_responses\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1; sysctl -w net.ipv4.route.flush=1
```

## TWGCB-01-008-0121

```shell
grep -Els "^\s*net\.ipv4\.conf\.all\.rp_filter\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv4\.net.ipv4.conf\.all\.rp_filter\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv4.conf.all.rp_filter=1; sysctl -w net.ipv4.route.flush=1
```

## TWGCB-01-008-0123

```shell
grep -Els "^\s*net\.ipv4\.tcp_syncookies\s*=\s*[02]*" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | while read filename; do sed -ri "s/^\s*(net\.ipv4\.tcp_syncookies\s*)(=)(\s*\S+\b).*$/# *REMOVED* \1/" $filename; done; sysctl -w net.ipv4.tcp_syncookies=1; sysctl -w net.ipv4.route.flush=1
```


## TWGCB-01-008-0131

▪  開啟終端機，執行以下指令，檢查網路介面是否處於混雜模式：

```shell
#ip link | grep -i promisc
```

▪  若發現網路介面處於混雜模式，則執行以下指令，關閉網路介面混雜模式：


```shell
#ip link set dev (網路介面裝置名稱) multicast off promisc off
```

## TWGCB-01-008-0137,TWGCB-01-008-0138

▪  開啟終端機，執行以下指令，尋找稽核日誌檔案：

```shell
grep -iw log_file /etc/audit/auditd.conf
```
▪  執行以下指令，設定稽核日誌檔案權限為600或更低權限：

```shell
chmod 600 (稽核日誌檔案名稱)
```

▪  設定稽核日誌檔案「/var/log/audit/audit.log」之指令範例如下：

```shell
chown root:root /var/log/audit/audit.log
chmod 600 /var/log/audit/audit.log
```

## TWGCB-01-008-0139

▪  開啟終端機，執行以下指令，尋找稽核日誌目錄：

```shell
grep -iw log_file /etc/audit/auditd.conf
```

▪  執行以下指令，設定稽核日誌目錄擁有者與群組：

```shell
chown root:root (稽核日誌目錄名稱)
```

▪  設定稽核日誌目錄「/var/log/audit」之指令範例如下：

```shell
chown root:root /var/log/audit
chmod 600 /var/log/audit
```

## TWGCB-01-008-0206,TWGCB-01-008-0205

* 刪除前請先調查

開啟終端機，執行以下指令，移除/etc/cron.deny與/etc/at.deny，並建立/etc/cron.allow與/etc/at.allow後，設定其權限為600或更低權限：

```shell
rm /etc/cron.deny
rm /etc/at.deny
touch /etc/cron.allow
touch /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow
chmod 600 /etc/cron.allow
chmod 600 /etc/at.allow
```

## TWGCB-01-008-0143

▪  開啟終端機，執行以下指令，檢查稽核工具權限：

```shell
stat -c "%a %n" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audisp-remote /sbin/audisp-syslog /sbin/augenrules
```

▪  若有稽核工具權限高於750，則執行以下指令，設定稽核工具權限為750或更低權限：

```shell
chmod 750 (稽核工具名稱)
```

▪  若有稽核工具擁有者與群組非root，則執行以下指令，設定稽核工具擁有者與群組為root：

```shell
chown root:root (稽核工具名稱)
```

## TWGCB-01-008-0158

▪  開啟終端機，執行以下指令，在系統上所有磁區(partition)，逐一檢查磁區所掛載之檔案目錄(如根目錄)中的特權程式，並為每個特權程序的執行，建立稽核規則：

```shell
find (partition) -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" }'
```

▪  在/etc/audit/rules.d/目錄，新增或編輯「privileged.rules」檔案，將根磁區(root partition)的特權程式稽核規則加入到該檔案，指令範例如下：

```shell
find / -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" }' >> /etc/audit/rules.d/privileged.rules
```

## TWGCB-01-008-0161

▪  開啟終端機，執行指令如下，尋找sudo日誌檔案路徑

```shell
grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//'
```

寫入 ```files/{{ansible_distribution}}{{ansible_distribution_major_version}}/etc/audit/rules.d/actions.rules``` 文件中


## TWGCB-01-008-0176

```
編輯/etc/rsyslog.conf檔案與 /etc/rsyslog.d/目錄下的「.conf」檔案，設定參數「$FileCreateMode」為0640或更低權限，範例如下：
$FileCreateMode 0640
```

查調完請新增task

## TWGCB-01-008-0177

1. 調查

* /etc/rsyslog.d/目錄下的「.conf」檔案
* /etc/rsyslog.conf

2. 新增或修改成以下內容：

```
auth.*,authpriv.* /var/log/secure
daemon.* /var/log/messages
```

## TWGCB-01-008-0189

▪  開啟終端機，執行以下指令，檢查是否有未受限程序在執行：

```shell
ps -eZf | grep unconfined_service_t
```

▪  檢視上一步驟的輸出結果，若有未受限程序在執行，須執行chcon指令，將該程序設定至非「unconfined_service_t」之區域。以將「/usr/sbin/httpd」程序設定至「httpd_exec_t」區域為例，chcon指令範例如下：

```shell
chcon -t httpd_exec_t /usr/sbin/httpd
```

## TWGCB-01-008-0225

1. 調查所有帳號

執行下列

```shell
chage --mindays 1 (使用者帳號名稱)
chage --warndays 14 (使用者帳號名稱)
chage --maxdays 90 (使用者帳號名稱)
chage --inactive 30 (使用者帳號名稱)
```

## TWGCB-01-008-0241

/etc/profile.d/目錄下的「.sh」檔案及/etc/bashrc檔案，新增或修改參數如下：
umask 027

```shell
ll /etc/profile.d/*.sh
```

## TWGCB-01-008-0231

▪  開啟終端機，執行以下指令，尋找「NOPASSWD」或「!authenticate」：

```shell
#egrep -i '(nopasswd|!authenticate)' /etc/sudoers /etc/sudoers.d/*
```

▪  執行「visudo -f」指令編輯/etc/sudoers檔案或 /etc/sudoers.d/目錄下的檔案，針對包含「NOPASSWD」或「!authenticate」的指令行，予以註解(#)或刪除

## TWGCB-01-008-0237

▪  開啟終端機，執行以下指令，設定系統帳號(sync、shutdown及halt帳號除外)不可使用殼層(Shell)登入：

```shell
awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print $1}' /etc/passwd | while read user; do usermod -s $(which nologin) $user; done
```

▪  執行以下指令，鎖定所有非root之系統帳號：

```shell
awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}' | while read user; do usermod -L $user; done
```