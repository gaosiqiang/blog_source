---
title: mysql导入导出csv
author: 高思强
date: 2017-11-29 13:31:34
comments: true
tags:
- [mysql]
categories:
- [mysql]
- [运维]
---

# mysql导入导出csv
> CSV 逗号分隔值（Comma-Separated Values，CSV，有时也称为字符分隔值，因为分隔字符也可以不是逗号），其文件以纯文本形式存储表格数据（数字和文本）。纯文本意味着该文件是一个字符序列，不含必须像二进制数字那样被解读的数据。    —— [百度百科](https://baike.baidu.com/item/CSV/10739?fr=aladdin)


## 准备工作
> 把txt文件的后缀改成.csv各个字段之间用","分隔即可，txt默认保存的文件编码是ANSI，如果数据库使用UTF-8编码，那么一定要将这个csv文件另存为UTF-8格式

> 创建一个表临时表，字段名与你要导入的excel表字段关联且顺序相同
"字段分隔符"更改为","，就是excel另存为默认选择的"(逗号分隔)"，你可以自由选择分隔符，通常出现在你的excel或csv表格数据里有","的情况下
数据行之间的分隔符是'\r\n'
> 设置mysql编码```set names utf8;```

## 导入和导出sql语句
- 导入csv到mysql
```
LOAD DATA LOCAL INFILE 'home/import.csv'
INTO TABLE `tablename`
FIELDS TERMINATED BY  ','
LINES TERMINATED BY '\r\n'
(id,name);
```
- 导出mysql到csv
```
SELECT id,name INTO OUTFILE '/home/output.csv'
FIELDS TERMINATED BY ' ' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM tablename;
```

## ps

| 符号                    |说明        |
| :----------------------|:-----------|
| FIELDS TERMINATED BY   |字段终止字符  |
| OPTIONALLY ENCLOSED BY |封套符       |
| LINES TERMINATED BY    |行终止符     |