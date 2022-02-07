---
title: 简易安装Shadowsocks ss服务
author: 
date: 2018-07-02 15:48:04 
comments: true
tags:
- 网络
categories:
- 运维
---

## 1)安装
Debian / Ubuntu:

```shell
apt-get install python-pip
pip install shadowsocks
```

CentOS:

```shell
yum install python-setuptools && easy_install pip
pip install shadowsocks
```

## 2)配置
创建vim /etc/shadowsocks.json文件:

```json
{
    "server":"my_server_ip",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"mypassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

### 配置说明：

| 字段 | 说明 |
| :-- | :-- |
|server |          ss服务监听地址|
|server_port |      ss服务监听端口|
|local_address | 本地的监听地址|
|local_port   |  本地的监听端口|
|password    |   密码|
|timeout     |   超时时间，单位秒|
|method      |   加密方法，默认是aes-256-cfb|
|fast_open    |   使用TCP_FASTOPEN, true / false|
|workers      |     workers数，只支持Unix/Linux系统|

### 配置demo

```code
配置单个ss账号:
{  
    "server":"0.0.0.0",  
    "server_port":8388,  
    "local_address": "127.0.0.1",  
    "local_port":1080,  
    "password":"mypassword",  
    "timeout":300,  
    "method":"aes-256-cfb",  
    "fast_open": false  
}  
配置多个ss账号
{  
    "server":"0.0.0.0",  
    "port_password":{  
     "8381":"pwd1",  # 端口号 : 密码
     "8382":"pwd2",  
     "8383":"pwd3",  
     "8384":"pwd4"  
     },  
    "timeout":300,  
    "method":"aes-256-cfb",  
    "fast_open": false  
}
```

## 3)启动前关闭防火墙:

```code
systemctl stop firewalld.service #停止
systemctl disable firewalld.service #禁用
```

## 4)操作

| 类型 | 执行 |
| :-- | :-- |
|前台启动|ssserver -c /etc/shadowsocks.json|
|后台启动|ssserver -c /etc/shadowsocks.json -d start|
|后台停止|ssserver -c /etc/shadowsocks.json -d stop|

启动ss:

    ssserver -c /etc/shadowsocks.json
    or
    ssserver -p 443 -k password -m rc4-md5

后台运行:

    ssserver -c /etc/shadowsocks.json -d start
    or
    sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start

后台停止:

    ssserver -c /etc/shadowsocks.json -d stop
    or
    sudo ssserver -d stop

检查日志：

    sudo less /var/log/shadowsocks.log


## 5)开机启动
> 编辑rc.local

```code
vi /etc/rc.local  
键入
ssserver -c /etc/shadowsocks.json -d start  
```

## 6)安装shadowsocks客户端
- [Windows](https://github.com/shadowsocks/shadowsocks-windows/releases)
- [Mac OS X](https://github.com/shadowsocks/ShadowsocksX-NG/releases)
- [linux](https://github.com/shadowsocks/shadowsocks-qt5/releases)
- [linux Install wiki](https://github.com/shadowsocks/shadowsocks-qt5/wiki/Installation)
- [iOS for itunes](https://itunes.apple.com/app/apple-store/id1070901416?pt=2305194&ct=shadowsocks.org&mt=8)
- [iOS](https://github.com/shadowsocks/shadowsocks-iOS/releases)
- [Android](https://play.google.com/store/apps/details?id=com.github.shadowsocks)

## wiki:
- [官方文档](https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)
- [客户端下载](https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File)

## 参考
- https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
- https://www.rxblog.xyz/0-1-shadowsocks-start/
- https://blog.csdn.net/wf632856695/article/details/79313258
- https://blog.csdn.net/junbujianwpl/article/details/78639247
- https://blog.csdn.net/chengxuyuanyonghu/article/details/74358289
- https://shadowsocks.blogspot.com/
