以标准化熵筛选于样本中相对均衡分布的细胞 (Natural killer cell, Platelet, Mature endothelial cell, B cell, Myeloid cell, Neutrophil, Monocyte, Neural stem cell, Unknown) (cutoff: 0.5) 

(给定离散随机变量 $X$，其取值为 ${x_1, x_2,...,x_K}$，对应概率分布为 $P(X = x_i) = p_i$，则 **归一化香农熵** 定义为：$H_{\text{norm}}(X) = \frac{ -\sum_{i=1}^K p_i \log p_i }{ \log K }$，取值范围 $0 \leq H_{\text{norm}}(X) \leq 1$)。

去除未知细胞 (unknown)。

在选定的细胞中，分析两组 features (即，[_基因集_ (NAT10, LINC02193, DDX10P1, ...[n = 116], 来自于FUSION TWAS全转录组关联研究[Section: AA]) ]{.underline}，与 [_代谢通量_ (Platelet_AA - Platelet_Normal, Myeloid_cell_AA ..., ...[n = 12], 来自于Limma 代谢通量差异分析[Section: AA_FLUX]) ]{.underline})。

对于基因集，在各组细胞中，以阈值穿透率去除低表达的基因 (例如，去除总体表达为 0 的基因) (阈值：0，穿透率 cutoff：0.3) (设某基因 $g$ 在细胞群体 $C$ 中的表达值集合为 ${e_c | c \in C}$，给定阈值 $\tau$，则 **阈值穿透率** 定义为：$\text{Penetration}(g, C, \tau) = \frac{ \sum_{c \in C} \mathbf{1}_{\{e_c > \tau\}} }{ |C| } \times 100\%$ ($\mathbf{1}_{{e_c > \tau}}$ 是指示函数，当 $e_c > \tau$ 时为 1，否则为 0))。

