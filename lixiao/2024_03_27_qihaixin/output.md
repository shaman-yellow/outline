---
title: 
bibliography: '/home/echo/utils.tool/inst/extdata/library.bib'
csl: '/home/echo/utils.tool/inst/extdata/nature.csl'
reference-section-title: "Reference"
link-citations: true
output:
  bookdown::pdf_document2:
    # pandoc_args: [
      # "--filter", "pandoc-fignos",
      # "--filter", "pandoc-tablenos"
    # ]
    keep_tex: true
    keep_md: true
    toc: false
    # toc_depth: 4
    latex_engine: xelatex
header-includes:
  \usepackage{caption}
  \captionsetup{font={footnotesize},width=6in}
  \renewcommand{\dblfloatpagefraction}{.9}
  \makeatletter
  \renewenvironment{figure}
  {\def\@captype{figure}}
  \makeatother
  \@ifundefined{Shaded}{\newenvironment{Shaded}}
  \@ifundefined{snugshade}{\newenvironment{snugshade}}
  \renewenvironment{Shaded}{\begin{snugshade}}{\end{snugshade}}
  \definecolor{shadecolor}{RGB}{230,230,230}
  \usepackage{xeCJK}
  \usepackage{setspace}
  \setstretch{1.3} 
  \usepackage{tcolorbox}
  \setcounter{secnumdepth}{4}
  \setcounter{tocdepth}{4}
  \usepackage{wallpaper}
  \usepackage[absolute]{textpos}
  \tcbuselibrary{breakable}
  \renewenvironment{Shaded}
  {\begin{tcolorbox}[colback = gray!10, colframe = gray!40, width = 16cm,
    arc = 1mm, auto outer arc, title = {R input}]}
  {\end{tcolorbox}}
  \usepackage{titlesec}
  \titleformat{\paragraph}
  {\fontsize{10pt}{0pt}\bfseries} {\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}} {1em} {} []

---






\begin{titlepage} \newgeometry{top=7.5cm}
\ThisCenterWallPaper{1.12}{~/outline/lixiao//cover_page.pdf}
\begin{center} \textbf{\Huge
中药复方乌梅丸网络药理学分析} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-01}}
\end{textblock} \begin{textblock}{10}(3,7.3)
\Large \textcolor{black}{LiChuang Huang}
\end{textblock} \begin{textblock}{10}(3,11.3)
\Large \textcolor{black}{@立效研究院}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}

\tableofcontents

\listoffigures

\listoftables

\newpage

\pagenumbering{arabic}

# 摘要 {#abstract}

## 需求

中药复方乌梅丸：乌梅，花椒，细辛，黄连，黄柏，干姜，附子，桂枝，人参，当归

疾病：慢性结肠炎，炎性肠病，肠纤维化，可以都包含，也可以单独一种疾病（如果单独疾病可以做出来，优先级按照语序来）

目标：筛出有效成分XX，及其作用靶点蛋白YY，YY需满足：1、与XX能对接 2、富集分析显示YY与疾病相关的机制相关（比如炎症，纤维化，再放宽可以免疫细胞调控）

其它：

1、选取中药复方（乌梅丸）中和调控纤维化相关的单体成分，结合pubchem、chemical book、scifinder等数据库分析排名靠前的化合物的活性信息，并通过中医网络药理学方法（如TCMSP平台和BATMAN-TCM数据库），分析有效成分XXX的对应靶点YYY，功能富集分析显示YYY调控肠道纤维化。

2、、通过PubChem数据库获取中药单体主要活性成分的2D化学结构，在PDB数据库中查找相关核心靶点蛋白3D结构，通过Autodock软件进行分子对接，获取结合能最高的位点，最后通过Pymol软件进行可视化处理。

交付：

1. 疾病-复方-成分-靶点网络图
2. 成分XX-靶点网络图
3. XX与YY分子对接pymol可视化图，注意细节标注
4. 成分XX靶点功能富集分析
5. 总的复方靶点的功能富集分析
6. YY可能参与的环节需要标注在4上或者单独注释分

