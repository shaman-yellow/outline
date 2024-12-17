## 3.2 Mfuzz 聚类分析 (MRNA)

* Content: 8, 10 为按时序上调
* Author: Anonymous
* Comment: 8不能算上调吧 ,  总感觉这个时序结果怪怪的\...

> Reply: 

---------------


## 3.3 富集分析 (MRNA)

* Content: ![](media/image11.png){width="6.2in" height="4.959722222222222in"}
* Author: Anonymous
* Comment: 这个图的比例可以适当调整下，太宽了

> Reply: 

---------------


## 3.5 COX 回归 (LUNG)

* Content: 在单因素 COX 回归的基础上
* Author: Anonymous
* Comment: 对那些基因进行COX?在怎么样的条件下，还保留多少个基因进行的lasso？

> Reply: 

---------------

* Content: 见 Tab. [**1**](\l)
* Author: Anonymous
* Comment: 要对所以的标识性结果进行描述或者解释，不然后期编辑不好写。

> Reply: 

---------------

* Content: ![](media/image14.png){width="6.2in" height="6.2in"}
* Author: Anonymous
* Comment: 横坐标的λ呢？

> Reply: 

---------------

* Content: **Tab.** **1** > LUNG sig Multivariate Cox Coefficients
* Author: Anonymous
* Comment: 多因素筛到多少个基因？有没有用step进行基因过滤？

> Reply: 

---------------


## 3.6 Survival 生存分析 (LUNG)

* Content: ![](media/image16.png){width="6.2in" height="4.133333333333334in"}
* Author: Anonymous
* Comment: 样本名称不用展示 ,  一般预后模型的基因最好控制在10个以内，后期做实验好把控，这将近30个基因，有点小多。

> Reply: 

---------------

* Content: ![](media/image17.png){width="6.2in" height="4.76875in"}
* Author: Anonymous
* Comment: 调整宽度，以及下方的表格和KM曲线横坐标不对称

> Reply: 

---------------


## 3.7 GEO 数据获取 (GEO\_LUAD)

* Content: ![](media/image21.png){width="6.2in" height="4.76875in"}
* Author: Anonymous
* Comment: 按照中位值不行，试着用survminer包中的surv\_cutpoint函数按照最佳阈值去划分组别，看看KM曲线会不会显著

> Reply: 

---------------

* Content: ![](media/image22.png){width="6.2in" height="6.2in"}
* Author: Anonymous
* Comment: 这个不行，肺癌的数据集挺多的啊， ,  GSE30219 ,  GSE50081 ,  GSE31210 ,  GSE11969 ,  GSE68465

> Reply: 

---------------


