---
author:
  name: "Xiaox Liu"
title: "Kinect_capture"
date: 2018-10-26T15:23:06+08:00
draft: false
toc: false
images:
tags:
  - Kinect
---

最近在跑离线ORBSLAM2，需要本地数据集。 手头靠谱点的相机暂时只有Kinect，还是一代。 
因此基本方法就是使用kinect去截取每帧图片，保存到本地。 
开源驱动libfreenect刚好提供了这一工具，驱动方式便选择libfreenect了。 
<!--more-->

## start
```bash
$ git clone https://github.com/OpenKinect/libfreenect
$ cd libfreenect
$ mkdir build
$ cd build
$ cmake .. 
$ make
```
以上则是编译libfreenect的过程，README.md文件中也有相同的说明。

## record

编译完成之后其实就可以开始图片数据集采集了，在libfreenect下build/bin文件夹中可以找到fakenect-record二进制执行文件。运行之，得到提示

```bash
record [-h] [-ffmpeg] [-ffmpeg-opts <option>] <target basename>
```

对于任务要求，我们只需要设置basename参数，也即是存放图片数据集的本地目录。

重新运行fakenect-record，即可在所选的路径下找到截取的一帧帧图片。


