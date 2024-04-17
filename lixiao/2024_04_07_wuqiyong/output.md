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
\begin{center} \textbf{\Huge 乙酰化酶分析筛选}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-17}}
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

利用生物信息学分析结合已有文献资料，筛选并验证与XX相关的乙酰化酶AA

具体要求为： 利用开源数据库，筛选心肌梗死机体的心脏细胞中关键差异表达基因XX以及与乙酰化相关酶基因的关联性。

1. 因客户之前所做基因为FKBP5，故XX初步定为FKBP5。假设FKBP5在心肌梗死机体心肌细胞中高表达，抑制FKBP5后可缓解心肌梗死。
2. 乙酰化酶AA备选：去乙酰化酶sirtuin 1（SIRT1）可以直接与FKBP5相互作用。
3. 若方案中的AA选择为HDAC6（客户之前发表过LncRNA NORAD-HDAC6-H3K9 -VEGF），那么方案中的XX选择不一定非要是FKBP5，若有创新点的更好的基因也可。

## 结果

- 结合数据库 MI 靶点 和 MI 小鼠数据集获取一批 MI 基因 Fig. \@ref(fig:Intersection-of-MI-DEGs-with-MI-targets)
- 从 epiFactor 数据库获取乙酰酶 (CoA)  (Tab. \@ref(tab:All-protein-of-CoA)) ，筛选了 MI 中为差异表达的 CoA (Fig. \@ref(fig:Intersection-of-All-CoA-with-MI-DEGs)) 。
- 根据 Fig. \@ref(fig:Intersection-of-MI-DEGs-with-MI-targets)
  和 Fig. \@ref(fig:Intersection-of-All-CoA-with-MI-DEGs)
  建立 PPI 网络 (有实验基础的蛋白物理直接互作) ，见 Fig. \@ref(fig:Filtered-and-formated-PPI-network)
- 筛选 CoA 与 DEGs 显著关联的组合，Fig. \@ref(fig:MI-correlation-heatmap)，Tab. \@ref(tab:MI-significant-correlation)
- 筛选上述关系：存在 PPI 关联且关联分析显著的组合 Tab. \@ref(tab:PPI-interact-and-significant-correlated-in-MI)
- 将上述 DEGs GO 富集分析，Fig. \@ref(fig:GO-enrichment)，BP 结果指向了 MI。
- 建立 CoA-XX-pathways 网络关系图，Fig. \@ref(fig:CoA-XX-GOpathways),
  数据见 Tab. \@ref(tab:All-candidates-and-enriched-GO-BP-pathways)。
- 最后，推荐 CoA-XX 组合为：
    - CoA:BRCA1, DEG:FLNA
    - CoA:HDAC9, DEG:PIK3CG
    - 以上 DEG 相关 GO 通路：cardiac muscle contraction; coagulation; muscle system process; regulation of body fluid levels; striated muscle contraction; wound healing
- 其它候选见 Tab. \@ref(tab:All-candidates-and-enriched-GO-BP-pathways)

注：

- FKBP5 (Fkbp5) 在 MI 中属于显著高表达，见 Tab. \@ref(tab:Fkbp5-expression)。
- FKBP5 在 Fig. \@ref(fig:Intersection-of-MI-DEGs-with-MI-targets) 被筛离。
- 尝试单独建立 PPI，未发现 SIRT1 与 FKBP5 的直接结合作用。





# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE236374**: Nine 8-week-old male C57BL/6JR mice were included in the experiment. The experiment was divided into 3 groups. Each group contained 3 mice, 2 groups of which required surgery to make models, called...

## 方法

Mainly used method:

- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Database `EpiFactors` used for screening epigenetic regulators[@Epifactors2022Maraku2023].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- R package `ClusterProfiler` used for GSEA enrichment[@ClusterprofilerWuTi2021].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## MI targets

使用以下合集：

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

    myocardial infarction

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

    Score > 5

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:GeneCards-used-data) (下方表格) 为表格GeneCards used data概览。