## 结果

1. 利用 BATMAN-TCM 数据库作为成分靶点数据库，并结合 Fig. \@ref(fig:Overall-targets-number-of-datasets) 所示的疾病靶点数据
   获得的疾病-复方-成分-靶点网络图见 Fig. \@ref(fig:Network-pharmacology-with-disease)
2. 筛选的成分的靶点关系图见 Fig. \@ref(fig:TOP-pharmacology-visualization)。
   这里的成分是后续的分析和分子对接筛选的 TOP 1，其名称等相关信息 (TOP 1-3) 可参考 Tab. \@ref(tab:Metadata-of-visualized-Docking)
3. Pymol 可视化见 Fig. \@ref(fig:Docking-72326-into-9ilb-detail) (局部放大加注释),
   Fig. \@ref(fig:Docking-72326-into-9ilb) (全局图)。
   此外，对接 TOP 2 和 TOP 3 的可视化也附在随后。
4. TOP 1 成分的富集分析见 Fig. \@ref(fig:TOP-KEGG-enrichment) 和 Fig. \@ref(fig:TOP-GO-enrichment)
5. 总的复方靶点的富集分析见 Fig. \@ref(fig:HERBS-KEGG-enrichment) 和 Fig. \@ref(fig:HERBS-GO-enrichment)
6. YY  (TOP 1 对应的结合靶点为 IL1B ) 参与的环节见
   Fig. \@ref(fig:TOP-hsa05321-visualization)

补充说明：

- TCMSP 网站最近几日都无法打开，所以草药数据来源只选用 BATMAN (这个数据库比 TCMSP 全面) 。
- 关于 “结合pubchem、chemical book、scifinder等数据库分析排名靠前的化合物的活性信息”，
  chemical book 和 scifinder 为商业工具，预计是无法获取权限的，这里没有使用；
  而 PubChem，我这里的分析中获取了成分的文献记录，即 LiteratureCount，
  具体可见 Tab. \@ref(tab:All-compounds-Literature-Count)，
  Tab. \@ref(tab:hsa05321-related-genes-and-compounds)。
  此外，还根据 CTD 对疾病相关的成分做了筛选，
  Fig. \@ref(fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related)
- 其它候选成分靶点 Tab. \@ref(tab:Intersection-Herbs-compounds-and-targets)
- 分子对接良好的结果汇总表格 Tab. \@ref(tab:Combining-Affinity)




# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Database `BATMAN-TCM` was used as source data of TCM ingredients and target proteins[@BatmanTcm20Kong2024].
- The Comparative Toxicogenomics Database (CTD) used for finding relationship between chemicals and disease[@ComparativeToxDavis2023].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行4列，以下预览的表格可能省略部分数据；表格含有10个唯一`Pinyin.Name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Pinyin.Name |Chinese.Name |English.Name         |Latin.Name           |
|:-----------|:------------|:--------------------|:--------------------|
|FU ZI       |附子         |Prepared common m... |Aconitum carmichaeli |
|GAN JIANG   |干姜         |Common ginger dri... |Zingiber officinale  |
|DANG GUI    |当归         |Chinese angelica ... |Angelica sinensis    |
|REN SHEN    |人参         |Ginseng              |Panax ginseng  [s... |
|XI XIN      |细辛         |Siebold wildginge... |Asarum sieboldii     |
|GUI ZHI     |桂枝         |Cassiabarktree twig  |Cinnamomum cassia... |
|HUA JIAO    |花椒         |Bunge pricklyash ... |Zanthoxylum bunge... |
|WU MEI      |乌梅         |Japanese apricot     |Prunus mume          |
|HUANG LIAN  |黄连         |Chinese goldthrea... |Coptis chinensis     |
|HUANG BAI   |黄柏         |Amur corktree equ... |Phellodendron amu... |

Figure \@ref(fig:intersection-of-all-compounds) (下方图) 为图intersection of all compounds概览。

**(对应文件为 `Figure+Table/intersection-of-all-compounds.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/intersection-of-all-compounds.pdf}
\caption{Intersection of all compounds}\label{fig:intersection-of-all-compounds}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/intersection-of-all-compounds-content`)**

### 成分靶点

Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/tables-of-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15264行3列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Herb_pinyin_name |Ingredient.name                |Target.name |
|:----------------|:------------------------------|:-----------|
|GUI ZHI          |3,4-dihydroxybenzoic acid      |AKT1        |
|GUI ZHI          |3,4-dihydroxybenzoic acid      |MGAM        |
|GUI ZHI          |[5-(6-aminopurin-9-yl)-4-hy... |NA          |
|GUI ZHI          |3-hydroxybenzaldehyde          |NA          |
|GUI ZHI          |3-phenylpropanoic acid         |NA          |
|GUI ZHI          |4-hydroxybenzoic acid          |HDAC6       |
|GUI ZHI          |acetaldehyde                   |HDAC11      |
|GUI ZHI          |acetaldehyde                   |MMP2        |
|GUI ZHI          |acetaldehyde                   |CDT1        |
|GUI ZHI          |acetaldehyde                   |CAT         |
|GUI ZHI          |acetaldehyde                   |MMP1        |
|GUI ZHI          |acetaldehyde                   |PPARG       |
|GUI ZHI          |acetaldehyde                   |TIMP1       |
|GUI ZHI          |acetaldehyde                   |AGT         |
|GUI ZHI          |acetaldehyde                   |IL1B        |
|...              |...                            |...         |



### 疾病靶点

Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    chronic colitis

\vspace{2em}


\textbf{
Restrict (with quotes)
:}

\vspace{0.5em}

    TRUE

\vspace{2em}


\textbf{
Filtering by Score:
:}

\vspace{0.5em}

    Score > 0

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:GeneCards-used-data) (下方表格) 为表格GeneCards used data概览。

**(对应文件为 `Figure+Table/GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有172行7列，以下预览的表格可能省略部分数据；表格含有172个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GeneCards-used-data)GeneCards used data

|Symbol    |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:---------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|CARMIL2   |Capping Pr... |Protein Co... |Q6F5E8     |43    |GC16P067644 |3     |
|WAS       |WASP Actin... |Protein Co... |P42768     |56    |GC0XP048676 |2.13  |
|IL37      |Interleuki... |Protein Co... |Q9NZH6     |48    |GC02P141239 |2.04  |
|LINC02605 |Long Inter... |RNA Gene      |           |19    |GC08P078838 |2.04  |
|TNFSF15   |TNF Superf... |Protein Co... |O95150     |52    |GC09M114784 |1.96  |
|LINC01672 |Long Inter... |RNA Gene      |           |18    |GC01P011469 |1.96  |
|STAT3     |Signal Tra... |Protein Co... |P40763     |62    |GC17M042313 |1.91  |
|BDNF-AS   |BDNF Antis... |RNA Gene      |           |28    |GC11P027466 |1.91  |
|CERNA3    |Competing ... |RNA Gene      |           |19    |GC08P056101 |1.8   |
|NOS2      |Nitric Oxi... |Protein Co... |P35228     |58    |GC17M027756 |1.73  |
|IL17A     |Interleuki... |Protein Co... |Q16552     |52    |GC06P052186 |1.69  |
|IFNG      |Interferon... |Protein Co... |P01579     |59    |GC12M068154 |1.49  |
|IL23A     |Interleuki... |Protein Co... |Q9NPF7     |48    |GC12P059649 |1.44  |
|MPO       |Myeloperox... |Protein Co... |P05164     |61    |GC17M058269 |1.38  |
|IL7R      |Interleuki... |Protein Co... |P16871     |55    |GC05P035852 |1.38  |
|...       |...           |...           |...        |...   |...         |...   |




### 疾病-成分-靶点

Figure \@ref(fig:Network-pharmacology-with-disease) (下方图) 为图Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease.pdf}
\caption{Network pharmacology with disease}\label{fig:Network-pharmacology-with-disease}
\end{center}

