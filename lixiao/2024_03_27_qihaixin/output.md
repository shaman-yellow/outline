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
\textbf{\textcolor{white}{2024-04-19}}
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

注：以下 “??” 引用为修改后暂保留内容。

1. 利用 ~~BATMAN-TCM~~ 数据库作为成分靶点数据库，并结合 Fig. \@ref(fig:Overall-targets-number-of-datasets) 所示的疾病靶点数据
   获得的疾病-复方-成分-靶点网络图见 Fig. \@ref(fig:Network-pharmacology-with-disease)
2. 筛选的成分的靶点关系图见 Fig. \@ref(fig:TOP-pharmacology-visualization)。
   ~~这里的成分是后续的分析和分子对接筛选的 TOP 1，其名称等相关信息 (TOP 1-3) 可参考 Tab. \@ref(tab:Metadata-of-visualized-Docking)~~
3. ~~Pymol 可视化见 Fig. \@ref(fig:Docking-72326-into-9ilb-detail) (局部放大加注释),
   Fig. \@ref(fig:Docking-72326-into-9ilb) (全局图)。
   此外，对接 TOP 2 和 TOP 3 的可视化也附在随后。~~
4. ~~TOP 1 成分的富集分析见 Fig. \@ref(fig:TOP-KEGG-enrichment) 和 Fig. \@ref(fig:TOP-GO-enrichment)~~
5. 总的复方靶点的富集分析见 Fig. \@ref(fig:HERBS-KEGG-enrichment) 和 Fig. \@ref(fig:HERBS-GO-enrichment)
6. ~~YY  (TOP 1 对应的结合靶点为 IL1B ) 参与的环节见 Fig. \@ref(fig:TOP-hsa05321-visualization)~~

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


## 再次修改的内容

- 数据库已换成 TCMSP, 根据 DL 和 OB 过滤成分, Tab. \@ref(tab:Compounds-filtered-by-OB-and-DL)
  (修改数据库来源后，全部内容已重做)
- 疾病靶点与成分靶点做交后，不再与IBD通路做交
- 成分-靶点通过批量分子对接滤过能量 >-1.2kcal/mol 的靶点,
  随后创建网络药理图 (对接能量为负值的结果见 Tab. \@ref(tab:Combining-Affinity))
- 中药-成分-靶点基因-相关通路, 见 Fig. \@ref(fig:Network-pharmacology-Affinity-filtered)，对应数据表格见
  Tab. \@ref(tab:Network-pharmacology-Affinity-filtered-data)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Database `BATMAN-TCM` was used as source data of TCM ingredients and target proteins[@BatmanTcm20Kong2024].
- The Comparative Toxicogenomics Database (CTD) used for finding relationship between chemicals and disease[@ComparativeToxDavis2023].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- The API of `UniProtKB` (<https://www.uniprot.org/help/api_queries>) used for mapping of names or IDs of proteins.
- Website `TCMSP` <https://tcmsp-e.com/> used for data source[@TcmspADatabaRuJi2014].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- R package `pathview` used for KEGG pathways visualization[@PathviewAnRLuoW2013].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行2列，以下预览的表格可能省略部分数据；含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Herb_pinyin_name |Herb_cn_name |
|:----------------|:------------|
|Wumei            |乌梅         |
|Huajiao          |花椒         |
|Xixin            |细辛         |
|Huanglian        |黄连         |
|Huangbo          |黄柏         |
|Ganjiang         |干姜         |
|Fuzi             |附子         |
|Guizhi           |桂枝         |
|Renshen          |人参         |
|Danggui          |当归         |

Table \@ref(tab:Compounds-filtered-by-OB-and-DL) (下方表格) 为表格Compounds filtered by OB and DL概览。

**(对应文件为 `Figure+Table/Compounds-filtered-by-OB-and-DL.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有129行15列，以下预览的表格可能省略部分数据；含有102个唯一`Mol ID；含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
OB (%) cut-off
:}

\vspace{0.5em}

    30%

\vspace{2em}


\textbf{
DL cut-off
:}

\vspace{0.5em}

    0.18

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-filtered-by-OB-and-DL)Compounds filtered by OB and DL

