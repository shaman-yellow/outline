
----------

本研究中，以 swissTargetPrediction 预测 **化合物集** (针灸干预脓毒症活
性成分: Dopamine, D-Lactate, Lactic acid, Malondialdehyde,
Diacylglycerol) 的作用靶点。设定靶点概率阈值 Probability 为 0.1。共得到
13 个唯一靶点【各成分的靶点统计：Diacylglycerol (n=3) , Dopamine (n=10)
】。

----------

现在的问题是，能使用的活性成分很少，再加上预测的靶点很少，只能得到 13 个针灸干预靶点。
再加上 DEGs 差异基因交集，只剩下 3 个靶点了。DEGs 我已经把阈值挑到最低了。

我现在这边已经没有任何调整空间了，需要方案那边调整方法。

注：如果不对 swissTargetPrediction 的 Probability 加阈值限制的话，靶点各成分靶点数量如下 (会多很多)
D-Lactate (n=10) , Diacylglycerol (n=106) , Dopamine (n=107) , Lactic acid (n=10) , Malondialdehyde (n=1) 

如果不卡 Probability，最终对 DEGs (sepsis vs healthy), Acupuncture Target 取交集，可以得到35个交集


