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
中药-有效成分-乳腺癌相关靶点的网药分析}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-05-22}}
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

网络药理学分析

- 药对：白花蛇舌草，半枝莲，浙贝母
- 疾病：乳腺癌
- 目标：提供中药-有效成分-乳腺癌相关靶点的网药分析

## 结果

- 数据来源于 TCMSP，以 OB、DL 筛选过化合物 Tab. \@ref(tab:Compounds-filtered-by-OB-and-DL)。
- 疾病靶点来源于 GeneCards, Tab. \@ref(tab:Disease-related-targets-from-GeneCards)
- 疾病成分靶点网络图：Fig. \@ref(fig:Targets-intersect-with-targets-of-diseases)
- 包含通路：Fig. \@ref(fig:Network-pharmacology-with-disease-and-pathway),
  Tab. \@ref(tab:Network-pharmacology-with-disease-and-pathway-data)

## 需求2

下一步请对 beta-sitosterol  的60个靶点做富集分析，并作这些靶点与糖酵解、巨噬细胞极化相关性分析。意向靶点为JTK2（即FGFR4），请重点关注
另外需要提供一个韦恩图表明beta-sitosterol 就是三种药共有的唯一成分

- 巨噬细胞极化, 富集上移 (无糖酵解富集)
- 表格中提供基因名称
- 关联分析热图，调整, 去除无关基因

## 结果2

见 \@ref(res2)

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- Website `TCMSP` <https://tcmsp-e.com/> used for data source[@TcmspADatabaRuJi2014].
- The API of `UniProtKB` (<https://www.uniprot.org/help/api_queries>) used for mapping of names or IDs of proteins.
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3行2列，以下预览的表格可能省略部分数据；含有3个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Herb_pinyin_name |Herb_cn_name |
|:----------------|:------------|
|Baihuasheshecao  |白花蛇舌草   |
|Banzhilian       |半枝莲       |
|Zhebeimu         |浙贝母       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Compounds-filtered-by-OB-and-DL) (下方表格) 为表格Compounds filtered by OB and DL概览。

**(对应文件为 `Figure+Table/Compounds-filtered-by-OB-and-DL.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有43行15列，以下预览的表格可能省略部分数据；含有39个唯一`Mol ID；含有3个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
OB (\%) and DL cut-off
:}

\vspace{0.5em}

    OB >= 30\%; DL >= 0.18

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-filtered-by-OB-and-DL)Compounds filtered by OB and DL

|Mol ID    |Molecu... |MW      |AlogP |Hdon |Hacc |OB (%)    |Caco-2   |BBB      |DL      |
|:---------|:---------|:-------|:-----|:----|:----|:---------|:--------|:--------|:-------|
|MOL001646 |2,3-di... |282.310 |3.262 |0    |4    |34.858... |0.75128  |0.17357  |0.26255 |
|MOL001659 |Porife... |412.770 |7.640 |1    |1    |43.829... |1.43659  |1.03472  |0.75596 |
|MOL001663 |(4aS,6... |456.780 |6.422 |2    |3    |32.028... |0.60932  |0.39268  |0.75713 |
|MOL001670 |2-meth... |252.280 |3.278 |0    |3    |37.827... |0.72896  |-0.12795 |0.20517 |
|MOL000449 |Stigma... |412.770 |7.640 |1    |1    |43.829... |1.44458  |1.00045  |0.75665 |
|MOL000358 |beta-s... |414.790 |8.084 |1    |1    |36.913... |1.32463  |0.98588  |0.75123 |
|MOL000098 |quercetin |302.250 |1.504 |5    |7    |46.433... |0.04842  |-0.76890 |0.27525 |
|MOL001040 |(2R)-5... |272.270 |2.298 |3    |5    |42.363... |0.37818  |-0.47578 |0.21141 |
|MOL012245 |5,7,4'... |302.300 |2.281 |3    |6    |36.626... |0.43274  |-0.31890 |0.26833 |
|MOL012246 |5,7,4'... |302.300 |2.281 |3    |6    |74.235... |0.37328  |-0.43273 |0.26479 |
|MOL012248 |5-hydr... |328.340 |2.820 |1    |6    |65.818... |0.84750  |0.07437  |0.32874 |
|MOL012250 |7-hydr... |298.310 |2.836 |1    |5    |43.716... |0.95759  |0.22129  |0.25376 |
|MOL012251 |Chrysi... |268.280 |2.853 |1    |4    |37.268... |0.90922  |0.15556  |0.20317 |
|MOL012252 |9,19-c... |426.800 |7.554 |1    |1    |38.685... |1.44891  |1.16360  |0.78074 |
|MOL002776 |Baicalin  |446.390 |0.639 |6    |11   |40.123... |-0.84777 |-1.74426 |0.75264 |
|...       |...       |...     |...   |...  |...  |...       |...      |...      |...     |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:intersection-of-all-compounds) (下方图) 为图intersection of all compounds概览。

