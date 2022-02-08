---
title: MacOs ssh
author: 高思强
date: 2020-04-21 03:04:05
comments: true
tags:
- Mac
categories:
- 奇技淫巧
---

# MacOs ssh

## 设备生成及设置ssh

### 生成ssh密匙
- 1此命令将创建以所提供的电子邮件地址为标签的新 SSH 密钥

```
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

> Generating public/private rsa key pair.
```
- 2提示您“Enter a file in which to save the key（输入要保存密钥的文件）”时，按 Enter 键。 这将接受默认文件位置。

```
> Enter a file in which to save the key (/Users/you/.ssh/id_rsa): [Press enter]
```
- 3在提示时输入安全密码。 更多信息请参阅“使用 SSH 密钥密码”。

```
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

### 将 SSH 密钥添加到 ssh-agent
> 将新SSH密钥添加到ssh-agent以管理密钥之前，应检查现有[SSH密钥](https://help.github.com/cn/github/authenticating-to-github/checking-for-existing-ssh-keys)并生成新SSH密钥。将SSH密钥添加到该代理时，应使用默认的macOS ssh-add命令，而不是使用通过[macports](https://www.macports.org/),[homebrew](http://brew.sh/)或某些其他外部来源安装的应用程序。

- 1在后台启动 ssh 代理。

```
$ eval "$(ssh-agent -s)"
> Agent pid 59566
```

- 2如果您使用的是 macOS Sierra 10.12.2 或更高版本，则需要修改（没有config文件，创建config文件）~/.ssh/config 文件以自动将密钥加载到ssh-agent中并在密钥链中存储密码。

```
Host *
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile ~/.ssh/id_rsa
```

```
Host www 别名
	HostName xxx.xx.xx.xxx 指定登录的主机名或IP地址
	Port 22 指定登录的端口号
	User root 登录用户名
	IdentityFile ~/.ssh/id_rsa 登录的私钥文件
	IdentitiesOnly yes 只接受SSH key 登录
	PubkeyAcceptedKeyTypes=+ssh-dss 接受的密钥类型
	# 代理
	AddKeysToAgent yes 向代理添加密钥
	UseKeychain yes 使用钥匙链
```
> IdentityFile和IdentitiesOnly至少设置一个，PubkeyAcceptedKeyTypes可以不设置，AddKeysToAgent和UseKeychain可以不设置

- 3将 SSH 私钥添加到 ssh-agent 并将密码存储在密钥链中。 如果您创建了不同名称的密钥，或者您要添加不同名称的现有密钥，请将命令中的 id_rsa 替换为您的私钥文件的名称。

```
$ ssh-add -K ~/.ssh/id_rsa
```
> 注：-K 选项位于 Apple 的 ssh-add 标准版本中，当您将 ssh 密钥添加到 ssh-agent 时，它会将密码存储在您的密钥链中。

> 如果您没有安装 Apple 的标准版本，可能会收到错误消息。 有关解决此错误的详细信息，请参阅“[错误：ssh-add：非法选项 -- K](https://help.github.com/cn/articles/error-ssh-add-illegal-option-k)”。

### 连接设备设置

- 1创建.ssh/authorized_keys文件
- 2获取连接设备的ssh公钥
`cat ~/.ssh/id_rsa.pub`	
- 3复制公钥添加到authorized_keys文件中


### 引用
https://help.github.com/cn/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

## Mac ssh问题
### Mac升级后ssh失效
#### 方案
如上所示重新设置ssh，因为系统升级后macOS Sierra 10.12.2 或更高版本要求ssh私钥长度大于2048所以重新设置ssh，或者在config配置选项中增量`PubkeyAcceptedKeyTypes=+ssh-dss`选项
#### 引用
- [mac ssh 免密登录 无效](https://www.google.com/search?newwindow=1&sxsrf=ALeKk01BDPp8N3PHLbm16Ihuuzqj2s6MbQ%3A1584479731124&source=hp&ei=8z1xXtakBazFmAWZj7rwAg&q=mac+ssh+%E5%85%8D%E5%AF%86%E7%99%BB%E5%BD%95+%E6%97%A0%E6%95%88&oq=mac+ssh+%E5%85%8D%E5%AF%86%E7%99%BB%E5%BD%95+%E6%97%A0%E6%95%88&gs_l=psy-ab.3...41.15622..15757...9.0..0.181.2644.1j21......0....1..gws-wiz.......35i39j0j0i12j0i67j0i30j0i333.OlVnNi7k75g&ved=0ahUKEwiW6pn8tqLoAhWsIqYKHZmHDi4Q4dUDCAY&uact=5)
- [ssh免密登陆配置无效排查过程记录](https://www.jianshu.com/p/274e6320daf2)
- [解决SSH免密登录配置成功后不生效问题](https://blog.csdn.net/lisongjia123/article/details/78513244)
- [mac ssh log](https://superuser.com/questions/838352/log-file-for-ssh-attempts)
- [mac 升级后 ssh 无效](https://www.google.com/search?q=mac+%E5%8D%87%E7%BA%A7%E5%90%8E+ssh+%E6%97%A0%E6%95%88&oq=mac+%E5%8D%87%E7%BA%A7%E5%90%8E+ssh+%E6%97%A0%E6%95%88&aqs=chrome..69i57.8264j0j7&sourceid=chrome&ie=UTF-8)
- [Mac升级到Sierra后SSH自动登录提示输入密码](http://linyehui.me/2016/10/09/unable-to-ssh-without-password-after-updating-sierra/)
- [苹果系统升级到sierra后，ssh远程证书免密码登录出错了](https://www.oschina.net/question/1262012_2199479)
- [解决MacOS Sierra 升级后原有的ssh private key无法通过验证](https://javasgl.github.io/MacOS-Sierra-ssh-config/)
- [ssh-add -l](https://www.google.com/search?q=ssh-add+-l&oq=ssh-add+-l&aqs=chrome..69i57.342j0j7&sourceid=chrome&ie=UTF-8)
- [如何将SSH私钥永久添加到“钥匙串”中，以便ssh自动可用？](https://qastack.cn/apple/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically-available-to-ssh)
- [Mac 上 ssh-add 永久将私钥](https://bin.zmide.com/?p=165)
- https://segmentfault.com/q/1010000000835302