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
  \usepackage{pgfornament}
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
\textbf{\textcolor{white}{2024-05-23}}
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

## 其他要求

在对MDR和TNBC基因预测并且取交集获得靶点基因的基础上，需要找到本课题所研究的ABCB1/YBX1/BCL2轴
即关注ABCB1和YBX1基因的下游信号通路，通过GO富集分析以及KEGG富集分析预测ABCB1/YBX1和BCL2之间的关联

## 其他要求的结果

见 \@ref(others)。



## 补充分析

使用临床数据，通过对三阴乳腺癌和癌旁组织进行生信分析，找到其中的关于紫杉类药物耐药的差异基因ABCB1（此为需要的目的基因）

## 补充分析结果

成功筛选到 ABCB1，见 Tab. \@ref(tab:BR-data-Resistance-vs-Non-resistance-DEGs-ABCB1)。

其余信息见 \@ref(workflow2)

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- R Package `pRRophetic` was used for Prediction of Clinical Chemotherapeutic Response[@PrropheticAnGeeleh2014].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- R package `pathview` used for KEGG pathways visualization[@PathviewAnRLuoW2013].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 三阴乳腺癌



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:TNBC-related-targets-from-GeneCards) (下方表格) 为表格TNBC related targets from GeneCards概览。

**(对应文件为 `Figure+Table/TNBC-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有491行7列，以下预览的表格可能省略部分数据；含有491个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 多药耐药

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:MDR-related-targets-from-GeneCards) (下方表格) 为表格MDR related targets from GeneCards概览。

**(对应文件为 `Figure+Table/MDR-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有722行7列，以下预览的表格可能省略部分数据；含有722个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## Paclitaxel resistance

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:PDR-related-targets-from-GeneCards) (下方表格) 为表格PDR related targets from GeneCards概览。

**(对应文件为 `Figure+Table/PDR-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有261行7列，以下预览的表格可能省略部分数据；含有261个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Paclitaxel resistance

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
\end{center}

Table: (\#tab:PDR-related-targets-from-GeneCards)PDR related targets from GeneCards

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|ABCB1    |ATP Bindin... |Protein Co... |P08183     |60    |GC07M087504 |5.69  |
|TUBB     |Tubulin Be... |Protein Co... |P07437     |58    |GC06P134798 |4.19  |
|FOXM1    |Forkhead B... |Protein Co... |Q08050     |52    |GC12M002857 |3.01  |
|TP53     |Tumor Prot... |Protein Co... |P04637     |62    |GC17M007661 |2.89  |
|ESR1     |Estrogen R... |Protein Co... |P03372     |62    |GC06P151656 |2.64  |
|MEG3     |Maternally... |RNA Gene (... |           |34    |GC14P116735 |2.64  |
|BCL2     |BCL2 Apopt... |Protein Co... |P10415     |59    |GC18M063123 |2.56  |
|ERBB2    |Erb-B2 Rec... |Protein Co... |P04626     |63    |GC17P039687 |2.53  |
|TUBB3    |Tubulin Be... |Protein Co... |Q13509     |59    |GC16P095438 |2.5   |
|PVT1     |Pvt1 Oncogene |RNA Gene (... |           |32    |GC08P128109 |2.46  |
|MAPK14   |Mitogen-Ac... |Protein Co... |Q16539     |60    |GC06P134977 |2.37  |
|CLU      |Clusterin     |Protein Co... |P10909     |56    |GC08M027596 |2.37  |
|IL6      |Interleukin 6 |Protein Co... |P05231     |60    |GC07P022725 |2.33  |
|MIR7-3HG |MIR7-3 Hos... |RNA Gene (... |Q8N6C7     |34    |GC19P112015 |2.28  |
|MYD88    |MYD88 Inna... |Protein Co... |Q99836     |57    |GC03P038290 |2.24  |
|...      |...           |...           |...        |...   |...         |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## MDR + TNBC 交集基因的富集分析



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Intersection-of-MDR-with-TNBC) (下方图) 为图Intersection of MDR with TNBC概览。

**(对应文件为 `Figure+Table/Intersection-of-MDR-with-TNBC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-MDR-with-TNBC.pdf}
\caption{Intersection of MDR with TNBC}\label{fig:Intersection-of-MDR-with-TNBC}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:KEGG-enrichment) (下方图) 为图KEGG enrichment概览。

