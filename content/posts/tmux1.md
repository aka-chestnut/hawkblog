---
title: "Tmux基础操作"
date: 2022-01-28T01:14:38+08:00
hidehome: false
draft: false
tags: ["Linux","Tmux"]
categories: "Linux"
series: ["Linux基础操作"]
---
本文记录了Tmux相关的基础操作，够用。
<!--more-->
Tmux -> Session -> Window -> Pane 

## 前缀键修改

Tmux和Screen操作有些相似，都有一个前缀键。通过前缀键+其他键的形式，来触发分屏等操作。这里为了Tmux和Screen键位一致，因此修改全局前缀键为`Ctrl+a`，修改方法如下：

1. `vim ~/.tmux.conf`
2. 在文件中输入：

    ```vim
    set -g prefix C-a
    unbind C-b
    bind C-a send-prefix
    ```

## 基本操作

1. 创建：直接输入tmux
2. 分屏，分出一个新的Pane

    1. 横向分屏`Ctrl+a`后按`%`
    2. 纵向分屏`Ctrl+a`后按`"`
3. 退出`Ctrl+d`
4. 切换`Ctrl+a`后按键盘方向键，可选择操作不同的Pane，注意此时方向键可以多按
5. zoom：按住`Ctrl+a`后放开，通过`Alt+方向键`即可完成缩放操作
6. 全屏：在想全屏的窗口上`Ctrl+a`+`z`,再同样一次操作即取消全屏
7. 挂起：`Ctrl+a`+`d`
8. 挂起后恢复：`tmux a`或`tmux attach`
9. 许多session如何切换：`Ctrl+a`后`s`，然后通过方向键操作选择不同的Session/Window/Pane
10. 创建一个新的Window：`Ctrl+a`后`c`
11. 切换Window：`Ctrl+a`后`w`(这个操作好像和9很像）
12. 翻阅内容：`Ctrl+a`+`PageUP`/`PageDown`
13. 如何从Tmux复制文本：按住`Shift`复制

## 补充

1. 创建一个带命名的新Session`tmux [new -s 会话名 -n 窗口名] `
2. 恢复一个有命名的Session`tmux at -t 会话名`
3. 关闭某一个会话`tmux kill-session -t 会话名`
