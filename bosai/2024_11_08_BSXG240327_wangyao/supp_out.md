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
  \usepackage{tikz}
  \usepackage{auto-pst-pdf}
  \usepackage{pgfornament}
  \usepackage{pstricks-add}
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






\begin{titlepage} \newgeometry{top=6.5cm}
\ThisCenterWallPaper{1.12}{~/outline/bosai//cover_page_analysis.pdf}
\begin{center} \textbf{\huge
基于血小板RNA测序数据预测早期肺癌潜在生物标志物}
\vspace{4em} \begin{textblock}{10}(3,4.85) \Large
\textbf{\textcolor{black}{BSXG240327}}
\end{textblock} \begin{textblock}{10}(3,5.8)
\Large \textbf{\textcolor{black}{黄礼闯}}
\end{textblock} \begin{textblock}{10}(3,6.75)
\Large \textbf{\textcolor{black}{补充分析}}
\end{textblock} \begin{textblock}{10}(3,7.7)
\Large \textbf{\textcolor{black}{陈立茂}}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 分析流程 {#abstract}





该分析思路与 (2023, **IF:4.8**, Q1, Biomolecules)[@HCC_RNA_Sequen_Wang_2023] 相似。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-26 17-47-48.png}
\caption{Unnamed chunk 7}\label{fig:unnamed-chunk-7}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 材料和方法 {#introduction}

## 数据分析平台

在 Linux pop-os x86_64 (6.9.3-76060903-generic) 上，使用 R version 4.4.2 (2024-10-31) (https://www.r-project.org/) 对数据统计分析与整合分析。


##  Biomart 基因注释 (Dataset: ALL)

以 R 包 `biomaRt` (2.62.0) 对基因进行注释，获取各数据库 ID 或注释信息，以备后续分析。

##  Limma 差异分析 (Dataset: MRNA)

以 R 包 `limma` (3.62.1) (2005, **IF:**, , )[@LimmaLinearMSmyth2005] `edgeR` (4.4.0) (, **IF:**, , )[@EdgerDifferenChen] 进行差异分析。以 `edgeR::filterByExpr` 过于 count 数量小于 10 的基因。以 `edgeR::calcNormFactors`，`limma::voom` 转化 count 数据为 log2 counts-per-million (logCPM)。分析方法参考 <https://bioconductor.org/packages/release/workflows/vignettes/RNAseq123/inst/doc/limmaWorkflow.html>。
使用 `limma::lmFit`, `limma::contrasts.fit`, `limma::eBayes` 差异分析对比组：Early_stage vs Healthy, Advanced_stage vs Healthy, Advanced_stage vs Early_stage。以 `limma::topTable` 提取所有结果，并过滤得到 adj.P.Val 小于 0.05，|Log2(FC)| 大于 1 的统计结果。

##  Mfuzz 聚类分析 (Dataset: MRNA)

以 R 包 `Mfuzz` (2.66.0) (, **IF:**, , )[@Mfuzz_a_softwa_Kumar_2007] 对基因聚类分析，设定 fuzzification 参数为 3.73540696993324 (以 `Mfuzz::mestimate` 预估) ，得到 8 个聚类。

##  富集分析 (Dataset: MRNA)

以 ClusterProfiler R 包 (4.15.0.2) (2021, **IF:33.2**, Q1, The Innovation)[@ClusterprofilerWuTi2021]进行 KEGG 和 GO 富集分析。

##  TCGA 数据获取 (Dataset: LUSC)

以 R 包 `TCGAbiolinks` (2.34.0) (2015, **IF:16.6**, Q1, Nucleic Acids Research)[@TcgabiolinksAColapr2015] 获取 TCGA 数据集。

以 R 包 `EFS` (1.0.3) (2017, **IF:4**, Q1, BioData Mining)[@EfsAnEnsemblNeuman2017] 筛选关键基因。
以 R 包 `survival` (3.7.0) 进行单因素 COX 回归 (`survival::coxph`)。筛选 `Pr(>|z|)` < .05` 的基因。

数据源自 TCGA-LUSC，筛选 AJCC Stage (ajcc_pathologic_stage) 为 Stage I, Stage II 的病人，并且 days_to_last_follow_up 大于 10 天，且为肿瘤组织的样本。

##  Survival 生存分析 (Dataset: LUSC)

将 Univariate COX 回归系数用于风险评分计算，根据中位风险评分 0.0797187407744678 将患者分为低危组和高危组。
以 R 包 `survival` (3.7.0) 生存分析，以 R 包 `survminer` (0.5.0) 绘制生存曲线。以 R 包 `timeROC` (0.4) 绘制 1, 3, 5 年生存曲线。

##  COX 回归 (Dataset: PROG)

以 R 包 `survival` (3.7.0) 做多因素 COX 回归 (`survival::coxph`)。

##  GEO 数据获取 (Dataset: LUSC)

以 R 包 `GEOquery` (2.74.0) 获取 GSE157010 数据集。

##  Survival 生存分析 (Dataset: GEO_LUSC)

将 Univariate COX 回归系数用于风险评分计算，根据中位风险评分 0.0418674487761947 将患者分为低危组和高危组。
以 R 包 `survival` (3.7.0) 生存分析，以 R 包 `survminer` (0.5.0) 绘制生存曲线。以 R 包 `timeROC` (0.4) 绘制 1, 3, 5 年生存曲线。

##  estimate 免疫评分 (Dataset: LUSC)

以 R 包 `estimate` (1.0.13) (2013, **IF:14.7**, Q1, Nature communications)[@Inferring_tumou_Yoshih_2013] 预测数据集的 stromal, immune, estimate 得分。
从 TISIDB (, **IF:**, , )[@TISIDB_an_inte_Ru_Be_2019] 数据库下载的 178 个基因 (genes encoding immunomodulators and chemokines) 比较表达量差异。

##  Limma 差异分析 (Dataset: LNCRNA)

以 R 包 `limma` (3.62.1) (2005, **IF:**, , )[@LimmaLinearMSmyth2005] `edgeR` (4.4.0) (, **IF:**, , )[@EdgerDifferenChen] 进行差异分析。以 `edgeR::filterByExpr` 过于 count 数量小于 10 的基因。以 `edgeR::calcNormFactors`，`limma::voom` 转化 count 数据为 log2 counts-per-million (logCPM)。分析方法参考 <https://bioconductor.org/packages/release/workflows/vignettes/RNAseq123/inst/doc/limmaWorkflow.html>。随后，以 公式 ~ 0 + group + batch 创建设计矩阵 (design matrix) 用于线性分析。
使用 `limma::lmFit`, `limma::contrasts.fit`, `limma::eBayes` 差异分析对比组：Early_stage vs Healthy, Advanced_stage vs Healthy, Advanced_stage vs Early_stage。以 `limma::topTable` 提取所有结果，并过滤得到 adj.P.Val 小于 0.05，|Log2(FC)| 大于 1 的统计结果。

# 分析结果 {#workflow}





## Limma 差异分析 (MRNA)

肝癌 RNA-seq， 共 247 个样本，分 3 组，分别为 Advanced_stage (65) , Early_stage (101) , Healthy (81) 。
元数据见 Tab. \@ref(tab:MRNA-metadata) 。
对基因注释后，获取 mRNA 数据差异分析。
差异分析 Early_stage vs Healthy, Advanced_stage vs Healthy, Advanced_stage vs Early_stage (若 A vs B，则为前者比后者，LogFC 大于 0 时，A 表达量高于 B)
得到的 DEGs 统计见 Fig. \@ref(fig:MRNA-Difference-intersection)。
所有 DEGs 表达特征见 Fig. \@ref(fig:MRNA-Heatmap-of-DEGs)。
所有上调 DEGs 有 539 个，下调共 781；一共 1278 个 (非重复)。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:MRNA-metadata) (下方表格) 为表格MRNA metadata概览。

**(对应文件为 `Figure+Table/MRNA-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有247行6列，以下预览的表格可能省略部分数据；含有247个唯一`sample'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MRNA-metadata)MRNA metadata

|sample        |group       |lib.size |norm.factors |rownames      |batch |
|:-------------|:-----------|:--------|:------------|:-------------|:-----|
|X180622CMQ... |Early_stage |14419487 |1            |180622CMQ-907 |1806  |
|X180622HLQ... |Early_stage |13558462 |1            |180622HLQ-908 |1806  |
|X180622LSF... |Early_stage |16935778 |1            |180622LSF-902 |1806  |
|X180622SRD... |Early_stage |16297826 |1            |180622SRD-906 |1806  |
|X180622YRQ... |Early_stage |17343112 |1            |180622YRQ-903 |1806  |
|X180623WMC... |Early_stage |16088883 |1            |180623WMC-911 |1806  |
|X180626XMH... |Early_stage |20035739 |1            |180626XMH-915 |1806  |
|X180627CSY... |Early_stage |17851721 |1            |180627CSY-918 |1806  |
|X180627XYJ... |Early_stage |18398673 |1            |180627XYJ-917 |1806  |
|X180628LJH... |Early_stage |11784847 |1            |180628LJH-902 |1806  |
|X180705LLF... |Early_stage |18773735 |1            |180705LLF-915 |1807  |
|X180705WWP... |Early_stage |14747138 |1            |180705WWP-912 |1807  |
|X180705ZQY... |Early_stage |15490310 |1            |180705ZQY-911 |1807  |
|X180705ZZX... |Early_stage |18523030 |1            |180705ZZX-913 |1807  |
|X180707CZM... |Early_stage |21342554 |1            |180707CZM-917 |1807  |
|...           |...         |...      |...          |...           |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Heatmap-of-DEGs) (下方图) 为图MRNA Heatmap of DEGs概览。

**(对应文件为 `Figure+Table/MRNA-Heatmap-of-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Heatmap-of-DEGs.pdf}
\caption{MRNA Heatmap of DEGs}\label{fig:MRNA-Heatmap-of-DEGs}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Early-stage-vs-Healthy) (下方图) 为图MRNA Early stage vs Healthy概览。

**(对应文件为 `Figure+Table/MRNA-Early-stage-vs-Healthy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Early-stage-vs-Healthy.pdf}
\caption{MRNA Early stage vs Healthy}\label{fig:MRNA-Early-stage-vs-Healthy}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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
**(上述信息框内容已保存至 `Figure+Table/MRNA-Early-stage-vs-Healthy-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Advanced-stage-vs-Healthy) (下方图) 为图MRNA Advanced stage vs Healthy概览。

**(对应文件为 `Figure+Table/MRNA-Advanced-stage-vs-Healthy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Advanced-stage-vs-Healthy.pdf}
\caption{MRNA Advanced stage vs Healthy}\label{fig:MRNA-Advanced-stage-vs-Healthy}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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
**(上述信息框内容已保存至 `Figure+Table/MRNA-Advanced-stage-vs-Healthy-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Advanced-stage-vs-Early-stage) (下方图) 为图MRNA Advanced stage vs Early stage概览。

**(对应文件为 `Figure+Table/MRNA-Advanced-stage-vs-Early-stage.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Advanced-stage-vs-Early-stage.pdf}
\caption{MRNA Advanced stage vs Early stage}\label{fig:MRNA-Advanced-stage-vs-Early-stage}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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
**(上述信息框内容已保存至 `Figure+Table/MRNA-Advanced-stage-vs-Early-stage-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Difference-intersection) (下方图) 为图MRNA Difference intersection概览。

**(对应文件为 `Figure+Table/MRNA-Difference-intersection.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Difference-intersection.pdf}
\caption{MRNA Difference intersection}\label{fig:MRNA-Difference-intersection}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/MRNA-Difference-intersection-content`)**


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`MRNA data DEGs' 数据已全部提供。

**(对应文件为 `Figure+Table/MRNA-data-DEGs`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/MRNA-data-DEGs共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_Early\_stage - Healthy.csv
\item 2\_Advanced\_stage - Healthy.csv
\item 3\_Advanced\_stage - Early\_stage.csv
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

## Mfuzz 聚类分析 (MRNA)

将上述筛选得的 DEGs 以 Mfuzz 聚类分析。
见 Fig. \@ref(fig:MRNA-Mfuzz-clusters)。按照 Healthy, Early_stage, Advanced_stage 顺序, 在 Mfuzz 聚类中，1, 3, 4 为按时序上调，共 590 个，6, 8 为按时序下调，共 325 个。其他基因为离散变化。。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-Mfuzz-clusters) (下方图) 为图MRNA Mfuzz clusters概览。

**(对应文件为 `Figure+Table/MRNA-Mfuzz-clusters.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-Mfuzz-clusters.pdf}
\caption{MRNA Mfuzz clusters}\label{fig:MRNA-Mfuzz-clusters}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 富集分析 (MRNA)

