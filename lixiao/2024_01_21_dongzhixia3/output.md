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
  \newenvironment{Shaded}{\begin{snugshade}}{\end{snugshade}}
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
    arc = 1mm, auto outer arc, title = {Input}]}
  {\end{tcolorbox}}
  \usepackage{titlesec}
  \titleformat{\paragraph}
  {\fontsize{10pt}{0pt}\bfseries} {\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}} {1em} {} []

---






\begin{titlepage} \newgeometry{top=7.5cm}
\ThisCenterWallPaper{1.12}{../cover_page.pdf}
\begin{center} \textbf{\Huge
肠道菌群宏基因组群落分析联合RNA-seq} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-30}}
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

需求：以客户提供的数据 (RNA-seq + 肠道菌宏基因组数据) ，筛选 DEGs、代谢物、肠道菌群关系链。

结果：

- 肠道菌群群落分析，以 MetaPhlAn 注释和定量肠道菌，MicrobiotaProcess 下游分析：
    - Alpha 和 Beta 分析均表明，对照组和模型组有显著差异 (\@ref(alpha), \@ref(beta)) 
    - 所有差异肠道菌见 \@ref(diff)
- 建立肠道菌和代谢物联系，以 gutMDisorder 数据库：
    - 将上述差异肠道菌在数据库筛选相关代谢物 (\@ref(meta)) 
- 建立代谢物和蛋白质 (基因) 的联系，以发表的文献数据[@ProteinMetabolBenson2023]
    - 关联性筛选结果见 Tab. \@ref(tab:MICRO-Discover-relationship-between-Microbiota-with-Host-genes-by-matching-metabolites)
- 建立上述筛选的蛋白质 (基因) 与此前的 RNA-seq 筛选的 DEGs 之间的关联：
    - (Liver 和 Ileum 的 DEGs 是此前已分析的，这里不再重新分析。见表格 Tab. \@ref(tab:Liver-DEGs) 和 Tab. \@ref(tab:Ileum-DEGs))
    - 筛选的基因与 Liver 和 Ileum DEGs 的交集见 Fig. \@ref(fig:Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs) 和Tab. \@ref(tab:Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs)
    - 按代谢物与蛋白质 (基因) 关联强弱 (关联系数 rho) ，将排名前 1000 的差异肠道菌、代谢物、DEGs 之间的关系呈现，Liver 和 Ileum 分别见 Fig. \@ref(fig:Liver-Top-1000-relationship-network), Fig. \@ref(fig:Ileum-Top-1000-relationship-network)
- 上述，肠道菌、差异基因 DEGs 均有数据支撑，而中间环节代谢物尚缺少验证；因此，这里选择已发表的胆结石研究[@ChangesAndCorChen2021]中的数据以进一步验证:
    - 根据该文献报道的胆结石小鼠模型差异代谢物 (肝脏) 进行验证筛选，经过滤后的结果见 Tab. \@ref(tab:Liver-results-filtered-by-validation), Tab. \@ref(tab:Ileum-results-filtered-by-validation)
- 最后，试着对上一步的最终基因筛选结果做进一步富集分析：
    - 结果见 \@ref(en1), \@ref(en2)




# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to[@ChangesAndCorChen2021].
- Supplementary file from article refer to[@ProteinMetabolBenson2023].

## 方法

Mainly used method:

- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- `Fastp` used for Fastq data preprocessing[@UltrafastOnePChen2023].
- Database `gutMDisorder` used for finding associations between gut microbiota and metabolites[@GutmdisorderACheng2019].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `MicrobiotaProcess` used for microbiome data visualization[@MicrobiotaproceXuSh2023].
- `MetaPhlAn` used for profiling the composition of microbial communities from metagenomic data[@ExtendingAndIBlanco2023].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 宏基因组群落分析

### 数据质控

 
`Fastp QC' 数据已全部提供。

**(对应文件为 `./fastp_local/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./fastp\_local/共包含18个文件。

\begin{enumerate}\tightlist
\item L1EGG121102--Chow1.html
\item L1EGG121103--Chow2.html
\item L1EGG121104\_L1EGG121104--Chow3.html
\item L1EGG121105\_L1EGG121105--Chow4.html
\item L1EGG121106\_L1EGG121106--Chow5.html
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}



### 群落鉴定和丰度定量 {#quant}

从这里开始，仅选择对照组和模型组进行分析。

Table \@ref(tab:Merged-abundance-table) (下方表格) 为表格Merged abundance table概览。