**(对应文件为 `Figure+Table/GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有567行7列，以下预览的表格可能省略部分数据；含有567个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GeneCards-used-data)GeneCards used data

|Symbol     |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:----------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|ACE        |Angiotensi... |Protein Co... |P12821     |60    |GC17P063477 |75.08 |
|MIAT       |Myocardial... |RNA Gene (... |           |32    |GC22P026646 |71.09 |
|F7         |Coagulatio... |Protein Co... |P08709     |56    |GC13P113105 |54.33 |
|ITGB3      |Integrin S... |Protein Co... |P05106     |61    |GC17P112532 |48.15 |
|LTA        |Lymphotoxi... |Protein Co... |P01374     |52    |GC06P134818 |44.63 |
|OLR1       |Oxidized L... |Protein Co... |P78380     |51    |GC12M029495 |44.32 |
|PLAT       |Plasminoge... |Protein Co... |P00750     |58    |GC08M042174 |39.78 |
|MCI2       |Myocardial... |Genetic Locus |           |4     |GC13U900611 |39.39 |
|F13A1      |Coagulatio... |Protein Co... |P00488     |56    |GC06M006144 |39.35 |
|CDKN2B-AS1 |CDKN2B Ant... |RNA Gene (... |           |31    |GC09P021994 |39.31 |
|LGALS2     |Galectin 2    |Protein Co... |P05162     |47    |GC22M037570 |38.25 |
|MEF2A      |Myocyte En... |Protein Co... |Q02078     |54    |GC15P099565 |38.14 |
|MIR499A    |MicroRNA 499a |RNA Gene (... |           |29    |GC20P034990 |37.65 |
|ESR1       |Estrogen R... |Protein Co... |P03372     |62    |GC06P151656 |37.58 |
|MIR208B    |MicroRNA 208b |RNA Gene (... |           |27    |GC14M023417 |35.34 |
|...        |...           |...           |...        |...   |...         |...   |



## MI mice DEGs {#MI}

### 数据来源

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE236374

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Raw reads were trimmed adaptor sequences and removed
low-quality reads using TrimGalore with default settings

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    Trimmed reads were aligned to the mm10 reference genome
by STAR with default settings

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    Read count extraction were performed using
FeatureCounts

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    Assembly: mm10

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/GSE236374-content`)**



### 差异分析

- MI-7d (7 day) vs Control

Figure \@ref(fig:MI-MI-7d-vs-MI-sham-DEGs) (下方图) 为图MI MI 7d vs MI sham DEGs概览。

**(对应文件为 `Figure+Table/MI-MI-7d-vs-MI-sham-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MI-MI-7d-vs-MI-sham-DEGs.pdf}
\caption{MI MI 7d vs MI sham DEGs}\label{fig:MI-MI-7d-vs-MI-sham-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
adj.P.Val cut-off
:}

\vspace{0.5em}

    0.05

\vspace{2em}


\textbf{
Log2(FC) cut-off
:}

\vspace{0.5em}

    1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/MI-MI-7d-vs-MI-sham-DEGs-content`)**

Table \@ref(tab:MI-data-MI-7d-vs-MI-sham-DEGs) (下方表格) 为表格MI data MI 7d vs MI sham DEGs概览。

**(对应文件为 `Figure+Table/MI-data-MI-7d-vs-MI-sham-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5724行8列，以下预览的表格可能省略部分数据；含有5724个唯一`Genesymbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:MI-data-MI-7d-vs-MI-sham-DEGs)MI data MI 7d vs MI sham DEGs

