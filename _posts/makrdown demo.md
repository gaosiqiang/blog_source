---
title: MarkDown Demo
author: 高思强
date: 2012-08-22 23:00:00
comments: true
tags:
categories:
---

# MarkDown Demo

## 美人鱼图

```mermaid
gantt
title A Gantt Diagram

section Section
A task           :a1, 2014-01-01, 30d
Another task     :after a1  , 20d
section Another
Task in sec      :2014-01-12  , 12d
anther task      : 24d
```



```mermaid
gantt
dateFormat YYYY-MM-DD
section S1
T1: 2014-01-01, 9d
section S2
T2: 2014-01-11, 9d
section S3
T3: 2014-01-02, 9d
```


## MathJax数学公式

$$\sqrt{2} \quad and \quad \sqrt[n]{3}$$


$$f(x_1,x_2,\underbrace{\ldots}_{\rm ldots} ,x_n) = x_1^2 + x_2^2 + \underbrace{\cdots}_{\rm cdots} + x_n^2$$


$$
\left\{
\begin{array}{c}
a_1x+b_1y+c_1z=d_1 \\ 
a_2x+b_2y+c_2z=d_2 \\ 
a_3x+b_3y+c_3z=d_3
\end{array}
\right. 
$$