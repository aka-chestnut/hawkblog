---
title: "Web基础——1.Html常用标签介绍"
date: 2022-03-02T21:37:07+08:00
hidehome: false
draft: false
tags: ["web","html"]
categories: "web"
series: ["前端基础课"]
---
本篇文章主要介绍Html常用标签
<!--more-->
## 文档结构

树形结构，html源码通常是要一个`<html>`标签作为根的树形结构

### 基础标签

1. `<html>`

    文档的根标签（根元素），其他所有的元素必须是该元素的后代
2. `<body>`

    通常包含该文档的内容
3. `<title>`

    定义文档的标题，显示在浏览器的标题栏上，只包含文本（包含的其他标签会被忽略）
4. `<meta>`

    包含不能由元相关元素表示的元数据信息，如编码等

    `charset`文档的字符编码

    `name`额外定义的元数据信息
5. `<icon>`定义logo

    ```html
    <link rel="icon" href="images/icon.png">
    ```

### 多行注释

`<!-- 多行注释 -->`

## 文本标签

文本标签多且复杂，通常都是一些预设好的样式，但大部分都可以看作是`<div>`和`<span>`的衍生：两者的区别是前者看作‘块’，会进行换行；而后者不会换行

1. `<div>`标签

    通用的流内容容器，在不使用css的情况下，对内容或者布局无影响

    其他的块级标签：<h1>, <p>, <pre>, <ul>, <ol>, <table>
2. `<span>`标签

    通用的行内容器，通常在没有合适的语义时才进行使用

    其他的内联标签例如：<i>, <b>, <del>, <ins>, <td>, <a>
3. `<h1>-<h6>`标签

    分级标题标签
4. `<p>`标签

    段落标签，通常表现为一整块与相邻文本分离的文本，或以垂直的空白隔离或以首行缩进
5. `<pre>`标签

    该元素的文本通常按照原文中的格式进行编排，等宽展示，文本中的空白符和换行符都会显示出来
6. `<br>`标签

    换行标签
7. `<hr>`标签

    段落级元素之间的主题转换，以水平线展示。（better use css)
8. `<i>`标签

    斜体
9. `<b>`标签

    加粗
10. `<del>`标签

     删除线
11. `<ins>`标签

     下划线

## 插入图片

将图像嵌入文档，默认为行内元素：`display:inline`

`<img src="/images/mon.jpeg" alt="这是一座山" width=300 height=300>`

包含四个属性

* `src`属性

  图片的路径
* `alt`属性

  可访问性，用于阅读器和无法加载图片时的显示
* `height`属性

  高度
* `width`属性

  宽度

## 插入音频与视频

### `<audio>`标签

用于嵌入音频内容

#### 基本用法

通过src指定路径，并添加文字说明，运用controls显示音频控件

```html
<audio
    controls
    src="/audios/bgm.mp3">
        Your browser does not support the
        <code>audio</code> element.
</audio>
```

#### 备选

可指定多个路径，如果第一个无法播放，则会自动第二个。两个都无法播放，显示空白的controls

```html
<audio controls>
    <source src="/audios/sound1" type="audio/mpeg"/>
    <source src="/audios/sound2" type="audio/mpeg"/>
</audio>
```

### `<video>`标签

与`<audio>`标签很类似

```html
<video controls width="800">

    <source src="/videos/video1.mp4"
            type="video/mp4">

    <source src="/videos/video2.mp4"
            type="video/mp4">

    Sorry, your browser doesn't support embedded videos.
</video>
```

## 超链接

用`<a>`标签表示超链接，可以指向其他网页、文件、同一页面的其他位置、电子邮箱或者其他任何URL的超链接

1. 本页跳转

    `<a href="/about.html">在当前页面打开</a>`
2. 打开新的标签页

    `<a href="https://baidu.com" target="_blank">打开新的标签页</a>`

## 表单

表单是文档中的一个区域，可包含交互空间，用于向Web服务器提交信息，可用来收集用户信息、与后端交互等操作

示例：

```html
<form>
First name:<br>
<input type="text" name="firstname">
<br>
Last name:<br>
<input type="text" name="lastname">
</form>
```

### 表单的类型

1. 基础的单行文本框 `<input type="text">`
2. 带调节器的数字框 `<input type="number">`
3. 邮箱框 `<input type="email">`
4. 密码框 `<input type="password">`
5. 单选/多选框 `<input type="ratio">`

### 表单的常用属性

1. `name` 名称
2. `id` 唯一ID
3. `maxlength` 最大长度
4. `minlength` 最小程度
5. `required` 是否必须
6. `placeholder` 表单控件为空时，控件中显示的内容

### `<label>`标签

通常与表单元素连用，用于定义表单元素的提示字符。

```html
<label for="firstname">用户FirstName</label>
<input type="text" name="firstname" id="firstname">
```

除了用`<label>`进行定义表单提示的方式，也可以使用`placeholder`

```html
<input type="text" name="lastname" placeholder="lastname" id="firstname">
```

两种方式的区别：

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220302211302-2uwrv09.png)

### `<select> <option>`标签

`<select>`一个提供选项菜单的控件

```html
<label for="country">国家：</label>
<select name="test" id="country">
    <option value="">请选择你的国家</option>
    <option value="china">中国</option>
    <option value="russian">俄罗斯</option>
    <option value="other">其他</option>
</select>
```

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220302211710-qnu658f.png)

### `<textarea>`

定义一个多行纯文本编辑控件

### `<textarea>`标签

一个多行纯文本的编辑控件，当希望用户输入一段相当长、不限格式的文本时可用。（评论）  
`<textarea name="test" id="" cols="30" rows="10">这是一个测试</textarea>`

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220302211419-idrqwzf.png)

### `<button>`标签

定义一个可点击的按钮，可用在表单、文档等需要简单按钮的地方。（可用css更改样式）

在表单内的最后定义`<button>提交</button>`

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220302211810-gzkzs0n.png)

### 定义表单下一步动作

可以在`<from>`中指定action来添加表单动作

```html
<!-- 提交后跳到about -->
<form action="/about.html">
```

## 列表

### 无序列表

运用`<ul>`标签定义无序列表，`<li>`代表列表元素

### 有序列表

运用`<ol>`标签定义无序列表，`<li>`代表列表元素

```html
<ul>
  <li>first item</li>
  <li>second item</li>
  <li>third item</li>
</ul>

<ol>
  <li>Fee</li>
  <li>Fi</li>
  <li>Fo</li>
  <li>Fum</li>
</ol>

<!-- 列表的嵌套 通过列表嵌套实现多级列表 -->
<ol>
    <li>test</li>
    <li>test</li>
    <ul>
        <li>test2</li>
        <li>test2</li>
        <ol>
            <li>test3</li>
            <li>test3</li>
        </ol>
    </ul>
</ol>
```

### 描述列表元素

用于展示键值对

```html
<dl>
    <dt>小红</dt>
    <dd>女</dd>
    <dt>马里奥</dt>
    <dd>男</dd>
    <dt>路易</dt>
    <dd>男</dd>
    <dt>小蓝</dt>
    <dd>男</dd>
</dl>
```

![image.png](https://b3logfile.com/siyuan/1617901637880/assets/image-20220302213506-5xa3yb8.png)
