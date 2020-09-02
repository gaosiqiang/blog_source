---
title: gitlab官方docker安装部署
author: 高思强
date: 2019-09-29 19:34:43
comments: true
tag:
---
# gitlab官方docker安装部署

## 1、安装docker
请自行查找官方安装文档
## 2、获取镜像
```shell
docker pull gitlab/gitlab-ce
```
## 3、运行镜像
```shell
sudo docker run -p 443:443 \ 映射https端口号
-p 83:80 \ 映射http端口号
-p 23:22 \ 映射ssh端口号
-v /data/gitlab/config:/etc/gitlab \
-v /data/gitlab/logs:/var/log/gitlab \
-v /data/gitlab:/var/opt/gitlab \ 
gitlab/gitlab-ce:latest
```
## 4、gitlab配置
- 编辑宿主机`/data/gitlab/config/gitlab.rb`文件
- 在文件末尾add以下配置参数
```shell
# 添加外部请求的域名(如果不支持https, 可以改成http)
external_url 'https://gitlab.example.com'
# 修改gitlab对应的时区 
gitlab_rails['time_zone'] = 'PRC'
# 开启邮件支持 
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'gitlab@example.com'
gitlab_rails['gitlab_email_display_name'] = 'example GitLab'
# 配置邮件参数
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.example.com"
gitlab_rails['smtp_port'] = 25
gitlab_rails['smtp_user_name'] = "gitlab@example.com"
gitlab_rails['smtp_password'] = "xxxxxx"
gitlab_rails['smtp_domain'] = "example.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
```
- 如果配置的https

在宿主机`/data/gitlab/config/ssl`目录下放置证书文件（如果没有ssl文件夹则创建密钥文件夹, 并放入证书）

> 通过ssh方式拉取代码时, 记住端口号是23, 不是默认的22

> 如果没有配置https, 是无法通过https路径拉取代码的

## 5、故障排除

- **Q**:502页面问题
- **A**:本地映射文件夹权限问题
宿主机`chmod -R 777 /data/gitlab/git-data/repositories`
or `chmod -R 777 /data/gitlab`
然后`docker restart gitlab`
- **Q**:ERR_CONNECTION_REFUSED&ERR_EMPTY_RESPONSE
- **A**:external_url配置参数禁止添加端口号

## 参考资料
- https://about.gitlab.com/install/
- https://docs.gitlab.com/omnibus/docker/
- https://docs.gitlab.com/ce/security/reset_root_password.html
- https://ken.io/note/centos7-gitlab-install-tutorial
- https://www.jianshu.com/p/786c0a7a49d4
- https://www.cnblogs.com/linkenpark/p/8405327.html