**(对应文件为 `Figure+Table/KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/KEGG-enrichment.pdf}
\caption{KEGG enrichment}\label{fig:KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GO-enrichment) (下方图) 为图GO enrichment概览。

**(对应文件为 `Figure+Table/GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GO-enrichment.pdf}
\caption{GO enrichment}\label{fig:GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Hsa05206-visualization) (下方图) 为图Hsa05206 visualization概览。

**(对应文件为 `Figure+Table/Hsa05206-visualization.png`)**

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

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## PR + TNBC 交集基因的富集分析





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Intersection-of-PR-with-TNBC) (下方图) 为图Intersection of PR with TNBC概览。

**(对应文件为 `Figure+Table/Intersection-of-PR-with-TNBC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-PR-with-TNBC.pdf}
\caption{Intersection of PR with TNBC}\label{fig:Intersection-of-PR-with-TNBC}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    ABCB1, FOXM1, TP53, ESR1, MEG3, BCL2, ERBB2, PVT1, IL6,
MIR7-3HG, SOX2, H19, MAPK1, JAK2, CDK1, NEAT1, MIR522,
EGR1, AKT1, BRCA1, USP7, HIF1A, XIST, MYC, STAT3, MIR200C,
MIR17, USP9X, KLF4, PPP1CA, KRT6A, GAS5, HOTAIR, MIR98,
PLK1, ZEB1, MIAT, AURKA, BRCA2, MIR133B, MIR155, MIRLET7C,
MIR200B, MIR...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-PR-with-TNBC-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PR-KEGG-enrichment) (下方图) 为图PR KEGG enrichment概览。

**(对应文件为 `Figure+Table/PR-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PR-KEGG-enrichment.pdf}
\caption{PR KEGG enrichment}\label{fig:PR-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PR-GO-enrichment) (下方图) 为图PR GO enrichment概览。

**(对应文件为 `Figure+Table/PR-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PR-GO-enrichment.pdf}
\caption{PR GO enrichment}\label{fig:PR-GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PR-hsa05206-visualization) (下方图) 为图PR hsa05206 visualization概览。

**(对应文件为 `Figure+Table/PR-hsa05206-visualization.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-05-23_16_47_36.37883/hsa05206.pathview.png}
\caption{PR hsa05206 visualization}\label{fig:PR-hsa05206-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa05206}

\vspace{2em}


\textbf{
Enriched genes
:}

\vspace{0.5em}

    MIR133B, MIR17, MIR21, MCL1, MIR200C, ZEB1, MIR27A,
EP300, MIRLET7C, MIR155, MIR494, MIR34A, ERBB2, BCL2,
STAT3, MYC, MIR18A, MIR200A, PIK3CA, NOTCH1, CD44, MIR335,
ABCB1, MIR34C, BRCA1, MIR199A1, PTGS2, MAPK1, TP53

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Intersection-genes-Genecard-Score-visualization-top10) (下方图) 为图Intersection genes Genecard Score visualization top10概览。

**(对应文件为 `Figure+Table/Intersection-genes-Genecard-Score-visualization-top10.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-genes-Genecard-Score-visualization-top10.pdf}
\caption{Intersection genes Genecard Score visualization top10}\label{fig:Intersection-genes-Genecard-Score-visualization-top10}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 三个所选基因的联系 {#others}

### StringDB



以 STRINGdb 对 Fig. \@ref(fig:Intersection-of-MDR-with-TNBC) 构建 PPI 网络 (physical, 可直接相互作用的网络) ,
获取 MCC top 10 的蛋白，重新构建这些蛋白和 ABCB1, YBX1, BCL2 的 PPI 网络，见 
Fig. \@ref(fig:Selected-genes-Top20-interaction)。


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Selected-genes-Top10-interaction) (下方图) 为图Selected genes Top10 interaction概览。

**(对应文件为 `Figure+Table/Selected-genes-Top10-interaction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Selected-genes-Top10-interaction.pdf}
\caption{Selected genes Top10 interaction}\label{fig:Selected-genes-Top10-interaction}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Selected-genes-Top10-interaction-data) (下方表格) 为表格Selected genes Top10 interaction data概览。

