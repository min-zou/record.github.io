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
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
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

#### 3.markdown中插入公式

在文件前加入
```
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
```
即可使用latex编辑公式并显示。
例：
```
$$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$
```
可显示为：
$$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$

#### 4.增加标签
参考[A simple shortcode to add tags for Hugo.](https://github.com/kazukyakayashi/Hugo-Tag-Shortcode)

- {{< tag update >}}🎊 dUpdddate{{< /tag >}}
- {{< tag add >}}🎉 Add{{< /tag >}}
- {{< tag changed >}}🔩 Changed{{< /tag >}} 
- {{< tag warning >}}💣 Warning{{< /tag >}}
- {{< tag deprecated >}}👻 Deprecated{{< /tag >}} 

#### 5.增加menu图标
参考[Hugo、Hexo博客搭建及Hugo的自定义配置](https://blog.csdn.net/qq_37908043/article/details/93350094)
阿里云下载图标后解压至本地，将eot、svg、ttf、woff等不同平台支持的格式复制放入static/fonts/iconfont下，在assets/scss文件夹下找到_fonts.scss文件，在其中将下载的css文件中内容完整复制过来。

同时文件路径src：url设置上述支持格式的路径并自定义名称，例：
```
@font-face {
  font-family: "iconfont";
  src: url('../fonts/iconfont/iconfont.eot?t=1590470537939'); /* IE9 */
  ...
}
.icon-fun:before {
  content: "\e633";
}
```

在layouts/partials下修改menu.html:
```
  <li>
  <a href="{{ .URL | absLangURL }}"><i class="iconfont {{ .Identifier }}"></i>{{ .Name }}</a>
  </li>
```
完成之后在config.toml中设置identifier，例：
```
  [[menu.main]]
    identifier = "icon-fun"
```
#### 6. shortcode自定义 
{{< bilibili BV18t41187Bx 3 >}}