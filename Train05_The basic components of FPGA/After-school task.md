1、考虑以下逻辑需要用几个LUT6来实现。

```
assign result0 = a ^ b & c | d;
assign result1 = c ^ e | b & d;
```

2、Single Port RAM、Simple Dual Port RAM、True Dual Port RAM的含义与区别；

3、Dual Port RAM的三种工作模式：Read First、Write First、No Change各是什么含义？

4、一个True Dual Port RAM，数据位宽为19bit，深度为1024，消耗几个BRAM18k资源？如果数据位宽为18bit，深度仍为1024，消耗几个BRAM18k资源？

5、使用Vivado工具打开DSP Macro IP，查看DSP支持哪些运算。

6、使用Input Buffer、Output Buffer时分别对输入、输出信号有何要求？

7、了解PLL的结构，PLL由哪些组件构成。