**(对应文件为 `Figure+Table/Selected-genes-Top10-interaction-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有54行2列，以下预览的表格可能省略部分数据；含有12个唯一`Source'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Selected-genes-Top10-interaction-data)Selected genes Top10 interaction data

|Source   |Target |
|:--------|:------|
|EP300    |SIRT1  |
|STAT3    |SIRT1  |
|STAT3    |EP300  |
|EZH2     |SIRT1  |
|EZH2     |EP300  |
|EZH2     |STAT3  |
|HSP90AA1 |SIRT1  |
|HSP90AA1 |EP300  |
|HSP90AA1 |STAT3  |
|HSP90AA1 |EZH2   |
|YBX1     |EP300  |
|HDAC1    |SIRT1  |
|HDAC1    |EP300  |
|HDAC1    |STAT3  |
|HDAC1    |EZH2   |
|...      |...    |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

# 附：分析流程 {#workflow2}

## TCGA-BRCA

数据来源于 TCGA-BRCA



### TNBC

获取 TCGA-BRCA 的标释，取 TNBC 子集。



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:TNBC-annotation) (下方表格) 为表格TNBC annotation概览。

**(对应文件为 `Figure+Table/TNBC-annotation.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1059行45列，以下预览的表格可能省略部分数据；含有1059个唯一`TCGA\_SAMPLE'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TNBC-annotation)TNBC annotation

|TCGA_S... |BARCODE   |TNBC |PAM50 |PAM50lite |TNBCtype |TNBCty... |IM_cen... |MSL_ce... |BL1_ce... |
|:---------|:---------|:----|:-----|:---------|:--------|:---------|:---------|:---------|:---------|
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |UNC      |BL1       |-0.067... |-0.204... |0.0901... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |0.0890... |-0.409... |0.6770... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |IM       |BL1       |0.5766... |-0.304... |0.3889... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |UNC      |BL1       |0.0583... |-0.299... |0.1577... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |-0.036... |-0.184... |0.2627... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |0.1164... |-0.415... |0.5891... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |-0.282... |-0.016... |0.4580... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |0.3572... |-0.209... |0.4447... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |-0.273... |-0.280... |0.6290... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |0.0485... |-0.160... |0.2680... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |-0.099... |-0.368... |0.5270... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |-0.299... |-0.358... |0.5655... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |BL1      |BL1       |0.1769526 |-0.267... |0.6534... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |IM       |BL1       |0.6529... |-0.285... |0.4433... |
|TCGA-A... |TCGA-A... |YES  |Basal |Basal     |MSL      |BL1       |0.1206... |0.2856... |0.0313... |
|...       |...       |...  |...   |...       |...      |...       |...       |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### TNBC 紫杉醇耐药性分析

使用 pRRophetic 预测 紫杉醇 Paclitaxel 耐药性 (IC50) ，并根据 IC50 分值分组。



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:QQ-plot-for-distribution-of-the-transformed-IC50-data) (下方图) 为图QQ plot for distribution of the transformed IC50 data概览。

**(对应文件为 `Figure+Table/QQ-plot-for-distribution-of-the-transformed-IC50-data.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/QQ-plot-for-distribution-of-the-transformed-IC50-data.pdf}
\caption{QQ plot for distribution of the transformed IC50 data}\label{fig:QQ-plot-for-distribution-of-the-transformed-IC50-data}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:BR-estimate-prediction-accuracy) (下方图) 为图BR estimate prediction accuracy概览。

**(对应文件为 `Figure+Table/BR-estimate-prediction-accuracy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/BR-estimate-prediction-accuracy.pdf}
\caption{BR estimate prediction accuracy}\label{fig:BR-estimate-prediction-accuracy}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:BR-predicted-drug-sensitivity) (下方表格) 为表格BR predicted drug sensitivity概览。

**(对应文件为 `Figure+Table/BR-predicted-drug-sensitivity.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有229行3列，以下预览的表格可能省略部分数据；含有229个唯一`sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\end{enumerate}\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
k-means clustering
:}

