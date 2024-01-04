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
\textbf{\textcolor{white}{2024-01-04}}
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
- 将获得的靶点进行GO, KEGG富集分析，目标靶点为USP5，关联成分为芍药苷Paeoniflorin
- 将芍药苷pae单独拎出，形成pae-targets-pathway网络，此处形成的target genes的GO、KEGG富集图也需要，
  备注USP5参与哪些部分（功能、通路）
- 分子对接模拟芍药苷与USP5互作
- 转至第2步目标靶点为SOX18，关联成分为芍药苷Paeoniflorin
- 第3步中备注SOX18参与哪些部分（功能、通路）
- 分子对接模拟芍药苷与SOX18互作

注：USP5 和 SOX18 不参与功能、通路。其它分析结果见 \@ref(workflow)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis [@ClusterprofilerWuTi2021].
- The API of `UniProtKB` (<https://www.uniprot.org/help/api_queries>) used for mapping of names or IDs of proteins .
- R package `PubChemR` used for querying compounds information .
- Web tool of `SwissTargetPrediction` used for drug-targets prediction [@SwisstargetpredDaina2019].
- Website `TCMSP` <https://tcmsp-e.com/tcmsp.php> used for data source [@TcmspADatabaRuJi2014].
- `AutoDock vina` used for molecular docking [@AutodockVina1Eberha2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction [@TheGenecardsSStelze2016].
- R package `biomaRt` used for gene annotation [@MappingIdentifDurinc2009].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## TCMSP 白芍成分获取



Table \@ref(tab:Baishao-Compounds-and-targets) (下方表格) 为表格Baishao Compounds and targets概览。

**(对应文件为 `Figure+Table/Baishao-Compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有990行3列，以下预览的表格可能省略部分数据；表格含有39个唯一`Mol ID'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Baishao-Compounds-and-targets)Baishao Compounds and targets

|Mol ID    |Molecule Name    |Target name                    |
|:---------|:----------------|:------------------------------|
|MOL001246 |(1R)-()-Nopinone |Gamma-aminobutyric-acid rec... |
|MOL001246 |(1R)-()-Nopinone |Cytochrome P450-cam            |
|MOL001246 |(1R)-()-Nopinone |Lysozyme                       |
|MOL001246 |(1R)-()-Nopinone |Alcohol dehydrogenase 1C       |
|MOL001246 |(1R)-()-Nopinone |Nicotinate-nucleotide--dime... |
|MOL001393 |myristic acid    |Prostaglandin G/H synthase 1   |
|MOL001393 |myristic acid    |Prostaglandin G/H synthase 2   |
|MOL001393 |myristic acid    |Cholinesterase                 |
|MOL001393 |myristic acid    |Phospholipase A2               |
|MOL001393 |myristic acid    |Rhinovirus coat protein        |
|MOL001393 |myristic acid    |Ig gamma-1 chain C region      |
|MOL001393 |myristic acid    |Ferrichrome-iron receptor      |
|MOL001393 |myristic acid    |3-oxoacyl-[acyl-carrier-pro... |
|MOL001393 |myristic acid    |Nuclear receptor coactivator 2 |
|MOL001393 |myristic acid    |Nuclear receptor coactivator 1 |
|...       |...              |...                            |

## 白芍总苷 (Total glucosides of paeony, TGP) 成分

### 白芍总苷 (Total glucosides of paeony, TGP) 成分和筛选

根据提供的文献，搜集其中的白芍总苷 (Total glucosides of paeony, TGP) [@TotalGlucosideJiang2020]。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
TGP
:}

\vspace{0.5em}

    442534, 51346141, 21631105, 21631106, 138113866,
14605198, 50163461, 102000323, 494717, 138108175,
124079396, 101382399, 102516499, 71452334, 137705343

\vspace{2em}
\end{tcolorbox}
\end{center}

以 `PubChemR` 获取这些化合物的同义名：

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
442534
:}

\vspace{0.5em}

    Paeoniflorin, 23180-57-6, Peoniflorin, Paeonia moutan,
NSC 178886, UNII-21AIQ4EV64, 21AIQ4EV64, CCRIS 6494, EINECS
245-476-2, PAEONIFLORIN (USP-RS), PAEONIFLORIN [USP-RS],
NSC-178886,
((2S,2aR,2a1S,3aR,4R,5aR)-4-Hydroxy-2-methyl-2a-(((2S,3R,4S,5S,6R)-3,4,5-trihydroxy-6-(hydroxymethyl)tetrahydro-2...

\vspace{2em}


\textbf{
51346141
:}

\vspace{0.5em}

    Albiflorin, 39011-90-0, SCHEMBL24008597, AC-34702

\vspace{2em}


\textbf{
21631105
:}

\vspace{0.5em}

    Oxypaeoniflorin, Oxypaeoniflora, 39011-91-1,
UNII-3A7O4NBD5S, 3A7O4NBD5S, OXYPEONIFLORIN, NSC 258310,
NSC-258310, J17.727J, beta-D-GLUCOPYRANOSIDE,
(1AR,2S,3AR,5R,5AR,5BS)-TETRAHYDRO-5-HYDROXY-5B-(((4-HYDROXYBENZOYL)OXY)METHYL)-2-METHYL-2,5-METHANO-1H-3,4-DIOXACYCLOBUTA(CD)PENTALEN-1A(2H)-YL,
bet...

\vspace{2em}


\textbf{
21631106
:}

\vspace{0.5em}

    Benzoylpaeoniflorin, 38642-49-8, CHEMBL4861111,
CHEBI:69583, HMS3886L18, MFCD00869479, s9149,
AKOS037645102, CCG-270143, AC-34005, AS-57134, Q27137925

\vspace{2em}


\textbf{
138113866
:}

\vspace{0.5em}

    A866179,
-D-Glucopyranoside,tetrahydro-5-hydroxy-5b-[[(4-hydroxybenzoyl)oxy]methyl]-2-methyl-2,5-methano-1H-3,4-dioxacyclobuta[cd]pentalen-1a(2H)-yl,6-benzoate,[1aR-(1aa,2b,3aa,5a,5aa,5ba)]-

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}

根据同义名，在 Tab. \@ref(tab:Baishao-Compounds-and-targets) 中搜索这些化合物，得到：

Table \@ref(tab:TCMSP-Baishao-the-found-TGP) (下方表格) 为表格TCMSP Baishao the found TGP概览。

**(对应文件为 `Figure+Table/TCMSP-Baishao-the-found-TGP.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有85行15列，以下预览的表格可能省略部分数据；表格含有1个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TCMSP-Baishao-the-found-TGP)TCMSP Baishao the found TGP

|Herb_p... |Mol ID    |Molecu......3 |Molecu......4 |MW     |AlogP |Hdon |Hacc |OB (%) |Caco-2 |
|:---------|:---------|:-------------|:-------------|:------|:-----|:----|:----|:------|:------|
|Baishao   |MOL000106 |PYG           |https:...     |126.12 |1.03  |3    |3    |22.98  |0.69   |
|Baishao   |MOL001218 |Pisol         |https:...     |186.38 |4.62  |1    |1    |18.5   |1.23   |
|Baishao   |MOL001246 |(1R)-(...     |https:...     |138.23 |1.52  |0    |1    |57.86  |1.23   |
|Baishao   |MOL001393 |myrist...     |https:...     |228.42 |5.46  |1    |2    |21.18  |1.07   |
|Baishao   |MOL001396 |PENTAD...     |https:...     |242.45 |5.91  |1    |2    |20.18  |1.08   |
|Baishao   |MOL001402 |Octaco...     |https:...     |394.86 |13.15 |0    |0    |8.15   |1.91   |
|Baishao   |MOL001644 |Dodecanal     |https:...     |184.36 |4.59  |0    |1    |21.52  |1.4    |
|Baishao   |MOL001801 |salicy...     |https:...     |138.13 |1.17  |2    |3    |32.13  |0.63   |
|Baishao   |MOL001888 |2,2-di...     |https:...     |128.24 |2.09  |1    |1    |82.54  |1.22   |
|Baishao   |MOL001889 |Methyl...     |https:...     |294.53 |6.64  |0    |2    |41.93  |1.46   |
|Baishao   |MOL001890 |octade...     |https:...     |252.54 |8.14  |0    |0    |19.5   |1.87   |
|Baishao   |MOL001891 |9-meth...     |https:...     |178.24 |3.55  |0    |0    |26.87  |1.95   |
|Baishao   |MOL001892 |Diprop...     |https:...     |250.32 |3.29  |0    |4    |66.3   |0.78   |
|Baishao   |MOL001893 |BU3           |https:...     |90.14  |-0.14 |2    |2    |34.87  |0.19   |
|Baishao   |MOL001894 |Bicetyl       |https:...     |450.98 |14.97 |0    |0    |8.03   |1.96   |
|...       |...       |...           |...           |...    |...   |...  |...  |...    |...    |

根据 OB、DL 筛选：

Figure \@ref(fig:Filterd-TGP) (下方图) 为图Filterd TGP概览。

**(对应文件为 `Figure+Table/Filterd-TGP.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filterd-TGP.pdf}
\caption{Filterd TGP}\label{fig:Filterd-TGP}
\end{center}



### 白芍总苷 (Total glucosides of paeony, TGP)  成分的靶点预测

通过 `SwissTargetPrediction` 预测靶点。

Figure \@ref(fig:SwissTargetPrediction-results) (下方图) 为图SwissTargetPrediction results概览。

**(对应文件为 `Figure+Table/SwissTargetPrediction-results.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SwissTargetPrediction-results.pdf}
\caption{SwissTargetPrediction results}\label{fig:SwissTargetPrediction-results}
\end{center}




## 白芍总苷 (Total glucosides of paeony, TGP)  的网络药理学分析

### 白芍总苷 (Total glucosides of paeony, TGP)  成分-靶点

Figure \@ref(fig:Network-pharmacology-visualization) (下方图) 为图Network pharmacology visualization概览。

**(对应文件为 `Figure+Table/Network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-visualization.pdf}
\caption{Network pharmacology visualization}\label{fig:Network-pharmacology-visualization}
\end{center}



### 白芍总苷 (Total glucosides of paeony, TGP)  和 过敏性鼻炎 (allergic rhinitis, AR)  靶基因的交集

Figure \@ref(fig:Baishao-TGP-targets-intersect-with-AR-related-targets) (下方图) 为图Baishao TGP targets intersect with AR related targets概览。

**(对应文件为 `Figure+Table/Baishao-TGP-targets-intersect-with-AR-related-targets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Baishao-TGP-targets-intersect-with-AR-related-targets.pdf}
\caption{Baishao TGP targets intersect with AR related targets}\label{fig:Baishao-TGP-targets-intersect-with-AR-related-targets}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    LGALS3, EGFR, VEGFA, CYP2D6, SELP, SERPINE1, PIK3CG,
MMP9, ITK, ADRB2, STAT3, PTGS2

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Baishao-TGP-targets-intersect-with-AR-related-targets-content`)**

Figure \@ref(fig:Targets-of-compounds-and-related-disease) (下方图) 为图Targets of compounds and related disease概览。

**(对应文件为 `Figure+Table/Targets-of-compounds-and-related-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Targets-of-compounds-and-related-disease.pdf}
\caption{Targets of compounds and related disease}\label{fig:Targets-of-compounds-and-related-disease}
\end{center}



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

    LGALS3, VEGFA, SERPINE1, SELP, ADRB2, CYP2D6, STAT3,
PTGS2

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Paeoniflorin-targets-intersect-with-AR-related-targets-content`)**

Figure \@ref(fig:Network-pharmacology-visualization-of-Paeoniflorin) (下方图) 为图Network pharmacology visualization of Paeoniflorin概览。

**(对应文件为 `Figure+Table/Network-pharmacology-visualization-of-Paeoniflorin.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-visualization-of-Paeoniflorin.pdf}
\caption{Network pharmacology visualization of Paeoniflorin}\label{fig:Network-pharmacology-visualization-of-Paeoniflorin}
\end{center}




## 富集分析

### 白芍总苷 (Total glucosides of paeony, TGP) 与 AR 交集基因的富集分析

Figure \@ref(fig:TGP-Interect-genes-KEGG-enrichment) (下方图) 为图TGP Interect genes KEGG enrichment概览。

**(对应文件为 `Figure+Table/TGP-Interect-genes-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TGP-Interect-genes-KEGG-enrichment.pdf}
\caption{TGP Interect genes KEGG enrichment}\label{fig:TGP-Interect-genes-KEGG-enrichment}
\end{center}

Figure \@ref(fig:TGP-Interect-genes-GO-enrichment) (下方图) 为图TGP Interect genes GO enrichment概览。

**(对应文件为 `Figure+Table/TGP-Interect-genes-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TGP-Interect-genes-GO-enrichment.pdf}
\caption{TGP Interect genes GO enrichment}\label{fig:TGP-Interect-genes-GO-enrichment}
\end{center}



### 芍药苷 (Paeoniflorin, P) 与 AR 交集基因的富集分析

Figure \@ref(fig:Pae-Interect-genes-KEGG-enrichment) (下方图) 为图Pae Interect genes KEGG enrichment概览。

**(对应文件为 `Figure+Table/Pae-Interect-genes-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Pae-Interect-genes-KEGG-enrichment.pdf}
\caption{Pae Interect genes KEGG enrichment}\label{fig:Pae-Interect-genes-KEGG-enrichment}
\end{center}

Figure \@ref(fig:Pae-Interect-genes-GO-enrichment) (下方图) 为图Pae Interect genes GO enrichment概览。

**(对应文件为 `Figure+Table/Pae-Interect-genes-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Pae-Interect-genes-GO-enrichment.pdf}
\caption{Pae Interect genes GO enrichment}\label{fig:Pae-Interect-genes-GO-enrichment}
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





