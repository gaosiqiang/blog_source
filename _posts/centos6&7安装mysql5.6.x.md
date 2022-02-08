---
title: centos6&7安装mysql5.6.x
author: 高思强
date: 2020-03-04 23:37:27
comments: true
tags:
- Mysql
categories:
- Linux
---

### centos6&7安装mysql5.6.x

安装版本5.6

- 一.首先检查是否安装mysql可以略过
```rpm -qa | grep mysql```

有的话通过下面的命令来卸载掉

```
rpm -e mysql   //普通删除模式
rpm -e --nodeps mysql    // 强力删除模式，如果使用上面命令删除时，提示有依赖的其它文件，则用该命令可以对其进行强力删除
```

- 二.安装相关 cmake

```
yum -y install  cmake make gcc gcc-c++ gcc-g77 autoconf automake zlib* fiex* libxml* ncurses-devel libmcrypt* libtool-ltdl-devel* git readline-devel bison-devel bison* ncurses ncurses-libs
```

- 三.下载对应版本的mysql安装包
操作系统为`Source Code`，选择操作系统版本为`Generic Linux`

https://dev.mysql.com/downloads/mysql/

- 四.解压cd到mysql安装包

```
//5.7.5以下的版本都可以
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql/ -DSYSCONFDIR=/usr/local/mysql/etc -DMYSQL_UNIX_ADDR=/tmp/mysql/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_TCP_PORT=3306
//
make && make install
```

- 五.然后在根目录下创建/data/mysql文件夹,并赋读写权限

- 六.配置用户权限
使用下面的命令查看是否有mysql用户及用户组
`cat /etc/passwd` 查看用户列表
`cat /etc/group`  查看用户组列表
添加用户组 `groupadd mysql`
添加用户 `useradd -g mysql mysql`
修改`/usr/local/mysql`权限 `chown -R mysql:mysql /usr/local/mysql`

- 七.配置my.cnf和初始化mysql

```
cp /usr/local/mysql/support-files/my-default.cnf   /etc/my.cnf //复制my.cnf文件
cp /usr/local/mysql/support-files/mysql.server  /etc/init.d/mysql //如果无法复制可以先cd到mysql.server的目
录下cp
```

修改my.cnf配置，把innodb相关选项前面的#去掉
在安装目录下执行

```
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/ --defaults-file=/etc/my.cnf --user=mysql` //这个是初始化mysql,只有安装时候才能初始化一次

chmod +x /etc/init.d/mysql 赋予可执行权限
chkconfig --add mysql       添加服务
chkconfig --list             显示服务列表
chkconfig --level 345 mysql on如果看到mysql的服务，并且3,4,5都是on的话则成功，如果是off，则键入
service mysql start //启动mysql或者指定配置文件启动/usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf
```

> 如果把mysql加入service服务中,启动mysql就不需要指定my.conf文件,因为service服务会自动在etc下找my.cnf,如果没有加service服务,那么启动的时候就需要指定my.cnf文件

> ps:一般只要把my.cnf设置好这里就不会报错

- 八.设置PATH要不不能直接调用mysql
修改/etc/profile文件，在文件末尾添加
`PATH=/usr/local/mysql/bin:$PATH`
`export PATH`
关闭文件，运行下面的命令，让配置立即生效
`source /etc/profile`

- 九.重置MySQL的root密码
cd到mysql安装目录下的bin目录下执行

```
./mysql -u root -p mysql或./mysql -u root -p mysql或./mysql -u root
```
//用空密码进入mysql管理命令行,也可以修改my.cnf文件中添加一行skip-grant-tables,密码设置完成后把加入的那一行“skip-grant-tables”注释或删除
(进入mysql,或者用use mysql指令)

```
update user set password=PASSWORD(“123″) where user=’root’; //把密码重置为123 或者 SET PASSWORD = PASSWORD('123456');
```

> (注意，如果是表中没有的用户名，使用insert)

```
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.16.%' IDENTIFIED BY 'password' WITH GRANT OPTION; //设置可以远程连接数据库的账号
flush privileges;//刷新权限
```

```
quit或  ‘/  退出数据库管理
service mysqld restart`，OK，搞定！
```


- 最后远程连接mysql

```
./mysql -u dbname -P 3388 -h 127.0.0.1 -uroot -ppassworld
Enter password:
./mysql -h xxx.xx.xx.xx -u root -p
Enter password:
```

- 引用
	- [mysql安装配置](http://dev.mysql.com/doc/refman/5.5/en/source-configuration-options.html)
	- [安装文档](https://dev.mysql.com/doc/refman/5.6/en/source-installation.html)