|Mol ID    |Molecu... |MW      |AlogP |Hdon |Hacc |OB (%)    |Caco-2  |BBB      |DL      |
|:---------|:---------|:-------|:-----|:----|:----|:---------|:-------|:--------|:-------|
|MOL001040 |(2R)-5... |272.270 |2.298 |3    |5    |42.363... |0.37818 |-0.47578 |0.21141 |
|MOL000358 |beta-s... |414.790 |8.084 |1    |1    |36.913... |1.32463 |0.98588  |0.75123 |
|MOL000422 |kaempf... |286.250 |1.771 |4    |6    |41.882... |0.26096 |-0.55335 |0.24066 |
|MOL000449 |Stigma... |412.770 |7.640 |1    |1    |43.829... |1.44458 |1.00045  |0.75665 |
|MOL005043 |campes... |400.760 |7.628 |1    |1    |37.576... |1.31892 |0.93697  |0.71481 |
|MOL008601 |Methyl... |318.550 |6.665 |0    |2    |46.899... |1.48280 |0.92545  |0.23381 |
|MOL000953 |CLR       |386.730 |7.376 |1    |1    |37.873... |1.43101 |1.12678  |0.67677 |
|MOL000098 |quercetin |302.250 |1.504 |5    |7    |46.433... |0.04842 |-0.76890 |0.27525 |
|MOL013271 |Kokusa... |259.280 |2.330 |0    |5    |66.676... |0.94967 |0.66840  |0.19584 |
|MOL002663 |Skimmi... |259.280 |2.330 |0    |5    |40.136... |1.26344 |1.09995  |0.19638 |
|MOL002881 |Diosmetin |300.280 |2.318 |3    |6    |31.137... |0.46152 |-0.66187 |0.27442 |
|MOL000358 |beta-s... |414.790 |8.084 |1    |1    |36.913... |1.32463 |0.98588  |0.75123 |
|MOL000098 |quercetin |302.250 |1.504 |5    |7    |46.433... |0.04842 |-0.76890 |0.27525 |
|MOL012140 |4,9-di... |254.310 |3.375 |0    |3    |65.301... |1.21324 |0.72110  |0.19237 |
|MOL012141 |Caribine  |326.430 |1.220 |2    |5    |37.064... |0.33508 |-0.14706 |0.82656 |
|...       |...       |...     |...   |...  |...  |...       |...     |...      |...     |

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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3763行4列，以下预览的表格可能省略部分数据；含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Herb_pinyin_name |Molecule name   |symbols   |protein.names        |
|:----------------|:---------------|:---------|:--------------------|
|Guizhi           |ent-Epicatechin |MBLAC1    |Metallo-beta-lact... |
|Guizhi           |ent-Epicatechin |NCOA7     |Nuclear receptor ... |
|Guizhi           |ent-Epicatechin |ERAP140   |Nuclear receptor ... |
|Guizhi           |ent-Epicatechin |ESNA1     |Nuclear receptor ... |
|Guizhi           |ent-Epicatechin |Nbla00052 |Nuclear receptor ... |
|Guizhi           |ent-Epicatechin |Nbla10993 |Nuclear receptor ... |
|Guizhi           |ent-Epicatechin |HSP90AA2P |Heat shock protei... |
|Guizhi           |ent-Epicatechin |HSP90AA2  |Heat shock protei... |
|Guizhi           |ent-Epicatechin |HSPCAL3   |Heat shock protei... |
|Guizhi           |ent-Epicatechin |PTGS1     |Prostaglandin G/H... |
|Guizhi           |ent-Epicatechin |COX1      |Prostaglandin G/H... |
|Guizhi           |ent-Epicatechin |PTGS2     |Prostaglandin G/H... |
|Guizhi           |ent-Epicatechin |COX2      |Prostaglandin G/H... |
|Guizhi           |ent-Epicatechin |PRKACA    |cAMP-dependent pr... |
|Guizhi           |ent-Epicatechin |PKACA     |cAMP-dependent pr... |
|...              |...             |...       |...                  |



### 疾病靶点

Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}

Table \@ref(tab:GeneCards-used-data) (下方表格) 为表格GeneCards used data概览。

