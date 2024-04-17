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
中药-有效成分-乳腺癌相关靶点的网药分析}
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

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- Website `TCMSP` <https://tcmsp-e.com/> used for data source[@TcmspADatabaRuJi2014].
- The API of `UniProtKB` (<https://www.uniprot.org/help/api_queries>) used for mapping of names or IDs of proteins.
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

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

Table \@ref(tab:Compounds-filtered-by-OB-and-DL) (下方表格) 为表格Compounds filtered by OB and DL概览。

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

    MOL000358

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/intersection-of-all-compounds-content`)**

### 成分靶点

Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

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



### 疾病靶点

Table \@ref(tab:Disease-related-targets-from-GeneCards) (下方表格) 为表格Disease related targets from GeneCards概览。

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



### 疾病-成分-靶点网络图

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



### 疾病-成分-靶点-通路网络图

Figure \@ref(fig:Network-pharmacology-with-disease-and-pathway) (下方图) 为图Network pharmacology with disease and pathway概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease-and-pathway.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease-and-pathway.pdf}
\caption{Network pharmacology with disease and pathway}\label{fig:Network-pharmacology-with-disease-and-pathway}
\end{center}

Table \@ref(tab:Network-pharmacology-with-disease-and-pathway-data) (下方表格) 为表格Network pharmacology with disease and pathway data概览。

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




