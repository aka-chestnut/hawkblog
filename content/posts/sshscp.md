---
title: "Linux笔记-ssh与scp命令"
date: 2022-02-02T21:59:19+08:00
hidehome: false
draft: false
tags: ["Linux"]
categories: "Linux"
series: ["Linux"]
---
本文是Linux远程操控的两个常用命令scp与ssh的笔记。
<!--more-->
## ssh-远程登录

### 基本操作

`ssh user@hostname`

首次登录会提示保存fingerprint，这样会把服务器信息保存在`~/.ssh/know_hosts`

登录时可指定端口

`ssh user@hostname -p 22`

### 配置服务器信息

创建文件`~/.ssh/config`

可对服务器信息进行配置，配置后再次登录时可直接使用别名`ssh myserver1`

```txt
Host myserver1
    HostName IP地址或域名
    User 对应用户名

Host myserver2
    HostName IP地址或域名
    User 对应用户名
```

### 配置免密钥

输入`ssh-keygen`，一路回车；执行结束后，会在`~/.ssh`文件夹下多两个文件

* `id_rsa` 私钥
* `id_rsa.pub` 公钥

如果想要免密钥登录某服务器，这只需要将公钥中的内容，复制到对应服务器的`~/.ssh/authorized_keys`文件中；也可以使用命令一键添加公钥：`ssh-copy-id myserver`

### 远程执行命令

`ssh user@hostname command`

如：

```bash
ssh user@hostname ls -a
## 单引号中$i可以求值（单引号$i是远程服务器的值)
ssh myserver 'for ((i=0;i<10;i++)) do echo $i;done'
## 双引号中的$i不可以求值（双引号$i是本地的值）
ssh myserver "for ((i=0;i<10;i++)) do echo $i;done"
```

## scp远程拷贝

`scp source destination`将source文件复制到destination中

`scp -r ./tmp myserver:/home`将文件夹tmp复制到远程服务器的home下

`scp -r ./tmp myserver:homework`将文件夹tmp复制到远程服务器～目录下的的homework文件夹中

也可以将远程服务器中的文件复制到本地目录下

`scp -r myserver:homework .`将myserver：～文件夹下的home文件夹复制到当前目录

### 指定端口

`scp -P 22 source destination`

### 远程配置vim/tmux

`scp ~/.vimrc ~/.tmux.conf myserver:`
