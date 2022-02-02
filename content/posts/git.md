---
title: "AcWing-Git笔记"
date: 2022-02-03T01:25:03+08:00
hidehome: false
draft: false
tags: ["Linux","git"]
categories: "Linux"
series: ["Linux"]
---
第三次学Git了，再记一次笔记。
<!--more-->
## 基本概念

* 工作区：仓库的目录，工作区是独立于各个分支的
* 暂存区：数据暂时存放的区域，是工作区与版本库的中间区域，相当于一个缓存区，独立于各个分支

  暂存区存储所有觉得有价值的代码！
* 版本库：存放所有已提交到本地仓库的代码版本
* 版本结构：一个树形结构，每个节点代表一个版本

## 常用命令

1. `git config --global user.name xxx`设置全局用户名（存在~/.gitconfig)
2. `git config --global user.email xxx@xxx.com`设置全局邮箱
3. `git init`当前目录配置成git仓库
4. `git add XX`将文件放在暂存区
5. `git commit -m "备注信息"`将暂存区的文件提交到当前分支
6. `git status`当前目录状态
7. `git diff file`查看当前文件与暂存区文件的区别
8. `git rm --cached readme.txt`或`git restore --staged readme.txt`将文件从暂存区删除（不希望继续管理该文件）/还原暂存区文件状态
9. `git log`查看历史

    `git log --oneline`
10. `git reflog`查看HEAD的移动历史
11. `git reset --hard HEAD^`或`git reset --hard HEAD~`将代码回滚到上一个版本

     * 回滚两次 `git reset --hard HEAD^^`
     * 回滚100次 `git reset --hard HEAD~100`
     * 回滚到某一个特定版本 `git reset --hard 版本号`

     回滚后如何再重新撤销回滚？

     `git reflog`查看HEAD的全部历史记录，根据版本号回滚到特定版本
12.  `git checkout XX`或`git restore XX` 回滚到暂存区现有的版本（撤销工作区->暂存区)
13. `git remote add origin git@git.acwing.com:xxx/XXX.git` 将本地仓库关联到远程仓库
14. `git push -u (第一次需要-u以后不需要)`  将当前分支推送到远程仓库  
     `git push origin branch_name` 将本地的某个分支推送到远程仓库
15. `git clone git@git.acwing.com:xxx/XXX.git` 将远程仓库XXX下载到当前目录下

## 分支命令

PS: 多分支公用一个暂存区，提交时看处在哪个分支就在哪个分支提交

1. `git checkout -b branch_name`创建新的分支
2. `git branch`查看所有分支和当前所处的分支
3. `git checkout master`切换分支
4. `git merge branch_name`将分支合并到当前分支
5. `git branch -d dev`删除分支
6. 解决冲突：

    当两个分支的修改存在冲突时，无法自动合并，需要手动处理冲突，并提交持久化。
7. `git push --set-upstream origin branch_name`同步本地的其他分支到云端(云端无对应分支，需要首先进行创建)
8. `git push -d origin dev3`删除云端分支（本地删除分支，但云端无法删除，需要用命令删除云端分支）
9. `git branch --set-upstream-to=origin/branch_name1 branch_name2`将本地分支branch_name2绑定远程分支branch_name1

    之后通过`git pull`即可拉去远程分支
10. `git pull`将远程分支与当前仓库分支合并

     `git pull origin dev5` 将云端的分支与本地分支合并
11. `git checkout -t origin/branch_name`将远程分支拉取到本地

## stash

将某一时刻的工作区/暂存区全部存储到一个栈中

1. `git stash list`查看栈中所有内容
2. `git stash`存入栈（工作区）
3. `git stash pop`弹出栈中的内容（apply 并 删除）
4. `git stash apply` 恢复栈顶，但不删除
5. `git stash drop` 删除栈顶元素

## 多人同分支开发

如果多个人同时对dev分支进行开发，很可能出现某人提交后，另一个人同时提交无法成功的情况，因为云端现在版本已经更新，和本地存在冲突。此时需要先解决冲突，再push。(同时修改同一个文件）

1. `git pull`
2. 在本地解决冲突
3. `git push`