将 MFuzz 上调聚类与下调聚类分别以 KEGG 富集分析。
KEGG 见 Fig. \@ref(fig:MRNA-up-KEGG-enrichment), Fig. \@ref(fig:MRNA-down-KEGG-enrichment)。
GO 见 Fig. \@ref(fig:MRNA-up-GO-enrichment), Fig. \@ref(fig:MRNA-down-GO-enrichment)。
上调组主要富集于 Cellular Processes, Metabolism 相关。
下调组富集于 Immune system 相关。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-up-KEGG-enrichment) (下方图) 为图MRNA up KEGG enrichment概览。

**(对应文件为 `Figure+Table/MRNA-up-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-up-KEGG-enrichment.pdf}
\caption{MRNA up KEGG enrichment}\label{fig:MRNA-up-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-up-GO-enrichment) (下方图) 为图MRNA up GO enrichment概览。

**(对应文件为 `Figure+Table/MRNA-up-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-up-GO-enrichment.pdf}
\caption{MRNA up GO enrichment}\label{fig:MRNA-up-GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-down-KEGG-enrichment) (下方图) 为图MRNA down KEGG enrichment概览。

**(对应文件为 `Figure+Table/MRNA-down-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-down-KEGG-enrichment.pdf}
\caption{MRNA down KEGG enrichment}\label{fig:MRNA-down-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MRNA-down-GO-enrichment) (下方图) 为图MRNA down GO enrichment概览。

**(对应文件为 `Figure+Table/MRNA-down-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MRNA-down-GO-enrichment.pdf}
\caption{MRNA down GO enrichment}\label{fig:MRNA-down-GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## TCGA 数据获取 (LUSC)

获取 TCGA-LUSC 数据，用于临床数据分析和预后模型建立。



## COX 回归 (LUSC)

数据源自 TCGA-LUSC，筛选 AJCC Stage (ajcc_pathologic_stage) 为 Stage I, Stage II 的病人，并且 days_to_last_follow_up 大于 10 天，且为肿瘤组织的样本。所用样本的元数据见 Tab. \@ref(tab:LUSC-metadata)。

数据特征如下：

Data Frame Summary  
Dimensions: 296 x 6  
Duplicates: 93  

+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| No | Variable                | Stats / Values         | Freqs (% of Valid) | Graph                | Valid    | Missing |
+====+=========================+========================+====================+======================+==========+=========+
| 1  | age_at_index            | Mean (sd) : 67.4 (8.5) | 40 distinct values |               :      | 291      | 5       |
|    | [integer]               | min < med < max:       |                    |           : : :      | (98.3%)  | (1.7%)  |
|    |                         | 39 < 69 < 84           |                    |           : : : .    |          |         |
|    |                         | IQR (CV) : 12 (0.1)    |                    |       : : : : : :    |          |         |
|    |                         |                        |                    |   . . : : : : : : :  |          |         |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| 2  | vital_status            | 1. Alive               | 228 (77.0%)        | IIIIIIIIIIIIIII      | 296      | 0       |
|    | [character]             | 2. Dead                |  68 (23.0%)        | IIII                 | (100.0%) | (0.0%)  |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| 3  | gender                  | 1. female              |  78 (26.4%)        | IIIII                | 296      | 0       |
|    | [character]             | 2. male                | 218 (73.6%)        | IIIIIIIIIIIIII       | (100.0%) | (0.0%)  |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| 4  | tumor_grade             | 1. Not Reported        | 296 (100.0%)       | IIIIIIIIIIIIIIIIIIII | 296      | 0       |
|    | [character]             |                        |                    |                      | (100.0%) | (0.0%)  |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| 5  | ajcc_pathologic_stage   | 1. Stage IA            |  72 (24.3%)        | IIII                 | 296      | 0       |
|    | [character]             | 2. Stage IB            | 107 (36.1%)        | IIIIIII              | (100.0%) | (0.0%)  |
|    |                         | 3. Stage II            |   1 ( 0.3%)        |                      |          |         |
|    |                         | 4. Stage IIA           |  53 (17.9%)        | III                  |          |         |
|    |                         | 5. Stage IIB           |  63 (21.3%)        | IIII                 |          |         |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+
| 6  | classification_of_tumor | 1. not reported        | 296 (100.0%)       | IIIIIIIIIIIIIIIIIIII | 296      | 0       |
|    | [character]             |                        |                    |                      | (100.0%) | (0.0%)  |
+----+-------------------------+------------------------+--------------------+----------------------+----------+---------+

将 LUSC 数据 (count) 标准化后 (同 MRNA 的方法)，以生存状态为指标 (Fig. \@ref(fig:LUSC-Group-distribution))，以 EFS 算法，进行 Feature selection, 得到 Top 30 基因, 统计得分见 Fig. \@ref(fig:LUSC-Top-Features-Selected-By-EFS)。
随后，以单因素 COX 回归，筛选能显著预测生存结局的基因。EFS 与单因素 COX 回归结果如 Tab. \@ref(tab:LUSC-Uni-COX-cofficients-filtered-by-EFS)。共 9 个基因：。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:LUSC-metadata) (下方表格) 为表格LUSC metadata概览。