**(对应文件为 `Figure+Table/GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有172行7列，以下预览的表格可能省略部分数据；含有172个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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

    IL10, TNF, IL1B, TP53, ESR2, NFE2L2, MMP9, NOS2, IFNG,
MPO, EGF, VCAM1, MAP3K7, ERBB2, MMP1, PTGS2, RAF1, HMOX1,
CDKN2A, GJA1, CD40LG, ALOX5, NCF2, IL4, VEGFC

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

    11066, 444899, 2353, 9064, 193148, 2703, 5281612,
119307, 5280863, 19009, 5280343, 65752, 72307, 5280794,
439533

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-CTD-records-with-herbs-of-hsa05321-related-content`)**

Table \@ref(tab:Intersection-Herbs-compounds-and-targets) (下方表格) 为表格Intersection Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/Intersection-Herbs-compounds-and-targets.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有141行4列，以下预览的表格可能省略部分数据；含有8个唯一`Herb\_pinyin\_name；含有15个唯一`Ingredient.name；含有24个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Intersection-Herbs-compounds-and-targets)Intersection Herbs compounds and targets

|Herb_pinyin_name |Ingredient.name |Target.name |CID     |
|:----------------|:---------------|:-----------|:-------|
|Wumei            |quercetin       |ALOX5       |5280343 |
|Wumei            |quercetin       |CD40LG      |5280343 |
|Wumei            |quercetin       |TP53        |5280343 |
|Wumei            |quercetin       |CDKN2A      |5280343 |
|Wumei            |quercetin       |EGF         |5280343 |
|Wumei            |quercetin       |GJA1        |5280343 |
|Wumei            |quercetin       |HMOX1       |5280343 |
|Wumei            |quercetin       |IFNG        |5280343 |
|Wumei            |quercetin       |IL1B        |5280343 |
|Wumei            |quercetin       |IL10        |5280343 |
|Wumei            |quercetin       |MMP1        |5280343 |
|Wumei            |quercetin       |MMP9        |5280343 |
|Wumei            |quercetin       |MAP3K7      |5280343 |
|Wumei            |quercetin       |MPO         |5280343 |
|Wumei            |quercetin       |NCF2        |5280343 |
|...              |...             |...         |...     |



## 分子对接前的网络图

Figure \@ref(fig:CTD-filtered-Compounds-Network-pharmacology-with-disease) (下方图) 为图CTD filtered Compounds Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/CTD-filtered-Compounds-Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/CTD-filtered-Compounds-Network-pharmacology-with-disease.pdf}
\caption{CTD filtered Compounds Network pharmacology with disease}\label{fig:CTD-filtered-Compounds-Network-pharmacology-with-disease}
\end{center}



## 分子对接

### Top docking

取  Fig. \@ref(fig:CTD-filtered-Compounds-Network-pharmacology-with-disease) 成分与靶点，进行批量分子对接。

以下展示了各个靶点结合度 Top 的成分

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Table \@ref(tab:Combining-Affinity) (下方表格) 为表格Combining Affinity概览。

**(对应文件为 `Figure+Table/Combining-Affinity.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有31行7列，以下预览的表格可能省略部分数据；含有15个唯一`hgnc\_symbol；含有8个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Combining-Affinity)Combining Affinity

|hgnc_symbol |Ingredient... |Affinity |PubChem_id |PDB_ID |Combn         |Herb_pinyi... |
|:-----------|:-------------|:--------|:----------|:------|:-------------|:-------------|
|TP53        |berberine     |-5.465   |2353       |8dc8   |2353_into_... |Huanglian;... |
|IL1B        |quercetin     |-4.52    |5280343    |9ilb   |5280343_in... |Wumei; Hua... |
|IL1B        |ginsenosid... |-4.4     |119307     |9ilb   |119307_int... |Renshen       |
|TP53        |quercetin     |-4.325   |5280343    |8dc8   |5280343_in... |Wumei; Hua... |
|ESR2        |palmatine     |-4.267   |19009      |7xwr   |19009_into... |Huanglian;... |
|NFE2L2      |sesamin       |-4.113   |72307      |7o7b   |72307_into... |Xixin         |
|NFE2L2      |Chelerythrine |-4.061   |2703       |7o7b   |2703_into_... |Huangbo       |
|NFE2L2      |quercetin     |-3.555   |5280343    |7o7b   |5280343_in... |Wumei; Hua... |
|EGF         |quercetin     |-2.956   |5280343    |2kv4   |5280343_in... |Wumei; Hua... |
|HMOX1       |quercetin     |-2.428   |5280343    |6eha   |5280343_in... |Wumei; Hua... |
|HMOX1       |kaempferol    |-2.141   |5280863    |6eha   |5280863_in... |Wumei; Xix... |
|IL1B        |Chelerythrine |-2.079   |2703       |9ilb   |2703_into_... |Huangbo       |
|RAF1        |quercetin     |-0.797   |5280343    |7jhp   |5280343_in... |Wumei; Hua... |
|NOS2        |palmatine     |-0.521   |19009      |4nos   |19009_into... |Huanglian;... |
|NOS2        |berberine     |-0.315   |2353       |4nos   |2353_into_... |Huanglian;... |
|...         |...           |...      |...        |...    |...           |...           |





