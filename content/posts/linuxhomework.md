---
title: "Linux笔记-Linux系列作业归档"
date: 2022-02-07T21:27:44+08:00
hidehome: false
draft: false
tags: ["Linux"]
categories: "Linux"
series: ["Linux"]
---
本章是Linux系列作业的一些记录，实践是检验真理的唯一标准，知行合一。
<!--more-->
至此，Linux笔记系列将告一段落，后面会陆续补充更多的Linux知识——Linux进阶。
## HomeWork1 文件相关操作

(0) 进入homework_0文件夹，分别创建文件夹dir_a, dir_b, dir_c  
(1) 进入homework_1文件夹，将a.txt, b.txt, c.txt 分别复制成: a.txt.bak, b.txt.bak, c.txt.bak  
(2) 进入homework_2文件夹，将a.txt, b.txt, c.txt 分别重命名为: a_new.txt, b_new.txt, c_new.txt  
(3) 进入homework_3文件夹，将dir_a文件夹下的a.txt, b.txt, c.txt分别移动到文件夹dir_b下  
(4) 进入homework_4文件夹，将普通文件a.txt, b.txt, c.txt删除  
(5) 进入homework_5文件夹，将文件夹dir_a, dir_b, dir_c删除  
(6) 进入homework_6文件夹，查看task.txt的内容，并按其指示进行操作  
(7) 进入homework_7文件夹，创建文件夹dir_0, dir_1, dir_2，  
    将a.txt, b.txt, c.txt复制到dir_0下，重命名为a0.txt, b0.txt, c0.txt;  
    将a.txt, b.txt, c.txt复制到dir_1下，重命名为a1.txt, b1.txt, c1.txt;  
    将a.txt, b.txt, c.txt复制到dir_2下，重命名为a2.txt, b2.txt, c2.txt;  
(8) 进入homework_8文件夹，分别在dir_a, dir_b, dir_c文件夹下查看task.txt的内容，并分别按照指示进行操作  
(9) 进入homework_9文件夹，将其中所有txt类型的文件删除

```shell
# 0
mkdir dir_{a..c}
# 1
for i in *; do  cp $i $i.bak; done
# 2
for i in *.txt; do mv $i ${i%.*}_new.txt ; done
# 3
mv * ../dir_
# 4
rm *
# 5
rm -rf  *
# 6
## 查看文件内容
cat task.txt | more
## 将task.txt重命名为done.txt, 创建目录dir_a，将done.txt移动到目录dir_a下
mkdir dir_a & mv task.txt ./dir_a/done.txt
# 7
mkdir dir_{0..2}
for i in {0..2}; do for j in *.txt; do cp $j ./dir_$i/${j%.*}$i.txt;done; done
# 8
rm a.txt
mv b.txt b_new.txt
cp c.txt c.txt.bak
# 9
rm *.txt
```

## HomeWork2 Tmux和Vim

(0) 进入homework_0文件夹，创建文件names.txt，并顺次将下列姓名写入该文件，每个名字占一行。  
    AcWing、yxc、Bob、张强、李明、Alice  
(1) 进入homework_1文件夹，打开problem.txt，并依次删除下列字符：  
    [1] 最后一行第101个字符  
    [2] 第3行第8个字符  
    [3] 第1行第30个字符  
    [4] 第16行第55个字符  
    [5] 第9行第80个字符  
    最后保存文件并退出。  
(2) 进入homework_2文件夹，打开problem.txt，并依次执行如下操作：  
    [1] 在第1个"two"的后面添加"abc"  
    [2] 在第2个"two"的前面添加"def"  
    [3] 将第3个"two"后面的连续12个字符删掉  
    [4] 将第4个"two"所在的行删掉  
    最后保存文件并退出。  
(3) 进入homework_3文件夹，打开problem.txt，并依次执行如下操作：  
    [1] 将第5行至第15行中所有of替换成OF。  
    [2] 将全文中所有的the替换成THE。  
    [3] 将第偶数个is替换成IS，第奇数个is不变。下标从1开始。  
(4) 进入homework_4文件夹，打开problem.txt，并依次执行如下操作：  
    [1] 删除第11行  
    [2] 将所删除的行粘贴到文件最后一行的下一行  
    [3] 复制第5行  
    [4] 将所复制的行粘贴到文件当前最后一行的下一行  
