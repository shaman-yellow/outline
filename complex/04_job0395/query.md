
我这里遇到一个问题。公司需要做靶基因预测，方案如下：

为获取针灸干预脓毒症的潜在作用靶点，本研究采用 SwissTargetPrediction 在线数据库进行靶点预测。SwissTargetPrediction 数据库（<https://www.swisstargetprediction.ch/>）输入针灸活性成分的 SMILES 结构式，选择 “Homosapiens” 为物种，提交后得到预测靶点，取概率值（Probability）> 0.1 的靶点纳入初步靶点集合。

然后公司提供了一个 PDF 文件，里面写有活性成分的表格。但是我看下来，表格中有的大都是细胞或者蛋白之类的。小分子结构太少了。
swissTargetPrediction 应该只支持小分子结构的靶点预测吧。此外，你先帮我整理出 pdf 文件中的小分子化合物吧。

你能根据其中的参考文献，整理出 PMID 给我吗？

最终返回我像这样的格式：

tibble::tribble(
  ~ compound, ~ pmid,
  "name", "123"
)

此外，不管是不是小分子结构，表格1中的全部活性成分，你也整理出 tribble 给我，我来确认你是否有正确识别内容。

全看下来，这里面真正能用于预测的只有这五个 (小分子化合物) ，其他都是无关的。

Dopamine
D-Lactate
Lactic acid
Malondialdehyde
Diacylglycerol

确认一下，是否只用这5个成分。

