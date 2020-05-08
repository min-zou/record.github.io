---
author:
  name: "Xiaox Liu"
title: "Generate Blog with Hexo"
date: 2018-10-23T20:40:11+08:00
draft: false
toc: false
images:
tags:
  - hexo
---
从零开始在hexo+github+阿里云域名下搭建博客

## 一、github page 设置

### 1、rep setting

新建github rep ， 命名为<你的项目名>.github.io

### 2、ssh setting

进入用户设置setting，Personal settings下的SSH and GPG keys ，hit New SSH key

获取当前pc的ssh key，获取方法见
粘贴获取到的key至github中

### 3、connect setting

打开安装后的git(默认安装)，选择你的本地git仓库(在想放置仓库的位置新建文件夹‘git-test’)

``` bash 
$ git clone https://github.com/your rep.git
```
在git bash或终端中添加用户名和邮箱，

``` bash
$ git config --global user.name "your name"
$ git config --global user.email your email
```

### 4、git setting

在项目目录下进行一下操作即可提交代码：

```bash
$ git add .
$ git status #(查看修改的地方)

$ git commit -m "your information about commit" #
(必须添加说明)
$ git push -u origin master （#first push with '-u'）
```

### 5、Domain Name setting

在阿里云注册域名，根据自己要求选择套餐

在域名控制台中选择域名解析，DNMA-www-10min-your rep's name(e.g. robot-github.github.io)

完成后打开github在项目setting中修改Github Pages中的Custom domain，添加你的域名并save

完成后关闭网页，此时已经可以通过自己的域名打开网页了，网页模板为新建github page rep时默认的主题

## 二、hexo配置

### 1、hexo install

hexo安装需要git和node.js，git一般ubuntu默认安装，windows下在前文已经安装完毕，则是需要安装Node.js，官方下载及教程如下：

官方下载地址：[下载Node.js](https://nodejs.org/download/)

官方安装教程：[安装Node.js](http://www.runoob.com/nodejs/nodejs-install-setup.html)

完成nodejs安装之后即可以安装hexo

```bash
$ npm install hexo-cli -g
$ cd git-test  #也即前文设置的文件夹目录下
$ hexo init blog
$ cd blog
$ npm install
$ hexo g  
$ hexo s #可以在http://localhost:4000/ 查看
```

hexo g 即hexo generate ，运行此命令会生成静态文件，在public文件夹中

hexo s 则会启动本地web服务，类似sublime的预览

More info: [官方文档](https://hexo.io/docs.html)

### 2、部署hexo到github page

并没有使用deploy部署，参考[手把手...](https://segmentfault.com/a/1190000004947261)博客中的做法使用git命令行部署，避免莫名其妙的问题

具体做法如下：

```bash
$ cd blog
$ git clone https://github.com/your rep.git .deploy/your rep
$ hexo g
$ cp -r pblic/* .deploy/your rep
$ cd .deploy/your rep
$ #一、4 git setting
```

提交完成之后即可打开购买的域名，查看网页了

其余具体的博客撰写查看[官方文档](https://hexo.io/docs.html)即可