(5) 进入homework_5文件夹，打开problem.txt，并依次执行如下操作：  
    [1] 删除第11行第15个字符（包含该字符）至第13行第5个字符（包含该字符）  
    [2] 将所删除的内容粘贴到文件末尾（注意不要另起一行）  
    [3] 复制第5行第88个字符（包含该字符）至第7行第6个字符（包含该字符）  
    [4] 将所复制的内容粘贴到当前文件末尾（注意不要另起一行）  
(6) 进入homework_6文件夹，并依次执行如下操作：  
    [1] 清空source0.cpp  
    [2] 将source1.cpp中的第1-3行和第12-24行复制到source0.cpp中  
(7) 进入homework_7文件夹，格式化source.cpp  
(8) 进入homework_8文件夹，打开source.cpp，并依次执行如下操作：  
    [1] 将第15-21行向右缩进2次。  
    [2] 将第22-23行向左缩进1次。  
(9) 进入homework_9文件夹，打开链接：https://www.acwing.com/activity/content/code/content/1694465/  
    新建文件source.cpp，将链接中的代码抄进source.cpp文件中。

```shell
# 7
## 格式化代码
gg=
```

## HomeWork3 Shell编程

创建好作业后，先进入文件夹/home/acs/homework/lesson_3/，然后：  
(0) 进入homework_0文件夹，编写自动完成lesson_1作业的脚本helper.sh。要求：  
    [1] 当前目录下仅包含helper.sh  
    [2] helper.sh具有可执行权限  
    [3] 在任意路径依次执行下列命令后，lesson_1的作业可以得到满分：  
        1) homework 1 create  
        2) /home/acs/homework/lesson_3/homework_0/helper.sh  
(1) 进入homework_1文件夹，编写脚本check_file.sh。要求：  
    [1] 当前目录下仅包含check_file.sh。  
    [2] check_file.sh具有可执行权限。  
    [3] check_file.sh接收一个传入参数。格式为 ./check_file.sh file  
    [4] 判断传递参数，分别在标准输出中输出如下内容（不包括双引号）：  
        1) 如果传入参数个数不是1，则输出一行："arguments not valid"，然后退出，退出状态等于1。  
        2) 如果file文件不存在，则输出一行："not exist"，然后退出，退出状态等于2。  
        3) 如果file文件存在，则输出分别进行如下5个判断，然后退出，退出状态等于0。  
            1] 如果file为普通文件，则输出一行："regular file"  
            2] 如果file为目录（文件夹），则输出一行："directory"  
            3] 如果file具有可读权限，则输出一行："readable"  
            4] 如果file具有可写权限，则输出一行："writable"  
            5] 如果file具有可执行权限，则输出一行："executable"  
(2) 进入homework_2文件夹，编写脚本main.sh。要求：  
    [1] 当前目录下仅包含main.sh  
    [2] main.sh具有可执行权限  
    [3] 该文件从stdin(标准输入)中读取一个整数n  
    [4] 在stdout(标准输出)输出斐波那契数列的第n项。即：a[0] = 1, a[1] = 1, a[i] = a[i - 1] + a[i - 2], 求a[n]。  
    [5] 数据保证 0 <= n <= 20，脚本不需要判断n的合法性。  
(3) 进入homework_3文件夹，编写脚本main.sh。要求：  
    [1] 当前目录下仅包含main.sh  
    [2] main.sh具有可执行权限  
    [3] 该文件从stdin(标准输入)中读取两行整数n和m  
    [4] 在stdout(标准输出)中输出1~n的按字典序从小到大的顺序数第m个全排列，输出一行，用空格隔开所有数，行末可以有多余空格。  
    [5] 数据保证 1 <= n <= 10, 1 <= m <= min(100, n!)，脚本不需要判断数据的合法性。  
(4) 进入homework_4文件夹，编写脚本main.sh。要求：  
    [1] 当前目录下仅包含main.sh  
    [2] main.sh具有可执行权限  
    [3] main.sh接收两个传入参数。格式为 ./main.sh input_file output_file  
    [4] 从input_file中读取一个正整数n，然后将前n个正整数的平方和写入output_file中  
    [5] 数据保证 1 <= n <= 100，脚本不需要判断所有数据的合法性。

