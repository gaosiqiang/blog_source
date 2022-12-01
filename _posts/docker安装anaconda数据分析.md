---
title: docker安装anaconda数据分析
author: 高思强
date: 2018-04-23 19:22:26
comments: true
tags:
- [docker]
- [anaconda]
categories:
- 运维
---
# docker安装anaconda数据分析

## docker
### 安装docker
- mac:[下载](https://www.docker.com/community-edition#/mac)安装包
- centos:```# yum install docker-io```
- ubuntu:```# sudo apt-get remove docker docker-engine docker.io```
### docker运行容器
- ```# docker run -it -p 宿主机端口:容器应用端口 centos:latest /bin/bash```
### docker容器转镜像
- ```# sudo docker commit -m "镜像说明" -a “你的用户名" 容器id 镜像名:标签```

> 以下操作是在容器内进行
## 安装anaconda
```
# wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.1.0-Linux-x86_64.sh
# bash Anaconda3-5.1.0-Linux-x86_64.sh
```
提示输入 yes
最后
```
# source ~/.bashrc
# conda -V
```
安装完成
更新anaconda
```# conda upgrade --all```
安装包
```# conda install 包名```

更换国内源
```
# conda config --add channels - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
# conda config --add channels - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
# conda config --set show_channel_urls yes
```

## 安装jupyter notebook
```# conda install jupyter notebook```
启动jupyter
```# jupyter notebook```

## jupyter配置文件
1、生成jupyter配置文件
```
# jupyter notebook --generate-config
Writing default config to: /root/.jupyter/jupyter_notebook_config.py
```

2、默认路径
```# vi ~/.jupyter/jupyter_notebook_config.py```

3、说明
```
c.NotebookApp.ip='*' # 设置所有ip皆可访问，设置远程访问jupyter
c.NotebookApp.password = u'sha1:密匙字符' # 
c.NotebookApp.open_browser = False # 禁止自动打开浏览器，默认False即启动后不调用浏览器
c.NotebookApp.port = 8888 #指定一个端口
c.NotebookApp.notebook_dir = '/data/python/jupyter' # 设置存储路径
c.NotebookApp.allow_root =True # 允许root运行
c.NotebookApp.allow_remote_access = True  # 允许远程登入
```

## 设置jupter密码
### 通过jupter设置密码
```
# jupyter notebook password
```
输入密码并再次确认密码一致

```
enter password:
verify password:
```

### 通过ipython设置密码
1、安装ipython
python默认有交互解释执行器,但是ipython解释执行器更加强大

> Tab 键补充完整
> **?**：关于对象的详细信息
> **!**：执行系统 shell 命令
> 语法突出显示

```# conda install ipython```
使用ipython
```# ipython 进入python shell交互```


2、使用ipython生成密码
```
# ipython //进入ipython交互模式
# In [1]: from notebook.auth import passwd
# In [2]: passwd()

Enter password: 
Verify password: 
Out[2]: 'sha1:d93397e8cfba:d93d88814530642f44233b72110621aef924bdd7'
```

3、修改默认配置文件
```# vi ~/.jupyter/jupyter_notebook_config.py```
如下修改
```
c.NotebookApp.ip='*' # 设置所有ip皆可访问
c.NotebookApp.password = u'sha1:上面生成的哈希值' # 
c.NotebookApp.open_browser = False # 禁止自动打开浏览器
c.NotebookApp.port = 8888 #指定一个端口
c.NotebookApp.notebook_dir = '/data/python/jupyter' # 设置存储路径
```

### 运行jupyter
### 方式1
1、启动`# jupyter notebook`；

2、访问http://you_domain:端口/，如有密码则是设置的密码；

3、CLI内两次Ctrl + C可以结束运行jupyter notebook服务；

### 方式1
1、获取启动参数`# jupyter notebook -h`

2、root后台启动`# jupyter notebook --allow-root`；

2、CLI内两次control+c就是结束运行jupyter notebook服务；

## 参考
https://jupyter-notebook.readthedocs.io/en/stable/public_server.html