|rownames |Genesy... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |
|:--------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|7514     |Ctss      |4.8320... |7.4632... |50.601... |5.8181... |8.3472... |19.814... |
|14679    |Adamts2   |3.9541... |7.5930... |37.675... |9.6997... |3.8153... |17.557... |
|23411    |Col14a1   |4.5612... |7.5634... |37.311... |1.0637... |3.8153... |17.437... |
|11851    |Lox       |5.9882... |7.0429... |37.907... |9.1490... |3.8153... |17.419... |
|21619    |Fstl1     |3.9252... |9.4422... |33.841... |2.6934... |6.6702... |16.550... |
|1261     |Ctsh      |2.6147... |6.6709... |31.959... |4.6403... |6.6702... |16.144... |
|13487    |Pla2g7    |4.0298... |4.6625... |32.933... |3.4885... |6.6702... |16.129... |
|22176    |Laptm5    |3.3558... |6.9162... |31.874... |4.7596... |6.6702... |16.105... |
|1490     |Sparc     |3.2522... |11.160... |32.579... |3.8660... |6.6702... |16.079... |
|6315     |Hexb      |3.1220... |6.3869... |31.264... |5.7173... |6.6702... |15.929... |
|5004     |Ctsz      |3.0952... |6.9421... |30.777... |6.6372... |6.6702... |15.790... |
|21174    |Fbln5     |3.7685... |7.2452... |30.367... |7.5384... |6.6702... |15.656... |
|1805     |Litaf     |2.3676... |5.9412... |30.219... |7.8956... |6.6702... |15.624... |
|12260    |Nckap1l   |3.3359... |5.8304... |29.954... |8.5853... |6.6702... |15.519... |
|3893     |Gusb      |2.3568... |6.0931... |29.740... |9.1894... |6.6702... |15.480... |
|...      |...       |...       |...       |...       |...       |...       |...       |



### 基因映射

将小鼠基因映射到人类

Table \@ref(tab:Mapped-genes) (下方表格) 为表格Mapped genes概览。

