**生物医药合作项目开发**

**研究方向： [再生障碍性贫血 ;]{.underline}**

**委托人： [邓姝 ;]{.underline}**

**受托人： [杭州铂赛生物科技有限公司 .]{.underline}**

1 研究背景
==========

1.1 思路
--------

再生障碍性贫血 (Aplastic anemia，AA)
是指骨髓无法形成血液，这是多种病理生理机制对终末器官的影响) [(2018,
**IF:96.2**, Q1, The New England journal of medicine)]{.highlight}^1^。
骨髓被脂肪取代的常见病理可能是化学或物理损伤（医源性；苯）；免疫破坏（主要是
T 细胞）；以及维持细胞完整性和免疫调节的重要基因的体质缺陷
(Constitutional Syndromes)。 体质性骨髓衰竭的患者中，大多数患者年龄在 18
岁以下，约 50% 在基因组筛查中出现突变。 免疫性 AA (Immune aplastic
anemia，IAA) 中，细胞毒性 T 细胞在功能和表型上处于激活态，通过 Fas/FasL
诱导细胞凋亡，并以寡克隆形式循环 (2018, **IF:96.2**, Q1, The New England
journal of medicine)^1^。 此外，免疫性 AA 会发生干细胞突变导致的免疫逃逸
(丢失了包含 HLA 等位基因的 6 号染色体区域的粒细胞)
，通过克隆扩增发挥替代造血的功能。 全基因组关联研究 (Genome-Wide
Association Study，GWAS) 研究显示，HLA-DPB1 种系的 SNP 提高了重症 AA
(SAA) 的风险 (2020, **IF:8.1**, Q1, American journal of human
genetics)^2^。

细胞代谢与 AA 的发展有所关联。最近的研究表明，SAA
患者的血浆代谢组和肠道微生物组成均异常 (2021, **IF:4.6**, Q1, Frontiers
in cell and developmental biology)^3^。此外，一项儿童的 scRNA-seq
数据分析表明，T淋巴细胞的代谢异常主要集中在糖酵解/糖异生上。此外，自然杀伤细胞的代谢异常集中在氧化磷酸化上，治疗免疫细胞的异常代谢途径可能有助于开发治疗
AA 的新策略 (2023, **IF:3.5**, Q2, Frontiers in oncology)^4^。

综上，结合 TWAS 以及 AA 的细胞代谢的分析策略将可能成为发现 AA
疾病机制或治疗的重要方法。通过 TWAS
发现源于遗传突变导致的基因表达改变，随后在 AA
的细胞代写上分析这种影响，从而发现基因突变对于 AA 患者细胞代谢的改变。

2 可行性
========

2.1 以 `"Aplastic anemia" AND "GWAS"` 搜索文献。
------------------------------------------------

![](media/image3.png){width="6.2in" height="2.825in"}

2.2 以 `"Aplastic anemia" AND "metabolic"` 搜索文献。
-----------------------------------------------------

![](media/image4.png){width="6.2in" height="2.984027777777778in"}

3 创新性
========

3.1 以 `"Aplastic anemia" AND "TWAS"` 搜索文献。
------------------------------------------------

![](media/image5.png){width="6.2in" height="2.611111111111111in"}

3.2 以 `"Aplastic anemia" AND "TWAS" AND "metabolic"` 搜索文献。
----------------------------------------------------------------

![](media/image6.png){width="6.2in" height="2.3472222222222223in"}

4 参考文献和数据集
==================

4.1 GWAS 数据
-------------

> **Tab.** Traits in Open GWAS

+----------------------+-------------------+------------+---------+--------------+
| > Id                 | > Trait           | > Coverage | > Ncase | > Group name |
+----------------------+-------------------+------------+---------+--------------+
| > Ebi-a-GCST90018794 | > Aplastic anemia |            | > 4128  | > Public     |
+----------------------+-------------------+------------+---------+--------------+
| > Ebi-a-GCST90018574 | > Aplastic anemia |            | > 53    | > Public     |
+----------------------+-------------------+------------+---------+--------------+

Tab. 在 Open GWAS 中匹配到的可用数据集 (GWAS统计数据)。

4.2 scRNA-seq
-------------

-   GSE279914

> **Tab.** AA GSE279914 metadata