**(对应文件为 `Figure+Table/LUSC-metadata.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有296行87列，以下预览的表格可能省略部分数据；含有296个唯一`sample'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LUSC-metadata)LUSC metadata

|sample    |group |lib.size |norm.f... |barcode   |patient   |shortL... |defini... |sample......9 |sample......10 |... |
|:---------|:-----|:--------|:---------|:---------|:---------|:---------|:---------|:-------------|:--------------|:---|
|TCGA-1... |Dead  |37255376 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Alive |43492507 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Dead  |39714818 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Dead  |39975834 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Alive |40747917 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Alive |44429215 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Alive |21735012 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-1... |Alive |61555320 |1         |TCGA-1... |TCGA-1... |TP        |Primar... |TCGA-1...     |01             |... |
|TCGA-2... |Dead  |48526883 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Alive |60443027 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Alive |60226646 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Alive |58365924 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Dead  |58631601 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Dead  |54098835 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|TCGA-2... |Alive |54921696 |1         |TCGA-2... |TCGA-2... |TP        |Primar... |TCGA-2...     |01             |... |
|...       |...   |...      |...       |...       |...       |...       |...       |...           |...            |... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-Group-distribution) (下方图) 为图LUSC Group distribution概览。

**(对应文件为 `Figure+Table/LUSC-Group-distribution.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-Group-distribution.pdf}
\caption{LUSC Group distribution}\label{fig:LUSC-Group-distribution}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-Top-Features-Selected-By-EFS) (下方图) 为图LUSC Top Features Selected By EFS概览。

**(对应文件为 `Figure+Table/LUSC-Top-Features-Selected-By-EFS.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-Top-Features-Selected-By-EFS.pdf}
\caption{LUSC Top Features Selected By EFS}\label{fig:LUSC-Top-Features-Selected-By-EFS}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:LUSC-Uni-COX-cofficients-filtered-by-EFS) (下方表格) 为表格LUSC Uni COX cofficients filtered by EFS概览。

