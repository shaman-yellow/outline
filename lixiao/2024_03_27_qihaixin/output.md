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
\textbf{\textcolor{white}{2024-04-08}}
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

化合物 3081405

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


## 补充的内容

- 分子对接前的网络图 Fig. \@ref(fig:CTD-filtered-Compounds-Network-pharmacology-with-disease)，
  仅根据 Fig. \@ref(fig:Overall-targets-number-of-datasets) 过滤靶点，和
  Fig. \@ref(fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related) 过滤成分。
- 随后分子对接已全部重做。
- 分子对接后，筛选 Affinity &lt; -1.2, 网络图 Fig. \@ref(fig:Network-pharmacology-Affinity-filtered)
  (唯独 Fig. \@ref(fig:Network-pharmacology-Affinity-filtered) 中化合物采用了最简洁的同义名，其他图没有修改;
  此外，Tab. \@ref(tab:Combining-Affinity) 有化合物名称和来源药物)
- 关于化合物 3081405, 存在于收集的复方成分中，
  可在 Tab. \@ref(tab:tables-of-Herbs-compounds-and-targets) 中找到；
  但不在 Tab. \@ref(tab:Intersection-Herbs-compounds-and-targets) 中，
  是 CTD 的步骤过滤除外的 (Fig. \@ref(fig:Intersection-of-CTD-records-with-herbs-of-hsa05321-related))。

以下是 BATMAN 记录的 3081405 的靶点 (预测的靶点的 score cutoff 设置为 0.9)。

Table \@ref(tab:3081405-targets) (下方表格) 为表格3081405 targets概览。

**(对应文件为 `Figure+Table/3081405-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行4列，以下预览的表格可能省略部分数据；含有1个唯一`Ingredient.id；含有2个唯一`Herb\_pinyin\_name；含有1个唯一`Ingredient.name；含有3个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:3081405-targets)3081405 targets

|Ingredient.id |Herb_pinyin_name |Ingredient.name      |Target.name |
|:-------------|:----------------|:--------------------|:-----------|
|3081405       |HUANG BAI        |(7S,13aS)-3,10-di... |CYP2C9      |
|3081405       |HUANG BAI        |(7S,13aS)-3,10-di... |CYP1A2      |
|3081405       |HUANG BAI        |(7S,13aS)-3,10-di... |CYP3A4      |
|3081405       |HUANG LIAN       |(7S,13aS)-3,10-di... |CYP2C9      |
|3081405       |HUANG LIAN       |(7S,13aS)-3,10-di... |CYP1A2      |
|3081405       |HUANG LIAN       |(7S,13aS)-3,10-di... |CYP3A4      |



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
- R package `pathview` used for KEGG pathways visualization[@PathviewAnRLuoW2013].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行4列，以下预览的表格可能省略部分数据；含有10个唯一`Pinyin.Name'。
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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15264行4列，以下预览的表格可能省略部分数据；含有2200个唯一`Ingredient.id；含有10个唯一`Herb\_pinyin\_name；含有2186个唯一`Ingredient.name；含有2267个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Ingredient.id |Herb_pinyin_name |Ingredient.name      |Target.name |
|:-------------|:----------------|:--------------------|:-----------|
|72            |GUI ZHI          |3,4-dihydroxybenz... |AKT1        |
|72            |GUI ZHI          |3,4-dihydroxybenz... |MGAM        |
|73            |GUI ZHI          |[5-(6-aminopurin-... |NA          |
|101           |GUI ZHI          |3-hydroxybenzalde... |NA          |
|107           |GUI ZHI          |3-phenylpropanoic... |NA          |
|135           |GUI ZHI          |4-hydroxybenzoic ... |HDAC6       |
|177           |GUI ZHI          |acetaldehyde         |HDAC11      |
|177           |GUI ZHI          |acetaldehyde         |MMP2        |
|177           |GUI ZHI          |acetaldehyde         |CDT1        |
|177           |GUI ZHI          |acetaldehyde         |CAT         |
|177           |GUI ZHI          |acetaldehyde         |MMP1        |
|177           |GUI ZHI          |acetaldehyde         |PPARG       |
|177           |GUI ZHI          |acetaldehyde         |TIMP1       |
|177           |GUI ZHI          |acetaldehyde         |AGT         |
|177           |GUI ZHI          |acetaldehyde         |IL1B        |
|...           |...              |...                  |...         |



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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有172行7列，以下预览的表格可能省略部分数据；含有172个唯一`Symbol'。
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


\textbf{
Enriched genes
:}

\vspace{0.5em}

    NOD2, TNF, IL6, IL12A, IFNG, STAT1, IL4, IL1B, IL13,
IL10, TLR4, IL17A, STAT3, IL18, FOXP3

\vspace{2em}
\end{tcolorbox}
\end{center}




### 与疾病相关的活性成分筛选

#### CTD 数据库记录与肠炎 (Colitis) 相关的化合物

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

    8530, 335, 54675866, 177, 7847, 190, 60961, 5280934,
637563, 444899, 2236, 119258, 5282102, 241, 2353, 6918391,
72326, 64971, 31404, 2519, 644019, 1548943, 2703, 5959,
312, 1794427, 5280795, 5997, 305, 637511, 638011, 8842,
323, 969516, 3026, 637568, 5281612, 5281613, 16078, 5757,
5756, 702, 5991...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-CTD-records-with-herbs-of-hsa05321-related-content`)**

Table \@ref(tab:Intersection-Herbs-compounds-and-targets) (下方表格) 为表格Intersection Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/Intersection-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1030行5列，以下预览的表格可能省略部分数据；含有10个唯一`Herb\_pinyin\_name；含有108个唯一`Ingredient.name；含有94个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Intersection-Herbs-compounds-and-targets)Intersection Herbs compounds and targets

