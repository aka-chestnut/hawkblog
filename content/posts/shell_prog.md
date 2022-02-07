---
title: "Linux笔记-Shell编程"
date: 2022-02-01T00:52:32+08:00
hidehome: false
draft: false
tags: ["Linux"]
categories: "Linux"
series: ["Linux"]
---
本篇记录了Linux-Shell脚本编程相关的知识。
<!--more-->

## 一、注释

1. 单行注释

    ```bash
    # 这是一行注释
    echo "Hello World" # 也可以在这里注释
    ```
2. 多行注释

    格式如下：

    ```bash
    :<<EOF
    这是一个多行注释
    可以有多行
    EOF

    # 可以吧上述的EOF换成任意的字符/字符串，主要保证首位闭合
    :<<test
    这也是一个多行注释
    可以把EOF换成任意字符
    test
    ```

## 二、变量

### a. 变量定义

```bash
name1='hyk'
name2="hyk"
name3=hyk 
```

### b. 使用变量

```bash
echo $name1 
echo ${name2}
echo ${name3}TEST
```

### c. 只读变量

```bash
name1_readonly=hyk
name2_readonly=hyk
readonly name1_readonly
declare -r name2_readonly

#name1_readonly=check
#name2_readonly=hyk
```

修改只读变量会报错

`./test1.sh:15: read-only variable: name1_readonly`

### d.  全局变量与局部变量

```bash
# 将变量声明成全局变量
name=hyk
export name # 方法1
declare -x name # 方法2

# 将变量从全局变回局部变量
export name=hyk
declare +x name
```

### e. 字符串

```bash
name=hyk
# 注意字符串单引号与双引号的区别
echo 'hello, $name \"hh\"'
# hello, $name \"hh\"
# 单引号中，不会转义，并且无法引用变量                                                                 
echo "hello, $name \"hh\""
# hello, hyk "hh"                                                                         
```

### f. 删除变量

```bash
unset hyk
```

### g. 字符串长度与子串

```bash
name=hyk
echo ${#name}
# 3

name="hello hyk!"
echo ${name:1:5}
# ello
```

## 三、默认变量

```bash
#! /bin/zsh
echo "文件名：" $0
echo "第一个参数： " $1
echo "第二个参数： " $2
echo "第三个参数： " $3

echo "共传入参数个数：" $#
echo "传入参数组成的字符串：" $*
echo "传入参数单独拆分的字符串：" $@
echo "当前进程ID" $$
echo "上一条命令的退出命令" $?
echo "也可以返回某条命令的standout" $(echo 1)
echo "返回command命令的standout,但是不能嵌套" `echo 1`
```

输出如下：

```txt
文件名： ./test2.sh
第一个参数：  first
第二个参数：  second
第三个参数：  third
共传入参数个数： 3
传入参数组成的字符串： first second third
传入参数单独拆分的字符串： first second third
当前进程ID 35490
上一条命令的退出命令 0
也可以返回某条命令的standout 1
返回command命令的standout,但是不能嵌套 1
```

## 四、数组

```bash
# 定义数组
array=(1 hyk first "my")
testarray=()

# 使用数组
echo ${array[0]}
echo ${array[3]}

# 插入元素
array[4]='showmeyourcode'
echo ${array[4]}

# 输出整个数组
echo ${array[@]}
echo ${array[*]}

# 输出数组长度
echo ${#array[@]}
echo ${#array[*]}
```

## 五、expr命令

`expr`用于求表达式的值

* 每一项需要用空格隔开
* 如果遇到表达式报错，可以试试将特定字符转义
* 对包含空格以及其他特殊字符的字符串需要用引号括起来
* 会在`stdout`中输出结果，逻辑表达式如果为真，输出1否则0
* `exit code`如果为逻辑表达式，如果结果为真输出0，否则为1

### 字符串表达式

* `length` 返回字符串长度
* `index` 任意单个字符在String中最前面的字符位置，下标从1开始。如果不存在则返回0
* `substr` 返回String字符串中从开始位置到结束位置的子串。如果数字为非正树，返回空字符串

```bash
str="Hello World!"

echo `expr length "$str"`  # ``不是单引号，表示执行该命令，输出12
echo `expr index "$str" aWd`  # 输出7，下标从1开始
echo `expr substr "$str" 2 3`  # 输出 ell
```

### 整数表达式

* `+ -`加减
* `* / %`乘除模
* `( )`优先级

```bash
#! /bin/bash
a=3
b=4

echo `expr $a + $b`
echo `expr $a - $b`
echo `expr $a \* $b`
echo `expr $a / $b`
echo `expr $a % $b`
echo `expr \( $a + 1 \) \* \( $b + 1 \)`
# output
# 7
# -1
# 12
# 0
# 3
# 20
```

### 逻辑表达式

```bash
#! /bin/bash
a=3
b=4

echo `expr $a \> $b`
echo `expr $a '<' $b`
echo `expr $a '>=' $b`
echo `expr $a \<\= $b`

c=0 
d=5 

echo `expr $c \& $d`
echo `expr $a \& $b`
echo `expr $c \| $d`
echo `expr $a \| $b`
# output
# 0
# 1
# 0
# 1
# 0
# 3
# 5
# 3
```