**(对应文件为 `Figure+Table/LUSC-Uni-COX-cofficients-filtered-by-EFS.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有9行7列，以下预览的表格可能省略部分数据；含有9个唯一`feature'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LUSC-Uni-COX-cofficients-filtered-by-EFS)LUSC Uni COX cofficients filtered by EFS

|feature  |coef          |exp(coef)     |se(coef)      |z             |pvalue        |p.adjust      |
|:--------|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|SERPINE1 |0.24390416... |1.27622202... |0.11338208... |2.15117024... |0.03146276... |0.83624230... |
|BCL2L2   |-0.4283650... |0.65157349... |0.14369845... |-2.9809998... |0.00287308... |0.83624230... |
|SLC14A1  |0.45789329... |1.58074031... |0.09645783... |4.74708263... |2.06371657... |0.00184702... |
|DYRK3    |0.29492209... |1.34302172... |0.13055192... |2.25904045... |0.02388086... |0.83624230... |
|PDCD11   |-0.2666409... |0.76594805... |0.11389728... |-2.3410647... |0.01922883... |0.83624230... |
|AGPAT3   |0.27364386... |1.31474648... |0.12352324... |2.21532281... |0.02673791... |0.83624230... |
|COQ2     |-0.2876134... |0.75005145... |0.12333293... |-2.3320085... |0.01970024... |0.83624230... |
|TPK1     |0.31038423... |1.36394908... |0.13272344... |2.33857877... |0.01935724... |0.83624230... |
|MPZL1    |0.30363800... |1.35477853... |0.11695141... |2.59627472... |0.00942406... |0.83624230... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## Survival 生存分析 (LUSC)

这些基因表达特征如 Fig. \@ref(fig:LUSC-risk-score-related-genes-heatmap) 热图所示。

建立预后特征，构建风险评分：

$$
Score = \sum(expr(Gene) \times coef)
$$

按中位风险评分，将病例分为 Low 和 High 风险组，随后进行生存分析，
见 Fig. \@ref(fig:LUSC-survival-curve-of-risk-score)。
AUC 见 Fig. \@ref(fig:LUSC-time-ROC)。
第 1，3，5 年存活的患者，风险评分显著较低。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-risk-score-related-genes-heatmap) (下方图) 为图LUSC risk score related genes heatmap概览。

**(对应文件为 `Figure+Table/LUSC-risk-score-related-genes-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-risk-score-related-genes-heatmap.pdf}
\caption{LUSC risk score related genes heatmap}\label{fig:LUSC-risk-score-related-genes-heatmap}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-survival-curve-of-risk-score) (下方图) 为图LUSC survival curve of risk score概览。

**(对应文件为 `Figure+Table/LUSC-survival-curve-of-risk-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-survival-curve-of-risk-score.pdf}
\caption{LUSC survival curve of risk score}\label{fig:LUSC-survival-curve-of-risk-score}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-time-ROC) (下方图) 为图LUSC time ROC概览。

