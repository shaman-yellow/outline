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
三阴乳腺癌的多药耐药的靶点分析} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-07}}
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

三阴乳腺癌的多药耐药的靶点分析 (创新性比较好的通路)

## 结果

经查阅资料，发现 MDR 所能应用的数据库或方法比较有限，难以拓展分析。
以下采用了比较简单的办法得出结果，仅供参考。

- 分别对 MDR 和 TNBC 使用 GeneCards 获取相关基因，见
  Tab. \@ref(tab:MDR-related-targets-from-GeneCards) 和
  Tab. \@ref(tab:TNBC-related-targets-from-GeneCards)
- 取交集基因 Fig. \@ref(fig:Intersection-of-MDR-with-TNBC)
- 对交集基因做富集分析见 Fig. \@ref(fig:KEGG-enrichment) 和 Fig. \@ref(fig:GO-enrichment)。
- "MicroRNAs in cancer" 可能是良好的候选通路，见 Fig. \@ref(fig:Hsa05206-visualization) 中的 "breast cancer" 部分。



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- R package `pathview` used for KEGG pathways visualization[@PathviewAnRLuoW2013].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 三阴乳腺癌

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Triple negative breast cancer

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

    Score > 3

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:TNBC-related-targets-from-GeneCards) (下方表格) 为表格TNBC related targets from GeneCards概览。

**(对应文件为 `Figure+Table/TNBC-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有491行7列，以下预览的表格可能省略部分数据；表格含有491个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TNBC-related-targets-from-GeneCards)TNBC related targets from GeneCards

|Symbol       |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|BRCA1        |BRCA1 DNA ... |Protein Co... |P38398     |59    |GC17M043044 |29.76 |
|BARD1        |BRCA1 Asso... |Protein Co... |Q99728     |55    |GC02M214725 |19.27 |
|BRCA2        |BRCA2 DNA ... |Protein Co... |P51587     |56    |GC13P032315 |19.14 |
|EGFR         |Epidermal ... |Protein Co... |P00533     |63    |GC07P055019 |17.03 |
|TP53         |Tumor Prot... |Protein Co... |P04637     |62    |GC17M007661 |15.21 |
|CD274        |CD274 Mole... |Protein Co... |Q9NZQ7     |54    |GC09P005450 |14.49 |
|PALB2        |Partner An... |Protein Co... |Q86YC2     |53    |GC16M023603 |13.77 |
|LOC126862571 |BRD4-Indep... |Functional... |           |9     |GC17P103838 |13.42 |
|LINC01672    |Long Inter... |RNA Gene      |           |18    |GC01P011469 |11.84 |
|CHEK2        |Checkpoint... |Protein Co... |O96017     |63    |GC22M028687 |11.81 |
|AR           |Androgen R... |Protein Co... |P10275     |60    |GC0XP067544 |11.11 |
|H19          |H19 Imprin... |RNA Gene      |           |34    |GC11M001995 |11.05 |
|LDHA         |Lactate De... |Protein Co... |P00338     |58    |GC11P018394 |10.71 |
|ERBB2        |Erb-B2 Rec... |Protein Co... |P04626     |63    |GC17P039687 |10.66 |
|STAT3        |Signal Tra... |Protein Co... |P40763     |62    |GC17M042313 |10.6  |
|...          |...           |...           |...        |...   |...         |...   |

## 多药耐药

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Multidrug Resistance

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

    Score > 1

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:MDR-related-targets-from-GeneCards) (下方表格) 为表格MDR related targets from GeneCards概览。

**(对应文件为 `Figure+Table/MDR-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有722行7列，以下预览的表格可能省略部分数据；表格含有722个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MDR-related-targets-from-GeneCards)MDR related targets from GeneCards

|Symbol    |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:---------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|ABCB1     |ATP Bindin... |Protein Co... |P08183     |60    |GC07M087504 |66.16 |
|ABCC1     |ATP Bindin... |Protein Co... |P33527     |56    |GC16P015949 |63.99 |
|ABCC2     |ATP Bindin... |Protein Co... |Q92887     |57    |GC10P099782 |47.35 |
|ABCG2     |ATP Bindin... |Protein Co... |Q9UNQ0     |58    |GC04M088090 |30.63 |
|ABCC3     |ATP Bindin... |Protein Co... |O15438     |53    |GC17P050634 |29.32 |
|ABCC4     |ATP Bindin... |Protein Co... |O15439     |53    |GC13M095019 |27.78 |
|ABCB4     |ATP Bindin... |Protein Co... |P21439     |55    |GC07M087365 |27.09 |
|MVP       |Major Vaul... |Protein Co... |Q14764     |49    |GC16P065989 |23.3  |
|ABCC5     |ATP Bindin... |Protein Co... |O15440     |52    |GC03M183919 |22.16 |
|ABCB11    |ATP Bindin... |Protein Co... |O95342     |55    |GC02M168922 |21.17 |
|ABCC6     |ATP Bindin... |Protein Co... |O95255     |56    |GC16M018124 |18.44 |
|ABCC10    |ATP Bindin... |Protein Co... |Q5T3U5     |42    |GC06P043427 |16.93 |
|C19orf48P |Chromosome... |Pseudogene    |           |30    |GC19M050797 |14.79 |
|DNAH8     |Dynein Axo... |Protein Co... |Q96JB1     |47    |GC06P125656 |11.7  |
|RPSA      |Ribosomal ... |Protein Co... |P08865     |55    |GC03P039406 |10.85 |
|...       |...           |...           |...        |...   |...         |...   |



## 交集基因的富集分析

Figure \@ref(fig:Intersection-of-MDR-with-TNBC) (下方图) 为图Intersection of MDR with TNBC概览。

**(对应文件为 `Figure+Table/Intersection-of-MDR-with-TNBC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-MDR-with-TNBC.pdf}
\caption{Intersection of MDR with TNBC}\label{fig:Intersection-of-MDR-with-TNBC}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    ABCB1, GSTP1, YBX1, LINC01672, BCL2, TP53, TOP2A,
TMX2-CTNND1, ESR1, HIF1A, SCARNA5, PTGS2, AKT1, BIRC5,
PVT1, CERNA3, MIR7-3HG, JUN, CD44, STAT3, MIR381, PTEN,
TNF, S100A4, MGMT, CAV1, MYC, EGFR, ERCC1, H19, SIRT1,
SOD2-OT1, NFKB1, IL6, HSPA4, PARP1, NOTCH1, CTNNB1, VEGFA,
CDH1, VIM, ANXA5, ALDH...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-MDR-with-TNBC-content`)**

Figure \@ref(fig:KEGG-enrichment) (下方图) 为图KEGG enrichment概览。

**(对应文件为 `Figure+Table/KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/KEGG-enrichment.pdf}
\caption{KEGG enrichment}\label{fig:KEGG-enrichment}
\end{center}

Figure \@ref(fig:GO-enrichment) (下方图) 为图GO enrichment概览。

**(对应文件为 `Figure+Table/GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GO-enrichment.pdf}
\caption{GO enrichment}\label{fig:GO-enrichment}
\end{center}

Figure \@ref(fig:Hsa05206-visualization) (下方图) 为图Hsa05206 visualization概览。

**(对应文件为 `Figure+Table/hsa05206.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-04-07_14_43_17.00905/hsa05206.pathview.png}
\caption{Hsa05206 visualization}\label{fig:Hsa05206-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa05206}

\vspace{2em}
\end{tcolorbox}
\end{center}