## 六、read命令

标准输入

```bash
bash-3.2$ read -p "Please input your name:" -t 30 name
Please input your name:test
bash-3.2$ echo $name
test
```

## 七、echo命令

```bash
# 换行
bash-3.2$ echo -e "Hi\ntest"
Hi
test
# 不换行
bash-3.2$ echo -e "Hi \c";echo " test"
Hi  test
# 不转义/取变量
bash-3.2$ echo '$name\"'
$name\"
```

## 八、printf命令

格式化输出命令，和C中的printf很类似，默认不在末尾添加换行符

```bash
# printf format-string [args]
bash-3.2$ printf "%d * %d = %d\n" 2 3 `expr 2 \* 3`
2 * 3 = 6
bash-3.2$ printf "My name is %s\n" www
My name is www
bash-3.2$ printf "%-10.2f\n" 123.124125
123.12
```

## 九、test命令与判断符号`[]`

### 逻辑运算符

`&&`表且，`||`表示或，同样遵循短路原则。exit code为0表示真，为1表示假。

### test命令

用于文件类型的判断以及变量之间的比较。

```bash
test 2 -lt 3
echo $? # 输出上条命令的exit code
```

#### 判断文件类型

| 参数 | 意义           |
| ------ | ---------------- |
| -e   | 文件是否存在<br /> |
| -f<br /> | 是否为文件     |
| -d   | 是否为文件夹   |

```bash
bash-3.2$ test -e test2.sh && echo "exists" || echo "not exists"
exists
bash-3.2$ test -f test2.sh && echo "is a file" || echo "not a file"
is a file
bash-3.2$ test -\d test2.sh && echo "is a dir" || echo "not a dir"
not a dir
```

#### 判断文件权限

| 参数 | 意义           |
| ------ | ---------------- |
| -r   | 文件是否可读   |
| -w   | 文件是否可写   |
| -x   | 文件是否可执行 |
| -s   | 是否为非空文件 |

#### 整数判断

| 参数 | 意义     |
| ------ | ---------- |
| -eq  | 等于     |
| -ne  | 不等于   |
| -gt  | 大于     |
| -lt  | 小于     |
| -ge  | 大于等于 |
| -le  | 小于等于 |

#### 字符串比较

| 参数                | 意义                                                                   |
| --------------------- | ------------------------------------------------------------------------ |
| test -z STRING      | 判断STRING是否为空，如果为空，返回true                                 |
| test -n STRING      | 判断STRING是否非空，如果非空，返回true（此参数-n可以省略：相当于默认） |
| test str1 == str2   | 判断str1是否等于str2                                                   |
| test str1 != str2<br /> | 判断str1是否不等于str2                                                 |

```bash
bash-3.2$ test "abc" == "cad" && echo "true" || echo "false"
false
bash-3.2$ test "abc" == "abc" && echo "true" || echo "false"
true
```

#### 多重条件判断

| 参数 | 意义                                             |
| ------ | -------------------------------------------------- |
| -a   | 两个条件是否同时成立                             |
| -o   | 两个条件是否至少成立一个                         |
| !    | 取反，如果`test ! -x file`，即不可执行返回true |

```bash
bash-3.2$ test "abc" == "abc" -a "cbc" == "abc" && echo "true" || echo "false"
false
bash-3.2$ test "abc" == "abc" -o "cbc" == "abc" && echo "true" || echo "false"
true
```

### 判断符号`[]`

`[]`与test的用法几乎一致，通常用于`if`语句中，`[[]]`是`[]`的加强版，支持更多特性

```bash
bash-3.2$ [ 2 -lt 3 ] && echo "true" || echo "false"
true
bash-3.2$ [ 2 -gt 3 ] && echo "true" || echo "false"
false
bash-3.2$ touch file
bash-3.2$ [ -e file ] && echo "true" || echo "false"
true
bash-3.2$ rm file
bash-3.2$ [ -e file ] && echo "true" || echo "false"
false
```

注意：

1. `[]`中的每一项要用空格隔开
2. 中的变量最好用双引号括起来
3. 中的参数最好用单/双引号括起来

原因：

```bash
bash-3.2$ [ "$name" == "test 123" ] && echo "true" || echo "false"
true # 否则会报错/无法输出正确答案
```

## 十、判断语句

### if...then

形式：

```bash
if condition
then
    语句1
    语句2
elif condition
then
    语句3
    语句4
else
    语句5
    语句6
fi
```

PS：注意只有在有condition情况下需要加then，如果只有一个else，则不需要加。

### case...esac

```python
read a
echo "你输入的数字是：${a}"
case $a in 
    1)
        echo "你输入的数字是1"
        ;;
    2)
        echo "你输入的数字是2"
        ;;
    3)
        echo "你输入的数字是3"
        ;;
    *)
        echo "你输入的数字不是1，2，3"
        ;;
esac
```