|Herb_pinyin_name |Ingredient.name  |Target.name |LiteratureCount |cids |
|:----------------|:----------------|:-----------|:---------------|:----|
|GUI ZHI          |acetaldehyde     |MMP1        |37277           |177  |
|GUI ZHI          |acetaldehyde     |IL1B        |37277           |177  |
|GUI ZHI          |acetaldehyde     |TNF         |37277           |177  |
|GUI ZHI          |acetaldehyde     |NFKBIA      |37277           |177  |
|GUI ZHI          |acetaldehyde     |IL6         |37277           |177  |
|GUI ZHI          |acetaldehyde     |MMP9        |37277           |177  |
|GUI ZHI          |acetaldehyde     |VCAM1       |37277           |177  |
|HUANG BAI        |acetaldehyde     |MMP1        |37277           |177  |
|HUANG BAI        |acetaldehyde     |IL1B        |37277           |177  |
|HUANG BAI        |acetaldehyde     |TNF         |37277           |177  |
|HUANG BAI        |acetaldehyde     |NFKBIA      |37277           |177  |
|HUANG BAI        |acetaldehyde     |IL6         |37277           |177  |
|HUANG BAI        |acetaldehyde     |MMP9        |37277           |177  |
|HUANG BAI        |acetaldehyde     |VCAM1       |37277           |177  |
|DANG GUI         |7H-purin-6-amine |PRKAA1      |63177           |190  |
|...              |...              |...         |...             |...  |

## 分子对接前的网络图

Figure \@ref(fig:CTD-filtered-Compounds-Network-pharmacology-with-disease) (下方图) 为图CTD filtered Compounds Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/CTD-filtered-Compounds-Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/CTD-filtered-Compounds-Network-pharmacology-with-disease.pdf}
\caption{CTD filtered Compounds Network pharmacology with disease}\label{fig:CTD-filtered-Compounds-Network-pharmacology-with-disease}
\end{center}

Table \@ref(tab:Compounds-CTD-Synonyms) (下方表格) 为表格Compounds CTD Synonyms概览。

