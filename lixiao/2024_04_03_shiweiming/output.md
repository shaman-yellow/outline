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
XX基因通过促进糖酵解促进巨噬细胞M1极化}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-05-06}}
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




## 生信需求

疾病：类风湿性关节炎RA
物种：临床患者或者动物模型都可以
细胞：巨噬细胞

目标：筛出XX基因，XX基因满足，
1、是糖酵解相关基因
2、与巨噬细胞极化相关（M1/M2）

设想：XX基因在RA中上调，RA中M1巨噬细胞上调，其中XX基因主要分布在M1巨噬细胞而非M2巨噬细胞上，XX基因可能通过促进糖酵解促进巨噬细胞M1极化

M1标志：iNOS，CD11c，CD86等
M2标志：CD206，IL-10，TGF-beta等

## 结果

- 首先通过分析 GEO 单细胞数据，鉴定出巨噬细胞不同表型 Fig. \@ref(fig:The-Phenotypes)。
- 该数据集为小鼠来源，鉴定 M0、M1、M2 的小鼠基因 Marker 参考[@NovelMarkersTJablon2015]，
  实际使用的 Marker 见 Tab. \@ref(tab:The-markers-for-Macrophage-phenotypes-annotation)
- 进行差异分析 (Tab. \@ref(tab:DEGs-of-the-contrasts)) ：
    - XX 在RA中M1巨噬细胞上调: `GPI-day25-RA_Macrophage_M1` vs `Control_Macrophage_M1`
    - 其中XX基因主要分布在M1巨噬细胞而非M2巨噬细胞上: `GPI-day25-RA_Macrophage_M1` vs `GPI-day25-RA_Macrophage_M2`
- 以上两组差异基因交集见 Fig. \@ref(fig:Intersection-of-RA-M1-up-with-M1-not-M2)
- 小鼠基因映射到人类 Tab. \@ref(tab:Mapped-genes)
- 其中糖酵解相关的基因见 Fig. \@ref(fig:Intersection-of-RA-M1M2-related-with-Glycolysis-related)
- 筛选到唯一的基因: PPARG (小鼠 Pparg)。其表达特征见 Fig. \@ref(fig:Violing-plot-of-expression-level-of-the-Pparg)

## 进一步分析需求

利用开源数据库进行生物信息学分析，筛选并验证类风湿性关节炎临床患者和动物模型中与巨噬细胞极化和糖酵解相关的关键基因XX的表达情况

- XX (VWF) 表达水平与炎症因子、巨噬细胞浸润、巨噬细胞极化相关因子、糖酵解相关因子的相关性
- 与患者状态（例如血清类风湿因子（RF）、抗链球菌溶血素抗体（ASO）、红细胞沉降率（ESR）和C反应蛋白（CRP））的相关性

## 进一步分析结果

- 关联分析结果见 Fig. \@ref(fig:HUMAN-correlation-heatmap), Tab. \@ref(tab:HUMAN-correlation)。
- 未找到可用的 RA 表型数据集。

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE184609**: scRNA-Seq analysis of FACS-sorted live synovial cells isolated from naïve mice (two replicates) or from mice at day 6, 14, or 25 of GPI-induced arthritis (one replicate per time point).

- **GSE17755**: Peripheral blood was obtained from patients with RA (n=112), SLE (n=22), polyJIA (n=6), sJIA (n=51), HC (n=8), and HI (n=45). Blood samples from 8 HC and 45 HI are used as control.

## 方法

Mainly used method:

- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- The data in published article of Jablonski et al used for distinguishing macrophage phenotypes (M0/M1/M2)[@NovelMarkersTJablon2015].
- The R package `Seurat` used for scRNA-seq processing[@IntegratedAnalHaoY2021; @ComprehensiveIStuart2019].
- `SCSA` (python) used for cell type annotation[@ScsaACellTyCaoY2020].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## scRNA-seq

### 数据来源

