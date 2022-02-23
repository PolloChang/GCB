# GCB
政府組態基準(GCB) 

## 常用操作說明

```shell
ansible-playbook -i inventory playbookTest.yml

ansible-playbook --private-key /home/jameschang/Documents/gitContent/jameschang/GCB/.ssh/id_rsa -i inventory playbook.yml
```

## 特殊用法

### 帳號相關

* 更改密碼

```
ansible-playbook -i inventory playbookChangpwd.yml --extra-vars "newpassword=pwd username=username"
```
#### CVE

```shell
ansible-playbook -i inventorys/inventory playbookCVE.yml -kK
```