**(对应文件为 `Figure+Table/LUSC-time-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-time-ROC.pdf}
\caption{LUSC time ROC}\label{fig:LUSC-time-ROC}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-boxplot-of-risk-score) (下方图) 为图LUSC boxplot of risk score概览。

**(对应文件为 `Figure+Table/LUSC-boxplot-of-risk-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-boxplot-of-risk-score.pdf}
\caption{LUSC boxplot of risk score}\label{fig:LUSC-boxplot-of-risk-score}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## COX 回归 (Prognosis)



进一步通过单因素和多因素 COX 回归的方式评估了包括风险评分在内的4项预后特征 (smoking, treatment 等其他数据缺失值较多，不易处理) 。数据特征如下：

Data Frame Summary  
Dimensions: 291 x 5  
Duplicates: 0  

+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+
| No | Variable              | Stats / Values       | Freqs (% of Valid)  | Graph               | Valid    | Missing |
+====+=======================+======================+=====================+=====================+==========+=========+
| 1  | rownames              | 1. TCGA-18-3408-01A  |   1 ( 0.3%)         |                     | 291      | 0       |
|    | [character]           | 2. TCGA-18-3409-01A  |   1 ( 0.3%)         |                     | (100.0%) | (0.0%)  |
|    |                       | 3. TCGA-18-3415-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 4. TCGA-18-3416-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 5. TCGA-18-3419-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 6. TCGA-18-3421-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 7. TCGA-18-4721-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 8. TCGA-18-5592-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 9. TCGA-21-1071-01A  |   1 ( 0.3%)         |                     |          |         |
|    |                       | 10. TCGA-21-1072-01A |   1 ( 0.3%)         |                     |          |         |
|    |                       | [ 281 others ]       | 281 (96.6%)         | IIIIIIIIIIIIIIIIIII |          |         |
+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+
| 2  | age                   | 1. <= 65             | 111 (38.1%)         | IIIIIII             | 291      | 0       |
|    | [character]           | 2. > 65              | 180 (61.9%)         | IIIIIIIIIIII        | (100.0%) | (0.0%)  |
+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+
| 3  | gender                | 1. female            |  77 (26.5%)         | IIIII               | 291      | 0       |
|    | [character]           | 2. male              | 214 (73.5%)         | IIIIIIIIIIIIII      | (100.0%) | (0.0%)  |
+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+
| 4  | ajcc_pathologic_stage | 1. Stage I           | 176 (60.5%)         | IIIIIIIIIIII        | 291      | 0       |
|    | [character]           | 2. Stage II          | 115 (39.5%)         | IIIIIII             | (100.0%) | (0.0%)  |
+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+
| 5  | risk_score            | Mean (sd) : 0 (1.4)  | 291 distinct values |           :         | 291      | 0       |
|    | [numeric]             | min < med < max:     |                     |           : :       | (100.0%) | (0.0%)  |
|    |                       | -5.3 < 0.1 < 4.1     |                     |         : : : .     |          |         |
|    |                       | IQR (CV) : 1.8 (122) |                     |       : : : : :     |          |         |
|    |                       |                      |                     |     . : : : : : .   |          |         |
+----+-----------------------+----------------------+---------------------+---------------------+----------+---------+

单因素和多因素分析结果，风险评分是诊断早期肺癌预后的独立风险指标，见 Tab. \@ref(tab:META-Coefficients-Of-COX)。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:META-Coefficients-Of-COX) (下方表格) 为表格META Coefficients Of COX概览。