这是一批小鼠的 单细胞测序数据。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE184609

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    10X Genomics Cell Ranger v3.1

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    Gene-cell UMI matrix was generated for downstream
analyses. Low-quality cells were removed based on their
unique feature counts and mitochondrial gene content. Data
was normalized and log transformed using the default
setting of Seurat (version 3.1.4).

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    Genome\_build: mm10

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    Supplementary\_files\_format\_and\_content: For each
sample, there is one mtx file with filtered gene expressing
UMI counts for each sample, one tsv file containing gene
names, and one tsv file with cell barcodes.

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/GSE184609-content`)**



### 细胞聚类与初步注释

使用 SCSA 对细胞类型注释。

Figure \@ref(fig:SCSA-Cell-type-annotation) (下方图) 为图SCSA Cell type annotation概览。

**(对应文件为 `Figure+Table/SCSA-Cell-type-annotation.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SCSA-Cell-type-annotation.pdf}
\caption{SCSA Cell type annotation}\label{fig:SCSA-Cell-type-annotation}
\end{center}



### 巨噬细胞重聚类

Figure \@ref(fig:Microphage-UMAP-Clustering) (下方图) 为图Microphage UMAP Clustering概览。

**(对应文件为 `Figure+Table/Microphage-UMAP-Clustering.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Microphage-UMAP-Clustering.pdf}
\caption{Microphage UMAP Clustering}\label{fig:Microphage-UMAP-Clustering}
\end{center}




### 巨噬细胞表型 M0、M1、M2 鉴定 Markers

Table \@ref(tab:The-markers-for-Macrophage-phenotypes-annotation) (下方表格) 为表格The markers for Macrophage phenotypes annotation概览。

**(对应文件为 `Figure+Table/The-markers-for-Macrophage-phenotypes-annotation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有26行2列，以下预览的表格可能省略部分数据；含有3个唯一`cell'。
\end{tcolorbox}
\end{center}

Table: (\#tab:The-markers-for-Macrophage-phenotypes-annotation)The markers for Macrophage phenotypes annotation

|cell          |markers   |
|:-------------|:---------|
|Macrophage_M0 |Sh2d3c    |
|Macrophage_M0 |Slc13a3   |
|Macrophage_M0 |Rcan1     |
|Macrophage_M0 |Trp53inp1 |
|Macrophage_M0 |Slc40a1   |
|Macrophage_M0 |Il16      |
|Macrophage_M1 |Cfb       |
|Macrophage_M1 |Slfn4     |
|Macrophage_M1 |H2-Q6     |
|Macrophage_M1 |Fpr1      |
|Macrophage_M1 |Slfn1     |
|Macrophage_M1 |Ccrl2     |
|Macrophage_M1 |Fpr2      |
|Macrophage_M1 |Cxcl10    |
|Macrophage_M1 |Oasl1     |
|...           |...       |

Figure \@ref(fig:Heatmap-show-the-reference-genes) (下方图) 为图Heatmap show the reference genes概览。

**(对应文件为 `Figure+Table/Heatmap-show-the-reference-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Heatmap-show-the-reference-genes.pdf}
\caption{Heatmap show the reference genes}\label{fig:Heatmap-show-the-reference-genes}
\end{center}

Figure \@ref(fig:Macrophage-phenotypes-type-annotation) (下方图) 为图Macrophage phenotypes type annotation概览。

**(对应文件为 `Figure+Table/Macrophage-phenotypes-type-annotation.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Macrophage-phenotypes-type-annotation.pdf}
\caption{Macrophage phenotypes type annotation}\label{fig:Macrophage-phenotypes-type-annotation}
\end{center}

### RA 与 Control 的巨噬细胞表型

随后，根据数据集的来源 (RA 或 Control，将巨噬细胞分类) 

Figure \@ref(fig:The-Phenotypes) (下方图) 为图The Phenotypes概览。

**(对应文件为 `Figure+Table/The-Phenotypes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/The-Phenotypes.pdf}
\caption{The Phenotypes}\label{fig:The-Phenotypes}
\end{center}



### 差异分析

- XX 在RA中M1巨噬细胞上调: `GPI-day25-RA_Macrophage_M1` vs `Control_Macrophage_M1`
- 其中XX基因主要分布在M1巨噬细胞而非M2巨噬细胞上: `GPI-day25-RA_Macrophage_M1` vs `GPI-day25-RA_Macrophage_M2`

Table \@ref(tab:DEGs-of-the-contrasts) (下方表格) 为表格DEGs of the contrasts概览。