**(对应文件为 `Figure+Table/intersection-of-all-compounds.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/intersection-of-all-compounds.pdf}
\caption{Intersection of all compounds}\label{fig:intersection-of-all-compounds}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    MOL000358

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/intersection-of-all-compounds-content`)**

### 成分靶点

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/tables-of-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1846行4列，以下预览的表格可能省略部分数据；含有3个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Herb_pinyin_name |Molecule name |symbols  |protein.names        |
|:----------------|:-------------|:--------|:--------------------|
|Banzhilian       |luteolin      |NA       |NA                   |
|Banzhilian       |luteolin      |MMP2     |72 kDa type IV co... |
|Banzhilian       |luteolin      |CLG4A    |72 kDa type IV co... |
|Banzhilian       |luteolin      |ADCY2    |Adenylate cyclase... |
|Banzhilian       |luteolin      |KIAA1060 |Adenylate cyclase... |
|Banzhilian       |luteolin      |APP      |Amyloid-beta prec... |
|Banzhilian       |luteolin      |A4       |Amyloid-beta prec... |
|Banzhilian       |luteolin      |AD1      |Amyloid-beta prec... |
|Banzhilian       |luteolin      |AR       |Androgen receptor... |
|Banzhilian       |luteolin      |DHTR     |Androgen receptor... |
|Banzhilian       |luteolin      |NR3C4    |Androgen receptor... |
|Banzhilian       |luteolin      |XIAP     |E3 ubiquitin-prot... |
|Banzhilian       |luteolin      |API3     |E3 ubiquitin-prot... |
|Banzhilian       |luteolin      |BIRC4    |E3 ubiquitin-prot... |
|Banzhilian       |luteolin      |IAP3     |E3 ubiquitin-prot... |
|...              |...           |...      |...                  |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}



### 疾病靶点

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Disease-related-targets-from-GeneCards) (下方表格) 为表格Disease related targets from GeneCards概览。

