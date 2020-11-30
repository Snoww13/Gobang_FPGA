基于xc7a35tftg256-1的FPGA五子棋
===
测试README.md

环境依赖
---

vivado 2017.4<br>
某FPFA学习板

功能描述
---
行列按键为游戏主要输入，按键分别对应：<br>
上`key14` , 下`key6` 左右<br>
确认 取消<br>

显示为VGA接口视频输出，默认分辨率为<br>

程序结构
---
代码层级<br>

* 主模块
    * 分频
    * 鼠标记录
    * 下标记录
    * 行列键盘
    * 数码管显示
    * VGA显示

### 引用
> 引用别处句子

*斜体* **粗体**
~~删除~~

### 分割线
***
### 代码高亮
``` verilog
always@(posedge clk)
begin

end
```
### To-do List

- [x] 需求分析
- [x] 系统设计
- [x] 详细设计
- [ ] 编码
- [ ] 测试
- [ ] 交付

### 流程图
```
graph TD
    A[dad] -->B(dad)
    B --> C{adsad}
```
> 数据结构
>> 树
>>> 二叉树
>>>> 平衡二叉树
>>>>> 满二叉树

$$
\mathbf{V}_1 \times \mathbf{V}_2 =
\begin{vmatrix}
\mathrm{i} & \mathrm{j} & \mathrm{k} \\
\frac{\partial X}{\partial u} &  \frac{\partial Y}{\partial u} & 0 \\
\frac{\partial X}{\partial v} &  \frac{\partial Y}{\partial v} & 0 \\
\end{vmatrix}
$$