**(对应文件为 `Figure+Table/Compounds-CTD-Synonyms.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有108行2列，以下预览的表格可能省略部分数据；含有108个唯一`CID'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-CTD-Synonyms)Compounds CTD Synonyms

|CID |Synonym      |
|:---|:------------|
|177 |acetaldehyde |
|190 |adenine      |
|241 |benzene      |
|305 |choline      |
|311 |Aciletten    |
|312 |chloride     |
|323 |coumarin     |
|335 |Orthocresol  |
|338 |Rutranex     |
|370 |gallate      |
|379 |Caprylsaeure |
|612 |lactate      |
|702 |ethanol      |
|774 |histamine    |
|931 |naphthalene  |
|... |...          |







## 分子对接

### Top docking

取  Fig. \@ref(fig:CTD-filtered-Compounds-Network-pharmacology-with-disease) 成分与靶点，进行批量分子对接。

以下展示了各个靶点结合度 Top 5 的成分 (前 25 条记录)

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Table \@ref(tab:Combining-Affinity) (下方表格) 为表格Combining Affinity概览。

**(对应文件为 `Figure+Table/Combining-Affinity.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有134行8列，以下预览的表格可能省略部分数据；含有43个唯一`hgnc\_symbol；含有21个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Combining-Affinity)Combining Affinity

|hgnc_s... |Ingred... |Affinity |PubChe... |PDB_ID |Combn     |Herb_p... |Synonym   |
|:---------|:---------|:--------|:---------|:------|:---------|:---------|:---------|
|IL1B      |(1R,3a... |-7.303   |72326     |9ilb   |72326_... |HUANG ... |Betulin   |
|DCLK1     |(1E,6E... |-7.265   |969516    |7kxw   |969516... |DANG GUI  |curcumin  |
|IL1B      |(3S,8S... |-6.096   |5997      |9ilb   |5997_i... |WU MEI    |choles... |
|TP53      |2-[(1R... |-6.09    |644019    |8dc8   |644019... |GUI ZHI   |cannab... |
|TP53      |5-hydr... |-5.706   |3806      |8dc8   |3806_i... |FU ZI     |juglone   |
|TP53      |16,17-... |-5.465   |2353      |8dc8   |2353_i... |HUA JI... |berberine |
|TP53      |8-meth... |-5.458   |2236      |8dc8   |2236_i... |XI XIN    |Aristo... |
|TP53      |(1R,3a... |-5.083   |64971     |8dc8   |64971_... |HUANG BAI |Mairin    |
|IL1B      |(2R,3R... |-5.083   |119258    |9ilb   |119258... |REN SHEN  |Astilbin  |
|IL1B      |2,2-di... |-5.038   |5959      |9ilb   |5959_i... |XI XIN    |chlora... |
|IL18      |(1E,6E... |-4.999   |969516    |4xfu   |969516... |DANG GUI  |curcumin  |
|IL1B      |2-[(1R... |-4.959   |644019    |9ilb   |644019... |GUI ZHI   |cannab... |
|AREG      |(1E,6E... |-4.91    |969516    |2rnl   |969516... |DANG GUI  |curcumin  |
|IL18      |2-(4-h... |-4.76    |72303     |4xfu   |72303_... |FU ZI     |Honokiol  |
|EGF       |2-[(1R... |-4.636   |644019    |2kv4   |644019... |GUI ZHI   |cannab... |
|...       |...       |...      |...       |...    |...       |...       |...       |



### 对接可视化

Table \@ref(tab:Metadata-of-visualized-Docking) (下方表格) 为表格Metadata of visualized Docking概览。

**(对应文件为 `Figure+Table/Metadata-of-visualized-Docking.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3行6列，以下预览的表格可能省略部分数据；含有3个唯一`PubChem\_id；含有3个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Metadata-of-visualized-Docking)Metadata of visualized Docking

|PubChem_id |PDB_ID |Affinity |Combn         |hgnc_symbol |Ingredient... |
|:----------|:------|:--------|:-------------|:-----------|:-------------|
|72326      |9ilb   |-7.303   |72326_into... |IL1B        |(1R,3aS,5a... |
|969516     |7kxw   |-7.265   |969516_int... |DCLK1       |(1E,6E)-1,... |
|644019     |8dc8   |-6.09    |644019_int... |TP53        |2-[(1R,6R)... |

Figure \@ref(fig:Docking-72326-into-9ilb) (下方图) 为图Docking 72326 into 9ilb概览。

**(对应文件为 `Figure+Table/72326_into_9ilb.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/72326_into_9ilb/72326_into_9ilb.png}
\caption{Docking 72326 into 9ilb}\label{fig:Docking-72326-into-9ilb}
\end{center}

Figure \@ref(fig:Docking-969516-into-4xfu) (下方图) 为图Docking 969516 into 4xfu概览。

**(对应文件为 `Figure+Table/969516_into_7kxw.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_7kxw/969516_into_7kxw.png}
\caption{Docking 969516 into 4xfu}\label{fig:Docking-969516-into-4xfu}
\end{center}

Figure \@ref(fig:Docking-774-into-nod2) (下方图) 为图Docking 774 into nod2概览。

**(对应文件为 `Figure+Table/644019_into_8dc8.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/644019_into_8dc8/644019_into_8dc8.png}
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

**(对应文件为 `Figure+Table/detail_969516_into_7kxw.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_7kxw/detail_969516_into_7kxw.png}
\caption{Docking 969516 into 4xfu detail}\label{fig:Docking-969516-into-4xfu-detail}
\end{center}

Figure \@ref(fig:Docking-774-into-nod2-detail) (下方图) 为图Docking 774 into nod2 detail概览。

**(对应文件为 `Figure+Table/detail_644019_into_8dc8.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/644019_into_8dc8/detail_644019_into_8dc8.png}
\caption{Docking 774 into nod2 detail}\label{fig:Docking-774-into-nod2-detail}
\end{center}




### 对接能量 < -1.2 网络图

Figure \@ref(fig:Network-pharmacology-Affinity-filtered) (下方图) 为图Network pharmacology Affinity filtered概览。

**(对应文件为 `Figure+Table/Network-pharmacology-Affinity-filtered.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-Affinity-filtered.pdf}
\caption{Network pharmacology Affinity filtered}\label{fig:Network-pharmacology-Affinity-filtered}
\end{center}

Table \@ref(tab:Network-pharmacology-Affinity-filtered-data) (下方表格) 为表格Network pharmacology Affinity filtered data概览。

**(对应文件为 `Figure+Table/Network-pharmacology-Affinity-filtered-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有505行3列，以下预览的表格可能省略部分数据；含有10个唯一`Herb\_pinyin\_name；含有25个唯一`Ingredient.name；含有77个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Network-pharmacology-Affinity-filtered-data)Network pharmacology Affinity filtered data

|Herb_pinyin_name |Ingredient.name |Target.name |
|:----------------|:---------------|:-----------|
|DANG GUI         |adenine         |PRKAA1      |
|DANG GUI         |adenine         |PRKAA2      |
|DANG GUI         |adenine         |PRKAB1      |
|REN SHEN         |adenine         |PRKAA1      |
|REN SHEN         |adenine         |PRKAA2      |
|REN SHEN         |adenine         |PRKAB1      |
|DANG GUI         |ethanol         |VCAM1       |
|DANG GUI         |ethanol         |TP53        |
|DANG GUI         |ethanol         |NFE2L2      |
|DANG GUI         |ethanol         |HMOX1       |
|DANG GUI         |ethanol         |PON1        |
|DANG GUI         |ethanol         |IL6         |
|DANG GUI         |ethanol         |NOS2        |
|DANG GUI         |ethanol         |IL10        |
|DANG GUI         |ethanol         |TNF         |
|...              |...             |...         |



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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有43行9列，以下预览的表格可能省略部分数据；含有43个唯一`ID'。
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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有431行10列，以下预览的表格可能省略部分数据；含有2个唯一`ont'。
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
|BP  |GO:006... |positi... |7/9       |146/18614 |5.6140... |9.0217... |1.5305... |3458/3... |7     |
|BP  |GO:006... |regula... |7/9       |331/18614 |1.8434... |1.4812... |2.5129... |3458/3... |7     |
|BP  |GO:000... |fatty ... |6/9       |161/18614 |3.1353... |1.6794... |2.8492... |3553/5... |6     |
|BP  |GO:004... |regula... |6/9       |182/18614 |6.5956... |2.6497... |4.4954... |3458/3... |6     |
|BP  |GO:015... |neuroi... |5/9       |76/18614  |1.2349... |3.9690... |6.7335... |3458/3... |5     |
|BP  |GO:003... |positi... |7/9       |450/18614 |1.5913... |4.2620... |7.2306... |3458/3... |7     |
|BP  |GO:007... |monoca... |6/9       |220/18614 |2.0766... |4.7603... |8.0760... |3553/5... |6     |
|BP  |GO:004... |positi... |5/9       |87/18614  |2.4649... |4.7603... |8.0760... |3458/3... |5     |
|BP  |GO:004... |astroc... |4/9       |24/18614  |2.6660... |4.7603... |8.0760... |3458/3... |4     |
|BP  |GO:000... |positi... |4/9       |28/18614  |5.1326... |8.2482... |1.3993... |3553/3... |4     |
|BP  |GO:007... |cellul... |6/9       |327/18614 |2.2565... |2.7249... |4.6229... |3553/5... |6     |
|BP  |GO:004... |carbox... |6/9       |328/18614 |2.2982... |2.7249... |4.6229... |3553/5... |6     |
|BP  |GO:001... |organi... |6/9       |331/18614 |2.4272... |2.7249... |4.6229... |3553/5... |6     |
|BP  |GO:015... |regula... |4/9       |41/18614  |2.5315... |2.7249... |4.6229... |3553/3... |4     |
|BP  |GO:004... |positi... |4/9       |42/18614  |2.7974... |2.7249... |4.6229... |3458/3... |4     |
|... |...       |...       |...       |...       |...       |...       |...       |...       |...   |