**(对应文件为 `Figure+Table/Disease-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1746行7列，以下预览的表格可能省略部分数据；含有1746个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    breast cancer

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

    Score > 15

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:Disease-related-targets-from-GeneCards)Disease related targets from GeneCards

|Symbol       |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score  |
|:------------|:-------------|:-------------|:----------|:-----|:-----------|:------|
|BRCA2        |BRCA2 DNA ... |Protein Co... |P51587     |56    |GC13P032315 |584.27 |
|BRCA1        |BRCA1 DNA ... |Protein Co... |P38398     |59    |GC17M043044 |565.02 |
|PALB2        |Partner An... |Protein Co... |Q86YC2     |53    |GC16M023603 |366.84 |
|ATM          |ATM Serine... |Protein Co... |Q13315     |61    |GC11P108223 |340.7  |
|CHEK2        |Checkpoint... |Protein Co... |O96017     |63    |GC22M028687 |336.43 |
|BRIP1        |BRCA1 Inte... |Protein Co... |Q9BX63     |57    |GC17M061679 |325.07 |
|CDH1         |Cadherin 1    |Protein Co... |P12830     |58    |GC16P068737 |306.68 |
|BARD1        |BRCA1 Asso... |Protein Co... |Q99728     |55    |GC02M214725 |291.41 |
|TP53         |Tumor Prot... |Protein Co... |P04637     |62    |GC17M007661 |287.34 |
|MSH6         |MutS Homol... |Protein Co... |P52701     |58    |GC02P047695 |239.29 |
|MSH2         |MutS Homol... |Protein Co... |P43246     |57    |GC02P047403 |231.87 |
|MLH1         |MutL Homol... |Protein Co... |P40692     |58    |GC03P036993 |223.25 |
|C11orf65     |Chromosome... |Protein Co... |Q8NCR3     |40    |GC11M108308 |218.43 |
|LOC126862571 |BRD4-Indep... |Functional... |           |10    |GC17P114574 |215.91 |
|APC          |APC Regula... |Protein Co... |P25054     |58    |GC05P112707 |199.23 |
|...          |...           |...           |...        |...   |...         |...    |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}



### 疾病-成分-靶点网络图

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Network-pharmacology-with-disease) (下方图) 为图Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease.pdf}
\caption{Network pharmacology with disease}\label{fig:Network-pharmacology-with-disease}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Targets-intersect-with-targets-of-diseases) (下方图) 为图Targets intersect with targets of diseases概览。

**(对应文件为 `Figure+Table/Targets-intersect-with-targets-of-diseases.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Targets-intersect-with-targets-of-diseases.pdf}
\caption{Targets intersect with targets of diseases}\label{fig:Targets-intersect-with-targets-of-diseases}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    CHEK2, TP53, PTEN, ERBB2, CDKN2A, AKT1, AR, CASP8,
ERBB3, JUN, MYC, IL2, MDM2, CDK2, IL1B, FGFR4, BCL2, BAX,
TGFB1, ESR2, IGF2, NFE2L2, PPARG, EGF, PTGS2, TNF, MMP2,
MMP9, RAF1, CASP3, CYP1A1, NFKB1, CTSD, PCNA, PLAU, TOP2A,
CDK1, MMP1, E2F1, VEGFC, IFNG, CYP1B1, CHEK1, PIK3CG, IL10,
CASP9, CAV1,...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**



### 富集分析

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



### 疾病-成分-靶点-通路网络图

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Network-pharmacology-with-disease-and-pathway) (下方图) 为图Network pharmacology with disease and pathway概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease-and-pathway.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease-and-pathway.pdf}
\caption{Network pharmacology with disease and pathway}\label{fig:Network-pharmacology-with-disease-and-pathway}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Network-pharmacology-with-disease-and-pathway-data) (下方表格) 为表格Network pharmacology with disease and pathway data概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease-and-pathway-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有431行5列，以下预览的表格可能省略部分数据；含有3个唯一`Herb\_pinyin\_name；含有24个唯一`Ingredient.name；含有101个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Network-pharmacology-with-disease-and-pathway-data)Network pharmacology with disease and pathway data

|Herb_pinyin_name |Ingredient.name |Target.name |Hit_pathway_number |Enriched_pathways    |
|:----------------|:---------------|:-----------|:------------------|:--------------------|
|Baihuasheshecao  |quercetin       |NFKB1       |18                 |AGE-RAGE signalin... |
|Baihuasheshecao  |quercetin       |RELA        |18                 |AGE-RAGE signalin... |
|Banzhilian       |baicalein       |RELA        |18                 |AGE-RAGE signalin... |
|Banzhilian       |luteolin        |RELA        |18                 |AGE-RAGE signalin... |
|Banzhilian       |quercetin       |NFKB1       |18                 |AGE-RAGE signalin... |
|Banzhilian       |quercetin       |RELA        |18                 |AGE-RAGE signalin... |
|Banzhilian       |wogonin         |RELA        |18                 |AGE-RAGE signalin... |
|Baihuasheshecao  |quercetin       |AKT1        |17                 |AGE-RAGE signalin... |
|Banzhilian       |baicalein       |AKT1        |17                 |AGE-RAGE signalin... |
|Banzhilian       |luteolin        |AKT1        |17                 |AGE-RAGE signalin... |
|Banzhilian       |quercetin       |AKT1        |17                 |AGE-RAGE signalin... |
|Banzhilian       |wogonin         |AKT1        |17                 |AGE-RAGE signalin... |
|Baihuasheshecao  |quercetin       |TP53        |14                 |Cellular senescen... |
|Banzhilian       |baicalein       |TP53        |14                 |Cellular senescen... |
|Banzhilian       |luteolin        |TP53        |14                 |Cellular senescen... |
|...              |...             |...         |...                |...                  |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}



