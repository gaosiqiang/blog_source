---
title: ssh免密登入配置
author: 高思强
date: 2019-01-09 11:32:44
comments: true
tags:
- ssh
categories:
- Linux
---

# ssh免密登入配置
#### 创建ssh
`ssh-keygen -t rsa -C “my_email”`
输入文件名:
输入密码:
确认密码:

> 如果不设置文件名,默认是id_rsa,直接回车
如果不设置密码直接回车

**只有执行了ssh-keygen -t rsa才有.ssh文件夹**

#### 免密码登入配置
> 将本地id_rsa.pub中的密匙添加到远程linux的authorized_keys，如果没有就新建该文件

``scp ~/.ssh/id_rsa.pub  root@Linux ip:/root/.ssh/authorized_keys``

**然后ssh登入即可实现免密登入**

#### .ssh/文件说明
|参数|说明|
| :-- | :-- |
|authorized_keys|存放远程免密登录主机的ssh公钥,主要通过这个文件记录多台机器的公钥|
|id_rsa|生成的私钥文件|
|id_rsa.pub|生成的公钥文件|
|know_hosts|已知的主机公钥清单|

- 如果希望ssh公钥生效需满足至少下面两个条件：
> 1) .ssh目录的权限必须是700 
> 2) .ssh/authorized_keys文件权限必须是600



#### linux ssh 别名登录小技巧,适用unix系统族
- 1)创建~/.ssh/config文件并为每台服务器指定登录信息和验证方法：
`vim ~/.ssh/config`
- 2)键入以下内容
```shell
Host www
  HostName 123.56.106.97
  Port 22
  User root
  IdentityFile ~/.ssh/id_rsa 或 ~/.ssh/id_rsa.pub  ?
  IdentitiesOnly yes
 
Host bbs
  HostName 123.56.106.97
  User anotheruser
  PubkeyAuthentication no
 ```

- 3)使用别名ssh登录
```ssh www ```

**选项注释**
|选项|注释|
| :-- | :-- |
|HostName|指定登录的主机名或IP地址|
|Port|指定登录的端口号|
|User|登录用户名|
|IdentityFile|登录的公钥文件|
|IdentitiesOnly|只接受SSH key 登录|
|PubkeyAuthentication|公匙验证|

> ps:执行ssh-add -l 查看是否有ssh公匙