**(对应文件为 `Figure+Table/DEGs-of-the-contrasts.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有355行7列，以下预览的表格可能省略部分数据；含有2个唯一`contrast；含有335个唯一`gene'。
\end{tcolorbox}
\end{center}

Table: (\#tab:DEGs-of-the-contrasts)DEGs of the contrasts

|contrast      |p_val         |avg_log2FC    |pct.1 |pct.2 |p_val_adj     |gene    |
|:-------------|:-------------|:-------------|:-----|:-----|:-------------|:-------|
|GPI-day25-... |1.75831850... |2.17770295... |0.044 |0.385 |5.27495551... |Adora3  |
|GPI-day25-... |2.23900708... |9.52901476... |0.069 |0.427 |6.71702126... |F7      |
|GPI-day25-... |6.04375313... |9.97788827... |0.093 |0.536 |1.81312594... |Hal     |
|GPI-day25-... |1.83819770... |13.5930067... |0.052 |0.641 |5.51459312... |Cxcl13  |
|GPI-day25-... |1.00690808... |4.79632080... |0.153 |0.583 |3.02072424... |Ifi44   |
|GPI-day25-... |2.16444867... |8.41136649... |0.153 |0.87  |6.49334601... |Slc13a3 |
|GPI-day25-... |8.87142099... |7.46793928... |0.081 |0.391 |2.66142629... |Cd4     |
|GPI-day25-... |1.52778766... |0.95745400... |0.141 |0.307 |4.58336298... |Tnfsf14 |
|GPI-day25-... |4.80404528... |3.93765968... |0.169 |0.484 |1.44121358... |Cd79b   |
|GPI-day25-... |8.42060311... |3.12179649... |0.06  |0.651 |2.52618093... |Cd209e  |
|GPI-day25-... |8.42067724... |1.96704094... |0.145 |0.786 |2.52620317... |Adgre4  |
|GPI-day25-... |8.24915617... |8.83724798... |0.161 |0.766 |2.47474685... |Pparg   |
|GPI-day25-... |1.31157015... |8.50505864... |0.153 |0.292 |3.93471045... |F10     |
|GPI-day25-... |2.28779328... |2.51813054... |0.024 |0.411 |6.86337986... |Apoc4   |
|GPI-day25-... |2.75634208... |4.11075823... |0.073 |0.755 |8.26902626... |Il10    |
|...           |...           |...           |...   |...   |...           |...     |

Figure \@ref(fig:Intersection-of-RA-M1-up-with-M1-not-M2) (下方图) 为图Intersection of RA M1 up with M1 not M2概览。

**(对应文件为 `Figure+Table/Intersection-of-RA-M1-up-with-M1-not-M2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-RA-M1-up-with-M1-not-M2.pdf}
\caption{Intersection of RA M1 up with M1 not M2}\label{fig:Intersection-of-RA-M1-up-with-M1-not-M2}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    Ifi44, Adgre4, Pparg, Dppa3, Cadm1, P2ry14, Gm1673,
Vwf, Ednrb, Fam43a, Bambi, Slc28a2, Plk2, Rcn3, Rrm1,
Ifi204, Bmp2, Gfra2, Spon1, Gstm1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-RA-M1-up-with-M1-not-M2-content`)**




## 小鼠基因映射到人类基因

Table \@ref(tab:Mapped-genes) (下方表格) 为表格Mapped genes概览。

**(对应文件为 `Figure+Table/Mapped-genes.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有19行2列，以下预览的表格可能省略部分数据；含有19个唯一`mgi\_symbol；含有19个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Mapped-genes)Mapped genes

|mgi_symbol |hgnc_symbol |
|:----------|:-----------|
|Bmp2       |BMP2        |
|Ednrb      |EDNRB       |
|Dppa3      |DPPA3       |
|Spon1      |SPON1       |
|Gfra2      |GFRA2       |
|Bambi      |BAMBI       |
|Cadm1      |CADM1       |
|Slc28a2    |SLC28A2     |
|Rrm1       |RRM1        |
|Ifi44      |IFI44       |
|Gm1673     |C4orf48     |
|Ifi204     |MNDA        |
|P2ry14     |P2RY14      |
|Rcn3       |RCN3        |
|Gstm1      |GSTM1       |
|...        |...         |



## 糖酵解相关基因

Table \@ref(tab:Glycolysis-related-genes-from-GeneCards) (下方表格) 为表格Glycolysis related genes from GeneCards概览。

**(对应文件为 `Figure+Table/Glycolysis-related-genes-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有118行7列，以下预览的表格可能省略部分数据；含有118个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Glycolysis

