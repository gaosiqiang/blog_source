---
title: 安装Node.js
author: 高思强
date: 2018-07-03 12:01:16
comments: true
tags:
- node.js
categories:
- 运维
---

# 安装Node.js

**step1**安装Git

| 系统 | 安装 |
| :-- | :-- |
|Linux（Ubuntu，Debian）| sudo apt-get install git-core|
|Linux（Fedora，Red Hat，CentOS）|sudo yum install git-core|
|Mac | 使用Homebrew，MacPorts或安装程序进行安装|
|Windows| [官方文档](https://git-scm.com/download/win) |

**step2安装Node.js**

1)安装gcc
	
	yum install gcc
	yum install gcc-c++

如果gcc版本过低就需要安装指定版本的gcc

2)源码安装Node.js:

1,[下载源码源列表](https://nodejs.org/dist)选择Nodejs版本

	cd /usr/local/src/
	wget https://nodejs.org/dist/v10.13.0/node-v10.13.0.tar.gz

2,解压源码

	tar zxvf node-v10.13.0.tar.gz

3,编译安装

	cd node-v10.13.0
	./configure --prefix=/usr/local/node/v10.13.0
	make && make install

4,配置NODE_HOME，进入profile编辑环境变量

	vim /etc/profile

设置nodejs环境变量，在 **export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL** 一行的上面添加如下内容:

	#set for nodejs
	export NODE_HOME=/usr/local/node/8.11.2
	export PATH=$NODE_HOME/bin:$PATH

:wq保存并退出，编译/etc/profile 使配置生效

	source /etc/profile

5,验证是否安装配置成功

	node -v

输出 v10.13.0 表示配置成功

npm模块安装路径

	/usr/local/node/10.13.0/lib/node_modules/

[参考博客](https://www.runoob.com/nodejs/nodejs-install-setup.html)

> 文档

- [office docment zh-cn](https://nodejs.org/zh-cn/)
- [download page](https://nodejs.org/en/download/)
- [菜鸟 node](http://www.runoob.com/nodejs/nodejs-install-setup.html)

**注：**Nodejs 官网提供了编译好的Linux二进制包，你也可以下载下来直接应用。

3)其他方式安装:

[节点版本管理器](https://github.com/creationix/nvm)安装node.js
nvm的创建者提供了一个自动安装nvm的简单脚本：
cURL: ```$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash```
Wget: ```$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash```
安装nvm后，重新启动终端并运行以下命令来安装Node.js：```$ nvm install stable```

nvm(Node Version Manager) ，nvm是 Nodejs 版本管理器，它让我们方便的对切换Nodejs 版本。
nvm 介绍：[使用 nvm 管理不同版本的 node 与 npm](https://www.runoob.com/w3cnote/nvm-manager-node-versions.html)

关于nvm的详细安装以及使用可以访问以下链接：

- Linux: https://github.com/creationix/nvm
- Windows: https://github.com/coreybutler/nvm-windows

> Q&A

- Q:failed to autodetect C++ compiler version (CXX=g++)
- A: # yum install gcc gcc++ gcc-c++