### 对接能量 < -1.2 的成分与靶点分析

#### 对应靶点的富集分析

Figure \@ref(fig:AFF-KEGG-enrichment) (下方图) 为图AFF KEGG enrichment概览。

**(对应文件为 `Figure+Table/AFF-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/AFF-KEGG-enrichment.pdf}
\caption{AFF KEGG enrichment}\label{fig:AFF-KEGG-enrichment}
\end{center}

#### 中药-成分-靶点-通路

Figure \@ref(fig:Network-pharmacology-Affinity-filtered) (下方图) 为图Network pharmacology Affinity filtered概览。

**(对应文件为 `Figure+Table/Network-pharmacology-Affinity-filtered.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-Affinity-filtered.pdf}
\caption{Network pharmacology Affinity filtered}\label{fig:Network-pharmacology-Affinity-filtered}
\end{center}

Table \@ref(tab:Network-pharmacology-Affinity-filtered-data) (下方表格) 为表格Network pharmacology Affinity filtered data概览。

**(对应文件为 `Figure+Table/Network-pharmacology-Affinity-filtered-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有26行5列，以下预览的表格可能省略部分数据；含有6个唯一`Herb\_pinyin\_name；含有4个唯一`Ingredient.name；含有6个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Network-pharmacology-Affinity-filtered-data)Network pharmacology Affinity filtered data

|Herb_pinyin_name |Ingredient.name |Target.name |Hit_pathway_number |Enriched_pathways    |
|:----------------|:---------------|:-----------|:------------------|:--------------------|
|Huajiao          |quercetin       |TP53        |9                  |Bladder cancer; B... |
|Huangbo          |quercetin       |TP53        |9                  |Bladder cancer; B... |
|Huanglian        |quercetin       |TP53        |9                  |Bladder cancer; B... |
|Wumei            |quercetin       |TP53        |9                  |Bladder cancer; B... |
|Huajiao          |quercetin       |EGF         |6                  |Bladder cancer; B... |
|Huangbo          |quercetin       |EGF         |6                  |Bladder cancer; B... |
|Huanglian        |quercetin       |EGF         |6                  |Bladder cancer; B... |
|Wumei            |quercetin       |EGF         |6                  |Bladder cancer; B... |
|Huajiao          |quercetin       |HMOX1       |4                  |Chemical carcinog... |
|Huajiao          |quercetin       |NFE2L2      |4                  |Chemical carcinog... |
|Huangbo          |quercetin       |HMOX1       |4                  |Chemical carcinog... |
|Huangbo          |quercetin       |NFE2L2      |4                  |Chemical carcinog... |
|Huanglian        |quercetin       |HMOX1       |4                  |Chemical carcinog... |
|Huanglian        |quercetin       |NFE2L2      |4                  |Chemical carcinog... |
|Renshen          |kaempferol      |HMOX1       |4                  |Chemical carcinog... |
|...              |...             |...         |...                |...                  |



### kaempferol 和 HMOX1 对接可视化

Figure \@ref(fig:Docking-5280863-into-6eha) (下方图) 为图Docking 5280863 into 6eha概览。

**(对应文件为 `Figure+Table/5280863_into_6eha.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/5280863_into_6eha/5280863_into_6eha.png}
\caption{Docking 5280863 into 6eha}\label{fig:Docking-5280863-into-6eha}
\end{center}

Figure \@ref(fig:Docking-5280863-into-6eha-detail) (下方图) 为图Docking 5280863 into 6eha detail概览。

**(对应文件为 `Figure+Table/detail_5280863_into_6eha.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/5280863_into_6eha/detail_5280863_into_6eha.png}
\caption{Docking 5280863 into 6eha detail}\label{fig:Docking-5280863-into-6eha-detail}
\end{center}



