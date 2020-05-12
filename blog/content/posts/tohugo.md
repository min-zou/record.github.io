---
author:
  name: "Xiaox Liu"
title: "Tohugo"
date: 2020-05-08T14:34:25+08:00
draft: false
toc: true
images:
tags:
  - hugo
---
## hugo折腾过程

### 记录博客从hexo迁移至hugo所遇到的问题

转向hugo也是因为hugo生成很快并且支持修改在线预览，同时也有hugo构建和使用很方便的原因。



#### 1. github page部署之后无法加载css和js
原因其实很简单，hugo编译静态站点时需要指定baseurl，本地预览时设置的localhost需要在生成静态页面时重新给定，即
```
hugo --theme=hello-friend-ng --baseUrl="https://xxx.github.io"
```

所使用的主题是[hello-friend-ng](https://github.com/rhazdon/hugo-theme-hello-friend-ng/)，极简但还挺好看的。
#### 2. 页面menu点击后跳转错误
其实还是和baseurl相关，config.toml中设置的
```
  [[menu.main]]
    identifier = "blog"
    name       = "Record"
    pre = "<i class='fa fa-road'></i>"
    url        = "/posts"
```
其页面url是和baseurl不一致的，它会使用root路径，在使用github page部署时会出现问题，因此将[canonifyURLs](https://gohugo.io/getting-started/configuration/#all-configuration-settings)设置为false以寻找相对路径而不是直接绝对路径给定了。

#### ...