Figure \@ref(fig:Targets-intersect-with-targets-of-diseases) (下方图) 为图Targets intersect with targets of diseases概览。

**(对应文件为 `Figure+Table/Targets-intersect-with-targets-of-diseases.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Targets-intersect-with-targets-of-diseases.pdf}
\caption{Targets intersect with targets of diseases}\label{fig:Targets-intersect-with-targets-of-diseases}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    IL10, TNF, IL7, ACAD8, IL1B, NLRP3, PRKAB1, PRKAA1,
TACR1, SLC7A2, PRKAA2, AKR1B10, NOD2, TLR4, CD44, DCLK1,
IL33, TP53, PON1, LY96, SIRT1, ESR2, NR0B1, AGER, CSF3,
GABPA, NFE2L2, MUC2, MMP9, MIF, IL17A, CXCL8, PIAS3, STAT3,
NOS2, IFNG, MPO, EGF, IL6, VCAM1, MIR18A, TCF4, MST1,
MIR155, CA4, EGFR,...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**

### 富集分析

Figure \@ref(fig:HERBS-KEGG-enrichment) (下方图) 为图HERBS KEGG enrichment概览。

**(对应文件为 `Figure+Table/HERBS-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HERBS-KEGG-enrichment.pdf}
\caption{HERBS KEGG enrichment}\label{fig:HERBS-KEGG-enrichment}
\end{center}

Figure \@ref(fig:HERBS-GO-enrichment) (下方图) 为图HERBS GO enrichment概览。

**(对应文件为 `Figure+Table/HERBS-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HERBS-GO-enrichment.pdf}
\caption{HERBS GO enrichment}\label{fig:HERBS-GO-enrichment}
\end{center}

#### 与肠道炎症相关的通路和基因

Figure \@ref(fig:HERBS-hsa05321-visualization) (下方图) 为图HERBS hsa05321 visualization概览。

**(对应文件为 `Figure+Table/hsa05321.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-29_15_06_14.604672/hsa05321.pathview.png}
\caption{HERBS hsa05321 visualization}\label{fig:HERBS-hsa05321-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa05321}

\vspace{2em}
\end{tcolorbox}
\end{center}




### 与疾病相关的活性成分筛选

#### PubMed 文献报道数 (任意领域)

Table \@ref(tab:All-compounds-Literature-Count) (下方表格) 为表格All compounds Literature Count概览。

