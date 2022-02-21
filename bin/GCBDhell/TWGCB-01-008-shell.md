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