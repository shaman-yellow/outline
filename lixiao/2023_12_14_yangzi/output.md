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
\begin{center} \textbf{\Huge 白芍网络药理学}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-02}}
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

## 需求和结果

- 白芍总苷 Total glucosides of paeony 中主要化学成分10-20个（TCMSP筛选下口服利用度等）及各个化学成分对应的作用靶点
  （gene与AR过敏性鼻炎相关），最终形成drug-chemical-target gene靶点图
    - 由于苷类 (Glycosides, G)  成分过少(Tab. \@ref(tab:Baishao-glycosides-related-compounds),
      Fig. \@ref(fig:Classification-hierarchy))，没有利用 OB 筛选。
      由于靶点过少，这里也没有根据 AR 相关过滤后绘制成分靶点图，而是直接绘制，
      网络药理图见 Fig. \@ref(fig:Baishao-Network-pharmacology-visualization)。
      其中与 AR 相关的基因见 Fig. \@ref(fig:Baishao-glucosides-targets-intersect-with-AR-related-targets)。
- 将获得的靶点进行GO, KEGG富集分析，目标靶点为USP5，关联成分为芍药苷Paeoniflorin
    - 苷类 (Glycosides, G)  没有富集到 USP5 (TCMSP 的苷类 (Glycosides, G) 靶点信息，不包含 USP5 和 SOX18) ，
      Fig. \@ref(fig:Gly-Interect-genes-KEGG-enrichment) 和 Fig. \@ref(fig:Gly-Interect-genes-GO-enrichment) 为富集分析结果。
- 将芍药苷pae单独拎出，形成pae-targets-pathway网络，此处形成的target genes的GO、KEGG富集图也需要，
  备注USP5参与哪些部分（功能、通路）
    - Fig. \@ref(fig:Paeoniflorin-Network-pharmacology-visualization) 为 Paeoniflorin 网络药理图 
      (由于靶点过少，这里也没有根据 AR 相关过滤后绘制成分靶点图，而是直接绘制) 。
      Paeoniflorin 与 AR 交集基因为 Fig. \@ref(fig:Paeoniflorin-targets-intersect-with-AR-related-targets)
- 分子对接模拟芍药苷与USP5互作
    - 见 Fig. \@ref(fig:Overall-combining-Affinity) 和 Fig. \@ref(fig:Paeoniflorin-combine-USP5)
- 转至第2步目标靶点为SOX18，关联成分为芍药苷Paeoniflorin
    - Paeoniflorin 不包含 SOX18
- 第3步中备注SOX18参与哪些部分（功能、通路）
    - 不参与
- 分子对接模拟芍药苷与SOX18互作
    - 见 Fig. \@ref(fig:Paeoniflorin-combine-SOX18)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Database `PubChem` used for querying information (e.g., InChIKey, CID) of chemical compounds; Tools of `Classyfire` used for get systematic classification of chemical compounds [@PubchemSubstanKimS2015; @ClassyfireAutDjoumb2016].
