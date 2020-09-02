---
title: 源码安装gcc
author: 高思强
date: 2018-07-03 10:45:16
comments: true
tags:
- [linux]
- [gcc]
categories:
- 运维
---

# 源码安装gcc

## 引用
- [gcc官网](https://gcc.gnu.org/)
- [gcc官方安装文档](https://gcc.gnu.org/install/)
- [gcc源列表](https://gcc.gnu.org/mirrors.html)
- gcc相关blog  [1](https://www.cppfans.org/1719.html)  [2](http://www.cnblogs.com/chuncn/archive/2010/10/15/1851853.html)  [3](https://www.cnblogs.com/lpbottle/p/install_gcc.html)  [4](https://www.cnblogs.com/succeed/p/6204438.html)

## 安装实录

	$ yum install make
	$ yum -y install bzip2
	$ yum install -y gcc-c++ glibc-static gcc //为避免出错建议安装此包(本人没有试过)
	$ wget ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.9.4/gcc-4.9.4.tar.gz
	$ tar zxvf gcc-4.9.4.tar.gz
	$ cd gcc-4.9.4
	$ ./contrib/download_prerequisites //自动下载供编译需求的依赖项
	$ mkdir gcc_temp //在源码目录下建立一个文件夹存放编译结果的中间文件
	$ cd gcc_temp
	$ ../configure --prefix=/usr/local/gcc --enable-checking=release --enable-languages=c,c++ --disable-multilib //预编译
	$ make -j 8 & make install  //make参数中的8是CPU线程数


## 编译参数说明：

|参数|说明|
| :-- | :-- |
|--prefix=/usr/local/gcc | 指定安装路径 |
|--enable-bootstrap | 这里引用网上一些文献对该参数的解释：用第一次编译生成的程序进行第二次编译，然后用再次生成的程序进行第三次编译，并且检查比较第二次和第三次结果的正确性，也就是进行冗余的编译检查工作。 非交叉编译环境下，默认已经将该值设为 enable，可以不用显示指定；交叉编译环境下，需要显示将其值设为 disable。|
|--enable-checking=release |以软件发布版的标准来对编译时生成的代码进行一致性检查；设置该选项为 enable并不会改变编译器生成的二进制结果，但是会导致编译的时间增加；该选项仅支持gcc编译器； 总体而言，对于上面这个选项，机器的硬件配置较低，以及不愿等待太久编译时间的童鞋，可以设置为 disable；但是这会增加产生未预期的错误的风险，所以应该慎用。 可以同时设置 --disable-bootstrap 与 --disable-checking，这对编译过程的提速很有帮助。|
|--enable-threads=posix | 顾名思义，启用posix标准的线程支持 ，要让程序能在符合POSIX规范的linux发布版上正确运行，就应该启用该选项，取决于宿主或目标操作系统的类型，其它可用值有：aix，dec，solaris，win32等，如果你是其它的类UNIX系统，就需要设置相应的值。|
|--enable-languages=c,c++ | 支持的高级语言类型和运行时库，可以设置的所有语言包括 ada,c,c++,Fortran,java,objc,obj-c++,GO 等语言。这里只开启了c和c++,因为支持的语言越多，就需要安装越多的相应静态与动态库，还有五花八门的依赖库，这会让管理变得困难，体积也会变得庞大。|
|--disable-multilib | 如果你的操作系统是32位，默认就已经设置为 disable，这意味着gcc仅能生成32位的可执行程序；如果你的操作系统是64位，默认就已经设置为 enable，这意味着用gcc编译其它源文件时可以通过 -m32 选项来决定是否生成32位机器代码。如果在64位系统上，要禁止生成32位代码， 设置 --disable-multilib。|
|--enable-gather-detailed-mem-stats |允许收集详细的内存使用信息，如果设置该参数为 enable，则将来编译好的gcc可执行程序，可以通过 -fmem-report 选项来输出编译其它程序时的实时内存使用情况。|
|--with-long-double-128 | 指定 long double 类型为128位（16字节！）；设置为 without，则 long double类型将为64位（8字节），这将与普通的 double 类型一样。 基于 Glib 2.4以上版本编译时，默认已经是128位。|




## 安装后设置

	vi /etc/profile.d/gcc.sh
	键入 export PATH=/usr/local/gcc/bin:$PATH
	source /etc/profile.d/gcc.sh
	gcc --version
	
	ln -sv /usr/local/gcc/include/ /usr/include/gcc
	"/usr/include/gcc" -> "/usr/local/gcc/include/"
	vi /etc/ld.so.conf.d/gcc.conf
	键入 /usr/local/gcc/lib64
	ldconfig -v
	ldconfig -p |grep gcc  //验证是否导出 

## 相关问题处理:

| Q | A |
| :-- | :-- |
|tar (child): lbzip2: Cannot exec: No such file or directory 解决方法|yum -y install bzip2如果虚拟机无法联网，也可以源码安装，下载：[bzip2-1.0.6.tar](http:/www.bzip.org/downloads.html)，安装过程如下：tar zxvf bzip2-1.0.6.tar.gz cd bzip2-1.0.6/ 为编译做准备，创建libbz2.so动态链接库(这一步很重要，安装python的时候如果没有这一步，python安装不上bz2模块)：make -f Makefile-libbz2_so make && make install|



问题原因：升级gcc后，生成的动态库没有替换老版本 gcc 动态库导致的
解决方案：将gcc最新版本的动态库替换系统中老版本的动态库。

查找编译gcc时生成的最新动态库

	find / -name "libstdc++.so*"

将找到的动态库libstdc++.so.6.0.21复制到/usr/lib64

	cp /gcc-4.9.4/gcc_temp/x86_64-unknown-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6.0.20 /usr/lib64
	
切换工作目录至/usr/lib64，删除原来的软连接， 将默认库的软连接指向最新动态库。
	
	cd /usr/lib64
	rm -rf libstdc++.so.6
	ln -s libstdc++.so.6.0.20 libstdc++.so.6