**(对应文件为 `Figure+Table/Mapped-genes.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5274行2列，以下预览的表格可能省略部分数据；含有5123个唯一`mgi\_symbol；含有5146个唯一`hgnc\_symbol'。
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
|Tmsb4x     |TMSB4Y      |
|Hopx       |HOPX        |
|Cyth4      |CYTH4       |
|Col6a2     |COL6A2      |
|Pacsin2    |PACSIN2     |
|Fbln1      |FBLN1       |
|Sh3bp2     |SH3BP2      |
|Abcg1      |ABCG1       |
|Mipep      |MIPEP       |
|Itgb2      |ITGB2       |
|Pmepa1     |PMEPA1      |
|Maged2     |MAGED2      |
|Postn      |POSTN       |
|Slc39a6    |SLC39A6     |
|Sirpa      |SIRPG       |
|...        |...         |



### FKBP5 的表达

FKBP5 (Fkbp5) 在 MI 中属于显著高表达。

Table \@ref(tab:Fkbp5-expression) (下方表格) 为表格Fkbp5 expression概览。

**(对应文件为 `Figure+Table/Fkbp5-expression.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行10列，以下预览的表格可能省略部分数据；含有1个唯一`hgnc\_symbol'。
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

Table: (\#tab:Fkbp5-expression)Fkbp5 expression

|hgnc_s... |mgi_sy... |rownames |Genesy... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |
|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|FKBP5     |Fkbp5     |9124     |Fkbp5     |1.5635... |5.3072... |5.7027... |0.0002... |0.0005... |0.0172... |



## MI intersection (`MI_key_DEGs`)

Figure \@ref(fig:Intersection-of-MI-DEGs-with-MI-targets) (下方图) 为图Intersection of MI DEGs with MI targets概览。

**(对应文件为 `Figure+Table/Intersection-of-MI-DEGs-with-MI-targets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-MI-DEGs-with-MI-targets.pdf}
\caption{Intersection of MI DEGs with MI targets}\label{fig:Intersection-of-MI-DEGs-with-MI-targets}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    ABCG1, ITGB2, POSTN, EGLN3, PPARGC1A, LTBP2, CYBB,
C3AR1, THBS1, SERPINE1, CLU, SFRP2, TGFB3, IGFBP4, TNC,
LCP1, GAS6, CTSZ, HPGDS, BGN, VLDLR, GUCY1A1, CYP4F3, LIPA,
NCAM1, GLA, HLA-DMB, FERMT3, LGALS3, TLR2, MMP2, GPNMB,
CYBA, ALCAM, KDR, TNNI3, ARNTL, IGFBP7, ANPEP, PPM1L,
TNFRSF1B, SERPINF1, ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-MI-DEGs-with-MI-targets-content`)**



## 乙酰化酶

### 使用的乙酰化酶及其相关信息

Table \@ref(tab:All-protein-of-CoA) (下方表格) 为表格All protein of CoA概览。

**(对应文件为 `Figure+Table/All-protein-of-CoA.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有145行25列，以下预览的表格可能省略部分数据；含有142个唯一`HGNC\_symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-protein-of-CoA)All protein of CoA

|HGNC_s... |Modifi... |Id  |Status |HGNC_ID |HGNC_name |GeneID |UniPro......8 |UniPro......9 |Domain    |
|:---------|:---------|:---|:------|:-------|:---------|:------|:-------------|:-------------|:---------|
|ARID4A    |Histon... |36  |#      |9885    |AT ric... |5926   |P29374        |ARI4A_...     |ARID P... |
|ARID4B    |Histon... |37  |#      |15550   |AT ric... |51742  |Q4LE39        |ARI4B_...     |ARID P... |
|ATF2      |Histon... |49  |#      |784     |activa... |1386   |P15336        |ATF2_H...     |bZIP_1... |
|ATXN7     |Histon... |55  |#      |10560   |ataxin 7  |6314   |O15265        |ATX7_H...     |Pfam-B... |
|BANP      |Histon... |62  |#      |13450   |BTG3 a... |54971  |Q8N9N5        |BANP_H...     |BEN PF... |
|BAZ2A     |Histon... |67  |#      |962     |bromod... |11176  |Q9UIF9        |BAZ2A_...     |Bromod... |
|BCORL1    |Histon... |70  |#      |25657   |BCL6 c... |63035  |Q5H9F3        |BCORL_...     |Ank_2 ... |
|BRCA1     |Histon... |73  |#      |1100    |breast... |672    |P38398        |BRCA1_...     |BRCT P... |
|BRCA2     |Histon... |74  |#      |1101    |breast... |675    |P51587        |BRCA2_...     |BRCA-2... |
|BRMS1L    |Histon... |86  |#      |20512   |breast... |84312  |Q5PSV4        |BRM1L_...     |Sds3 P... |
|BRPF3     |Histon... |88  |#      |14256   |bromod... |27154  |Q9ULD4        |BRPF3_...     |Bromod... |
|CDY1      |Histon... |115 |#      |1809    |chromo... |9085   |Q9Y6F8        |CDY1_H...     |Chromo... |
|CDY1B     |Histon... |116 |#      |23920   |chromo... |253175 |Q9Y6F8        |CDY1_H...     |Chromo... |
|CDY2A     |Histon... |117 |#      |1810    |chromo... |9426   |Q9Y6F7        |CDY2_H...     |Chromo... |
|CDY2B     |Histon... |118 |#      |23921   |chromo... |203611 |Q9Y6F7        |CDY2_H...     |Chromo... |
|...       |...       |... |...    |...     |...       |...    |...           |...           |...       |



### 筛选差异表达的乙酰化酶 (`CoA_DEGs`)

使用 MI 数据 (\@ref(MI)) 的 DEGs，筛选差异表达的乙酰化酶。

以 `mgi_symbol` 取交集。

Figure \@ref(fig:Intersection-of-All-CoA-with-MI-DEGs) (下方图) 为图Intersection of All CoA with MI DEGs概览。

**(对应文件为 `Figure+Table/Intersection-of-All-CoA-with-MI-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-All-CoA-with-MI-DEGs.pdf}
\caption{Intersection of All CoA with MI DEGs}\label{fig:Intersection-of-All-CoA-with-MI-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    Brca1, Eid1, Eid2b, Hdac11, Hdac9, Hif1an, Jdp2,
Morf4l2, Ncoa1, Nsl1, Sirt7, Smarca1, Taf7, Zbtb16

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-All-CoA-with-MI-DEGs-content`)**



## 其它候选

### 以 PPI 网络筛选与 `CoA_DEGs` 相关的 `MI_key_DEGs` {#ppi}

根据 Fig. \@ref(fig:Intersection-of-MI-DEGs-with-MI-targets)
和 Fig. \@ref(fig:Intersection-of-All-CoA-with-MI-DEGs)
建立 PPI 网络 (有实验基础的蛋白物理直接互作) 。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
STRINGdb network type:
:}

\vspace{0.5em}

    physical

\vspace{2em}


\textbf{
Filter experiments score:
:}

\vspace{0.5em}

    At least score 100

\vspace{2em}


\textbf{
Filter textmining score:
:}

\vspace{0.5em}

    At least score 0

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:PPI-annotation) (下方表格) 为表格PPI annotation概览。

**(对应文件为 `Figure+Table/PPI-annotation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1364行10列，以下预览的表格可能省略部分数据；含有381个唯一`from'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item experiments:  相关实验。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:PPI-annotation)PPI annotation

|from     |to       |homology |experi......4 |experi......5 |database |databa... |textmi......8 |textmi......9 |... |
|:--------|:--------|:--------|:-------------|:-------------|:--------|:---------|:-------------|:-------------|:---|
|TNFRSF1A |RIPK3    |0        |292           |0             |0        |0         |473           |0             |... |
|DCN      |PLAT     |0        |205           |0             |0        |0         |0             |0             |... |
|DCN      |TGFB1    |0        |457           |0             |500      |0         |979           |60            |... |
|MMP2     |TGFB1    |0        |548           |0             |0        |0         |118           |0             |... |
|PLAT     |SERPINE1 |0        |955           |0             |700      |0         |982           |0             |... |
|MYH9     |ACTA2    |0        |205           |97            |900      |0         |0             |91            |... |
|MMP2     |COL1A1   |0        |292           |0             |0        |0         |0             |0             |... |
|TGFB1    |VDR      |0        |292           |0             |0        |0         |0             |0             |... |
|COL1A1   |VDR      |0        |292           |0             |0        |0         |0             |0             |... |
|MMP2     |LOX      |0        |238           |0             |0        |0         |0             |0             |... |
|COL1A1   |LOX      |0        |230           |0             |0        |0         |0             |0             |... |
|COL1A1   |SPARC    |0        |457           |0             |0        |0         |89            |90            |... |
|VDR      |IL12B    |0        |292           |0             |0        |0         |0             |0             |... |
|ACTA2    |CTSD     |0        |229           |0             |0        |0         |0             |0             |... |
|VDR      |EGR1     |0        |292           |0             |0        |0         |0             |0             |... |
|...      |...      |...      |...           |...           |...      |...       |...           |...           |... |

获取 CoA -> DEGs 的网络：

Figure \@ref(fig:Filtered-and-formated-PPI-network) (下方图) 为图Filtered and formated PPI network概览。

**(对应文件为 `Figure+Table/Filtered-and-formated-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filtered-and-formated-PPI-network.pdf}
\caption{Filtered and formated PPI network}\label{fig:Filtered-and-formated-PPI-network}
\end{center}