**(对应文件为 `Figure+Table/META-Coefficients-Of-COX.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行5列，以下预览的表格可能省略部分数据；含有4个唯一`feature'。
\end{tcolorbox}
\end{center}

Table: (\#tab:META-Coefficients-Of-COX)META Coefficients Of COX

|feature              |Uni_coefficients   |Uni_p                |Multi_coefficients |Multi_p              |
|:--------------------|:------------------|:--------------------|:------------------|:--------------------|
|Age (>65/<=64)       |0.215192027477178  |0.41311128570459     |0.101704964279124  |0.709950395815607    |
|gender (female/male) |0.183214670354876  |0.523084334023976    |0.36615958534245   |0.209021149635656    |
|AJCC stage (I/II)    |0.0144776502394665 |0.954293406973733    |0.295933974836866  |0.256805285385573    |
|Risk score           |0.54781086968627   |6.06868708145961e-09 |0.565964036073118  |1.45743179043085e-09 |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## GEO 数据获取 (GEO_LUSC)

为了验证预后特征在不同数据平台上的性能，这里获取了 GEO 数据平台的早期肺癌数据 (GSE157010，微阵列数据)，并筛选了 Stage 为 I，II 阶段的病例。数据特征如下：

Data Frame Summary  
Dimensions: 202 x 14  
Duplicates: 0  

+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| No | Variable               | Stats / Values                | Freqs (% of Valid)  | Graph                | Valid    | Missing |
+====+========================+===============================+=====================+======================+==========+=========+
| 1  | sample                 | 1. GSM4750621                 |   1 ( 0.5%)         |                      | 202      | 0       |
|    | [character]            | 2. GSM4750622                 |   1 ( 0.5%)         |                      | (100.0%) | (0.0%)  |
|    |                        | 3. GSM4750623                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 4. GSM4750624                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 5. GSM4750625                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 6. GSM4750626                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 7. GSM4750627                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 8. GSM4750628                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 9. GSM4750630                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 10. GSM4750631                |   1 ( 0.5%)         |                      |          |         |
|    |                        | [ 192 others ]                | 192 (95.0%)         | IIIIIIIIIIIIIIIIIII  |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 2  | vital_status           | 1. Alive                      | 107 (53.0%)         | IIIIIIIIII           | 202      | 0       |
|    | [character]            | 2. Dead                       |  95 (47.0%)         | IIIIIIIII            | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 3  | group                  | 1. Alive                      | 107 (53.0%)         | IIIIIIIIII           | 202      | 0       |
|    | [character]            | 2. Dead                       |  95 (47.0%)         | IIIIIIIII            | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 4  | days_to_last_follow_up | Mean (sd) : 1403 (697.3)      | 186 distinct values |       :              | 202      | 0       |
|    | [numeric]              | min < med < max:              |                     |       :              | (100.0%) | (0.0%)  |
|    |                        | 4.9 < 1669.8 < 3062.5         |                     |       :              |          |         |
|    |                        | IQR (CV) : 1111.8 (0.5)       |                     | : : . : :            |          |         |
|    |                        |                               |                     | : : : : : .          |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 5  | stage                  | 1. T1                         |  63 (31.2%)         | IIIIII               | 202      | 0       |
|    | [character]            | 2. T2                         | 139 (68.8%)         | IIIIIIIIIIIII        | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 6  | rownames               | 1. GSM4750621                 |   1 ( 0.5%)         |                      | 202      | 0       |
|    | [character]            | 2. GSM4750622                 |   1 ( 0.5%)         |                      | (100.0%) | (0.0%)  |
|    |                        | 3. GSM4750623                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 4. GSM4750624                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 5. GSM4750625                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 6. GSM4750626                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 7. GSM4750627                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 8. GSM4750628                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 9. GSM4750630                 |   1 ( 0.5%)         |                      |          |         |
|    |                        | 10. GSM4750631                |   1 ( 0.5%)         |                      |          |         |
|    |                        | [ 192 others ]                | 192 (95.0%)         | IIIIIIIIIIIIIIIIIII  |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 7  | title                  | 1. CAD_NA379PT_RNA_2115A_F4   |   1 ( 0.5%)         |                      | 202      | 0       |
|    | [character]            | 2. CAD_NA380PT_RNA_2115A_H1   |   1 ( 0.5%)         |                      | (100.0%) | (0.0%)  |
|    |                        | 3. CAD_NA381PT_RNA_2115A_C3   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 4. CAD_NA382PT_RNA_2115A_G4   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 5. CAD_NA383PT_RNA_2115A_E7   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 6. CAD_NA384PT_RNA_2115A_E4   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 7. CAD_NA385PT_RNA_2115A_G5   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 8. CAD_NA386PT_RNA_2116A_B1_  |   1 ( 0.5%)         |                      |          |         |
|    |                        | 9. CAD_NA388PT_RNA_2116A_D5   |   1 ( 0.5%)         |                      |          |         |
|    |                        | 10. CAD_NA389PT_RNA_2116A_D12 |   1 ( 0.5%)         |                      |          |         |
|    |                        | [ 192 others ]                | 192 (95.0%)         | IIIIIIIIIIIIIIIIIII  |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 8  | age.ch1                | 1. 63                         | 12 ( 5.9%)          | I                    | 202      | 0       |
|    | [character]            | 2. 64                         | 12 ( 5.9%)          | I                    | (100.0%) | (0.0%)  |
|    |                        | 3. 65                         | 12 ( 5.9%)          | I                    |          |         |
|    |                        | 4. 71                         | 12 ( 5.9%)          | I                    |          |         |
|    |                        | 5. 70                         | 10 ( 5.0%)          |                      |          |         |
|    |                        | 6. 59                         |  9 ( 4.5%)          |                      |          |         |
|    |                        | 7. 61                         |  9 ( 4.5%)          |                      |          |         |
|    |                        | 8. 66                         |  9 ( 4.5%)          |                      |          |         |
|    |                        | 9. 68                         |  9 ( 4.5%)          |                      |          |         |
|    |                        | 10. 72                        |  9 ( 4.5%)          |                      |          |         |
|    |                        | [ 29 others ]                 | 99 (49.0%)          | IIIIIIIII            |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 9  | diagnosis.ch1          | 1. Squamous Cell Carcinoma o  | 202 (100.0%)        | IIIIIIIIIIIIIIIIIIII | 202      | 0       |
|    | [character]            |                               |                     |                      | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 10 | os_event.ch1           | 1. 0                          | 107 (53.0%)         | IIIIIIIIII           | 202      | 0       |
|    | [character]            | 2. 1                          |  95 (47.0%)         | IIIIIIIII            | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 11 | os_mo.ch1              | 1. 55.6931506849315           |   3 ( 1.5%)         |                      | 202      | 0       |
|    | [character]            | 2. 60.6904109589041           |   3 ( 1.5%)         |                      | (100.0%) | (0.0%)  |
|    |                        | 3. 69.041095890411            |   3 ( 1.5%)         |                      |          |         |
|    |                        | 4. 15.0904109589041           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 5. 60.1972602739726           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 6. 60.2958904109589           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 7. 60.7890410958904           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 8. 61.0520547945205           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 9. 61.0849315068493           |   2 ( 1.0%)         |                      |          |         |
|    |                        | 10. 61.7095890410959          |   2 ( 1.0%)         |                      |          |         |
|    |                        | [ 176 others ]                | 179 (88.6%)         | IIIIIIIIIIIIIIIII    |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 12 | Sex.ch1                | 1. Female                     |  71 (35.1%)         | IIIIIII              | 202      | 0       |
|    | [character]            | 2. Male                       | 131 (64.9%)         | IIIIIIIIIIII         | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 13 | Stage.ch1              | 1. T1a                        | 23 (11.4%)          | II                   | 202      | 0       |
|    | [character]            | 2. T1b                        | 40 (19.8%)          | III                  | (100.0%) | (0.0%)  |
|    |                        | 3. T2a                        | 74 (36.6%)          | IIIIIII              |          |         |
|    |                        | 4. T2b                        | 65 (32.2%)          | IIIIII               |          |         |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+
| 14 | tissue.ch1             | 1. lung                       | 202 (100.0%)        | IIIIIIIIIIIIIIIIIIII | 202      | 0       |
|    | [character]            |                               |                     |                      | (100.0%) | (0.0%)  |
+----+------------------------+-------------------------------+---------------------+----------------------+----------+---------+




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:LUSC-GSE157010-metadata) (下方表格) 为表格LUSC GSE157010 metadata概览。

**(对应文件为 `Figure+Table/LUSC-GSE157010-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有202行14列，以下预览的表格可能省略部分数据；含有202个唯一`sample'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LUSC-GSE157010-metadata)LUSC GSE157010 metadata

|sample    |vital_... |group |days_t... |stage |rownames  |title     |age.ch1 |diagno... |os_eve... |
|:---------|:---------|:-----|:---------|:-----|:---------|:---------|:-------|:---------|:---------|
|GSM475... |Dead      |Dead  |1259.5... |T2    |GSM475... |CAD_NA... |63      |Squamo... |1         |
|GSM475... |Dead      |Dead  |993.20... |T2    |GSM475... |CAD_NA... |78      |Squamo... |1         |
|GSM475... |Alive     |Alive |2071.2... |T2    |GSM475... |CAD_NA... |68      |Squamo... |0         |
|GSM475... |Alive     |Alive |2836.6... |T2    |GSM475... |CAD_NA... |71      |Squamo... |0         |
|GSM475... |Dead      |Dead  |452.71... |T2    |GSM475... |CAD_NA... |83      |Squamo... |1         |
|GSM475... |Dead      |Dead  |835.39... |T2    |GSM475... |CAD_NA... |63      |Squamo... |1         |
|GSM475... |Alive     |Alive |1945.9... |T2    |GSM475... |CAD_NA... |73      |Squamo... |0         |
|GSM475... |Dead      |Dead  |234.73... |T2    |GSM475... |CAD_NA... |71      |Squamo... |1         |
|GSM475... |Alive     |Alive |1045.4... |T2    |GSM475... |CAD_NA... |76      |Squamo... |0         |
|GSM475... |Dead      |Dead  |581.91... |T2    |GSM475... |CAD_NA... |72      |Squamo... |1         |
|GSM475... |Alive     |Alive |1919.3... |T2    |GSM475... |CAD_NA... |78      |Squamo... |0         |
|GSM475... |Dead      |Dead  |982.35... |T2    |GSM475... |CAD_NA... |72      |Squamo... |1         |
|GSM475... |Dead      |Dead  |1091.8... |T2    |GSM475... |CAD_NA... |71      |Squamo... |1         |
|GSM475... |Dead      |Dead  |671.67... |T2    |GSM475... |CAD_NA... |68      |Squamo... |1         |
|GSM475... |Alive     |Alive |1880.8... |T2    |GSM475... |CAD_NA... |59      |Squamo... |0         |
|...       |...       |...   |...       |...   |...       |...       |...     |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## Survival 生存分析 (GEO_LUSC)

GEO 数据集中，风险评分基因集表达特征见 Fig. \@ref(fig:GEO-LUSC-risk-score-related-genes-heatmap)。
将 GEO 数据集按相同的方式处理，并计算风险评分，
生存结果见 Fig. \@ref(fig:GEO-LUSC-survival-curve-of-risk-score)，高风险组与低风险组显著差异。
ROC 曲线见 Fig. \@ref(fig:GEO-LUSC-time-ROC)。
第 1，3，5 年风险评分差异见 Fig. \@ref(fig:GEO-LUSC-boxplot-of-risk-score) 。



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GEO-LUSC-risk-score-related-genes-heatmap) (下方图) 为图GEO LUSC risk score related genes heatmap概览。

**(对应文件为 `Figure+Table/GEO-LUSC-risk-score-related-genes-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GEO-LUSC-risk-score-related-genes-heatmap.pdf}
\caption{GEO LUSC risk score related genes heatmap}\label{fig:GEO-LUSC-risk-score-related-genes-heatmap}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GEO-LUSC-boxplot-of-risk-score) (下方图) 为图GEO LUSC boxplot of risk score概览。

**(对应文件为 `Figure+Table/GEO-LUSC-boxplot-of-risk-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GEO-LUSC-boxplot-of-risk-score.pdf}
\caption{GEO LUSC boxplot of risk score}\label{fig:GEO-LUSC-boxplot-of-risk-score}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GEO-LUSC-time-ROC) (下方图) 为图GEO LUSC time ROC概览。

