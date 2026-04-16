
统一为标准 Markdown（LaTeX）行内公式写法如下：

---

**最终公式：**

$$ FinalScore(m,r) = \left( \sum_{s,k} CommuScore_{PD}(s,m,k,r) \times |Log2FC(s,m,k,r)| \right) \times PR(m) $$

---

**说明（段落形式）：**

其中，$s$ 表示 Sender（信号发送细胞类型），$m$ 表示 Metabolite（代谢物），$k$ 表示 Sensor（代谢物对应的受体或转运分子），$r$ 表示 Receiver（信号接收细胞类型）；$CommuScore_{PD}(s,m,k,r)$ 表示在 PD 组中针对完整通讯链（Sender–Metabolite–Sensor–Receiver）计算得到的通讯强度评分；$Log2FC(s,m,k,r)$ 表示 PD 组相对于对照组的通讯强度对数倍数变化，其绝对值用于刻画差异幅度；对所有上游 Sender 与 Sensor 进行求和，实现对通讯事件在代谢物–受体细胞层面的聚合，从而得到局部通讯强度；$PR(m)$ 表示在以差异加权权重为边权构建的有向网络（Sender→Metabolite→Receiver）中计算得到的代谢物节点 PageRank 值，用于表征其在全局网络中的拓扑重要性。该综合评分同时整合了通讯强度、差异程度及网络结构信息，可用于筛选在 PD 微环境中具有关键调控作用的代谢物及其对应的受体细胞。