### 第一题

```bash
#! /bin/bash
# 0
cd /home/acs/homework/lesson_1/homework_0
mkdir dir_{a..c}
# 1
cd /home/acs/homework/lesson_1/homework_1
for i in *; do  cp $i $i.bak; done
# 2
cd /home/acs/homework/lesson_1/homework_2
for i in *.txt; do mv $i ${i%.*}_new.txt ; done
# 3
cd /home/acs/homework/lesson_1/homework_3/dir_a
mv * ../dir_b
# 4
cd /home/acs/homework/lesson_1/homework_4
rm *
# 5
cd /home/acs/homework/lesson_1/homework_5
rm -rf  *
# 6
cd /home/acs/homework/lesson_1/homework_6
## 将task.txt重命名为done.txt, 创建目录dir_a，将done.txt移动到目录dir_a下
mkdir dir_a && mv task.txt ./dir_a/done.txt
# 7
cd /home/acs/homework/lesson_1/homework_7
mkdir dir_{0..2}
for i in {0..2}; do for j in *.txt; do cp $j ./dir_$i/${j%.*}$i.txt;done; done
# 8
cd /home/acs/homework/lesson_1/homework_8
cd dir_a
rm a.txt
cd ../dir_b
mv b.txt b_new.txt
cd ../dir_c
cp c.txt c.txt.bak
# 9
cd /home/acs/homework/lesson_1/homework_9
rm *.txt
```

### 第二题

```bash
#! /bin/bash

if [ $# -ne 1 ]
then
    echo arguments not valid
    exit 1
fi

if [ ! -e "$1" ]
then
    echo not exist
    exit 2
fi

if [ -f "$1" ]
then
    echo regular file
fi

if [ -d "$1" ]
then
    echo directory
fi

if [ -r "$1" ]
then
    echo readable
fi

if [ -w "$1" ]
then
    echo writable
fi

if [ -x "$1" ]
then
    echo executable
fi
```

### 第三题

```bash
#! /bin/bash

func() {
    if [ $1 == 0 ]
    then
        echo 1
        exit 0
    fi

    if [ $1 == 1 ]
    then
        echo 1
        exit 0
    fi

    prev=1
    next=1
    for((i=2;i<=$1;i++))
    do
       tmp=$prev
       prev=$next
       next=`expr $prev + $tmp`
   done
   echo $next
   exit 0
}
read n
echo $(func $n)
```

### 第四题

```bash
#! /bin/bash
read n
read m

for ((i=0;i<n;i++))
do
    v[$i]=0
done

idx=0

func(){
if [ $1 == $n ]
then
    idx=`expr $idx + 1`
    if [ $idx == $m ]
    then
        echo ${res[@]}
    fi
    return 0
fi
local i=0
for((i=0;i<$n;i++))
do
    if [ ${v[$i]} == 0 ]
    then
        v[$i]=1
        res[$1]=`expr $i + 1`
        func `expr $1 + 1`
        if [ $idx == $m ]
        then
            return 0
        fi
        v[$i]=0
    fi
done
}

func 0
```

### 第五题

```bash
#! /bin/bash
read n < $1
res=0
for((i=1;i<=$n;i++))
do
    res=`expr $res + $i \* $i`
done
echo $res > $2
```

## HomeWork4 ssh与scp

创建好作业后，先进入文件夹/home/acs/homework/lesson_4/，然后：  
(0) 进入homework_0文件夹，要求：  
    [1] 该文件夹内容为空  
    [2] 配置服务器账号的密钥登陆方式。服务器信息可以通过如下命令获得：  
        homework 4 getinfo  
        将服务器账号的名称（Host）配置成：myserver  
