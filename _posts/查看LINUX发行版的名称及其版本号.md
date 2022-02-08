---
title: 查看LINUX发行版的名称及其版本号
author: 高思强
date: 2020-03-04 13:18:21
comments: true
tags:
- Linux
categories:
- Linux
---

### 查看LINUX发行版的名称及其版本号

#### 一、查看Linux内核版本命令（两种方法）：
- 1、cat /proc/version

```
[root@localhost ~]# cat /proc/version
Linux version 3.10.0-1062.1.2.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-39) (GCC) ) #1 SMP Mon Sep 30 14:19:46 UTC 2019
```

- 2、uname -a

```
[root@localhost ~]# uname -a
Linux localhost.localdomain 3.10.0-1062.1.2.el7.x86_64 #1 SMP Mon Sep 30 14:19:46 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```

#### 二、查看Linux系统版本的命令（3种方法）：
- 1、lsb_release -a，即列出完整的版本信息：

```
[root@localhost ~]# lsb_release -a
LSB Version:	:core-4.1-amd64:core-4.1-noarch
Distributor ID:	CentOS
Description:	CentOS Linux release 7.7.1908 (Core)
Release:	7.7.1908
Codename:	Core
```

> 上面的命令适用于所有的Linux发行版，包括Redhat、SuSE、Debian…等发行版

- 2、cat /etc/redhat-release，该命令只适合于Redhat系的Linux：

```
[root@localhost ~]# cat /etc/redhat-release
CentOS Linux release 7.7.1908 (Core)
```

- 3、cat /etc/issue，该命令适用于所有的Linux发行版。

```
[root@localhost ~]# cat /etc/issue
CentOS release 6.7 (Final)
Kernel \r on an \m
```