---
title: "Linux笔记-管道、环境变量与常用命令"
date: 2022-02-07T11:05:04+08:00
hidehome: false
draft: false
tags: ["Linux"]
categories: "Linux"
series: ["Linux"]
---
本篇记录ACWing-Linux系列课程倒数第二讲的笔记
<!--more-->
## 管道

与文件重定向类似，但本质上是一个pipeline，即将上一个命令的stdout重定向到下一个命令的stdin

* 仅处理stdout，会忽略stderr（todo：管道中可以对stderr重定向么）
* 位于右边的命令需能接收stdin
* 可无限串联

例子：

统计当前文件夹下py文件的总行数

```bash
find . -name *.py | xargs cat | wc -l
```

## 环境变量

> **环境变量、shell变量与用户变量的区别与联系**
>
> Linux下的变量分为两类，环境变量与shell变量。环境变量存储在/etc/profile文件中，命令行shell变量存储在~/.bashrc文件中
>
> shell变量根据私有与否分为用户变量与私有变量
>
> PS：此处参考了很多文章也没有完全理解env、set和export的区别。目前的理解是shell变量是shell特有的，比如bash和zsh的shell变量应该是不同的；环境变量是所有bash共有的，比如`HOME`这种变量。
>
> export在linux中用于设置环境变量，但直接在shell中的修改不是持久的，为了可持久化，通常需要修改/etc/profile来export设置的环境变量
>

Linux中用环境变量来记录配置信息，修改环境变量可以快速修改系统配置。

### 查看环境变量

1. env 显示当前用户变量
2. set 显示当前shell变量，包括当前用户的变量（是bash特有的，
3. export 显示当前导出成用户变量的shell变量
4. `echo $PATH`输出某个环境变量的值

### 修改环境变量

1. 可直接在bash中修改环境变量，仅对当前bash生效
2. 在~/.bashrc中修改环境变量，每次bash启动都会先执行bashrc文件中的命令（ssh或tmux新开pane都会新启动一个bash）

### 常见环境变量

1. `HOME` 家目录地址
2. `PATH`可执行文件的存储路径，路径之间用`:`隔开；当某个可执行文件同时出现在多个路径中时，会选择最左边的执行
3. `LD_LIBRARY_PATH`动态连接库（.so）文件的的地址，内容时冒号分割的路径地址
4. `C_INCLUDE_PATH`头文件路径：C语言
5. `CPLUS_INCLUDE_PATH`头文件路径：C++
6. `PYTHONPATH`包导入路径：Python
7. `JAVA_HOME` jdk的安装路径
8. `CLASSPATH` 包导入路径：Java

## 常用命令

### 系统状况

1. `top` 任务管理器（所有进程信息）

    输入M 按内存排序

    输入P 按CPU排序

    q：退出
2. `df -h` 硬盘使用情况
3. `free -h` 内存使用情况
4. `du -sh` 查看当前目录的占用大小
5. `ps aux` 查看所有进程
6. `kill -9 pid` 杀进程

    传递其他信号 `kill -s SIGTERM pid`
7. `netstat -nt` 查看所有网络连接
8. `w` 列出当前登录用户（who的简写？)

    检验了一下，`w`命令显示的信息比`who`显示的信息更全

    `w`命令还会显示用户执行的任务情况[参考](http://c.biancheng.net/view/3869.html)
9. `ping` 查看联网

### 文件权限

1. `chmod` 修改文件权限

    `+x` 可执行

    `-x` 不可执行

    `777` 修改文件777

    `777 -R` 递归整个文件夹777

### 文件检索

1. `find 检索目录 -name x`
2. `grep xxx` 输出所有包含xxx的行
3. `wc` 统计

    既可以从标准输入读入内容，也可以从命令行中传入文件名

    `wc -l` 统计行数

    `wc -w` 统计单词数

    `wc -c` 统计字节数
4. `tree` 以树状展示目录结构，可加-a显示隐藏文件
5. `ag xxx` 搜索当前目录下所有文件，检索字符串xxx

    输出格式为：文件，对应行数，该行的xxx字符串会高亮
6. `cut` 分割一行内容

    > 从stdin中读入多行数据  
    > `echo $PATH | cut -d ':' -f 3,5`：输出PATH用:分割后第3、5列数据  
    > `echo $PATH | cut -d ':' -f 3-5`：输出PATH用:分割后第3-5列数据  
    > `echo $PATH | cut -c 3,5`：输出PATH的第3、5个字符  
    > `echo $PATH | cut -c 3-5`：输出PATH的第3-5个字符
    >

7. `sort` 将每行内容按字典序排序

    可从stdin读取和命令行参数读取文件列表
8. `xargs` 将标准输入中的数据用空格或者回车分割成命令行参数，如上文中的py行树统计应用

### 查看文件内容

1. `more` 

    回车：下一行

    空格：下一页

    `b` 上一页

    `q` 退出
2. `less`

    回车：下一行

    `y` 上一行

    `Page Down` 下一页

    `Page Up` 上一页

    `q` 退出
3. `head -3 xxx` 显示前三行，也可以从标准输入中读取内容
4. `tail -3 xxx` 同上，显示后三行

### 用户相关

1. `history` 

    显示当前用户的历史操作，内容存放在~/.bash_history

### 工具

1. `md5sum` 计算md5哈希值

    可直接标准输入

    也可以xargs读取文件名列表
2. `time command` 统计命令的执行时间（command 为命令）
3. `ipython3` python3交互式环境，这个比较熟了
4. `watch -n 0.1 command` 每0.1秒执行一次command命令
5. `tar` 压缩文件

    `tar -zcvf xxx.tar.gz /path/to/file/*` 将目录下文件压缩成xxx.tar.gz

    `tar -zxvf xxx.tar.gz` 将压缩文件解压到当前文件夹
6. `diff xxx yyy` 比较xxx与yyy文件的不同

### 安装

1. `sudo command` 以root权限执行
2. `apt-get install xxx` 安装软件
3. `pip install xxx --user --upgrade` 安装python软件