**(对应文件为 `Figure+Table/GEO-LUSC-time-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GEO-LUSC-time-ROC.pdf}
\caption{GEO LUSC time ROC}\label{fig:GEO-LUSC-time-ROC}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GEO-LUSC-survival-curve-of-risk-score) (下方图) 为图GEO LUSC survival curve of risk score概览。

**(对应文件为 `Figure+Table/GEO-LUSC-survival-curve-of-risk-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GEO-LUSC-survival-curve-of-risk-score.pdf}
\caption{GEO LUSC survival curve of risk score}\label{fig:GEO-LUSC-survival-curve-of-risk-score}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


## estimate 免疫评分 (LUSC)

为了探索标记与肿瘤免疫微环境之间的关系，我们对来自 TCGA LUSC 的数据进行了 ESTIMATE 计算免疫评分、ESTIMATE 评分和stromal 评分。根据评分结果，将病例分为 High 组和 Low 组，免疫评分和 ESTIMATE 评分较低的患者具有较高的风险评分，见 Fig. \@ref(fig:LUSC-immune-Scores-Plot)。
此外，还比较了高危组和低危组之间编码免疫调节剂和趋化因子的基因的表达情况。从 TISIDB 数据库下载的 178 个基因中，有 127 个可以在 TCGA 表达矩阵中找到，两组之间有 119 个表达存在差异 (p.value &lt; 0.05)。
前 10 个基因见 Fig. \@ref(fig:LUSC-Top10-Immune-Related-Genes)。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-immune-Scores-Plot) (下方图) 为图LUSC immune Scores Plot概览。