## beta-sitosterol {#res2}

### 富集分析





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:SITO-KEGG-enrichment) (下方图) 为图SITO KEGG enrichment概览。

**(对应文件为 `Figure+Table/SITO-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SITO-KEGG-enrichment.pdf}
\caption{SITO KEGG enrichment}\label{fig:SITO-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:SITO-GO-enrichment) (下方图) 为图SITO GO enrichment概览。

**(对应文件为 `Figure+Table/SITO-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SITO-GO-enrichment.pdf}
\caption{SITO GO enrichment}\label{fig:SITO-GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:SITO-KEGG-enrichment-data) (下方表格) 为表格SITO KEGG enrichment data概览。

**(对应文件为 `Figure+Table/SITO-KEGG-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有181行11列，以下预览的表格可能省略部分数据；含有181个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:SITO-KEGG-enrichment-data)SITO KEGG enrichment data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |geneID...      |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|:--------------|
|hsa04080 |Neuroa... |18/34     |366/8753 |1.2099... |2.1900... |1.1590... |148/14... |18    |148 &#124; ... |
|hsa05032 |Morphi... |8/34      |91/8753  |1.4533... |9.0812... |4.8060... |1812/2... |8     |1812 &#124;... |
|hsa04020 |Calciu... |11/34     |253/8753 |1.5051... |9.0812... |4.8060... |148/14... |11    |148 &#124; ... |
|hsa04725 |Cholin... |8/34      |113/8753 |8.2528... |3.7344... |1.9763... |596/11... |8     |596 &#124; ... |
|hsa04215 |Apopto... |5/34      |32/8753  |1.2159... |4.4015... |2.3294... |581/59... |5     |581 &#124; ... |
|hsa05033 |Nicoti... |5/34      |40/8753  |3.8860... |1.1722... |6.2040... |1139/2... |5     |1139 &#124;... |
|hsa05167 |Kaposi... |8/34      |194/8753 |5.5839... |1.4438... |7.6411... |581/71... |8     |581 &#124; ... |
|hsa04742 |Taste ... |6/34      |86/8753  |8.1367... |1.6363... |8.6601... |1131/2... |6     |1131 &#124;... |
|hsa05210 |Colore... |6/34      |86/8753  |8.1367... |1.6363... |8.6601... |581/59... |6     |581 &#124; ... |
|hsa04261 |Adrene... |7/34      |154/8753 |1.6438... |2.9753... |1.5746... |148/14... |7     |148 &#124; ... |
|hsa05161 |Hepati... |7/34      |162/8753 |2.3085... |3.7986... |2.0103... |581/59... |7     |581 &#124; ... |
|hsa05145 |Toxopl... |6/34      |111/8753 |3.6575... |5.5167... |2.9196... |596/83... |6     |596 &#124; ... |
|hsa04726 |Seroto... |6/34      |115/8753 |4.4952... |6.0205... |3.1862... |836/33... |6     |836 &#124; ... |
|hsa05152 |Tuberc... |7/34      |180/8753 |4.6567... |6.0205... |3.1862... |581/59... |7     |581 &#124; ... |
|hsa01524 |Platin... |5/34      |73/8753  |8.0960... |9.3555... |4.9511... |581/59... |5     |581 &#124; ... |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |...            |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:SITO-GO-enrichment-data) (下方表格) 为表格SITO GO enrichment data概览。

**(对应文件为 `Figure+Table/SITO-GO-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2405行12列，以下预览的表格可能省略部分数据；含有3个唯一`ont'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\item ont:  One of "BP", "MF", and "CC" subontologies. The Cellular Component (CC), the Molecular Function (MF) and the Biological Process (BP).
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:SITO-GO-enrichment-data)SITO GO enrichment data

|ont |ID        |Descri... |GeneRatio |BgRatio   |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:---|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:-----|
|BP  |GO:004... |regula... |15/37     |433/18614 |1.4579... |2.9742... |1.6528... |148/15... |15    |
|BP  |GO:190... |respon... |7/37      |36/18614  |5.3761... |5.4836... |3.0474... |1128/1... |7     |
|BP  |GO:190... |respon... |12/37     |383/18614 |5.6547... |3.8452... |2.1369... |1128/1... |12    |
|BP  |GO:006... |regula... |9/37      |148/18614 |1.0226... |5.2155... |2.8984... |154/11... |9     |
|BP  |GO:000... |G prot... |7/37      |56/18614  |1.4519... |5.9240... |3.2921... |1128/1... |7     |
|BP  |GO:000... |adenyl... |10/37     |234/18614 |2.1044... |7.1552... |3.9763... |148/14... |10    |
|BP  |GO:009... |acetyl... |6/37      |31/18614  |2.8612... |8.1337... |4.5201... |1128/1... |6     |
|BP  |GO:000... |regula... |9/37      |173/18614 |4.1766... |8.1337... |4.5201... |148/14... |9     |
|BP  |GO:000... |calciu... |12/37     |455/18614 |4.1950... |8.1337... |4.5201... |148/58... |12    |
|BP  |GO:190... |cellul... |6/37      |33/18614  |4.2917... |8.1337... |4.5201... |1128/1... |6     |
|BP  |GO:000... |muscle... |11/37     |349/18614 |4.7585... |8.1337... |4.5201... |148/14... |11    |
|BP  |GO:000... |phosph... |8/37      |113/18614 |4.7845... |8.1337... |4.5201... |148/14... |8     |
|BP  |GO:007... |calciu... |11/37     |360/18614 |6.6320... |1.0407... |5.7835... |148/58... |11    |
|BP  |GO:006... |excita... |8/37      |124/18614 |1.0137... |1.4771... |8.2087... |154/11... |8     |
|BP  |GO:009... |postsy... |6/37      |39/18614  |1.2534... |1.7046... |9.4734... |1128/1... |6     |
|... |...       |...       |...       |...       |...       |...       |...       |...       |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### TCGA-BRCA



获取 TCGA-BRCA (RNA-seq) 数据，以备关联分析

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:BC-metadata) (下方表格) 为表格BC metadata概览。

**(对应文件为 `Figure+Table/BC-metadata.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1094行92列，以下预览的表格可能省略部分数据；含有1094个唯一`sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:BC-metadata)BC metadata

|sample    |group |lib.size |norm.f... |barcode   |patient   |shortL... |defini... |sample......9 |sample......10 |... |
|:---------|:-----|:--------|:---------|:---------|:---------|:---------|:---------|:-------------|:--------------|:---|
|TCGA-3... |Alive |56714504 |1         |TCGA-3... |TCGA-3... |TP        |Primar... |TCGA-3...     |01             |... |
|TCGA-3... |Alive |37595179 |1         |TCGA-3... |TCGA-3... |TP        |Primar... |TCGA-3...     |01             |... |
|TCGA-3... |Alive |22598154 |1         |TCGA-3... |TCGA-3... |TP        |Primar... |TCGA-3...     |01             |... |
|TCGA-3... |Alive |52725445 |1         |TCGA-3... |TCGA-3... |TP        |Primar... |TCGA-3...     |01             |... |
|TCGA-4... |Alive |47412261 |1         |TCGA-4... |TCGA-4... |TP        |Primar... |TCGA-4...     |01             |... |
|TCGA-5... |Alive |34214129 |1         |TCGA-5... |TCGA-5... |TP        |Primar... |TCGA-5...     |01             |... |
|TCGA-5... |Alive |24260663 |1         |TCGA-5... |TCGA-5... |TP        |Primar... |TCGA-5...     |01             |... |
|TCGA-5... |Alive |33575287 |1         |TCGA-5... |TCGA-5... |TP        |Primar... |TCGA-5...     |01             |... |
|TCGA-A... |Alive |47572949 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |60545003 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |61032351 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |48818918 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |56402921 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |68534939 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|TCGA-A... |Alive |73332059 |1         |TCGA-A... |TCGA-A... |TP        |Primar... |TCGA-A...     |01             |... |
|...       |...   |...      |...       |...       |...       |...       |...       |...           |...            |... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### 糖酵解、巨噬细胞极化相关基因

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:MP-related-targets-from-GeneCards) (下方表格) 为表格MP related targets from GeneCards概览。

**(对应文件为 `Figure+Table/MP-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有72行7列，以下预览的表格可能省略部分数据；含有72个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Macrophage polarization

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

    Score > 2

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:MP-related-targets-from-GeneCards)MP related targets from GeneCards

