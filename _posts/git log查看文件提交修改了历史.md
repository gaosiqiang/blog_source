---
title: git log查看文件提交修改了历史
author: 高思强
date: 2018-07-18 16:05:50
comments: true
tags:
- git
categories:
- 运维
---

# git log查看文件提交修改了历史

`# git log --help`
> 所有的git命令都可以通过git manual查看，在synopsis中可以看到公式  git log [<options>] [[--] <path>] 其中 []中的内容可以为空每个option都有相应的解释

| 指令 | 说明 | demo |
| :-- | :-- | :-- |
|`# git log -- filename （git log filename）`|可以看到该文件相关的commit记录|`# git log -- README.md`|
|`# git log -p filename`|可以显示该文件每次提交的diff|`# git log -p README.md`|
|`# git show commit-id filename`|查看某次提交中的某个文件变化|`# git show 999e31080f96c29d84e11a82e87bfa175976fe0e README.md`|
|`# git show commit-id`|根据commit-id查看某个提交|`# git show 999e31080f96c29d84e11a82e87bfa175976fe0e`|
|`# gitk --follow filename`|以图形化的界面显示文件修改列表||

- git log 的常用选项

| 选项 | 说明 |
| :-- | :-- |
|-p|按补丁格式显示每个更新之间的差异|
|--stat|显示每次更新的文件修改统计信息|
|--shortstat|只显示 --stat 中最后的行数修改添加移除统计|
|--name-only|仅在提交信息后显示已修改的文件清单|
|--name-status|显示新增、修改、删除的文件清单|
|--abbrev-commit|仅显示 SHA-1 的前几个字符，而非所有的 40 个字符|
|--relative-date|使用较短的相对时间显示（比如，“2 weeks ago”）|
|--graph|显示 ASCII 图形表示的分支合并历史|
|--pretty|使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（后跟指定格式）|
|-(n)|仅显示最近的 n 条提交|
|--since, --after|仅显示指定时间之后的提交|
|--until, --before|仅显示指定时间之前的提交|
|--author|仅显示指定作者相关的提交|
|--committer|仅显示指定提交者相关的提交|
|--grep|仅显示含指定关键字的提交|
|-S|仅显示添加或移除了某个关键字的提交|