\vspace{0.5em}

    Centers = 3

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:BR-predicted-drug-sensitivity)BR predicted drug sensitivity

|sample           |sensitivity       |kmeans_group |
|:----------------|:-----------------|:------------|
|TCGA-A1-A0SK-01A |-2.10842613469246 |2            |
|TCGA-A1-A0SO-01A |-2.09562910762259 |2            |
|TCGA-A1-A0SP-01A |-3.25995181471472 |3            |
|TCGA-A2-A04P-01A |-3.23445178824064 |3            |
|TCGA-A2-A04T-01A |-2.35183449260819 |1            |
|TCGA-A2-A04U-01A |-3.69008335272504 |3            |
|TCGA-A2-A0CM-01A |-3.52641697655325 |3            |
|TCGA-A2-A0D0-01A |-3.99448786955298 |3            |
|TCGA-A2-A0D2-01A |-3.5154928620097  |3            |
|TCGA-A2-A0EQ-01A |-2.44757901693141 |1            |
|TCGA-A2-A0ST-01A |-3.07631191508686 |1            |
|TCGA-A2-A0SX-01A |-3.29857199124933 |3            |
|TCGA-A2-A0T0-01A |-2.62869725258927 |1            |
|TCGA-A2-A0T2-01A |-2.86966880241339 |1            |
|TCGA-A2-A0YE-01A |-2.80843853558055 |1            |
|...              |...               |...          |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### 差异分析

#### Resistance vs Non_resistance

成功筛选到 ABCB1，见 Tab. \@ref(tab:BR-data-Resistance-vs-Non-resistance-DEGs-ABCB1)




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:metadata) (下方表格) 为表格metadata概览。

**(对应文件为 `Figure+Table/metadata.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有229行98列，以下预览的表格可能省略部分数据；含有229个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:metadata)Metadata

|rownames  |group     |lib.size  |norm.f... |sample    |barcode   |patient   |shortL... |defini... |sample... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|TCGA-A... |Resist... |671449... |1.0768... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Resist... |701385... |1.0274... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |569427... |0.9859... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |442163... |0.8182... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |615423... |0.9621... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |384309... |0.9349... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |455529... |1.0497... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |437885... |0.8295... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |510092... |0.9319... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |507124... |0.9101... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |520602... |0.9950... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Non_re... |701598... |1.0795... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |581753... |0.9089... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |452328... |0.8451... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|TCGA-A... |Others    |622011... |1.0001... |TCGA-A... |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:BR-Resistance-vs-Non-resistance-DEGs) (下方图) 为图BR Resistance vs Non resistance DEGs概览。

**(对应文件为 `Figure+Table/BR-Resistance-vs-Non-resistance-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/BR-Resistance-vs-Non-resistance-DEGs.pdf}
\caption{BR Resistance vs Non resistance DEGs}\label{fig:BR-Resistance-vs-Non-resistance-DEGs}
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
**(上述信息框内容已保存至 `Figure+Table/BR-Resistance-vs-Non-resistance-DEGs-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:BR-data-Resistance-vs-Non-resistance-DEGs) (下方表格) 为表格BR data Resistance vs Non resistance DEGs概览。

**(对应文件为 `Figure+Table/BR-data-Resistance-vs-Non-resistance-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有7924行22列，以下预览的表格可能省略部分数据；含有7924个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_id:  GENCODE/Ensembl gene ID
\item gene\_name:  GENCODE gene name
\item strand:  genomic strand
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:BR-data-Resistance-vs-Non-resistance-DEGs)BR data Resistance vs Non resistance DEGs