### 关联分析 {#cor}

根据 Fig. \@ref(fig:Filtered-and-formated-PPI-network)，以小鼠数据集 (\@ref(MI)) 进行关联分析。

Figure \@ref(fig:MI-correlation-heatmap) (下方图) 为图MI correlation heatmap概览。

**(对应文件为 `Figure+Table/MI-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MI-correlation-heatmap.pdf}
\caption{MI correlation heatmap}\label{fig:MI-correlation-heatmap}
\end{center}

Table \@ref(tab:MI-significant-correlation) (下方表格) 为表格MI significant correlation概览。

**(对应文件为 `Figure+Table/MI-significant-correlation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有738行7列，以下预览的表格可能省略部分数据；含有13个唯一`CoA\_DEGs\_ppi'。
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

Table: (\#tab:MI-significant-correlation)MI significant correlation

|CoA_DEGs_ppi |MI_key_DEG... |cor   |pvalue |-log2(P.va... |significant |sign |
|:------------|:-------------|:-----|:------|:-------------|:-----------|:----|
|Morf4l2      |Ppargc1a      |-0.95 |1e-04  |13.2877123... |< 0.001     |**   |
|Hdac9        |Ppargc1a      |0.98  |0      |16.6096404... |< 0.001     |**   |
|Sirt7        |Ppargc1a      |-0.92 |5e-04  |10.9657842... |< 0.001     |**   |
|Nsl1         |Ppargc1a      |-0.94 |2e-04  |12.2877123... |< 0.001     |**   |
|Taf7         |Ppargc1a      |0.9   |0.001  |9.96578428... |< 0.001     |**   |
|Ncoa1        |Ppargc1a      |0.91  |7e-04  |10.4803574... |< 0.001     |**   |
|Jdp2         |Ppargc1a      |-0.74 |0.0217 |5.52616114... |< 0.05      |*    |
|Hif1an       |Ppargc1a      |0.99  |0      |16.6096404... |< 0.001     |**   |
|Brca1        |Ppargc1a      |-0.93 |3e-04  |11.7027498... |< 0.001     |**   |
|Smarca1      |Ppargc1a      |-0.95 |1e-04  |13.2877123... |< 0.001     |**   |
|Hdac11       |Ppargc1a      |0.96  |0      |16.6096404... |< 0.001     |**   |
|Eid1         |Ppargc1a      |-0.87 |0.0024 |8.70274987... |< 0.05      |*    |
|Zbtb16       |Ppargc1a      |0.67  |0.0483 |4.37183300... |< 0.05      |*    |
|Morf4l2      |Il18r1        |0.88  |0.0018 |9.11778737... |< 0.05      |*    |
|Hdac9        |Il18r1        |-0.78 |0.013  |6.26534456... |< 0.05      |*    |
|...          |...           |...   |...    |...           |...         |...  |



### 存在 PPI 关联且关联分析显著的组合

结合 \@ref(ppi) 和 \@ref(cor) 筛选 CoA 与 XX 

Table \@ref(tab:PPI-interact-and-significant-correlated-in-MI) (下方表格) 为表格PPI interact and significant correlated in MI概览。

**(对应文件为 `Figure+Table/PPI-interact-and-significant-correlated-in-MI.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有64行9列，以下预览的表格可能省略部分数据；含有13个唯一`CoA\_DEGs\_ppi'。
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

Table: (\#tab:PPI-interact-and-significant-correlated-in-MI)PPI interact and significant correlated in MI

|CoA_DE... |MI_key... |cor   |pvalue |-log2(... |signif... |sign |CoA_hg... |DEG_hg... |
|:---------|:---------|:-----|:------|:---------|:---------|:----|:---------|:---------|
|Brca1     |Casp1     |0.91  |8e-04  |10.287... |< 0.001   |**   |BRCA1     |CASP1     |
|Brca1     |Ccna2     |0.9   |0.0011 |9.8282... |< 0.05    |*    |BRCA1     |CCNA2     |
|Brca1     |Ccnd1     |-0.87 |0.0024 |8.7027... |< 0.05    |*    |BRCA1     |CCND1     |
|Brca1     |Cdk1      |0.95  |1e-04  |13.287... |< 0.001   |**   |BRCA1     |CDK1      |
|Brca1     |E2f1      |0.95  |1e-04  |13.287... |< 0.001   |**   |BRCA1     |E2F1      |
|Brca1     |Esr1      |0.7   |0.0356 |4.8119... |< 0.05    |*    |BRCA1     |ESR1      |
|Brca1     |Ezh2      |0.88  |0.002  |8.9657... |< 0.05    |*    |BRCA1     |EZH2      |
|Brca1     |Fancd2    |0.94  |2e-04  |12.287... |< 0.001   |**   |BRCA1     |FANCD2    |
|Brca1     |Flna      |0.92  |4e-04  |11.287... |< 0.001   |**   |BRCA1     |FLNA      |
|Brca1     |Jup       |-0.94 |2e-04  |12.287... |< 0.001   |**   |BRCA1     |JUP       |
|Brca1     |Kif2c     |0.89  |0.0011 |9.8282... |< 0.05    |*    |BRCA1     |KIF2C     |
|Brca1     |Lgals3    |0.89  |0.0013 |9.5872... |< 0.05    |*    |BRCA1     |LGALS3    |
|Brca1     |Lmna      |0.89  |0.0015 |9.3808... |< 0.05    |*    |BRCA1     |LMNA      |
|Brca1     |Mapt      |-0.91 |8e-04  |10.287... |< 0.001   |**   |BRCA1     |MAPT      |
|Brca1     |Mefv      |0.97  |0      |16.609... |< 0.001   |**   |BRCA1     |MEFV      |
|...       |...       |...   |...    |...       |...       |...  |...       |...       |





### 富集分析

将 Tab. \@ref(tab:PPI-interact-and-significant-correlated-in-MI) 中的 DEGs 进行富集分析

Figure \@ref(fig:GO-enrichment) (下方图) 为图GO enrichment概览。

**(对应文件为 `Figure+Table/GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GO-enrichment.pdf}
\caption{GO enrichment}\label{fig:GO-enrichment}
\end{center}