+-------------+-------------+-------------+-------------+-------------+
| > Rownames  | > Title     | > Batch.ch1 | > Ce        | > Diseas    |
|             |             |             | ll.line.ch1 | e.state.ch1 |
+-------------+-------------+-------------+-------------+-------------+
| >           | > EG34,     | > 9         | > None      | > Diagnosis |
|  GSM8583310 | > EG35      |             |             |             |
|             | > CITE-seq  |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| >           | > EG36,     | > 9         | > Nalm-6,   | > Follow-up |
|  GSM8583311 | > EG37,     |             | > HL-60,    |             |
|             | > CellL\... |             | > Ju\...    |             |
+-------------+-------------+-------------+-------------+-------------+
| >           | > EG38,     | > 10        | > Nalm-6,   | > Diagnosis |
|  GSM8583312 | > EG39,     |             | > HL-60,    |             |
|             | > CellL\... |             | > Ju\...    |             |
+-------------+-------------+-------------+-------------+-------------+
| >           | > EG40,     | > 10        | > None      | > Diagnosis |
|  GSM8583313 | > EG41      |             |             |             |
|             | > CITE-seq  |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| >           | > EG46,     | > 12        | > Nalm-6,   | > Diagnosis |
|  GSM8583314 | > EG47,     |             | > HL-60,    |             |
|             | > CellL\... |             | > Ju\...    |             |
+-------------+-------------+-------------+-------------+-------------+
| > \...      | > \...      | > \...      | > \...      | > \...      |
+-------------+-------------+-------------+-------------+-------------+

4.3 单细胞数据预测代谢通量的方法
--------------------------------

-   scFEA 通过scRNA-seq 预测代谢通量 (2021, **IF:6.2**, Q1, Genome
    research)^5^
-   scFEA 的应用实例 (2023, **IF:3.9**, Q2, Frontiers in
    endocrinology)^6^

以标准化熵筛选于样本中相对均衡分布的细胞 (Natural killer cell, Platelet,
Mature endothelial cell, B cell, Myeloid cell, Neutrophil, Monocyte,
Neural stem cell, Unknown) (cutoff: 0.5)

(给定离散随机变量 $X$，其取值为 $x_{1},x_{2},...,x_{K}$，对应概率分布为
$P(X = x_{i}) = p_{i}$，则 **归一化香农熵**
定义为：$H_{\text{norm}}(X) = \frac{- \sum_{i = 1}^{K}p_{i}\text{log}p_{i}}{\text{log}K}$，取值范围
$0 \leq H_{\text{norm}}(X) \leq 1$)。

去除未知细胞 (unknown)。

在选定的细胞中，分析两组 ~features~ (即，\~ 基因集 (NAT10, LINC02193,
DDX10P1, ...\[n = 116\], 来自于FUSION TWAS全转录组关联研究\[Section:
AA\]) \~ ，与 *代谢通量\~(Platelet\_AA - Platelet\_Normal,
Myeloid\_cell\_AA ..., ...\[n = 12\], 来自于Limma
代谢通量差异分析\[Section: AA\_FLUX\])\~* )。

对于基因集，在各组细胞中，以阈值穿透率去除低表达的基因
(例如，去除总体表达为 0 的基因) (阈值：0，穿透率 cutoff：0.3) (设某基因
$g$ 在细胞群体 $C$ 中的表达值集合为 $e_{c}|c \in C$，给定阈值 $\tau$，则
**阈值穿透率**
定义为：$\text{Penetration}(g,C,\tau) = \frac{\sum_{c \in C}^{}\mathbf{1}_{\{ e_{c} > \tau\}}}{|C|} \times 100\%$
($\mathbf{1}_{e_{c} > \tau}$ 是指示函数，当 $e_{c} > \tau$ 时为
1，否则为 0))。

Reference
=========

1\. Young, N. S. Aplastic anemia. *The New England journal of medicine*
**379**, 1643--1656 (2018).

2\. Savage, S. A. *et al.* Genome-wide association study identifies
hla-dpb1 as a significant risk factor for severe aplastic anemia.
*American journal of human genetics* **106**, 264--271 (2020).

3\. Shao, Y. *et al.* Plasma metabolomic and intestinal microbial
analyses of patients with severe aplastic anemia. *Frontiers in cell and
developmental biology* **9**, (2021).

4\. Zhou, Q. *et al.* Single-cell rna sequencing depicts metabolic
changes in children with aplastic anemia. *Frontiers in oncology*
**13**, (2023).

5\. Alghamdi, N. *et al.* A graph neural network model to estimate
cell-wise metabolic flux using single-cell rna-seq data. *Genome
research* **31**, 1867--1884 (2021).

6\. Agoro, R. *et al.* Single cell cortical bone transcriptomics define
novel osteolineage gene sets altered in chronic kidney disease.
*Frontiers in endocrinology* **14**, (2023).