\vspace{2em}


\textbf{
Restrict (with quotes)
:}

\vspace{0.5em}

    FALSE

\vspace{2em}


\textbf{
Filtering by Score:
:}

\vspace{0.5em}

    Score > 3

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:Glycolysis-related-genes-from-GeneCards)Glycolysis related genes from GeneCards

|Symbol |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|TIGAR  |TP53 Induc... |Protein Co... |Q9NQ88     |45    |GC12P038924 |22.4  |
|PKM    |Pyruvate K... |Protein Co... |P14618     |58    |GC15M072199 |20.77 |
|HK2    |Hexokinase 2  |Protein Co... |P52789     |55    |GC02P074947 |19.42 |
|GAPDH  |Glyceralde... |Protein Co... |P04406     |59    |GC12P038965 |17.14 |
|LDHA   |Lactate De... |Protein Co... |P00338     |59    |GC11P018394 |15.81 |
|HIF1A  |Hypoxia In... |Protein Co... |Q16665     |57    |GC14P061695 |15.1  |
|RRAD   |RRAD, Ras ... |Protein Co... |P55042     |46    |GC16M067483 |15.1  |
|HK1    |Hexokinase 1  |Protein Co... |P19367     |59    |GC10P069269 |14.64 |
|PKLR   |Pyruvate K... |Protein Co... |P30613     |55    |GC01M155289 |13.37 |
|ENO1   |Enolase 1     |Protein Co... |P06733     |56    |GC01M008861 |13.36 |
|ENO3   |Enolase 3     |Protein Co... |P13929     |54    |GC17P004948 |13.33 |
|PFKP   |Phosphofru... |Protein Co... |Q01813     |53    |GC10P003066 |13.19 |
|TPI1   |Triosephos... |Protein Co... |P60174     |55    |GC12P006867 |13.18 |
|GLTC1  |Glycolysis... |RNA Gene (... |           |2     |GC11U909607 |12.97 |
|PGK1   |Phosphogly... |Protein Co... |P00558     |57    |GC0XP078166 |12.94 |
|...    |...           |...           |...        |...   |...         |...   |

Figure \@ref(fig:Intersection-of-RA-M1M2-related-with-Glycolysis-related) (下方图) 为图Intersection of RA M1M2 related with Glycolysis related概览。

**(对应文件为 `Figure+Table/Intersection-of-RA-M1M2-related-with-Glycolysis-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-RA-M1M2-related-with-Glycolysis-related.pdf}
\caption{Intersection of RA M1M2 related with Glycolysis related}\label{fig:Intersection-of-RA-M1M2-related-with-Glycolysis-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    PPARG

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-RA-M1M2-related-with-Glycolysis-related-content`)**



## 交集基因的表达 (小鼠单细胞数据)

Figure \@ref(fig:Violing-plot-of-expression-level-of-the-Pparg) (下方图) 为图Violing plot of expression level of the Pparg概览。

**(对应文件为 `Figure+Table/Violing-plot-of-expression-level-of-the-Pparg.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Violing-plot-of-expression-level-of-the-Pparg.pdf}
\caption{Violing plot of expression level of the Pparg}\label{fig:Violing-plot-of-expression-level-of-the-Pparg}
\end{center}



# 进一步分析

## 数据来源

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE17755

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Log2 ratios of Cy3 to Cy5 were calculated and
normalized by the method of global ratio median
normalization.

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/HUMAN-GSE17755-content`)**



## 炎症因子、巨噬细胞浸润、巨噬细胞极化相关因子、糖酵解相关因子

使用 genecards 获取相关基因 (各取前 50 基因)：

- IF: Inflammatory factors 炎症因子
- MI: Macrophage infiltration 巨噬细胞浸润
- MP: Macrophage polarization 巨噬细胞极化
- G: Glycolysis 糖酵解

Table \@ref(tab:All-Factors) (下方表格) 为表格All Factors概览。

**(对应文件为 `Figure+Table/All-Factors.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有200行2列，以下预览的表格可能省略部分数据；含有4个唯一`type'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-Factors)All Factors

|type                 |name      |
|:--------------------|:---------|
|Inflammatory factors |IL6       |
|Inflammatory factors |TNF       |
|Inflammatory factors |CRP       |
|Inflammatory factors |BDNF-AS   |
|Inflammatory factors |IL1B      |
|Inflammatory factors |LINC02605 |
|Inflammatory factors |TLR4      |
|Inflammatory factors |MIR146B   |
|Inflammatory factors |ADIPOQ    |
|Inflammatory factors |LINC01672 |
|Inflammatory factors |CXCL8     |
|Inflammatory factors |IL1A      |
|Inflammatory factors |NFKB1     |
|Inflammatory factors |CERNA3    |
|Inflammatory factors |IL18      |
|...                  |...       |

对上述基因集去重复后，关联分析。



## 关联分析

Figure \@ref(fig:HUMAN-correlation-heatmap) (下方图) 为图HUMAN correlation heatmap概览。

**(对应文件为 `Figure+Table/HUMAN-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HUMAN-correlation-heatmap.pdf}
\caption{HUMAN correlation heatmap}\label{fig:HUMAN-correlation-heatmap}
\end{center}

Figure \@ref(fig:HUMAN-correlation-heatmap-VWF-significant) (下方图) 为图HUMAN correlation heatmap VWF significant概览。

**(对应文件为 `Figure+Table/HUMAN-correlation-heatmap-VWF-significant.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HUMAN-correlation-heatmap-VWF-significant.pdf}
\caption{HUMAN correlation heatmap VWF significant}\label{fig:HUMAN-correlation-heatmap-VWF-significant}
\end{center}

 
`HUMAN regression VWF significant' 数据已全部提供。

**(对应文件为 `Figure+Table/HUMAN-regression-VWF-significant`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/HUMAN-regression-VWF-significant共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Glycolysis.pdf
\item 2\_Inflammatory factors.pdf
\item 3\_Macrophage infiltration.pdf
\item 4\_Macrophage polarization.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

Table \@ref(tab:HUMAN-correlation) (下方表格) 为表格HUMAN correlation概览。

**(对应文件为 `Figure+Table/HUMAN-correlation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2023行9列，以下预览的表格可能省略部分数据；含有17个唯一`From'。
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

Table: (\#tab:HUMAN-correlation)HUMAN correlation

|From    |To    |cor   |pvalue |-log2(... |signif... |sign |Factors   |Type   |
|:-------|:-----|:-----|:------|:---------|:---------|:----|:---------|:------|
|EDNRB   |GAPDH |-0.14 |0.0931 |3.4250... |> 0.05    |-    |Glycol... |Others |
|PPARG   |GAPDH |-0.06 |0.4812 |1.0552... |> 0.05    |-    |Glycol... |Others |
|CADM1   |GAPDH |-0.26 |9e-04  |10.117... |< 0.001   |**   |Glycol... |Others |
|BMP2    |GAPDH |-0.1  |0.225  |2.1520... |> 0.05    |-    |Glycol... |Others |
|SLC28A2 |GAPDH |0.06  |0.4919 |1.0235... |> 0.05    |-    |Glycol... |Others |
|RRM1    |GAPDH |0.33  |0      |16.609... |< 0.001   |**   |Glycol... |Others |
|BAMBI   |GAPDH |-0.16 |0.0796 |3.6510... |> 0.05    |-    |Glycol... |Others |
|PLK2    |GAPDH |-0.08 |0.3648 |1.4548... |> 0.05    |-    |Glycol... |Others |
|P2RY14  |GAPDH |0.43  |0      |16.609... |< 0.001   |**   |Glycol... |Others |
|MNDA    |GAPDH |-0.02 |0.7616 |0.3928... |> 0.05    |-    |Glycol... |Others |
|GSTM1   |GAPDH |-0.16 |0.073  |3.7759... |> 0.05    |-    |Glycol... |Others |
|IFI44   |GAPDH |-0.33 |0      |16.609... |< 0.001   |**   |Glycol... |Others |
|RCN3    |GAPDH |0.12  |0.148  |2.7563... |> 0.05    |-    |Glycol... |Others |
|SPON1   |GAPDH |-0.14 |0.0882 |3.5030... |> 0.05    |-    |Glycol... |Others |
|GFRA2   |GAPDH |-0.07 |0.3662 |1.4492... |> 0.05    |-    |Glycol... |Others |
|...     |...   |...   |...    |...       |...       |...  |...       |...    |





