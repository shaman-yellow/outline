

job0259 项目中，“Receiver细胞的确定” 方案这部分的内容论述我不太明白，
前面的部分筛选好了关键代谢物，但没有说确定关键 Receiver 细胞，
这里提到了确定 Receiver 细胞，但在没有关键基因的情况下，
只有关键代谢物，按方案中论述的，单凭 UMAP 图是无法确定哪个作为关键 Receiver 细胞吧？
 (如果是先做后面 bulk 得到关键基因，再根据关键基因来做 UMAP，也不对，因为根据方案，
后面的关键基因筛选是建立在 Receiver 细胞已经确定好的情况下，用 hdWGCNA 筛选模块去交集再去机器学习……) 

![](/home/echo/Pictures/Screenshots/Screenshot_20260406_135856.png)

以下是方案中的示例图，Fig. 5A，但这个图是凭基因去查看 UMAP 图吧？
所以，方案中论述的“Receiver细胞的确定”是何意呢？
还是说，是根据 Mebocost 中的 Sensor 基因的表达量来确定 Receiver 细胞？
又或者，是在上一步确定关键代谢物的同时，根据网络也确定好对应的最强联系的关键 Receiver 细胞？
——我目前是这么做的。上面这段方案的意思需要明确一下。

![](/home/echo/Pictures/Screenshots/Screenshot_20260406_140721.png)


以下是上一步骤论述确定代谢物的文字：

![](/home/echo/Pictures/Screenshots/Screenshot_20260406_140211.png)