## 十一、循环语句

### for...in...do...done

```bash
for var in val1 val2 val3
do
    语句
done

## 例：
for i in a 2 cc
do
    echo $i
done

for file in `ls`
do
    echo $file
done

for i in $(seq 1 10)
do
    echo $i
done

for i in {a..z}
do
    echo $i
done
```

### for((...;...;...))  do...done 

```bash
while condition
do 
    语句
eond

## 例子
while read name
do
echo $name
done
# 输入后屏幕会再一次打印输入，直到`ctrl+d`
a
a
reasr
reasr
gesg
gesg
```

### until...do...done

```bash
until condition
do
    语句
done

## 例
#! /bin/bash
until [ "$word" == "yes" ] || [ "$word" == "no" ]
do
    read -p "please enter a word,'yes' or 'no' to stop:" word
done
# 输入/输出
please enter a word,'yes' or 'no' to stop:a
please enter a word,'yes' or 'no' to stop:b
please enter a word,'yes' or 'no' to stop:test
please enter a word,'yes' or 'no' to stop:yes
```

### break命令

同其他语言：跳出当前一层循环

PS：`case when`语句中，只能跳出当前case，不能跳出整个`case when`

### continue命令

跳出当前一次循环

```bash
#! /bin/bash
for ((i=1;i<=10;i++))
do
if [ `expr $i % 2` -eq 0 ]
then
    continue 
fi
echo $i
done    
```

## 十二、函数

bash函数类似于C/C++的函数，但返回的是exit code，取值为0-255，0表示正常结束。

获取函数的输出结果，是通过echo输出到stdout中，然后通过`$(function_name)`来获取stdout中的结果。

函数的返回值可以通过`$?`获取

**函数格式：**

```bash
[function] func_name() {
    语句1
    语句2
}
```

函数示例：

```bash
func() {
    name=yxc
    echo "Hello $name"
}
func
```

### 获取`return`和`stdout`

> 不写return时，默认return 0
>
> return的获取方式：`$?`  
> output的获取方式：`$(func)`
>

```bash
func() {
    name=yxc
    echo "Hello $name"
    return 123
}

output=$(func)
ret=$?

echo "output = $output"
echo "return = $ret"
```

### 函数的输入参数

函数`$1`表示第一个输入参数，`$0`仍然是文件名

递归计算sum(x..1)的和

```bash
#! /bin/bash
func() {
    word=""
    while [ "$word" != "y" ] && [ "$word" != "n" ]
    do
        read -p "要进入func($1)函数么？请输入y/n" word
    done
  
    if [ "$word" == "n" ]
    then 
        echo 0
        return 0
    fi

    if [ $1 -le 0 ]
    then
        echo 0
        return 0
    fi

    sum=$(func $(expr $1 - 1))
    echo $(expr $sum + $1)
}

echo $(func 10)
```

### 函数内的局部变量

在函数内定义的局部变量，作用范围仅在当前函数内，可以在递归函数内定义局部变量

格式:`local 变量名=变量值`

## 十三、exit命令

1. eixt命令用来退出当前的shell进程，并返回一个退出状态，可以使用$?接收这个退出状态
2. exit命令可以接受一个整数值作为参数，代表退出状态，如果不指定，默认值为0
3. 退出状态只能是一个0-255之间的整数，只有0表示成功，其他都表示失败

exit命令测试代码

```bash
#! /bin/bash

if [ $# -ne 1 ]
then
    echo "args not valid"
    exit 1
else
    echo "args is valid"
    exit 0 
fi 

MacBook-Air  ~/test  ./test15.sh
args not valid
MacBook-Air  ~/test  ./test15.sh a
args is valid
MacBook-Air  ~/test  ./test15.sh a e
args not valid
MacBook-Air  ~/test  echo $?
1   # 自己定义的exit code
```

## 十四、文件重定向

每个进程默认大概打开三个文件描述符

* stdin 标准输入，从命令行读取数据，文件描述符为0
* stdout 标准输出，向命令行输出数据，文件描述符为1
* stderr 标准错误输出，向命令行输出数据，文件描述符为2

可是通过命令将三个文件重定向到其他文件中

| 命令                  | 说明                                                 |
| ----------------------- | ------------------------------------------------------ |
| `command > file`    | 将标准输出重定向到file中                             |
| `command < file`    | 将标准输入重定向到file中（相当于是以什么为输入文件） |
| `command >> file`   | 将标准输出以追加方式重定向到file<br />中                 |
| `command n>file`    | 将文件描述符n重定向到file中<br />                        |
| `command n >> file` | 将文件描述符n以追加方式重定向到file中                |

## 十五、引入外部脚本

类似于import操作，shell脚本中也可以引用其他文件中的代码

```bash
. filename # 点与文件名之间空格
# or
source filename
```

例：

```bash
# 文件1
#! /bin/bash
name=yxc

# 文件2
#! /bin/bash
source test16_1.sh

echo My name is $name

# 运行文件2，成功输出name变量的值
```