|rownames  |gene_id   |seqnames |start     |end       |width  |strand |source |type |score |
|:---------|:---------|:--------|:---------|:---------|:------|:------|:------|:----|:-----|
|ENSG00... |ENSG00... |chr15    |42412823  |42491141  |78319  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr4     |84669597  |84966690  |297094 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr8     |29055935  |29056685  |751    |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr5     |75511756  |75601144  |89389  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |46983287  |47100323  |117037 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr5     |119037772 |119249138 |211367 |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr7     |131110096 |131496632 |386537 |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr19    |48954815  |48961798  |6984   |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr10    |116671192 |116850251 |179060 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr10    |94402541  |94536332  |133792 |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr11    |392614    |404908    |12295  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr10    |118004916 |118046941 |42026  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr4     |107863473 |107989679 |126207 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr2     |169827454 |170084131 |256678 |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr11    |9778667   |10294219  |515553 |-      |HAVANA |gene |NA    |
|...       |...       |...      |...       |...       |...    |...    |...    |...  |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:BR-data-Resistance-vs-Non-resistance-DEGs-ABCB1) (下方表格) 为表格BR data Resistance vs Non resistance DEGs ABCB1概览。

**(对应文件为 `Figure+Table/BR-data-Resistance-vs-Non-resistance-DEGs-ABCB1.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行22列，以下预览的表格可能省略部分数据；含有1个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_id:  GENCODE/Ensembl gene ID
\item gene\_name:  GENCODE gene name
\item strand:  genomic strand
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:BR-data-Resistance-vs-Non-resistance-DEGs-ABCB1)BR data Resistance vs Non resistance DEGs ABCB1

|rownames  |gene_id   |seqnames |start    |end      |width  |strand |source |type |score |
|:---------|:---------|:--------|:--------|:--------|:------|:------|:------|:----|:-----|
|ENSG00... |ENSG00... |chr7     |87503017 |87713323 |210307 |-      |HAVANA |gene |NA    |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:ABCB1-boxplot) (下方图) 为图ABCB1 boxplot概览。

**(对应文件为 `Figure+Table/ABCB1-boxplot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ABCB1-boxplot.pdf}
\caption{ABCB1 boxplot}\label{fig:ABCB1-boxplot}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

#### Cancer vs Normal



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:BR-tumor-vs-normal-DEGs) (下方图) 为图BR tumor vs normal DEGs概览。

**(对应文件为 `Figure+Table/BR-tumor-vs-normal-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/BR-tumor-vs-normal-DEGs.pdf}
\caption{BR tumor vs normal DEGs}\label{fig:BR-tumor-vs-normal-DEGs}
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
**(上述信息框内容已保存至 `Figure+Table/BR-tumor-vs-normal-DEGs-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:BR-data-tumor-vs-normal-DEGs) (下方表格) 为表格BR data tumor vs normal DEGs概览。

**(对应文件为 `Figure+Table/BR-data-tumor-vs-normal-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有7555行22列，以下预览的表格可能省略部分数据；含有7555个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_id:  GENCODE/Ensembl gene ID
\item gene\_name:  GENCODE gene name
\item strand:  genomic strand
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:BR-data-tumor-vs-normal-DEGs)BR data tumor vs normal DEGs

|rownames  |gene_id   |seqnames |start     |end       |width  |strand |source |type |score |
|:---------|:---------|:--------|:---------|:---------|:------|:------|:------|:----|:-----|
|ENSG00... |ENSG00... |chrX     |15345596  |15384413  |38818  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr2     |191834310 |191847088 |12779  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |60149942  |60170899  |20958  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr11    |35431823  |35530300  |98478  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |43847148  |43863639  |16492  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |69147214  |69244846  |97633  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr14    |26443090  |26598033  |154944 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr1     |160115759 |160143591 |27833  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr11    |72576141  |72674591  |98451  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr6     |32041153  |32115334  |74182  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr8     |27869883  |27992673  |122791 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |68974488  |69060949  |86462  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr5     |154818492 |154859252 |40761  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr18    |23598926  |23662911  |63986  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr7     |130380339 |130388114 |7776   |+      |HAVANA |gene |NA    |
|...       |...       |...      |...       |...       |...    |...    |...    |...  |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:ABCB1-boxplot-tumor-vs-normal) (下方图) 为图ABCB1 boxplot tumor vs normal概览。

**(对应文件为 `Figure+Table/ABCB1-boxplot-tumor-vs-normal.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ABCB1-boxplot-tumor-vs-normal.pdf}
\caption{ABCB1 boxplot tumor vs normal}\label{fig:ABCB1-boxplot-tumor-vs-normal}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