**(对应文件为 `Figure+Table/All-compounds-Literature-Count.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2200行3列，以下预览的表格可能省略部分数据；表格含有2200个唯一`cids'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-compounds-Literature-Count)All compounds Literature Count

|cids    |name                           |LiteratureCount |
|:-------|:------------------------------|:---------------|
|702     |ethanol                        |540787          |
|5997    |(3S,8S,9S,10R,13R,14S,17R)-... |337620          |
|5988    |(2R,3R,4S,5S,6R)-2-[(2S,3S,... |204482          |
|24749   |2,3,4,5,6-pentahydroxyhexanal  |197377          |
|180     |propan-2-one                   |182194          |
|241     |benzene                        |155727          |
|5957    |[[(2R,3S,4R,5R)-5-(6-aminop... |151618          |
|5757    |(8R,9S,13S,14S,17S)-13-meth... |143457          |
|996     |phenol                         |125953          |
|612     |2-hydroxypropanoic acid        |115138          |
|8058    |hexane                         |112457          |
|5461108 |[[[(2R,3S,4R,5R)-5-(6-amino... |110671          |
|774     |2-(1H-imidazol-5-yl)ethanamine |98412           |
|60961   |(2R,3R,4S,5R)-2-(6-aminopur... |90522           |
|311     |2-hydroxypropane-1,2,3-tric... |78795           |
|...     |...                            |...             |

Table \@ref(tab:hsa05321-related-genes-and-compounds) (下方表格) 为表格hsa05321 related genes and compounds概览。

**(对应文件为 `Figure+Table/hsa05321-related-genes-and-compounds.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有409行5列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:hsa05321-related-genes-and-compounds)Hsa05321 related genes and compounds

|Herb_pinyin_name |Ingredient.name      |Target.name |LiteratureCount |cids |
|:----------------|:--------------------|:-----------|:---------------|:----|
|GUI ZHI          |acetaldehyde         |IL1B        |37277           |177  |
|GUI ZHI          |acetaldehyde         |TNF         |37277           |177  |
|GUI ZHI          |acetaldehyde         |IL6         |37277           |177  |
|HUANG BAI        |acetaldehyde         |IL1B        |37277           |177  |
|HUANG BAI        |acetaldehyde         |TNF         |37277           |177  |
|HUANG BAI        |acetaldehyde         |IL6         |37277           |177  |
|DANG GUI         |2-hydroxyethyl(tr... |TNF         |24884           |305  |
|REN SHEN         |2-hydroxyethyl(tr... |TNF         |24884           |305  |
|GUI ZHI          |chromen-2-one        |IL6         |26252           |323  |
|GUI ZHI          |chromen-2-one        |STAT3       |26252           |323  |
|REN SHEN         |2-hydroxybenzoic ... |IL4         |38476           |338  |
|GUI ZHI          |octanoic acid        |TLR4        |7352            |379  |
|HUANG BAI        |octanoic acid        |TLR4        |7352            |379  |
|WU MEI           |octanoic acid        |TLR4        |7352            |379  |
|XI XIN           |octanoic acid        |TLR4        |7352            |379  |
|...              |...                  |...         |...             |...  |



#### CTD 数据库记录与肾炎相关的化合物

Figure \@ref(fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related) (下方图) 为图Intersection of CTD records with herbs of hsa05321 related概览。

**(对应文件为 `Figure+Table/Intersection-of-CTD-records-with-herbs-of-hsa05321-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-CTD-records-with-herbs-of-hsa05321-related.pdf}
\caption{Intersection of CTD records with herbs of hsa05321 related}\label{fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    8530, 54675866, 177, 7847, 119258, 2353, 72326, 64971,
2519, 644019, 2703, 5959, 5280795, 5997, 305, 637511,
638011, 323, 969516, 637568, 5281613, 16078, 5757, 702,
2758, 445070, 5280805, 5280961, 441923, 774, 72303,
5280863, 10255, 3893, 8181, 439246, 6184, 12389, 379,
10228, 11092, 985, 8158, 9...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-CTD-records-with-herbs-of-hsa05321-related-content`)**

Table \@ref(tab:Intersection-Herbs-compounds-and-targets) (下方表格) 为表格Intersection Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/Intersection-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有307行5列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Intersection-Herbs-compounds-and-targets)Intersection Herbs compounds and targets

|Herb_pinyin_name |Ingredient.name      |Target.name |LiteratureCount |cids |
|:----------------|:--------------------|:-----------|:---------------|:----|
|GUI ZHI          |acetaldehyde         |IL1B        |37277           |177  |
|GUI ZHI          |acetaldehyde         |TNF         |37277           |177  |
|GUI ZHI          |acetaldehyde         |IL6         |37277           |177  |
|HUANG BAI        |acetaldehyde         |IL1B        |37277           |177  |
|HUANG BAI        |acetaldehyde         |TNF         |37277           |177  |
|HUANG BAI        |acetaldehyde         |IL6         |37277           |177  |
|DANG GUI         |2-hydroxyethyl(tr... |TNF         |24884           |305  |
|REN SHEN         |2-hydroxyethyl(tr... |TNF         |24884           |305  |
|GUI ZHI          |chromen-2-one        |IL6         |26252           |323  |
|GUI ZHI          |chromen-2-one        |STAT3       |26252           |323  |
|REN SHEN         |2-hydroxybenzoic ... |IL4         |38476           |338  |
|GUI ZHI          |octanoic acid        |TLR4        |7352            |379  |
|HUANG BAI        |octanoic acid        |TLR4        |7352            |379  |
|WU MEI           |octanoic acid        |TLR4        |7352            |379  |
|XI XIN           |octanoic acid        |TLR4        |7352            |379  |
|...              |...                  |...         |...             |...  |





## 分子对接

### Top docking

取 Tab. \@ref(tab:Intersection-Herbs-compounds-and-targets) 
(即，Fig. \@ref(fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related) 交集)
成分与靶点，进行批量分子对接。

以下展示了各个靶点结合度 Top 5 的成分

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Table \@ref(tab:Combining-Affinity) (下方表格) 为表格Combining Affinity概览。

**(对应文件为 `Figure+Table/Combining-Affinity.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有35行6列，以下预览的表格可能省略部分数据；表格含有10个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Combining-Affinity)Combining Affinity

|hgnc_symbol |Ingredient... |Affinity |PubChem_id |PDB_ID |Combn         |
|:-----------|:-------------|:--------|:----------|:------|:-------------|
|IL1B        |(1R,3aS,5a... |-7.303   |72326      |9ilb   |72326_into... |
|IL1B        |(3S,8S,9S,... |-6.096   |5997       |9ilb   |5997_into_... |
|IL1B        |(2R,3R)-2-... |-5.083   |119258     |9ilb   |119258_int... |
|IL1B        |2,2-dichlo... |-5.038   |5959       |9ilb   |5959_into_... |
|IL18        |(1E,6E)-1,... |-4.999   |969516     |4xfu   |969516_int... |
|IL1B        |2-[(1R,6R)... |-4.959   |644019     |9ilb   |644019_int... |
|IL18        |2-(4-hydro... |-4.76    |72303      |4xfu   |72303_into... |
|NOD2        |2-(1H-imid... |-4.417   |774        |nod2   |774_into_nod2 |
|FOXP3       |(1E,6E)-1,... |-4.169   |969516     |4wk8   |969516_int... |
|TLR4        |(2E,6E)-3,... |-3.564   |445070     |5nao   |445070_int... |
|TLR4        |(E)-3-phen... |-3.467   |637511     |5nao   |637511_int... |
|TLR4        |2-(1H-imid... |-3.032   |774        |5nao   |774_into_5nao |
|TLR4        |5-[(E)-2-(... |-2.558   |445154     |5nao   |445154_int... |
|TLR4        |prop-2-enal   |-2.434   |7847       |5nao   |7847_into_... |
|IL18        |ethanol       |-2.225   |702        |4xfu   |702_into_4xfu |
|...         |...           |...      |...        |...    |...           |

### 对接可视化

Table \@ref(tab:Metadata-of-visualized-Docking) (下方表格) 为表格Metadata of visualized Docking概览。

**(对应文件为 `Figure+Table/Metadata-of-visualized-Docking.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3行5列，以下预览的表格可能省略部分数据；表格含有3个唯一`PubChem\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Metadata-of-visualized-Docking)Metadata of visualized Docking

|PubChem_id |PDB_ID |Affinity |hgnc_symbol |Ingredient_name      |
|:----------|:------|:--------|:-----------|:--------------------|
|72326      |9ilb   |-7.303   |IL1B        |(1R,3aS,5aR,5bR,7... |
|969516     |4xfu   |-4.999   |IL18        |(1E,6E)-1,7-bis(4... |
|774        |nod2   |-4.417   |NOD2        |2-(1H-imidazol-5-... |

Figure \@ref(fig:Docking-72326-into-9ilb) (下方图) 为图Docking 72326 into 9ilb概览。

**(对应文件为 `Figure+Table/72326_into_9ilb.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/72326_into_9ilb/72326_into_9ilb.png}
\caption{Docking 72326 into 9ilb}\label{fig:Docking-72326-into-9ilb}
\end{center}

Figure \@ref(fig:Docking-969516-into-4xfu) (下方图) 为图Docking 969516 into 4xfu概览。

**(对应文件为 `Figure+Table/969516_into_4xfu.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_4xfu/969516_into_4xfu.png}
\caption{Docking 969516 into 4xfu}\label{fig:Docking-969516-into-4xfu}
\end{center}

Figure \@ref(fig:Docking-774-into-nod2) (下方图) 为图Docking 774 into nod2概览。

**(对应文件为 `Figure+Table/774_into_nod2.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/774_into_nod2/774_into_nod2.png}
\caption{Docking 774 into nod2}\label{fig:Docking-774-into-nod2}
\end{center}

### 局部对接细节

Figure \@ref(fig:Docking-72326-into-9ilb-detail) (下方图) 为图Docking 72326 into 9ilb detail概览。

**(对应文件为 `Figure+Table/detail_72326_into_9ilb.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/72326_into_9ilb/detail_72326_into_9ilb.png}
\caption{Docking 72326 into 9ilb detail}\label{fig:Docking-72326-into-9ilb-detail}
\end{center}

Figure \@ref(fig:Docking-969516-into-4xfu-detail) (下方图) 为图Docking 969516 into 4xfu detail概览。

**(对应文件为 `Figure+Table/detail_969516_into_4xfu.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_4xfu/detail_969516_into_4xfu.png}
\caption{Docking 969516 into 4xfu detail}\label{fig:Docking-969516-into-4xfu-detail}
\end{center}

Figure \@ref(fig:Docking-774-into-nod2-detail) (下方图) 为图Docking 774 into nod2 detail概览。

**(对应文件为 `Figure+Table/detail_774_into_nod2.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/774_into_nod2/detail_774_into_nod2.png}
\caption{Docking 774 into nod2 detail}\label{fig:Docking-774-into-nod2-detail}
\end{center}




### Top1 的靶点的富集分析 (参与 hsa05321 靶点) 

Figure \@ref(fig:TOP-KEGG-enrichment) (下方图) 为图TOP KEGG enrichment概览。

**(对应文件为 `Figure+Table/TOP-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TOP-KEGG-enrichment.pdf}
\caption{TOP KEGG enrichment}\label{fig:TOP-KEGG-enrichment}
\end{center}

Figure \@ref(fig:TOP-GO-enrichment) (下方图) 为图TOP GO enrichment概览。

**(对应文件为 `Figure+Table/TOP-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TOP-GO-enrichment.pdf}
\caption{TOP GO enrichment}\label{fig:TOP-GO-enrichment}
\end{center}

Figure \@ref(fig:TOP-hsa05321-visualization) (下方图) 为图TOP hsa05321 visualization概览。

**(对应文件为 `Figure+Table/hsa05321.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-29_17_34_39.609851/hsa05321.pathview.png}
\caption{TOP hsa05321 visualization}\label{fig:TOP-hsa05321-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa05321}

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:TOP-pharmacology-visualization) (下方图) 为图TOP pharmacology visualization概览。

**(对应文件为 `Figure+Table/TOP-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TOP-pharmacology-visualization.pdf}
\caption{TOP pharmacology visualization}\label{fig:TOP-pharmacology-visualization}
\end{center}



#### TOP1 的结合靶点 (IL1B) 参与的通路

Table \@ref(tab:IL1B-kegg) (下方表格) 为表格IL1B kegg概览。

**(对应文件为 `Figure+Table/IL1B-kegg.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有43行9列，以下预览的表格可能省略部分数据；表格含有43个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:IL1B-kegg)IL1B kegg

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa05143 |Africa... |4/4       |37/8672  |2.8046... |1.9487... |3.0019... |3458/3... |4     |
|hsa05332 |Graft-... |4/4       |42/8672  |4.7531... |1.9487... |3.0019... |3458/3... |4     |
|hsa05144 |Malaria   |4/4       |50/8672  |9.7797... |2.6731... |4.1177... |3458/3... |4     |
|hsa05321 |Inflam... |4/4       |65/8672  |2.8750... |5.8939... |9.0791... |3458/3... |4     |
|hsa05323 |Rheuma... |4/4       |93/8672  |1.2398... |1.7698... |2.7262... |3458/3... |4     |
|hsa04657 |IL-17 ... |4/4       |94/8672  |1.2949... |1.7698... |2.7262... |3458/3... |4     |
|hsa05142 |Chagas... |4/4       |102/8672 |1.8045... |1.8497... |2.8493... |3458/3... |4     |
|hsa05146 |Amoebi... |4/4       |102/8672 |1.8045... |1.8497... |2.8493... |3458/3... |4     |
|hsa05164 |Influe... |4/4       |171/8672 |1.4603... |1.2227... |1.8835... |3458/3... |4     |
|hsa01523 |Antifo... |3/4       |30/8672  |1.4911... |1.2227... |1.8835... |3553/3... |3     |
|hsa05152 |Tuberc... |4/4       |180/8672 |1.7961... |1.3389... |2.0625... |3458/3... |4     |
|hsa04940 |Type I... |3/4       |43/8672  |4.5273... |3.0937... |4.7656... |3458/3... |3     |
|hsa05134 |Legion... |3/4       |56/8672  |1.0157... |6.4072... |9.8699... |3553/3... |3     |
|hsa04060 |Cytoki... |4/4       |297/8672 |1.3490... |7.9018... |1.2172... |3458/3... |4     |
|hsa05133 |Pertussis |3/4       |76/8672  |2.5716... |1.3712... |2.1123... |3553/3... |3     |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |

Table \@ref(tab:IL1B-go) (下方表格) 为表格IL1B go概览。

**(对应文件为 `Figure+Table/IL1B-go.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有431行10列，以下预览的表格可能省略部分数据；表格含有2个唯一`ont'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\item ont:  One of "BP", "MF", and "CC" subontologies. The Cellular Component (CC), the Molecular Function (MF) and the Biological Process (BP).
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:IL1B-go)IL1B go

|ont |ID        |Descri... |GeneRatio |BgRatio   |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:---|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:-----|
|BP  |GO:004... |astroc... |4/4       |24/18614  |2.1250... |2.5330... |2.0802... |3458/3... |4     |
|BP  |GO:001... |astroc... |4/4       |43/18614  |2.4679... |1.4709... |1.2080... |3458/3... |4     |
|BP  |GO:006... |glial ... |4/4       |55/18614  |6.8205... |2.7100... |2.2256... |3458/3... |4     |
|BP  |GO:003... |positi... |4/4       |70/18614  |1.8336... |5.4642... |4.4875... |3458/3... |4     |
|BP  |GO:015... |neuroi... |4/4       |76/18614  |2.5657... |6.1166... |5.0234... |3458/3... |4     |
|BP  |GO:004... |astroc... |4/4       |87/18614  |4.4514... |8.8434... |7.2628... |3458/3... |4     |
|BP  |GO:003... |regula... |4/4       |98/18614  |7.2239... |1.0385... |8.5296... |3458/3... |4     |
|BP  |GO:003... |chemok... |4/4       |99/18614  |7.5281... |1.0385... |8.5296... |3458/3... |4     |
|BP  |GO:003... |positi... |4/4       |100/18614 |7.8417... |1.0385... |8.5296... |3458/3... |4     |
|BP  |GO:002... |glial ... |4/4       |119/18614 |1.5880... |1.8929... |1.5545... |3458/3... |4     |
|BP  |GO:005... |positi... |3/4       |16/18614  |2.0831... |2.2573... |1.8539... |3458/3... |3     |
|BP  |GO:015... |positi... |3/4       |18/18614  |3.0352... |3.0149... |2.4760... |3553/3... |3     |
|BP  |GO:005... |positi... |4/4       |154/18614 |4.5062... |4.1318... |3.3933... |3458/3... |4     |
|BP  |GO:006... |positi... |3/4       |21/18614  |4.9465... |4.2115... |3.4588... |3553/3... |3     |
|BP  |GO:005... |regula... |4/4       |163/18614 |5.6679... |4.5041... |3.6991... |3458/3... |4     |
|... |...       |...       |...       |...       |...       |...       |...       |...       |...   |





