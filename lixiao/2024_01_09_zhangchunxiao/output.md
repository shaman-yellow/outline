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
网络药理学+Mandenol与piezo1分子对接} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-16}}
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

- 三七总皂苷 panax notoginseng saponins 中有效成分
    - 使用来源于文献 (PMID: 29673237)[@PanaxNotoginseXieW2018] 以及附件文档中表格的化合物 (Tab. \@ref(tab:PNS-compounds)) 
- 结合疾病骨折愈合（软骨内骨化，血管生成）做网络药理学分析
    - 成分的靶点由 Super-Pred 预测 (Fig. \@ref(fig:SuperPred-results)) (SwissTarget 限制太多，速度慢，大分子无法预测，今后将以 Super-pred 替代) 。
    - 先单独分析成分靶点 (Fig. \@ref(fig:Network-pharmacology-visualization)) ，后再与疾病交集过滤 (Fig. \@ref(fig:Targets-intersect-with-targets-of-diseases))。
    - 疾病相关基因来源见 (Fig. \@ref(fig:All-diseases-Overall-targets-number-of-datasets))
- 候选基因的功能通路富集分析
    - 结果见 \@ref(enrich)
- 分子对接，与piezo1 (如果Mandenol与piezo1)
    - 分子对接见 Fig. \@ref(fig:Overall-combining-Affinity)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- R package `PubChemR` used for querying compounds information.
