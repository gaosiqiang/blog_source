---
title: php Xdebug配置
author: 高思强
date: 2018-02-07 15:36:50 
comments: true
tags:
- [Xdebug]
categories:
- php
---
# php Xdebug配置
## 我的php.ini配置

```
[php_xdebug]
zend_extension=xdebug.so
xdebug.remote_enable = On
xdebug.remote_handler=dbgp
xdebug.remote_host=192.168.50.141
xdebug.remote_port=9010
xdebug.idekey=PHPSTORM
```

## Xdebg参数说明

| 参数| 参数类型与默认值|参数选项与描述 |
| :-- | :-- | :-- |
|xdebug.default_enable=0      | | |
|xdebug.remote_enable=1       |boolean类型，默认值=0,开启1或On|远程调试开关，必须开启或关闭|
|xdebug.remote_handler=dbgp   |string类型，默认值=dbgp,指定远程调试的处理协议|远程调试xdebug与IDE使用的协议，默认就是dbgp|
|xdebug.remote_host=127.0.0.1 |string类型，默认值=localhost,指定远程调试的主机名 |远程调试xdebug回连的主机ip，如果开启了remote_connect_back，则该配置无效|
|xdebug.remote_connect_back=0 |默认0|是否回连，如果开启该选项，那么xdebug回连的ip会是发起调试请求对应的ip|
|xdebug.remote_port=9000      ||远程调试回连的port，默认即为9000，如果有端口冲突，可以修改，对应ide的debug配置里面也要同步修改|
|xdebug.remote_autostart=1    | | |
|xdebug.remote_mode          |string类型，默认值=req| 可以设为req或jit，req表示脚本一开始运行就连接远程客户端，jit表示脚本出错时才连接远程客户端。|
|xdebug.idekey=netbeans       | |调试使用的关键字，发起IDE上的idekey应该和这里配置的idekey一致，不一致则无效|
|xdebug.remote_log=/data/xdebug_log/remote.log |string类型，默认值=|指定远程调试的log日志路径和文件名|
|xdebug.profiler_enable=on    | |是否启用性能检测分析|
|xdebug.auto_trace=on         | boolean类型，默认值=0 |是否启用代码自动跟踪，是否在脚本运行之前自动调用相关追踪函数|
|xdebug.collect_params=on     | |允许收集传递给函数的参数变量|
|xdebug.collect_return=on     | |允许收集函数调用的返回值|
|xdebug.trace_output_dir="/data/trace_log" | |指定堆栈跟踪文件的存放目录|
|xdebug.profiler_output_dir="/data/debug"  | |指定性能分析文件的存放目录|
|xdebug.profiler_output_name=cachegrind.out.%t.%p | | |
|xdebug.cli_color             |integer类型，默认值=0 | 该参数自2.2版本开始引入。如果值=1，当处于CLI模式或连接虚拟控制台时，Xdebug将高亮显示var_dumps()和堆栈输出，；在Windows中，这需要安装ANSICON工具。如果值=2，不管是否处于CLI模式或连接虚拟控制台，Xdebug都会高亮显示var_dumps()或堆栈输出；这种情况下，你可能会看到转义后的代码。|
|xdebug.collect_assignments   |boolean类型，默认值=0| 该参数自2.1版本开始引入。用于控制是否为函数跟踪添加变量赋值功能。|
|xdebug.collect_includes      |boolean类型，默认值=1| 控制是否在跟踪文件中写入include()、include_once()、require()、require_once()等函数中用到的文件名。|
|xdebug.collect_params        |integer类型，默认值=0| 控制在调用函数时，是否收集传递给函数的参数信息。如果参数值过大，这可能会占用大量的内存；不过，在Xdebug 2中不会出现该问题，因为Xdebug 2将相关数据写入磁盘中，而不是占用内存。**如果值=0，则不显示任何信息。** **如果值=1，只显示类型和大小信息，例如：string(6)、array(8)。** **如果值=2，将显示类型和大小，以及全部信息的工具提示。** **如果值=3，将显示变量的全部内容。** **如果值=4，将显示变量的全部内容和变量名。**|
|xdebug.collect_return        |boolean类型，默认值=0| 控制是否在追踪文件中写入函数调用的返回值。|
|xdebug.collect_vars          |boolean类型，默认值=0| 控制是否收集指定作用域中的变量信息。由于需要反向工程PHP的操作码数组，因此Xdebug的分析速度可能比较慢。|
|xdebug.coverage_enable	       |boolean类型，默认值=1| 该参数自2.2版本开始引入。控制是否允许通过设置内部结构来启用代码覆盖率功能。|
|xdebug.default_enable        |boolean类型，默认值=1| 当发生异常或错误时，是否默认显示堆栈信息。|
|xdebug.dump.*	             |string类型，默认值=Empty| 这里的*可以是COOKIE, FILES, GET, POST, REQUEST, SERVER, SESSION中的任意一个。用于指定发生错误时是否显示超全局变量数组中的索引变量信息。比如，你想要显示请求的IP地址和请求方式，可以设置为xdebug.dump.SERVER=REMOTE_ADD,REQUEST_METHOD多个索引变量用英文逗号隔开，如果要输出其中的所有变量，可以直接用*，例如：xdebug.dump.GET=*|
|xdebug.dump_globals          |boolean类型，默认值=1| 控制是否显示通过xdebug.dump.*定义的所有超全局变量的信息。|
|xdebug.dump_once             |boolean类型，默认值=1| 如果出现多个错误，控制超全局变量信息是在所有错误中显示，还是只在第一个错误中显示。|
|xdebug.dump_undefined        |boolean类型，默认值=1| 控制是否显示超全局变量中未定义的值。|
|xdebug.extended_info         |integer类型，默认值=1| 是否强制进入PHP解析器的"extended_info"模式，这将允许Xdebug以远程调试器对文件或行添加断点。开启此模式将拖慢脚本的允许速度，该参数只能在php.ini中设置。|
|xdebug.file_link_format      |string类型，默认值=| 自2.2版本开始引入。用于指定堆栈信息中用到的文件名称的链接样式，这允许IDE通过设置链接协议，直接点击堆栈信息中的文件名称，即可快速打开指定的文件。例如：ZendStudio://%f@%l(%f表示文件路径，%f表示行号)。|
|xdebug.force_display_errors |integer类型，默认值=0| 自2.3版本开始引入。是否强制显示错误信息。|
|xdebug.force_error_reporting |integer类型，默认值=0| 自2.3版本开始引入。是否强制显示所有错误级别的信息。|
|xdebug.halt_level            |integer类型，默认值=0| 自2.3版本开始引入。指定出现那些错误级别的错误时，中止程序运行。例如：xdebug.halt_level=E_WARNING \| E_NOTICE \| E_USER_WARNING \| E_USER_NOTICE(也仅支持上述4种错误级别)。|
|xdebug.idekey               |string类型，默认值=\*complex\*| 指定传递给DBGp调试器处理程序的IDE Key。|
|xdebug.manual_url           |string类型，默认值=http://www.php.net| 仅2.2.1以下版本可用，用于指定从函数堆栈和错误信息链接到的帮助手册的基本URL。|
|xdebug.max_nesting_level    |integer类型，默认值=100| 指定递归的嵌套层级数。|
|xdebug.overload_var_dump    |boolean类型，默认值=1| 自2.2版本开始引入，当php.ini中的html_error设为1时，Xdebug是否默认使用自身的改进版本来重载var_dump()。|
|xdebug.profiler_append	      |integer类型，默认值=0| 当多个请求映射到相同文件时，指定是覆盖之前的调试信息文件还是追加内容到该文件中。|
|xdebug.profiler_enable	      |integer类型，默认值=0|指定是否启用Xdebug的性能分析，并创建性能信息文件。|
|xdebug.profiler_output_dir  |string类型，默认值=/tmp|指定性能分析信息文件的输出目录|
|xdebug.profiler_output_name |string类型，默认值=cachegrind.out.%p|指定性能分析信息文件的名称|
|xdebug.trace_options        |integer类型，默认值=0| 指定对于之后的请求，追踪文件是追加内容还是覆盖之前内容。|
|xdebug.trace_output_dir     |string类型，默认值=/tmp| 指定追踪文件的存放目录|
|xdebug.trace_output_name    |string类型，默认值=trace.%c|指定追踪文件的名称|

[官方配置文档](https://xdebug.org/docs/all_settings)