**(对应文件为 `Figure+Table/LUSC-immune-Scores-Plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-immune-Scores-Plot.pdf}
\caption{LUSC immune Scores Plot}\label{fig:LUSC-immune-Scores-Plot}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LUSC-Top10-Immune-Related-Genes) (下方图) 为图LUSC Top10 Immune Related Genes概览。

**(对应文件为 `Figure+Table/LUSC-Top10-Immune-Related-Genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LUSC-Top10-Immune-Related-Genes.pdf}
\caption{LUSC Top10 Immune Related Genes}\label{fig:LUSC-Top10-Immune-Related-Genes}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


## Limma 差异分析 (LNCRNA)

长链非编码RNA（lncRNA）在基因调控和癌症发展中起着重要作用。
这里对 lncRNA 做了差异分析，并与 mRNA 关联分析。
差异分析 Early_stage vs Healthy, Advanced_stage vs Healthy, Advanced_stage vs Early_stage (若 A vs B，则为前者比后者，LogFC 大于 0 时，A 表达量高于 B)。
得到的 DEGs 统计见 Fig. \@ref(fig:LNCRNA-Difference-intersection)。
所有上调 DEGs 有 539 个，下调共 781；一共 1278 个 (非重复)。。






\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`LNCRNA DEGs data' 数据已全部提供。

**(对应文件为 `Figure+Table/LNCRNA-DEGs-data`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/LNCRNA-DEGs-data共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_Early\_stage - Healthy.csv
\item 2\_Advanced\_stage - Healthy.csv
\item 3\_Advanced\_stage - Early\_stage.csv
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:LNCRNA-Difference-intersection) (下方图) 为图LNCRNA Difference intersection概览。

**(对应文件为 `Figure+Table/LNCRNA-Difference-intersection.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LNCRNA-Difference-intersection.pdf}
\caption{LNCRNA Difference intersection}\label{fig:LNCRNA-Difference-intersection}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/LNCRNA-Difference-intersection-content`)**


## 关联分析 (MRNA, LNCRNA)

将相关系数 &gt; 0.6 和 p &lt; 0.001 设定为识别相关阈值，最终建立网络图见 Fig. \@ref(fig:Significant-Correlation-mrna-lncRNA)。
共包含 4 个 mRNA，4 个 lncRNA，52 对关联关系。



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Significant-Correlation-mrna-lncRNA) (下方图) 为图Significant Correlation mrna lncRNA概览。

**(对应文件为 `Figure+Table/Significant-Correlation-mrna-lncRNA.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Significant-Correlation-mrna-lncRNA.pdf}
\caption{Significant Correlation mrna lncRNA}\label{fig:Significant-Correlation-mrna-lncRNA}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Significant-correlation) (下方表格) 为表格Significant correlation概览。

**(对应文件为 `Figure+Table/Significant-correlation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有52行7列，以下预览的表格可能省略部分数据；含有4个唯一`mRNA'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Significant-correlation)Significant correlation

|mRNA    |LncRNA  |cor   |pvalue |-log2(P.va... |significant |sign |
|:-------|:-------|:-----|:------|:-------------|:-----------|:----|
|SLC14A1 |HBB     |0.61  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |LTB     |-0.63 |0      |16.6096404... |< 0.001     |**   |
|AGPAT3  |NCKIPSD |0.71  |0      |16.6096404... |< 0.001     |**   |
|AGPAT3  |MAFG    |0.62  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |TMPPE   |0.65  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |PEAR1   |0.61  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |PROS1   |0.63  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |SYNM    |0.63  |0      |16.6096404... |< 0.001     |**   |
|AGPAT3  |TOM1L2  |0.61  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |TOM1L2  |0.61  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |DPY19L1 |0.62  |0      |16.6096404... |< 0.001     |**   |
|SLC14A1 |GYPA    |0.66  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |SH3TC2  |0.62  |0      |16.6096404... |< 0.001     |**   |
|AGPAT3  |STIM1   |0.61  |0      |16.6096404... |< 0.001     |**   |
|BCL2L2  |STIM1   |0.63  |0      |16.6096404... |< 0.001     |**   |
|...     |...     |...   |...    |...           |...         |...  |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 实验验证

请参考 (2023, **IF:4.8**, Q1, Biomolecules)[@HCC_RNA_Sequen_Wang_2023]

# 总结 {#conclusion}

本研究为肺癌早期诊断建立了预后的独立风险指标，这些基因是 ，
可预测肺癌 LUSC 中，Sage I、II 的预后疗效。
该风险评分对于 RNA-seq 可能有更敏感的评估，因为我们在 GEO 的微阵列数据集中，High 组与 Low 组
的风险评分差异不如 TCGA 显著。由于 GEO 中，包含生存结局和详细临床数据记录的数据集不多，
我们未能更多的验证。
后续评估发现，该风险评分与免疫微环境 (根据 ESTIMATE 评分) 显著相关。