**(对应文件为 `Figure+Table/Merged-abundance-table.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1590行13列，以下预览的表格可能省略部分数据；表格含有1590个唯一`clade\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Merged-abundance-table)Merged abundance table

|clade_... |L1EGG1......2 |L1EGG1......3 |L1EGG1......4 |L1EGG1......5 |L1EGG1......6 |L1EGG1......7 |... |
|:---------|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|:---|
|k__Bac... |99.99835      |100           |100           |100           |100           |100           |... |
|k__Arc... |0.00165       |0             |0             |0             |0             |0             |... |
|k__Bac... |43.04207      |26.21962      |35.11351      |38.43636      |41.23258      |37.83933      |... |
|k__Bac... |27.14994      |0.70409       |41.94514      |22.4391       |10.30688      |24.7957       |... |
|k__Bac... |22.28786      |1.84668       |11.54645      |3.45731       |0.37113       |2.64639       |... |
|k__Bac... |3.94504       |66.67222      |7.0249        |26.20566      |19.89094      |18.6702       |... |
|k__Bac... |1.61135       |4.04429       |1.66165       |7.25594       |12.58176      |14.00675      |... |
|k__Bac... |1.21374       |0             |0.25707       |2.02386       |2.48308       |1.89131       |... |
|k__Bac... |0.4301        |0.51236       |2.40227       |0.15918       |13.13363      |0.15032       |... |
|k__Bac... |0.31824       |0.00074       |0.04902       |0.0226        |0             |0             |... |
|k__Arc... |0.00165       |0             |0             |0             |0             |0             |... |
|k__Bac... |20.71366      |0.86067       |7.24419       |2.1026        |0.13696       |1.07217       |... |
|k__Bac... |15.78352      |0.3191        |27.43063      |16.53408      |7.19353       |19.10865      |... |
|k__Bac... |11.64828      |0.2736        |10.04731      |0.41265       |0.67944       |0.81364       |... |
|k__Bac... |10.10471      |15.68872      |14.30816      |17.52233      |19.43315      |18.17767      |... |
|...       |...           |...           |...           |...           |...           |...           |... |



### 群落分析

#### Alpha 多样性 {#alpha}

对照组和模型组有显著差异。

Figure \@ref(fig:Alpha-diversity) (下方图) 为图Alpha diversity概览。

**(对应文件为 `Figure+Table/Alpha-diversity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Alpha-diversity.pdf}
\caption{Alpha diversity}\label{fig:Alpha-diversity}
\end{center}

#### Beta 多样性 {#beta}

Figure \@ref(fig:PCoA) (下方图) 为图PCoA概览。

**(对应文件为 `Figure+Table/PCoA.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PCoA.pdf}
\caption{PCoA}\label{fig:PCoA}
\end{center}

Figure \@ref(fig:Sample-distance) (下方图) 为图Sample distance概览。

**(对应文件为 `Figure+Table/Sample-distance.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Sample-distance.pdf}
\caption{Sample distance}\label{fig:Sample-distance}
\end{center}

Figure \@ref(fig:Beta-diversity-group-test) (下方图) 为图Beta diversity group test概览。

**(对应文件为 `Figure+Table/Beta-diversity-group-test.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Beta-diversity-group-test.pdf}
\caption{Beta diversity group test}\label{fig:Beta-diversity-group-test}
\end{center}

 
`All hierarchy data' 数据已全部提供。

**(对应文件为 `Figure+Table/All-hierarchy-data`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/All-hierarchy-data共包含6个文件。

\begin{enumerate}\tightlist
\item 1\_Phylum.pdf
\item 2\_Class.pdf
\item 3\_Order.pdf
\item 4\_Family.pdf
\item 5\_Genus.pdf
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

Figure \@ref(fig:Species-hierarchy) (下方图) 为图Species hierarchy概览。

**(对应文件为 `Figure+Table/Species-hierarchy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Species-hierarchy.pdf}
\caption{Species hierarchy}\label{fig:Species-hierarchy}
\end{center}

#### 差异分析 {#diff}

Table \@ref(tab:Statistic-of-all-difference-microbiota) (下方表格) 为表格Statistic of all difference microbiota概览。