|Symbol      |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:-----------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|MIRLET7C    |MicroRNA L... |RNA Gene (... |           |29    |GC21P018103 |6.28  |
|GAS5        |Growth Arr... |RNA Gene (... |           |31    |GC01M173947 |4.76  |
|NR4A1AS     |NR4A1 Anti... |RNA Gene (... |           |13    |GC12M052059 |4.37  |
|LINC01672   |Long Inter... |RNA Gene (... |           |19    |GC01P020797 |4.33  |
|MIR125A     |MicroRNA 125a |RNA Gene (... |           |29    |GC19P113552 |4.23  |
|H19         |H19 Imprin... |RNA Gene (... |           |34    |GC11M001995 |3.82  |
|CERNA3      |Competing ... |RNA Gene (... |           |19    |GC08P056323 |3.76  |
|STAT3       |Signal Tra... |Protein Co... |P40763     |62    |GC17M042313 |3.73  |
|MIR146B     |MicroRNA 146b |RNA Gene (... |           |29    |GC10P102436 |3.7   |
|IL6         |Interleukin 6 |Protein Co... |P05231     |60    |GC07P022725 |3.5   |
|MIR98       |MicroRNA 98   |RNA Gene (... |           |26    |GC0XM053782 |3.42  |
|TMX2-CTNND1 |TMX2-CTNND... |RNA Gene (... |           |23    |GC11P057712 |3.39  |
|PLA2G5      |Phospholip... |Protein Co... |P39877     |46    |GC01P020028 |3.37  |
|LINC02605   |Long Inter... |RNA Gene (... |           |18    |GC08P078838 |3.15  |
|IRF5        |Interferon... |Protein Co... |Q13568     |55    |GC07P128937 |3.14  |
|...         |...           |...           |...        |...   |...         |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:GL-related-targets-from-GeneCards) (下方表格) 为表格GL related targets from GeneCards概览。

**(对应文件为 `Figure+Table/GL-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有118行7列，以下预览的表格可能省略部分数据；含有118个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    glycolysis

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

Table: (\#tab:GL-related-targets-from-GeneCards)GL related targets from GeneCards

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


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}



### 关联分析



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GL-Correlation-heatmap) (下方图) 为图GL Correlation heatmap概览。

**(对应文件为 `Figure+Table/GL-Correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GL-Correlation-heatmap.pdf}
\caption{GL Correlation heatmap}\label{fig:GL-Correlation-heatmap}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MP-Correlation-heatmap) (下方图) 为图MP Correlation heatmap概览。

**(对应文件为 `Figure+Table/MP-Correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MP-Correlation-heatmap.pdf}
\caption{MP Correlation heatmap}\label{fig:MP-Correlation-heatmap}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Correlation-heatmap) (下方图) 为图Correlation heatmap概览。

**(对应文件为 `Figure+Table/Correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Correlation-heatmap.pdf}
\caption{Correlation heatmap}\label{fig:Correlation-heatmap}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Linear curve' 数据已全部提供。

**(对应文件为 `Figure+Table/Linear-curve`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Linear-curve共包含2个文件。

\begin{enumerate}\tightlist
\item 1\_glycolysis.pdf
\item 2\_Macrophage polarization.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

### 韦恩图



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Intersection-of-Baihuasheshecao-with-Banzhilian-with-Zhebeimu) (下方图) 为图Intersection of Baihuasheshecao with Banzhilian with Zhebeimu概览。

**(对应文件为 `Figure+Table/Intersection-of-Baihuasheshecao-with-Banzhilian-with-Zhebeimu.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-Baihuasheshecao-with-Banzhilian-with-Zhebeimu.pdf}
\caption{Intersection of Baihuasheshecao with Banzhilian with Zhebeimu}\label{fig:Intersection-of-Baihuasheshecao-with-Banzhilian-with-Zhebeimu}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    beta-sitosterol

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-Baihuasheshecao-with-Banzhilian-with-Zhebeimu-content`)**

