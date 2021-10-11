---
author:
  name: "Xiaox Liu"
title: "Camera"
date: 2020-05-25T10:49:39+08:00
draft: false
toc: false
images:
tags:
  - camera model
---
## 鱼眼相机模型
### 一、Mei相机模型 omni+radtan
标定参数为：
$$x_1,k_1,k_2,p_1,p_2$$

矫正：
1. 设置射影矫正的相机内参
opencv函数获取或按照推荐的内参矩阵进行设置
2. 通过设置的新相机内参得到相机坐标系下的三维坐标
$$x=\frac{u-c_x^{new}}{f_x^{new}}$$
$$y=\frac{v-c_y^{new}}{f_y^{new}}$$
3. 投影到归一化平面
球半径 $$r=\sqrt{x^2+y^2+1}$$
即可得坐标为
$$
\begin{bmatrix} 
    \frac{x}{r}&\frac{y}{r}&\frac{1}{r}
\end{bmatrix}
$$
4. 将上述点变换到另一坐标系下，与标定系数x相关
此时坐标为
$$
\begin{bmatrix} 
    \frac{x}{r}&\frac{y}{r}&\frac{1}{r}+x_i
\end{bmatrix}
$$
5. 投影至归一化平面
记上述坐标为
$$
\begin{bmatrix} 
    X_s&Y_s&Z_s+x_i
\end{bmatrix}
$$
归一化后可得
$$
\begin{bmatrix} 
    \frac{X_s}{Z_s+x_i}&\frac{Y_s}{Z_s+x_i}&1
\end{bmatrix}
$$
记为
$$\begin{bmatrix} 
    x_1&y_1&1
\end{bmatrix}$$
6. 添加畸变
$$x_d=x_1(1+k_1(x^2_1+y^2_1)+k_2{(x^2_1+y^2_1)}^2)+2p_1x_1y_1+
p_2({(x^2_1+y^2_1)+2x^2_1})$$
$$y_d=y_1(1+k_1(x^2_1+y^2_1)+k_2{(x^2_1+y^2_1)}^2)+2p_2x_1y_1+
p_1({(x^2_1+y^2_1)+2y^2_1})$$
7. 通过内参系数进行投影
得到
$$
\begin{bmatrix} 
    f_xx_d+c_x&f_yy_d+c_y
\end{bmatrix}
$$
8. remap得到矫正图像

### 二、atan相机模型 pinhole+fov
标定参数为
$$w$$
1. 设置射影矫正的内参并投影至世界坐标系
$$x=\frac{u-c^{new}_x}{f^{new}_x}$$
$$y=\frac{v-c_y^{new}}{f_y^{new}}$$
2. 计算相机图像平面投影半径
$$r=\sqrt{x_2+y_2}$$
$$r_d = \frac{1}{w}arctan(2rtan(\frac{w}{2}))$$
3. 添加畸变
$$x_d=\frac{r_d}rx$$
$$y_d=\frac{r_d}ry$$

### 三、opencv等距鱼眼相机模型 pinhole+equi
标定参数为
$$k_1,k_2,k_3,k_4$$
与fov类似
简略步骤如下：
$$r=\sqrt{(x_2+y_2)}$$
$$\theta=arctan({r})$$
$$ \theta_d=\theta(1+k_1\theta^2+k_2\theta^4+k_3\theta^5+k_4\theta^8)$$
$$
\begin{bmatrix} 
    x_d&y_d
\end{bmatrix}=
\begin{bmatrix} 
    f_x\frac{\theta_d}{\theta}x+c_x&f_y\frac{\theta_d}{\theta}y+c_y
\end{bmatrix}
$$