(1) 进入homework_1文件夹，下列描述中的“本地”均表示当前文件夹。要求：  
    [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_1/  
    [2] 将本地的main.cpp文件上传到myserver中的~/homework/lesson_4/homework_1/目录中。  
    [3] 在本地创建文件夹dir。  
    [4] 将myserver中的/etc/lsb-release文件复制到dir中。  
(2) 进入homework_2文件夹，下列描述中的“本地”均表示当前文件夹，要求：  
    [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_2/  
    [2] 将本地的dir文件夹上传到myserver中的~/homework/lesson_4/homework_2/目录中。  
(3) 进入homework_3文件夹，下列描述中的“本地”均表示当前文件夹，要求：  
    [1] 在本地创建文件夹dir。  
    [2] 将myserver中的/var/lib/locales/supported.d文件夹下载到本地dir文件夹中。  
(4) 进入homework_4文件夹，编写脚本remote_mkdir.sh和remote_rmdir.sh，要求：  
    [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_4/  
    [2] 本地目录下仅包含remote_mkdir.sh和remote_rmdir.sh  
    [3] remote_mkdir.sh和remote_rmdir.sh具有可执行权限  
    [4] remote_mkdir.sh接收一个传入参数。格式为 ./remote_mkdir.sh directory_name  
        该操作可以在myserver服务器上的~/homework/lesson_4/homework_4/目录下，创建一个名为directory_name的文件夹  
    [5] remote_rmdir.sh接收一个传入传输。格式为 ./remote_rmdir.sh directory_name  
        该操作可以将myserver服务器上的~/homework/lesson_4/homework_4/目录下的名为directory_name的文件夹删掉。  
    [6] 注意：传入的文件参数可能包含空格。两个脚本均不需要判断传入参数的合法性。

```bash
## 1
# 按笔记步骤配置

## 2
ssh myserver "mkdir -p ~/homework/lesson_4/homework_1/"
scp main.cpp myser:homework/lesson_4/homework_1/
mkdir dir
cd dir
scp myserver:/etc/lsb-release .

## 3
ssh myserver 'mkdir -p ~/homework/lesson_4/homework_2'
scp -r dir/ myserver:homework/lesson_4/homework_2

## 4
mkdir dir
scp -r myserver:/var/lib/locales/supported.d ./dir/

## 5
touch remote_mkdir.sh
touch remote_rmdir.sh
chmod +x *
### mkdir 文件
#! /bin/bash
ssh myserver "mkdir -p ~/homework/lesson_4/homework_4/'${1}'"
## rmdir文件
#! /bin/bash
ssh myserver "rm -r ~/homework/lesson_4/homework_4/'${1}'"
```

## HomeWork5 git

创建好作业后，先进入文件夹/home/acs/homework/lesson_5/，然后：

(0) 在当前目录下创建文件夹homework，并将homework目录配置成git仓库。后续作业均在homework目录下操作；  
(1) 创建文件readme.txt，内容包含一行：111；  
将修改提交一个commit；  
(2) 在readme.txt文件末尾新增一行：222；  
将修改提交一个commit；  
(3) 创建文件夹：problem1和problem2；  
创建文件problem1/main.cpp。文件内容为下述链接中的代码：https://www.acwing.com/problem/content/submission/code_detail/7834813/；  
创建文件problem2/main.cpp。文件内容为下述链接中的代码：https://www.acwing.com/problem/content/submission/code_detail/7834819/；  
将修改提交一个commit；  
(4) 删除文件夹problem2；  
创建文件夹problem3；  
创建文件problem3/main.cpp。文件内容为下述链接中的代码：https://www.acwing.com/problem/content/submission/code_detail/7834841/；  
将readme.txt中最后一行222删掉，然后添加一行333；  
将修改提交一个commit；  
(5) 在https://git.acwing.com/上注册账号并创建仓库，仓库名称为homework；  
将本地git仓库上传到AC Git云端仓库；  
(6) 创建并切换至新分支dev；  
在readme.txt文件中添加一行444；  
将修改提交一个commit；  
将dev分支推送至AC Git远程仓库；  
(7) 切换回master分支；  
在readme.txt文件中添加一行555；  
将修改提交一个commit；  
(8) 将dev分支合并到master分支；  
手动处理冲突，使readme文件最终内容包含4行：111、333、555、444；  
将修改提交一个commit；  
(9) 将master分支的版本库push到AC Git云端仓库；  
登录myserver服务器（4. ssh作业中配置的服务器）；  
创建并清空文件夹：~/homework/lesson_5/；  
将AC Git云端仓库clone到~/homework/lesson_5/中；

**可参考笔记，本次作业比较简单，都是笔记中的命令。**

## HomeWrok6 Thrift

作业内容就是把课上的匹配系统最终版本实现，已完成。详见Thrift系列内容

## HomeWrok7 管道、环境变量与常用命令

(0) 进入homework_0文件夹，然后：  
[1] 编写可执行shell脚本，文件名为mydu，使得在任意目录执行该脚本后，可以输出当前目录所占用的磁盘空间大小，格式化输出（例如 1K, 234M, 2G）。  
[2] 修改环境变量PATH，使得在任意目录下输入mydu均可执行上述脚本。  
(1) 进入homework_1文件夹，然后：  
[1] 给当前目录下的所有文件添加可读权限。  
[2] 统计当前目录下共有多少个以.cpp结尾的文件，将结果写入ans.txt中。  
(2) 进入homework_2文件夹，然后：  
[1] 统计当前目录下所有cpp文件的总行数，将结果写入ans1.txt中。  
[2] 遍历当前目录下所有py文件，统计共有多少行包含字符串thrift，将结果写入ans2.txt中。  
(3) 进入homework_3文件夹，然后删除当前目录下的所有py文件。  
(4) 进入homework_4文件夹，然后：  
[1] 当前目录下包含一个文件scores.txt，文件中有若干行数据，每行数据包含用空格隔开的3个字段：姓名、数学成绩、算法成绩。  
[2] 将scores.txt文件的内容以空格为分隔符分隔成3列，将第一列内容写入names.txt，第二列内容写入mathematics.txt，第三列内容写入algorithm.txt。  
注意：scores.txt文件本身不要修改。  
(5) 进入homework_5文件夹，然后：  
[1] 当前目录下包含一个文件scores.txt，文件中有若干行数据，每行数据包含用空格隔开的3个字段：姓名、数学成绩、算法成绩。  
[2] 将scores.txt文件的内容以空格为分隔符分隔成3列，将第一列内容按字典序从小到大排序后写入names.txt。  
注意：scores.txt文件本身不要修改。  
(6) 进入homework_6文件夹，然后将scores.txt文件的前5行写入top.txt，后4行写入bottom.txt。  
(7) 进入homework_7文件夹，计算scores.txt文件的md5sum，将结果写入ans.txt。注意：ans.txt文件中只包含长度为32的md5sum，不包含其他内容。  
(8) 进入homework_8文件夹，然后：  
[1] 将dir_a文件夹压缩为project_a.tar.gz。  
[2] 将project_b.tar.gz压缩文件解压到当前目录。  
注意：不要删除dir_a文件夹和project_b.tar.gz文件。  
(9) 进入homework_9文件夹，然后计算 2112+3782112+378，将结果写入ans.txt中。

```bash
## 0
#! /bin/bash
pwd | du -sh

# 完成脚本后，加入环境变量
export PATH=/home/acs/homework/lesson_7/homework_0:$PATH

## 1
chmod +r . -R
find . -name *.cpp | wc -l > ans.txt

## 2
find . -name *.cpp | xargs cat | wc -l > ans1.txt
find . -name *.py | xargs cat | grep thrift | wc -l > ans2.txt

## 3
find . -name *.py | xargs rm

## 4
cat scores.txt | cut -d ' ' -f 1 > names.txt
cat scores.txt | cut -d ' ' -f 2 > mathematics.txt
cat scores.txt | cut -d ' ' -f 3 > algorithm.txt

## 5
cat scores.txt | cut -d ' ' -f 1 | sort > names.txt

## 6
head -5 scores.txt > top.txt
tail -4 scores.txt > bottom.txt

## 7
md5sum scores.txt | cut -d ' ' -f 1 > ans.txt

## 8
tar -zcvf project_a.tar.gz ./dir_a/*
tar -zxvf project_b.tar.gz

## 9
ipython3
a = 2 ** 112 + 3 ** 78
! echo $a > ans.txt
```

## HomeWork8 云服务器配置及Docker

本章内容比较简单，作业主要是对云服务器以及Docker免密登录的配置，不再赘述
