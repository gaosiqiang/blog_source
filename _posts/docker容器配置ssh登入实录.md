---
title: docker容器配置ssh登入实录
author: 高思强
date: 2017-11-28 01:25:00
comments: true
tags:
- [docker, 管理]
- [ssh]
categories:
- 运维
---

# docker容器配置ssh登入实录

## 目录
[TOC]

### 准备工作
```code
docker pull centos 下拉镜像
docker run centos:latest /bin/bash 启动容器
```
### 容器内部安装以下依赖
```code
$ sudo yum -y install openssh-server
$ sudo yum -y install openssh-clients
$ /usr/sbin/sshd 启动
$ /usr/sbin/sshd restart 重启
passwd
  新密码
  确认新密码
```

>ps:只有重置密码才能使用（如提示没有passwd这个命令行使用yum install passwd安装）和 ps -aux | grep sshd 查看sshd状态或者netstat -ant |grep 22也可以,ssh默认是端口号是22
#### 完成后重启容器
```code
$ docker run -it -p 5000:22 contos:latest /bin/bash
```
#### ssh连接docker容器
```code
$ ssh -p 5000 root@127.0.0.1
```
### 配置:
修改SSH配置文件以下选项，去掉#注释，将四个选项启用：
```code
$ vi /etc/ssh/sshd_config
```
- RSAAuthentication yes #启用 RSA 认证
- PubkeyAuthentication yes #启用公钥私钥配对认证方式
- AuthorizedKeysFile .ssh/authorized_keys #公钥文件路径（和上面生成的文件同）
- PermitRootLogin yes #root能使用ssh登录

### 实录中常见错误处理:
```code
//容器内启动sshd服务时
$ service sshd restart或者systemctl start sshd
```
>**Q报错**:Failed to get D-Bus connection: Operation not permitted原因是centos7的版本问题
**A解决方案**:docker run 的时候运行/usr/sbin/init 。比如
docker run -tid --name hadoopbase centos/hadoopbase:v001 /usr/sbin/init
- https://github.com/docker/docker/issues/7459 
- https://github.com/docker/docker/issues/2296

```code
//容器内启动sshd服务
$ /usr/sbin/sshd 启动sshd服务
```
>**报错**:Could not load host key: /etc/ssh/ssh_host_rsa_key
Could not load host key: /etc/ssh/ssh_host_ecdsa_key
Could not load host key: /etc/ssh/ssh_host_ed25519_key
sshd: no hostkeys available -- exiting.
**原因**:没有host key
**解决方案**: 依次使用ssh-keygen生产上述不存在的文件

```code
//本地ssh连接docker容器时报错
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
SHA256:1c8m4zKkJ/hwMyEJQ+MFRnBQYssRYhKVhmzrgsSZPd0.
Please contact your system administrator.
Add correct host key in /Users/gaosiqiang/.ssh/known_hosts to get rid of this message.
Offending RSA key in /Users/gaosiqiang/.ssh/known_hosts:43
RSA host key for [127.0.0.1]:5000 has changed and you have requested strict checking.
Host key verification failed.
```
>**解决方案**:
vim ~/.ssh/known_hosts
删除与连接ip相关的数据即可

### 拓展
```code
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
//rsa和dsa是两种不同的加密方式
```