- Web tool of `Super-PRED` used for drug-targets prediction[@SuperpredUpdaNickel2014].
- The `Transcription Factor Target Gene Database` (<https://tfbsdb.systemsbiology.net/>) was used for discovering relationship between transcription factors and genes. [@CausalMechanisPlaisi2016].
- `AutoDock vina` used for molecular docking[@AutodockVina1Eberha2021].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 三七总皂苷 (panax notoginseng saponins, PNS)  成分

来源于文献 (PMID: 29673237)[@PanaxNotoginseXieW2018] 以及附件文档中表格的化合物。

Table \@ref(tab:PNS-compounds) (下方表格) 为表格PNS compounds概览。

**(对应文件为 `Figure+Table/PNS-compounds.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有18行3列，以下预览的表格可能省略部分数据；表格含有13个唯一`No.'。
\end{tcolorbox}
\end{center}

Table: (\#tab:PNS-compounds)PNS compounds

|No.    |Name                  |Structure |
|:------|:---------------------|:---------|
|PNS-1  |Ginsenoside Rg1       |          |
|PNS-2  |Ginsenoside Rg3       |          |
|PNS-3  |Ginsenoside Rg5       |          |
|PNS-4  |Ginsenoside Rb1       |          |
|PNS-5  |Ginsenoside Rb3       |          |
|PNS-6  |Ginsenoside Re        |          |
|PNS-7  |Ginsenoside Rh1       |          |
|PNS-8  |Ginsenoside Rh2       |          |
|PNS-9  |Pseudoginsenoside-F11 |          |
|PNS-10 |Ginsenoside Ro        |          |
|PNS-11 |Ginsenoside K         |          |
|PNS-12 |Notoginsenoside R1    |          |
|NA     |Mandenol              |NA        |
|NA     |DFV                   |NA        |
|NA     |Diop                  |NA        |
|...    |...                   |...       |



### 成分靶点

使用 Super-Pred 预测化合物靶点。

Figure \@ref(fig:SuperPred-results) (下方图) 为图SuperPred results概览。

**(对应文件为 `Figure+Table/SuperPred-results.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SuperPred-results.pdf}
\caption{SuperPred results}\label{fig:SuperPred-results}
\end{center}

Figure \@ref(fig:Network-pharmacology-visualization) (下方图) 为图Network pharmacology visualization概览。

**(对应文件为 `Figure+Table/Network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-visualization.pdf}
\caption{Network pharmacology visualization}\label{fig:Network-pharmacology-visualization}
\end{center}

### Disease

Figure \@ref(fig:All-diseases-Overall-targets-number-of-datasets) (下方图) 为图All diseases Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/All-diseases-Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/All-diseases-Overall-targets-number-of-datasets.pdf}
\caption{All diseases Overall targets number of datasets}\label{fig:All-diseases-Overall-targets-number-of-datasets}
\end{center}









### 成分-靶点-疾病

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

    ABCB1, FLT3, MAP4K4, VDR, STAT3, ESR1, TGFBR2, F13A1,
NTRK1, MMP2, SERPINE1, TLR4, MMP1, HIF1A, CTSK, GBA1,
ENPP1, CXCR4, ITGB1, SCN9A, IDH1, PDGFRB, TTR, PTGS2, NOS2,
PIK3CA, NOS3, NFKB1, ESR2, PTPN11, MMP7, TERT, P2RX7, MMP8,
TGM2, PDGFRA, CREBBP, HDAC4, KDR, ALOX5, AR, MTOR, STAT1,
F2R, PIK3CG...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**

Figure \@ref(fig:Network-pharmacology-with-disease) (下方图) 为图Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease.pdf}
\caption{Network pharmacology with disease}\label{fig:Network-pharmacology-with-disease}
\end{center}



### PIEZO1 的转录因子分析

The `Transcription Factor Target Gene Database` (<https://tfbsdb.systemsbiology.net/>) was used for discovering relationship between transcription factors and genes. 

Table \@ref(tab:Transcription-Factor-binding-sites) (下方表格) 为表格Transcription Factor binding sites概览。

**(对应文件为 `Figure+Table/Transcription-Factor-binding-sites.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有238行10列，以下预览的表格可能省略部分数据；表格含有1个唯一`target'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item Start:  起始点
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Transcription-Factor-binding-sites)Transcription Factor binding sites

|target |TF_symbol |Motif     |Source |Strand |Start    |Stop     |PValue  |MatchS... |Overla... |
|:------|:---------|:---------|:------|:------|:--------|:--------|:-------|:---------|:---------|
|PIEZO1 |HOXD12    |HOXD12... |SELEX  |+      |88856337 |88856345 |6.0E-06 |GTGATAAAA |9         |
|PIEZO1 |HSF2      |HSF2_H... |SELEX  |-      |88856344 |88856356 |2.0E-06 |TTCCAG... |13        |
|PIEZO1 |SOX21     |SOX21_... |SELEX  |+      |88856312 |88856326 |2.0E-06 |AACAGT... |15        |
|PIEZO1 |FOXA2     |Foxa2_... |JASPAR |-      |88847053 |88847064 |9.0E-06 |TGTTTA... |12        |
|PIEZO1 |NF-KAPPAB |NF-kap... |JASPAR |+      |88851187 |88851196 |1.0E-06 |GGGAAT... |10        |
|PIEZO1 |TBX1      |TBX1_T... |SELEX  |+      |88848269 |88848288 |6.0E-06 |GTGACA... |20        |
|PIEZO1 |SOX4      |SOX4_H... |SELEX  |+      |88856311 |88856326 |2.0E-06 |TAACAG... |16        |
|PIEZO1 |RXRB      |Rxrb_n... |SELEX  |+      |88846744 |88846757 |1.0E-06 |GAGCTC... |14        |
|PIEZO1 |ESRRA     |ESRRA_... |SELEX  |+      |88846750 |88846768 |8.0E-06 |AAAGGT... |19        |
|PIEZO1 |CREB3L2   |Creb3l... |SELEX  |+      |88848344 |88848355 |7.0E-06 |TGCCAC... |12        |
|PIEZO1 |IRF7      |IRF7_I... |SELEX  |+      |88850912 |88850925 |3.0E-06 |CCGAAA... |14        |
|PIEZO1 |IRF7      |IRF7_I... |SELEX  |-      |88851996 |88852009 |3.0E-06 |AGCAAA... |14        |
|PIEZO1 |IRF7      |IRF7_I... |SELEX  |-      |88856323 |88856336 |1.0E-05 |CCCAAA... |14        |
|PIEZO1 |target    |SRY_HM... |SELEX  |-      |88856312 |88856326 |7.0E-06 |AACTCT... |15        |
|PIEZO1 |SOX2      |SOX2_H... |SELEX  |+      |88847416 |88847432 |9.0E-06 |GAAGAC... |17        |
|...    |...       |...       |...    |...    |...      |...      |...     |...       |...       |

Figure \@ref(fig:Intersection-of-TFs-with-queried-Candidates) (下方图) 为图Intersection of TFs with queried Candidates概览。

**(对应文件为 `Figure+Table/Intersection-of-TFs-with-queried-Candidates.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-TFs-with-queried-Candidates.pdf}
\caption{Intersection of TFs with queried Candidates}\label{fig:Intersection-of-TFs-with-queried-Candidates}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    NFKB1, RXRA, NFE2L2, PPARA

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-TFs-with-queried-Candidates-content`)**

Figure \@ref(fig:The-genes-and-related-TFs) (下方图) 为图The genes and related TFs概览。

**(对应文件为 `Figure+Table/The-genes-and-related-TFs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/The-genes-and-related-TFs.pdf}
\caption{The genes and related TFs}\label{fig:The-genes-and-related-TFs}
\end{center}



## 富集分析 {#enrich}

Figure \@ref(fig:Ids-KEGG-enrichment) (下方图) 为图Ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/Ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ids-KEGG-enrichment.pdf}
\caption{Ids KEGG enrichment}\label{fig:Ids-KEGG-enrichment}
\end{center}

Figure \@ref(fig:Ids-GO-enrichment) (下方图) 为图Ids GO enrichment概览。

**(对应文件为 `Figure+Table/Ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ids-GO-enrichment.pdf}
\caption{Ids GO enrichment}\label{fig:Ids-GO-enrichment}
\end{center}



## 分子对接

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Figure \@ref(fig:Mandenol-combine-PIEZO1) (下方图) 为图Mandenol combine PIEZO1概览。

**(对应文件为 `Figure+Table/5282184_into_piezo1.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./figs/5282184_into_piezo1.png}
\caption{Mandenol combine PIEZO1}\label{fig:Mandenol-combine-PIEZO1}
\end{center}




