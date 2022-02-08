---
title: php psr-4 autoload
author: 高思强
date: 2018-11-15 09:53:00
comments: true
tags:
- psr-4
categories:
- php
---

### php psr-4 autoload

composer docment

- https://docs.phpcomposer.com/01-basic-usage.html#Autoloading
- https://docs.phpcomposer.com/04-schema.html
- https://docs.phpcomposer.com/03-cli.html
- https://laravel-china.org/docs/composer/2018/04-schema/2085
- https://segmentfault.com/a/1190000000355928

1、项目根目录创建composer.json文件

**demo**

```json
{
  "autoload": {
    "psr-4": {
      "app\\": "vendor",
      "component\\": "vendor/component",
    }
  }
}
```
2、shell命令 `# composer dump-autoload`会生产vendor和autoload代码结构

3、composer.json中psr-4参数

- "app\\": "vendor"表示将命名空间vendor绑定到app上
- "component\\": "vendor/component"表示将命名空间vendor/component绑定到component上

4、demo

在vendor/component文件中创建类Test.php

```php
namespace component;//该文件的路径vendor/component,但是在psr-4参数中设置了绑定，所有namespace component等价namespace vendor/component
class Test{
	public function getNameSpace()
	{
		echo "NameSpace = ".__NAMESPACE__."<br/> ClassName = ".__CLASS__."<br/> Method = ".__METHOD__;
	}
}
```
其他类中使用Test类

```php
namespace app\module\Demo
use component\Test;//等价于use vendor/component\Test
echo (new Test())->getNameSpace();
```
> **输出**NameSpace=component ClassName= component/Test Method=component/Test:: getNameSpace

ps:composer.json中psr-4不设置任何参数无法实现自动加载，详情看autoload_statice.php文件