- R package `ClusterProfiler` used for gene enrichment analysis [@ClusterprofilerWuTi2021].
- The API of `UniProtKB` (<https://www.uniprot.org/help/api_queries>) used for mapping of names or IDs of proteins .
- Website `TCMSP` <https://tcmsp-e.com/tcmsp.php> used for data source [@TcmspADatabaRuJi2014].
- `AutoDock vina` used for molecular docking [@AutodockVina1Eberha2021].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## TCMSP 白芍成分获取





Table \@ref(tab:Baishao-Compounds-and-targets) (下方表格) 为表格Baishao Compounds and targets概览。

**(对应文件为 `Figure+Table/Baishao-Compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1036行17列，以下预览的表格可能省略部分数据；表格含有85个唯一`Mol ID'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Baishao-Compounds-and-targets)Baishao Compounds and targets

|Mol ID    |Herb_p... |Molecu......3 |Molecu......4 |MW     |AlogP |Hdon |Hacc |OB (%) |Caco-2 |
|:---------|:---------|:-------------|:-------------|:------|:-----|:----|:----|:------|:------|
|MOL000106 |Baishao   |PYG           |https:...     |126.12 |1.03  |3    |3    |22.98  |0.69   |
|MOL000211 |Baishao   |Mairin        |https:...     |456.78 |6.52  |2    |3    |55.38  |0.73   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|MOL000219 |Baishao   |BOX           |https:...     |121.12 |0.76  |0    |2    |31.55  |0.54   |
|...       |...       |...           |...           |...    |...   |...  |...  |...    |...    |

## 白芍所有化合物 (TCMSP) 的化学类

### 白芍的所有成分

Figure \@ref(fig:Classification-hierarchy) (下方图) 为图Classification hierarchy概览。

**(对应文件为 `Figure+Table/Classification-hierarchy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Classification-hierarchy.pdf}
\caption{Classification hierarchy}\label{fig:Classification-hierarchy}
\end{center}



### 白芍的苷类 (Glycosides, G) 成分和靶基因

Table \@ref(tab:Baishao-glycosides-related-compounds) (下方表格) 为表格Baishao glycosides related compounds概览。

**(对应文件为 `Figure+Table/Baishao-glycosides-related-compounds.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有93行20列，以下预览的表格可能省略部分数据；表格含有1个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Baishao-glycosides-related-compounds)Baishao glycosides related compounds

|Herb_p... |compounds |Target... |Mol ID    |Molecu... |MW     |AlogP |Hdon |Hacc |OB (%) |
|:---------|:---------|:---------|:---------|:---------|:------|:-----|:----|:----|:------|
|Baishao   |(Z)-(1... |NA        |MOL001908 |https:... |446.55 |-1.28 |6    |10   |5.74   |
|Baishao   |albifl... |NA        |MOL001911 |https:... |480.51 |-1.91 |5    |11   |21.29  |
|Baishao   |albifl... |NA        |MOL001927 |https:... |480.51 |-1.33 |5    |11   |12.09  |
|Baishao   |galloy... |NA        |MOL001932 |https:... |632.62 |-0.04 |7    |15   |3.03   |
|Baishao   |oxypae... |NA        |MOL001933 |https:... |496.51 |-1.55 |6    |12   |21.88  |
|Baishao   |Oxypae... |NA        |MOL005089 |https:... |496.51 |-1.55 |6    |12   |8.38   |
|Baishao   |sucrose   |Aldose... |MOL000842 |https:... |342.34 |-4.31 |8    |11   |7.17   |
|Baishao   |sucrose   |Aldose... |MOL000842 |https:... |342.34 |-4.31 |8    |11   |7.17   |
|Baishao   |sucrose   |Aldose... |MOL000842 |https:... |342.34 |-4.31 |8    |11   |7.17   |
|Baishao   |sucrose   |Alpha-... |MOL000842 |https:... |342.34 |-4.31 |8    |11   |7.17   |
|Baishao   |Astrag... |Calmod... |MOL000561 |https:... |448.41 |-0.32 |7    |11   |14.03  |
|Baishao   |Astrag... |Calmod... |MOL000561 |https:... |448.41 |-0.32 |7    |11   |14.03  |
|Baishao   |sucrose   |Chitin... |MOL000842 |https:... |342.34 |-4.31 |8    |11   |7.17   |
|Baishao   |Astrag... |Coagul... |MOL000561 |https:... |448.41 |-0.32 |7    |11   |14.03  |
|Baishao   |Astrag... |Coagul... |MOL000561 |https:... |448.41 |-0.32 |7    |11   |14.03  |
|...       |...       |...       |...       |...       |...    |...   |...  |...  |...    |

## 白芍苷类 (Glycosides, G)  的网络药理学分析

### 白芍-苷类 (Glycosides, G) -靶点

Figure \@ref(fig:Baishao-Network-pharmacology-visualization) (下方图) 为图Baishao Network pharmacology visualization概览。

**(对应文件为 `Figure+Table/Baishao-Network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Baishao-Network-pharmacology-visualization.pdf}
\caption{Baishao Network pharmacology visualization}\label{fig:Baishao-Network-pharmacology-visualization}
\end{center}

Figure \@ref(fig:Paeoniflorin-Network-pharmacology-visualization) (下方图) 为图Paeoniflorin Network pharmacology visualization概览。

**(对应文件为 `Figure+Table/Paeoniflorin-Network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Paeoniflorin-Network-pharmacology-visualization.pdf}
\caption{Paeoniflorin Network pharmacology visualization}\label{fig:Paeoniflorin-Network-pharmacology-visualization}
\end{center}

### 过敏性鼻炎 (allergic rhinitis, AR)  相关基因

AR 相关基因通过 geneCards 获取，并通过 Biomart 注释。

Table \@ref(tab:AR-related-genes) (下方表格) 为表格AR related genes概览。

**(对应文件为 `Figure+Table/AR-related-genes.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有178行8列，以下预览的表格可能省略部分数据；表格含有178个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:AR-related-genes)AR related genes

|hgnc_s... |ensemb... |entrez... |refseq... |chromo... |start_... |end_po... |descri... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|ADRB2     |ENSG00... |154       |NM_000024 |5         |148826611 |148828623 |adreno... |
|ALOX5AP   |ENSG00... |241       |NM_001629 |13        |30713478  |30764426  |arachi... |
|BDNF-AS   |ENSG00... |497258    |          |11        |27506830  |27698231  |BDNF a... |
|BGLAP     |ENSG00... |632       |NM_199173 |1         |156242184 |156243317 |bone g... |
|BPIFA1    |ENSG00... |51297     |NM_001... |20        |33235995  |33243311  |BPI fo... |
|BTK       |ENSG00... |695       |          |X         |101349338 |101390796 |Bruton... |
|C5AR1     |ENSG00... |728       |          |19        |47290023  |47322066  |comple... |
|CCDC40    |ENSG00... |55036     |NM_001... |HG2118... |59543     |125319    |coiled... |
|CCL1      |ENSG00... |6346      |NM_002981 |17        |34360328  |34363233  |C-C mo... |
|CCL18     |ENSG00... |6362      |NM_002988 |HSCHR1... |18377     |26129     |C-C mo... |
|CCL20     |ENSG00... |6364      |          |2         |227805739 |227817564 |C-C mo... |
|CCL4      |ENSG00... |6351      |NM_002984 |HSCHR1... |57924     |59718     |C-C mo... |
|CCNO      |ENSG00... |10309     |          |5         |55231152  |55233608  |cyclin... |
|CCR5      |ENSG00... |1234      |NM_000579 |3         |46370946  |46376206  |C-C mo... |
|CCR8      |ENSG00... |1237      |NM_005201 |3         |39329709  |39333680  |C-C mo... |
|...       |...       |...       |...       |...       |...       |...       |...       |



### 苷类 (Glycosides, G)  和 过敏性鼻炎 (allergic rhinitis, AR)  靶基因的交集

Figure \@ref(fig:Baishao-glucosides-targets-intersect-with-AR-related-targets) (下方图) 为图Baishao glucosides targets intersect with AR related targets概览。

**(对应文件为 `Figure+Table/Baishao-glucosides-targets-intersect-with-AR-related-targets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Baishao-glucosides-targets-intersect-with-AR-related-targets.pdf}
\caption{Baishao glucosides targets intersect with AR related targets}\label{fig:Baishao-glucosides-targets-intersect-with-AR-related-targets}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    NOS2, PIK3CG, PTGS1, PTGS2

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Baishao-glucosides-targets-intersect-with-AR-related-targets-content`)**



### 芍药苷 (Paeoniflorin, P)  和 过敏性鼻炎 (allergic rhinitis, AR)  靶基因的交集

Figure \@ref(fig:Paeoniflorin-targets-intersect-with-AR-related-targets) (下方图) 为图Paeoniflorin targets intersect with AR related targets概览。

**(对应文件为 `Figure+Table/Paeoniflorin-targets-intersect-with-AR-related-targets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Paeoniflorin-targets-intersect-with-AR-related-targets.pdf}
\caption{Paeoniflorin targets intersect with AR related targets}\label{fig:Paeoniflorin-targets-intersect-with-AR-related-targets}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Paeoniflorin-targets-intersect-with-AR-related-targets-content`)**




## 富集分析

### 白芍苷类 (Glycosides, G) 与 AR 交集基因的富集分析

Figure \@ref(fig:Gly-Interect-genes-KEGG-enrichment) (下方图) 为图Gly Interect genes KEGG enrichment概览。

**(对应文件为 `Figure+Table/Gly-Interect-genes-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Gly-Interect-genes-KEGG-enrichment.pdf}
\caption{Gly Interect genes KEGG enrichment}\label{fig:Gly-Interect-genes-KEGG-enrichment}
\end{center}

Figure \@ref(fig:Gly-Interect-genes-GO-enrichment) (下方图) 为图Gly Interect genes GO enrichment概览。

**(对应文件为 `Figure+Table/Gly-Interect-genes-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Gly-Interect-genes-GO-enrichment.pdf}
\caption{Gly Interect genes GO enrichment}\label{fig:Gly-Interect-genes-GO-enrichment}
\end{center}



## 分子对接

对接的对象为： SOX18, USP5

### 芍药苷 (Paeoniflorin, P) 

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Figure \@ref(fig:Paeoniflorin-combine-USP5) (下方图) 为图Paeoniflorin combine USP5概览。

**(对应文件为 `Figure+Table/442534_into_2dag.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./figs/442534_into_2dag.png}
\caption{Paeoniflorin combine USP5}\label{fig:Paeoniflorin-combine-USP5}
\end{center}

Figure \@ref(fig:Paeoniflorin-combine-SOX18) (下方图) 为图Paeoniflorin combine SOX18概览。

**(对应文件为 `Figure+Table/442534_into_sox18.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./figs/442534_into_sox18.png}
\caption{Paeoniflorin combine SOX18}\label{fig:Paeoniflorin-combine-SOX18}
\end{center}



