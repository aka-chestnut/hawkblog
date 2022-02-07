---
title: "Linux笔记-Thrift——1.概念与浅层理解"
date: 2022-02-07T13:38:28+08:00
hidehome: false
draft: false
tags: ["Linux","Thrift"]
categories: "Linux"
series: ["Thrift"]
---
本篇是Thrift学习过程中的笔记记录，主要内容为Thrift的概念以及框架整体的一些浅层理解
<!--more-->
## 什么是thrift

RPC框架，直白点说就是远程函数调用。（远程过程调用 Remote Procedure Call）

专业点说是一个计算机通信协议，允许运行于一台计算机的程序调用另一个计算机上的程序，屏蔽了通信的复杂性，可以使开发人员不需要关注网络编程的细节，专注于业务逻辑开发上。

**RPC是一种C/S架构的服务模型，通过server向client提供的接口，client向server发送数据，server接收数据并进行处理，并将处理结果返回到client端。**

---

RPC通常的步骤

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220207113821-emh7me9.png)

通常需要以上6个步骤，如果不借助thrift等工具，那么团队就需要完整实现Client和Server之间的通信，包括**序列化数据、利用socket或者http传输数据**等。而借助现有的RPC工具，那么开发就可以不关注底层的数据通信，只需要定义自己的服务。

---

Thrift就是一个这样的**跨语言RPC服务部署框架**，最早是由FaceBook在2007开发，2008进入阿帕奇开源项目。

它通过一个IDL来定义RPC的接口和数据类型，通过thrift命令就可以生成不同语言的代码。实际上就是实现了一个C/S模式，通过代码生成工具生成server端和client端的代码。

> 其中protocol（协议层, 定义数据传输格式，可以为二进制或者XML等）和transport（传输层，定义数据传输方式，可以为TCP/IP传输，内存共享或者文件共享等）被用作运行时库。
>

**协议栈示意**

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220207115358-qlvh5pb.png)

* client和server的最顶层是用户自定义的业务逻辑，也是用户需要编写的代码部分。
* 用户逻辑的下一层是Thrift子生成的代码，主要用于结构化数据的解析、发送和接收。服务端的自生成代码还包括RPC请求的转发（即client的函数A调用转发到server的函数A进行处理）

协议栈的其他模块都是Thrift运行时模块

* 底层IO，负责实际数据的传输，包括Socket、文件或者压缩数据流
* TTransport负责以直接流方式发送和接收Message，是底层IO模块在Thrift框架的实现，每一个底层IO模块都有一个对应的TTransport来负责Thrift的字节流数据在该IO模块上的传输
* TProtocol负责结构化的数据组装成Message，或者从Message读取结构化数据。它将一个有类型的数据转为字节流以交给TTransport进行传输；或者从TTransport中读取一定长度的字节数据转化为特定类型的数据。例如，该层可以将int32转换为一个四个字节的数据；或者从TTransport中取出四个字节的数据Decode为int32类型
* TServer负责接收Client的请求，并且将请求转发到Processor进行处理，其主要任务就是高效接受Client的请求，特别是高并发情况下快速接收并完成转发
* Processor负责对Client的请求作出响应：RPC请求转发、调用参数解析、用户逻辑调用、返回值写回等。是服务端从Thrift框架转入用户逻辑的关键流程，同时也负责Message结构中写入数据或者读出数据。

PS：

1. Thrift的特性在所有程序语言并非相同，可能存在差异
2. 用户运用Thrift只需要a. 运用IDL定义数据结构以及服务，b.运用代码生成工具生成对应的语言的框架代码，c.在生成的代码框架中完成业务逻辑