**(对应文件为 `Figure+Table/Statistic-of-all-difference-microbiota.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1693行8列，以下预览的表格可能省略部分数据；表格含有1693个唯一`label'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Statistic-of-all-difference-microbiota)Statistic of all difference microbiota

|label     |nodeClass |pvalue    |fdr       |LDAupper  |LDAmean   |LDAlower  |Sign_g... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|t__SGB... |OTU       |0.0020... |0.0160... |3.7811... |3.7217... |3.6527... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |3.3656... |3.3470... |3.3275... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.0906... |2.0529... |2.0118... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.3222... |2.2279... |2.1074... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.6348... |2.6044... |2.5717... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.7349... |2.7128... |2.6896... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |3.2904... |3.2657... |3.2395... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.4401... |2.4141... |2.3864... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.5684... |2.5329... |2.4943... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.1686... |2.1377... |2.1045... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |3.7672... |3.7140... |3.6534... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.6050... |2.5764... |2.5458... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |2.4451... |2.4190... |2.3911... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |3.4353... |3.3707... |3.2948... |Control   |
|t__SGB... |OTU       |0.0020... |0.0160... |NA        |NA        |NA        |NA        |
|...       |...       |...       |...       |...       |...       |...       |...       |

Figure \@ref(fig:The-abundance-and-LDA-from-Phylum-to-Class) (下方图) 为图The abundance and LDA from Phylum to Class概览。

**(对应文件为 `Figure+Table/The-abundance-and-LDA-from-Phylum-to-Class.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/The-abundance-and-LDA-from-Phylum-to-Class.pdf}
\caption{The abundance and LDA from Phylum to Class}\label{fig:The-abundance-and-LDA-from-Phylum-to-Class}
\end{center}



## 肠道菌群关联代谢物分析 {#meta}

Figure \@ref(fig:MICRO-alluvium-plot-of-Matched-data-in-gutMDisorder) (下方图) 为图MICRO alluvium plot of Matched data in gutMDisorder概览。

**(对应文件为 `Figure+Table/MICRO-alluvium-plot-of-Matched-data-in-gutMDisorder.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MICRO-alluvium-plot-of-Matched-data-in-gutMDisorder.pdf}
\caption{MICRO alluvium plot of Matched data in gutMDisorder}\label{fig:MICRO-alluvium-plot-of-Matched-data-in-gutMDisorder}
\end{center}

Table \@ref(tab:MICRO-Matched-data-in-gutMDisorder) (下方表格) 为表格MICRO Matched data in gutMDisorder概览。

**(对应文件为 `Figure+Table/MICRO-Matched-data-in-gutMDisorder.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有198行13列，以下预览的表格可能省略部分数据；表格含有13个唯一`Query'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MICRO-Matched-data-in-gutMDisorder)MICRO Matched data in gutMDisorder

|Query     |Gut.Mi......2 |Gut.Mi......3 |Gut.Mi......4 |Classi... |Substrate |Substr......7 |Substr......8 |... |
|:---------|:-------------|:-------------|:-------------|:---------|:---------|:-------------|:-------------|:---|
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Glucose |5793          |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |Salicin   |439503        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Xylose  |135191        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |L-Arab... |439195        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |L-Rham... |25310         |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Mannose |18950         |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Glucose |5793          |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |Salicin   |439503        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Xylose  |135191        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |L-Arab... |439195        |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |L-Rham... |25310         |HMDB00...     |... |
|Christ... |Christ...     |NA            |gm0883        |strain    |D-Mannose |18950         |HMDB00...     |... |
|Clostr... |Clostr...     |29347         |gm0885        |strain    |Bile acid |439520        |              |... |
|Clostr... |Clostr...     |29347         |gm0885        |strain    |Cholic... |221493        |HMDB00...     |... |
|Clostr... |Clostr...     |29347         |gm0885        |strain    |Chenod... |10133         |HMDB00...     |... |
|...       |...           |...           |...           |...       |...       |...           |...           |... |



## 代谢物关联蛋白质 (基因) 分析

<https://github.com/aeisman/protein-metabolite>
<https://mbenson.shinyapps.io/protein-metabolite/> [@ProteinMetabolBenson2023]

Table \@ref(tab:MICRO-Discover-relationship-between-Microbiota-with-Host-genes-by-matching-metabolites) (下方表格) 为表格MICRO Discover relationship between Microbiota with Host genes by matching metabolites概览。

**(对应文件为 `Figure+Table/MICRO-Discover-relationship-between-Microbiota-with-Host-genes-by-matching-metabolites.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有52210行10列，以下预览的表格可能省略部分数据；表格含有22个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:MICRO-Discover-relationship-between-Microbiota-with-Host-genes-by-matching-metabolites)MICRO Discover relationship between Microbiota with Host genes by matching metabolites

|.id |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:---|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|586 |Metabo... |          |Creatine      |Akkerm... |NEGR1     |creatine      |-0.217... |9.9886... |2.5777... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |RGMA      |creatine      |-0.204... |3.3272... |6.2440... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |RGMB      |creatine      |-0.200... |1.6028... |9.8838... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |CD55      |creatine      |-0.197... |4.2927... |2.1866... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |MB        |creatine      |-0.196... |1.1517... |3.3965... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |RELT      |creatine      |-0.194... |1.3574... |1.7104... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |IGFBP2    |creatine      |-0.193... |5.9415... |6.8494... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |IGFBP6    |creatine      |-0.187... |5.2454... |6.1876... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |CD59      |creatine      |-0.187... |7.7980... |8.7806... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |NPPB      |creatine      |-0.189... |1.7690... |9.4854... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |CDNF      |creatine      |-0.181... |1.3228... |7.0930... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |EFNB2     |creatine      |-0.180... |1.8860... |1.4601... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |UNC5D     |creatine      |-0.172... |3.7962... |3.8674... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |CST3      |creatine      |-0.169... |1.5765... |3.3814... |... |
|586 |Metabo... |          |Creatine      |Akkerm... |FSTL3     |creatine      |-0.169... |1.6812... |2.9297... |... |
|... |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |



## 蛋白质关联到 RNA-seq 的DEG

### Liver

Table \@ref(tab:Liver-DEGs) (下方表格) 为表格Liver DEGs概览。

**(对应文件为 `Figure+Table/Liver-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2998行11列，以下预览的表格可能省略部分数据；表格含有2998个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Liver-DEGs)Liver DEGs

|hgnc_s... |mgi_sy... |ensemb... |entrez... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|ENHO      |Enho      |ENSMUS... |69638     |energy... |-4.453... |2.2957... |-17.04... |2.0685... |0.0002... |
|CES2      |Ces2a     |ENSMUS... |102022    |carbox... |1.6614... |8.8361... |15.281... |5.6258... |0.0004... |
|HSD17B6   |Hsd17b6   |ENSMUS... |27400     |hydrox... |2.8011... |8.6106... |14.201... |1.0950... |0.0006... |
|FMO5      |Fmo5      |ENSMUS... |14263     |flavin... |1.2618... |8.1280... |13.790... |1.4285... |0.0007... |
|ABCB11    |Abcb11    |ENSMUS... |27413     |ATP-bi... |1.2515... |7.7893... |11.121... |9.7706... |0.0033... |
|GNAT1     |Gnat1     |ENSMUS... |14685     |G prot... |-2.232... |2.9799... |-10.64... |1.4365... |0.0044... |
|NNMT      |Nnmt      |ENSMUS... |18113     |nicoti... |-3.804... |5.1567... |-9.928... |2.6415... |0.0065... |
|CSAD      |Csad      |ENSMUS... |246277    |cystei... |-1.560... |7.2232... |-9.535... |3.7482... |0.0083... |
|ABCB1     |Abcb1a    |ENSMUS... |18671     |ATP-bi... |3.2131... |3.2740... |9.4563... |4.0267... |0.0084... |
|FGFR2     |Fgfr2     |ENSMUS... |14183     |fibrob... |2.9129... |4.2716... |9.2494... |4.8706... |0.0087... |
|DDAH1     |Ddah1     |ENSMUS... |69219     |dimeth... |1.3322... |6.8518... |9.1694... |5.2476... |0.0087... |
|ABCG5     |Abcg5     |ENSMUS... |27409     |ATP bi... |1.5044... |7.3228... |9.0073... |6.1127... |0.0089... |
|SLC1A2    |Slc1a2    |ENSMUS... |20511     |solute... |-1.900... |5.0951... |-8.951... |6.4435... |0.0089... |
|TTC39C    |Ttc39c    |ENSMUS... |72747     |tetrat... |-1.946... |6.2930... |-8.431... |1.0707... |0.0106... |
|WNK4      |Wnk4      |ENSMUS... |69847     |WNK ly... |2.3302... |2.6719... |8.3971... |1.1085... |0.0106... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |

Figure \@ref(fig:Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs) (下方图) 为图Liver Intersection of Microbiota associated Genes with DEGs概览。

**(对应文件为 `Figure+Table/Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs.pdf}
\caption{Liver Intersection of Microbiota associated Genes with DEGs}\label{fig:Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    CD59, FGFR1, TGFBR3, ACY1, GHR, CXCL12, CD93, POSTN,
BMP1, SMOC1, SERPINF2, OMD, APOL1, DCTPP1, APOA1, MAP2K2,
CCL23, INHBA, CFB, CAPG, SPP1, GFRA1, SERPINA3, IL15RA,
CADM1, IL1R1, ALCAM, CYP3A4, GDI2, IL18BP, GPT, IGFBP1,
F11, COL18A1, SERPINA1, HNRNPAB, AFM, IGFBP5, RBP4, TKT,
DDR2, APOM, KYNU,...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Liver-Intersection-of-Microbiota-associated-Genes-with-DEGs-content`)**

Table \@ref(tab:Liver-Microbiota-associated-Genes-filtered-by-DEGs) (下方表格) 为表格Liver Microbiota associated Genes filtered by DEGs概览。

**(对应文件为 `Figure+Table/Liver-Microbiota-associated-Genes-filtered-by-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10454行10列，以下预览的表格可能省略部分数据；表格含有22个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Liver-Microbiota-associated-Genes-filtered-by-DEGs)Liver Microbiota associated Genes filtered by DEGs

|.id  |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:----|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|588  |Metabo... |          |2-Imin...     |Clostr... |CD59      |creati...     |0.4459... |6.9021... |1.8504... |... |
|750  |Substrate |Glycine   |Acetyl...     |Clostr... |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|750  |Metabo... |          |Glycine       |Blautia   |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|750  |Metabo... |          |Glycine       |Lactob... |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|5793 |Substrate |D-Glucose |Acetate       |Christ... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Butyrate      |Christ... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetoin       |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetoin       |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Ethanol       |Lactob... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetate       |Clostr... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Butyrate      |Clostr... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|...  |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |

Figure \@ref(fig:Liver-Top-1000-relationship-network) (下方图) 为图Liver Top 1000 relationship network概览。

**(对应文件为 `Figure+Table/Liver-Top-1000-relationship-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Liver-Top-1000-relationship-network.pdf}
\caption{Liver Top 1000 relationship network}\label{fig:Liver-Top-1000-relationship-network}
\end{center}

Table \@ref(tab:Liver-Top-1000-relationship-data) (下方表格) 为表格Liver Top 1000 relationship data概览。

**(对应文件为 `Figure+Table/Liver-Top-1000-relationship-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1000行3列，以下预览的表格可能省略部分数据；表格含有26个唯一`Gut.Microbiota'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Liver-Top-1000-relationship-data)Liver Top 1000 relationship data

|Gut.Microbiota                 |Metabolite                     |Target_Gene |
|:------------------------------|:------------------------------|:-----------|
|Clostridium                    |2-Imino-1-methylimidazolidi... |CD59        |
|Clostridium                    |Acetyl phosphate(2-)           |GHR         |
|Blautia                        |Glycine                        |GHR         |
|Lactobacillus ruminis          |Glycine                        |GHR         |
|Christensenella minuta YIT ... |Acetate                        |PLXNB2      |
|Christensenella minuta YIT ... |Butyrate                       |PLXNB2      |
|Escherichia coli BW25113       |2,3-Butanediol                 |PLXNB2      |
|Escherichia coli BW25113       |Acetoin                        |PLXNB2      |
|Escherichia coli BW25113       |2,3-Butanedione                |PLXNB2      |
|Escherichia coli JCL166        |2,3-Butanediol                 |PLXNB2      |
|Escherichia coli JCL166        |Acetoin                        |PLXNB2      |
|Escherichia coli JCL166        |2,3-Butanedione                |PLXNB2      |
|Lactobacillus fermentum        |Ethanol                        |PLXNB2      |
|Clostridium pasteurianum       |Acetate                        |PLXNB2      |
|Clostridium pasteurianum       |Butyrate                       |PLXNB2      |
|...                            |...                            |...         |



### Ileum

Table \@ref(tab:Ileum-DEGs) (下方表格) 为表格Ileum DEGs概览。

**(对应文件为 `Figure+Table/Ileum-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2554行11列，以下预览的表格可能省略部分数据；表格含有2554个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Ileum-DEGs)Ileum DEGs

|hgnc_s... |mgi_sy... |ensemb... |entrez... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|HMGCS1    |Hmgcs1    |ENSMUS... |208715    |3-hydr... |-1.476... |7.1006... |-10.01... |3.4647... |0.0446... |
|LYPD8     |Lypd8     |ENSMUS... |70163     |LY6/PL... |-1.422... |6.7523... |-9.413... |5.7988... |0.0446... |
|ACAA1     |Acaa1b    |ENSMUS... |235674    |acetyl... |3.2729... |4.4478... |9.3290... |6.2488... |0.0446... |
|FDFT1     |Fdft1     |ENSMUS... |14137     |farnes... |-1.885... |4.1659... |-9.280... |6.5253... |0.0446... |
|COL1A1    |Col1a1    |ENSMUS... |12842     |collag... |0.9944... |6.5221... |9.2532... |6.6835... |0.0446... |
|SQLE      |Sqle      |ENSMUS... |20775     |squale... |-1.933... |5.8928... |-9.198... |7.0178... |0.0446... |
|TCF23     |Tcf23     |ENSMUS... |69852     |transc... |1.8100... |3.0507... |9.0283... |8.1816... |0.0446... |
|CCL23     |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|CCL15     |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|CCL15-... |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|PIGR      |Pigr      |ENSMUS... |18703     |polyme... |-1.150... |10.832... |-8.463... |1.3856... |0.0511... |
|GZMA      |Gzma      |ENSMUS... |14938     |granzy... |-3.299... |4.3784... |-8.447... |1.4064... |0.0511... |
|CEACAM21  |Ceacam10  |ENSMUS... |26366     |CEA ce... |-3.021... |2.5056... |-7.995... |2.1919... |0.0638... |
|MSMO1     |Msmo1     |ENSMUS... |66234     |methyl... |-1.455... |5.8017... |-7.623... |3.2019... |0.0777... |
|INSIG1    |Insig1    |ENSMUS... |231070    |insuli... |-1.306... |5.1683... |-7.562... |3.4134... |0.0784... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |

Figure \@ref(fig:Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs) (下方图) 为图Ileum Intersection of Microbiota associated Genes with DEGs概览。

**(对应文件为 `Figure+Table/Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs.pdf}
\caption{Ileum Intersection of Microbiota associated Genes with DEGs}\label{fig:Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    RGMB, GSN, POSTN, TNFRSF21, BMP1, WFIKKN2, B2M, SMOC1,
SLITRK5, JAM2, DSC2, PDE11A, CST6, APOL1, CCDC80, TNFRSF19,
CCL23, NOG, IL15RA, NRXN1, ALCAM, MDH1, GDI2, LCN2, IL18BP,
GZMA, SLPI, PTN, GPT, LGALS3BP, COL18A1, SERPINA1, PDE2A,
SOD3, CD109, EFNA3, CXCL10, SGTA, RET, POR, GAPDH, CHL1,
RAC1, A...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Ileum-Intersection-of-Microbiota-associated-Genes-with-DEGs-content`)**

Table \@ref(tab:Ileum-Microbiota-associated-Genes-filtered-by-DEGs) (下方表格) 为表格Ileum Microbiota associated Genes filtered by DEGs概览。

**(对应文件为 `Figure+Table/Ileum-Microbiota-associated-Genes-filtered-by-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有9208行10列，以下预览的表格可能省略部分数据；表格含有22个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Ileum-Microbiota-associated-Genes-filtered-by-DEGs)Ileum Microbiota associated Genes filtered by DEGs

|.id |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:---|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|588 |Metabo... |          |2-Imin...     |Clostr... |B2M       |creati...     |0.5130... |0         |0         |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |DSC2      |creati...     |0.5128... |0         |0         |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |RGMB      |creati...     |0.4166... |5.3138... |1.4246... |... |
|750 |Substrate |Glycine   |Acetyl...     |Clostr... |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|750 |Metabo... |          |Glycine       |Blautia   |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|750 |Metabo... |          |Glycine       |Lactob... |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |JAM2      |creati...     |0.4070... |2.8618... |7.6726... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |CST6      |creati...     |0.3307... |2.1455... |5.7522... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |SPOCK2    |creati...     |-0.321... |1.3977... |1.1241... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |LCN2      |creati...     |0.3110... |2.0900... |1.1206... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |TNFRSF21  |creati...     |0.3098... |7.2094... |7.7313... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |SMOC1     |creati...     |0.3071... |2.8839... |7.7317... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |TNFRSF19  |creati...     |0.2890... |4.7330... |1.2689... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |COL18A1   |creati...     |0.2883... |3.0855... |3.3089... |... |
|750 |Substrate |Glycine   |Acetyl...     |Clostr... |SLITRK5   |glycine       |0.2801... |1.7545... |4.7038... |... |
|... |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |

Figure \@ref(fig:Ileum-Top-1000-relationship-network) (下方图) 为图Ileum Top 1000 relationship network概览。

**(对应文件为 `Figure+Table/Ileum-Top-1000-relationship-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ileum-Top-1000-relationship-network.pdf}
\caption{Ileum Top 1000 relationship network}\label{fig:Ileum-Top-1000-relationship-network}
\end{center}

Table \@ref(tab:Ileum-Top-1000-relationship-data) (下方表格) 为表格Ileum Top 1000 relationship data概览。

**(对应文件为 `Figure+Table/Ileum-Top-1000-relationship-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1000行3列，以下预览的表格可能省略部分数据；表格含有26个唯一`Gut.Microbiota'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Ileum-Top-1000-relationship-data)Ileum Top 1000 relationship data

|Gut.Microbiota        |Metabolite                     |Target_Gene |
|:---------------------|:------------------------------|:-----------|
|Clostridium           |2-Imino-1-methylimidazolidi... |B2M         |
|Clostridium           |2-Imino-1-methylimidazolidi... |DSC2        |
|Clostridium           |2-Imino-1-methylimidazolidi... |RGMB        |
|Clostridium           |Acetyl phosphate(2-)           |RET         |
|Blautia               |Glycine                        |RET         |
|Lactobacillus ruminis |Glycine                        |RET         |
|Clostridium           |2-Imino-1-methylimidazolidi... |JAM2        |
|Clostridium           |2-Imino-1-methylimidazolidi... |CST6        |
|Clostridium           |2-Imino-1-methylimidazolidi... |SPOCK2      |
|Clostridium           |2-Imino-1-methylimidazolidi... |LCN2        |
|Clostridium           |2-Imino-1-methylimidazolidi... |TNFRSF21    |
|Clostridium           |2-Imino-1-methylimidazolidi... |SMOC1       |
|Clostridium           |2-Imino-1-methylimidazolidi... |TNFRSF19    |
|Clostridium           |2-Imino-1-methylimidazolidi... |COL18A1     |
|Clostridium           |Acetyl phosphate(2-)           |SLITRK5     |
|...                   |...                            |...         |



## 进一步验证代谢物的存在

以来自于文献 [@ChangesAndCorChen2021] 胆结石小鼠模型研究的差异代谢物 (肝脏) 验证

以下是来源数据：

Table \@ref(tab:unnamed-chunk-38) (下方表格) 为表格unnamed chunk 38概览。

**(对应文件为 `Figure+Table/unnamed-chunk-38.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3104行9列，以下预览的表格可能省略部分数据；表格含有100个唯一`metabolite'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item cor:  皮尔逊关联系数，正关联或负关联。
\item pvalue:  显著性 P。
\item -log2(P.value):  P 的对数转化。
\item significant:  显著性。
\item sign:  人为赋予的符号，参考 significant。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:unnamed-chunk-38)Unnamed chunk 38

|metabo... |microb... |cor       |pvalue    |AdjPvalue |-log2(... |signif... |sign |cid |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:----|:---|
|PE(16:... |Prevot... |0.6120... |0.0049... |0.0159... |7.6581... |< 0.05    |*    |NA  |
|PE(16:... |Alloba... |-0.559... |0.0115... |0.0218... |6.4339... |< 0.05    |*    |NA  |
|PE(16:... |[Eubac... |-0.461... |0.0419... |0.0636... |4.5738... |< 0.05    |*    |NA  |
|PE(16:... |A2        |-0.514... |0.0218... |0.0428... |5.5171... |< 0.05    |*    |NA  |
|PE(16:... |Trepon... |0.5303... |0.0161... |0.0471... |5.9517... |< 0.05    |*    |NA  |
|PE(16:... |Anaero... |0.5185... |0.0191... |0.0383... |5.7051... |< 0.05    |*    |NA  |
|PE(16:... |Bifido... |-0.670... |0.0016... |0.0160... |9.2801... |< 0.05    |*    |NA  |
|PE(16:... |Entero... |-0.475... |0.0357... |0.0567... |4.8046... |< 0.05    |*    |NA  |
|PE(16:... |Turici... |-0.524... |0.0176... |0.0299... |5.8208... |< 0.05    |*    |NA  |
|PE(16:... |Tyzzer... |-0.568... |0.0100... |0.0197... |6.6310... |< 0.05    |*    |NA  |
|PE(16:... |[Eubac... |-0.478... |0.0345... |0.0931... |4.8570... |< 0.05    |*    |NA  |
|PE(16:... |GCA-90... |-0.498... |0.0252... |0.0406... |5.3097... |< 0.05    |*    |NA  |
|PE(16:... |Rumino... |-0.466... |0.0382... |0.0868... |4.7099... |< 0.05    |*    |NA  |
|PE(16:... |Tyzzer... |0.6169... |0.0037... |0.0096... |8.0559... |< 0.05    |*    |NA  |
|PE(16:... |[Rumin... |-0.472... |0.0370... |0.0699... |4.7527... |< 0.05    |*    |NA  |
|...       |...       |...       |...       |...       |...       |...       |...  |... |



### Liver

Table \@ref(tab:Liver-results-filtered-by-validation) (下方表格) 为表格Liver results filtered by validation概览。

**(对应文件为 `Figure+Table/Liver-results-filtered-by-validation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有148行10列，以下预览的表格可能省略部分数据；表格含有1个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Liver-results-filtered-by-validation)Liver results filtered by validation

|.id    |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:------|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CD59      |deoxyc...     |-0.070... |4.5859... |2.0409... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |CD59      |deoxyc...     |-0.070... |4.5859... |2.0409... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |CD59      |deoxyc...     |-0.070... |4.5859... |2.0409... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CD59      |deoxyc...     |-0.070... |4.5859... |2.0409... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |AHSG      |deoxyc...     |0.0688... |0.0001... |3.0112... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |AHSG      |deoxyc...     |0.0688... |0.0001... |3.0112... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |AHSG      |deoxyc...     |0.0688... |0.0001... |3.0112... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |AHSG      |deoxyc...     |0.0688... |0.0001... |3.0112... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|...    |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |

#### 富集分析 {#en1}

Figure \@ref(fig:LIVER-ids-KEGG-enrichment) (下方图) 为图LIVER ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/LIVER-ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-ids-KEGG-enrichment.pdf}
\caption{LIVER ids KEGG enrichment}\label{fig:LIVER-ids-KEGG-enrichment}
\end{center}

Figure \@ref(fig:LIVER-ids-GO-enrichment) (下方图) 为图LIVER ids GO enrichment概览。

**(对应文件为 `Figure+Table/LIVER-ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-ids-GO-enrichment.pdf}
\caption{LIVER ids GO enrichment}\label{fig:LIVER-ids-GO-enrichment}
\end{center}



### Ileum

Table \@ref(tab:Ileum-results-filtered-by-validation) (下方表格) 为表格Ileum results filtered by validation概览。

**(对应文件为 `Figure+Table/Ileum-results-filtered-by-validation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有104行10列，以下预览的表格可能省略部分数据；表格含有1个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Ileum-results-filtered-by-validation)Ileum results filtered by validation

|.id    |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:------|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |FGF19     |deoxyc...     |0.0981... |8.8819... |4.5243... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |FGF19     |deoxyc...     |0.0981... |8.8819... |4.5243... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |FGF19     |deoxyc...     |0.0981... |8.8819... |4.5243... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |FGF19     |deoxyc...     |0.0981... |8.8819... |4.5243... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |PCSK9     |deoxyc...     |0.0946... |6.9429... |1.4891... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.065... |0.0001... |6.9947... |... |
|222528 |Metabo... |Bile acid |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.060... |0.0005... |0.0002... |... |
|222528 |Metabo... |Cholic... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.060... |0.0005... |0.0002... |... |
|222528 |Metabo... |Chenod... |Deoxyc...     |Clostr... |CCL23     |deoxyc...     |-0.060... |0.0005... |0.0002... |... |
|...    |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |



#### 富集分析 {#en2}

Figure \@ref(fig:ILEUM-ids-GO-enrichment) (下方图) 为图ILEUM ids GO enrichment概览。

**(对应文件为 `Figure+Table/ILEUM-ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ILEUM-ids-GO-enrichment.pdf}
\caption{ILEUM ids GO enrichment}\label{fig:ILEUM-ids-GO-enrichment}
\end{center}

Figure \@ref(fig:ILEUM-ids-KEGG-enrichment) (下方图) 为图ILEUM ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/ILEUM-ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ILEUM-ids-KEGG-enrichment.pdf}
\caption{ILEUM ids KEGG enrichment}\label{fig:ILEUM-ids-KEGG-enrichment}
\end{center}







