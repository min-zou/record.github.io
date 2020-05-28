---
author:
  name: "Xiaox Liu"
title: "Git"
date: 2020-05-27T14:48:36+08:00
draft: true
toc: false
images:
tags:
  - git
---
<!-- <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script> -->
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

## git使用记录
### 1. git reset
某次使用sublime merge操作时没注意，reset mixed后又不小心放弃了所有add的修改，即某个时间点后的代码全都没有了，还好习惯本地提交，保留有相关信息
```
git reflog
```
即可得到所有的操作记录，例：
```
...
a2b28f2 HEAD@{0}: amend
8008739 HEAD@{1}: checkout: ...
521fe2e HEAD@{2}: checkout: ...
8008739 HEAD@{3}: amend
cf8e3ae HEAD@{4}: commit (merge): Merge branch 'master' ...
...
```
此时即可选择最近时间点正常的提交，例如8008739，进行
```
git reset 8008739 --hard
```
即可将当前分支回滚到此处节点。

当然若是未提交状态下丢失修改，那就只能重写了。