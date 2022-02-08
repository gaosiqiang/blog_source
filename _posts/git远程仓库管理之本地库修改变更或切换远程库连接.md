---
title: git远程仓库管理之本地库修改变更或切换远程库连接
author: 高思强
date: 2020-05-15 17:52:04 
comments: true
tags:
- git
categories:
- 运维
---

# git远程仓库管理之本地库修改变更或切换远程库连接

## Prerequisite先决条件
### demo

- new git url:git@github.com:new_demo/new_demo.git
- old git url:git@github.com:old_demo/old_demo.git
- 远程仓库名称:origin

## Way 1 命令修改远程地址

### 0x01 查看当前远程库
	
	git remote 查看所有远程仓库
	git remote xxx 查看指定远程仓库地址
	git remote -v 查看当前本地库的远程仓库地址

> 显示：git@github.com:old_demo/old_demo.git

### 0x02 设置新远程库，命令：git remote set-url origin url
	
	git remote set-url origin git@github.com:new_demo/new_demo.git

### 0x03 查看当前远程库地址，确认是是否修改成功

	git remote -v
	
> 显示：git@github.com:new_demo/new_demo.git

## Way 2 先删除再添加远程仓库

### 0x01 查看当前远程库
	
	git remote -v 查看当前本地库的远程仓库地址

> 显示：git@github.com:old_demo/old_demo.git

### 0x02 删除当前本地库的远程连接

	git remote rm origin

### 0x03 添加当前本地库的新的远程连接
	
	git remote add origin git@github.com:new_demo/new_demo.git

### 0x04 查看当前远程库地址，确认是是否修改成功

	git remote -v
	
> 显示：git@github.com:new_demo/new_demo.git


## Way 3 修改配置文件config

### 0x01 打开config文件

	vim 本地库目录/.git/config
	
> 内容如下：
	
	[core]
	repositoryformatversion = 0
	filemode = true
	logallrefupdates = true
	precomposeunicode = true
	[remote "origin"]
	url = git@github.com:old_demo/old_demo.git
	fetch = +refs/heads/*:refs/remotes/origin/*
	[branch "master"]
	remote = origin
	merge = refs/heads/master

### 0x02 编辑config文件，修改[remote "origin"]下面的url

> 修改成

	[remote "origin"]
	url = git@github.com:new_demo/new_demo.git

### 0x03 保存修改后，查看是否修改成功

	git remote -v
	
> 显示：git@github.com:new_demo/new_demo.git

## PS
- 以上所有的命令都是在本地git库目录中执行


