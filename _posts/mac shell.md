---
title: mac shell
author: 高思强
date: 2017-11-30 00:37:01
comments: true
tags:
- [mac]
- [shell]
categories:
- 效率
---
# mac shell

## 安装brew
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
## 查看SHELL
>当前系统安装了哪些shell```$ cat /etc/shells```

> 当前正在使用的shell```$ echo $SHELL```

### oh my fish
> 安装```$ brew install fish```

即可使用

- 切换fish shell
```$ chsh -s /usr/local/bin/fish```

### zsh
zsh安装及配置

```
$ git clone git://github.com/robbyrussell/oh-my-zsh.git
$ cp ~/.zshrc ~/.zshrc.orig这个可以跳过不执行,最好是执行
$ cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```

wget安装方式
```
$ wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

mac安装
```
$ brew install zsh
```

安装完成后切换到zsh

```$ chsh -s /bin/zsh```

- 如果无法切换到zsh可能是环境变量的问题,终端执行

```
$ source ~/.zshrc
$ chsh -s /bin/zsh
```
切换回默认shell

```$ chsh -s /bin/bash```

配置zsh时需要修改.zshrc文件
//找到.zshrc文件
//修改theme
$ export ZSH_THEME="afowler"
//更多的themes在.oh-my-zsh/themes中
$ cd ~/
$ cd .oh-my-zsh/themes就到了theme目录
```
> - **中文乱码问题**
编辑 ~/.zshrc在文件内容末端添加:

```
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```
重启终端，或终端执行 ```$ source ~/.zshrc```


- [github](https://github.com/robbyrussell/oh-my-zsh)