### CoA-XX-pathways

Figure \@ref(fig:CoA-XX-GOpathways) (下方图) 为图CoA XX GOpathways概览。

**(对应文件为 `Figure+Table/CoA-XX-GOpathways.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/CoA-XX-GOpathways.pdf}
\caption{CoA XX GOpathways}\label{fig:CoA-XX-GOpathways}
\end{center}

Table \@ref(tab:All-candidates-and-enriched-GO-BP-pathways) (下方表格) 为表格All candidates and enriched GO BP pathways概览。

**(对应文件为 `Figure+Table/All-candidates-and-enriched-GO-BP-pathways.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有64行4列，以下预览的表格可能省略部分数据；含有13个唯一`CoA\_hgnc\_symbol；含有51个唯一`DEG\_hgnc\_symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-candidates-and-enriched-GO-BP-pathways)All candidates and enriched GO BP pathways

|CoA_hgnc_symbol |DEG_hgnc_symbol |Hit_pathway_number |Enriched_pathways    |
|:---------------|:---------------|:------------------|:--------------------|
|BRCA1           |FLNA            |6                  |cardiac muscle co... |
|BRCA1           |SRC             |6                  |coagulation; regu... |
|HDAC9           |PIK3CG          |6                  |cardiac muscle co... |
|NCOA1           |SRC             |6                  |coagulation; regu... |
|ZBTB16          |CASP3           |5                  |response to corti... |
|BRCA1           |CCND1           |4                  |regulation of bod... |
|BRCA1           |TTN             |4                  |cardiac muscle co... |
|JDP2            |FOS             |4                  |response to corti... |
|MORF4L2         |ACTG1           |4                  |coagulation; regu... |
|MORF4L2         |TNNT2           |4                  |cardiac muscle co... |
|NCOA1           |CCND1           |4                  |regulation of bod... |
|NCOA1           |FOS             |4                  |response to corti... |
|NCOA1           |PPARA           |4                  |muscle system pro... |
|BRCA1           |JUP             |3                  |cardiac muscle co... |
|BRCA1           |PLAUR           |3                  |coagulation; regu... |
|...             |...             |...                |...                  |



