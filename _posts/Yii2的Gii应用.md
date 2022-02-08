---
title: Yii2的Gii应用
author: 高思强
date: 2018-12-28 13:51:04
comments: true
tags:
- yii2
categories:
- php
---

# Yii2的Gii应用
Yii Gii

1、设置index.php文件

	defined('YII_ENV_DEV') or define('YII_ENV_DEV', true);
才能访问gii

2、advanced版本修改config/main.php，basic版本是web.php

```
'modules' => [
        'gii' => [
            'class'      => 'yii\gii\Module',
            'allowedIPs' => ['*', '127.0.0.1', '::1', '192.168.0.*', '192.168.178.20']
        ]
    ],
```
3、访问yousite/index.php?r=gii


4、yi2 Gii cli模式

查看yii cli所有命令

`# php yii`

查看yii cli命令帮助

`# php yii gii/module --help`

生成模型

`# php yii gii/model --ns=common\\models --tableName=表名 --modelClass=模型名`
模型名后面不用加model

生成crud

`# php yii gii/crud --modelClass=common\\models\\模型名 --controllerClass=backend\\controllers\\控制器名Controller --viewPath=@backend/views/视图就是控制器名`

生成的时候都会出confirm信息，如果不需要的话可以加上--interactive=0参数。hehe需要替换成你实际的表名、模型名等

生成module

`# php yii gii/module --moduleClass='app\modules\notification\Module' --moduleID='notification'`

生成的module结构

```
notification/
├── controllers
│   └── DefaultController.php
├── Module.php
└── views
    └── default
        └── index.php

3 directories, 3 files
```
> 在使用命名空间的时候如果没用‘’单引号括起来那么命名空间的单\就要换成双\

最后修改 /config/web.php文件

```
$config = [
    'modules' =>[
        'api' => 'app\modules\api\Module',
        'common' => [
            'class' => 'app\modules\common\Module',
        ],
        'finance' => [
            'class' => 'app\modules\finance\Module',
        ]
    ],
];
```
