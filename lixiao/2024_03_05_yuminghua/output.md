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
网络药理学寻找复方的靶点通路} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-06}}
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

复方组成：

The decoction consisted of 30 g astragalus membranaceus (huangqi黄芪3), 10 g polygonatum odoratum (yuzu玉竹), 6 g scolopendra subspinipes mutilans (tianlong蜈蚣4), 6 g pberetima (dilong地龙), 20 g solanum nigrum (longkui龙葵5), 20 g herbahedyotis (baihushecao白花蛇舌草), 20 g semen coicis (yiyiren薏苡仁), 6 g euphorbia helioscopia (zeqi泽漆), 10 g curcuma longa (eshu莪术6) and 6 g tendril-leaved fritillary bulb (chuanbei川贝母).

疾病：自身免疫性肠病

## 结果

- 网络药理图见 Fig. \@ref(fig:Network-pharmacology-with-disease)
- 通路聚焦见，Fig. \@ref(fig:Hsa04068-visualization) (SIRT1 相关) 


# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- Website `HERB` <http://herb.ac.cn/> used for data source[@HerbAHighThFang2021].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 网络药理学

### 成分靶点

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行18列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Herb_     |Herb_p... |Herb_c...  |Herb_e... |Herb_l... |Proper... |Meridians |UsePart   |Function  |Indica... |... |
|:---------|:---------|:----------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---|
|HERB00... |BAI HU... |白花蛇舌草 |all - ... |Herba ... |Cold; ... |Large ... |whole ... |1. To ... |Lung h... |... |
|HERB00... |CHUAN ... |川贝母     |Bulb o... |Bulbus... |Minor ... |Lung; ... |bulb      |To rem... |Lung h... |... |
|HERB00... |DI LONG   |地龙       |Earthworm |Pheretima |Cold; ... |Bladde... |Pheret... |Treatm... |1. Rel... |... |
|HERB00... |E ZHU     |莪术       |Zedora... |Rhizom... |Warm; ... |Spleen... |NA        |To pro... |1. Its... |... |
|HERB00... |HUANG QI  |黄芪       |root o... |Radix ... |Warm; ... |Lung; ... |root      |To rei... |Common... |... |
|HERB00... |LONG KUI  |龙葵       |Solanu... |NA        |NA        |NA        |aerial... |NA        |Clove ... |... |
|HERB00... |WU GONG   |蜈蚣       |Centipede |Scolop... |Warm; ... |Liver     |dried ... |To cal... |Acute ... |... |
|HERB00... |YI YI REN |薏苡仁     |seed o... |semen ... |Minor ... |Lung; ... |seed      |1. To ... |Edema,... |... |
|HERB00... |YU ZHU    |玉竹       |Fragra... |Rhizom... |Mild; ... |Lung; ... |rhizome   |To nou... |Lung s... |... |
|HERB00... |ZE QI     |泽漆       |Euphor... |NA        |NA        |NA        |NA        |NA        |Edema ... |... |

Table \@ref(tab:Components-of-Herbs) (下方表格) 为表格Components of Herbs概览。

**(对应文件为 `Figure+Table/Components-of-Herbs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有897行4列，以下预览的表格可能省略部分数据；表格含有831个唯一`Ingredient.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Components-of-Herbs)Components of Herbs

|herb_id    |Ingredient.id |Ingredient.name      |Ingredient.alias     |
|:----------|:-------------|:--------------------|:--------------------|
|HERB000208 |HBIN002551    |1H-2,6-dioxacyclo... |14259-45-1; NSC 3... |
|HERB000208 |HBIN003265    |(1S,4aS,5R,7aS)-5... |(1S,4aS,5R,7aS)-5... |
|HERB000208 |HBIN004057    |2,3-dimethoxy-6-m... |NA                   |
|HERB000208 |HBIN004058    |2,3-dimethoxy-6-m... |NA                   |
|HERB000208 |HBIN005745    |2-hydroxy-3-methy... |2-hydroxy-3-methy... |
|HERB000208 |HBIN005879    |2-methoxy-3-methy... |2-methoxy-3-methy... |
|HERB000208 |HBIN005968    |2-methyl-3-hydrox... |NA                   |
|HERB000208 |HBIN008641    |3-hydroxy-2-methy... |NA                   |
|HERB000208 |HBIN008695    |3&apos;-Hydroxyan... |3-(4-Methoxypheny... |
|HERB000208 |HBIN009961    |4,4-hydroxy- betw... |NA                   |
|HERB000208 |HBIN010238    |(4aS,6aR,6aS,6bR,... |NA                   |
|HERB000208 |HBIN011872    |5-o-p-methoxy cin... |AC1NSY1Y; 5-o-p-m... |
|HERB000208 |HBIN012673    |6-o-e-p-coumaroyl... |NA                   |
|HERB000208 |HBIN012702    |6-O- on- hydroxy ... |NA                   |
|HERB000208 |HBIN012703    |6-O- on- methoxy ... |NA                   |
|...        |...           |...                  |...                  |

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



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/intersection-of-all-compounds-content`)**

### 疾病

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

    autoimmune colitis

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

    Score > 4

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:GeneCards-used-data) (下方表格) 为表格GeneCards used data概览。

**(对应文件为 `Figure+Table/GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1056行7列，以下预览的表格可能省略部分数据；表格含有1056个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GeneCards-used-data)GeneCards used data

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score  |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:------|
|AIRE     |Autoimmune... |Protein Co... |O43918     |52    |GC21P044285 |168.07 |
|FAS      |Fas Cell S... |Protein Co... |P25445     |58    |GC10P106652 |99.65  |
|CTLA4    |Cytotoxic ... |Protein Co... |P16410     |57    |GC02P203854 |83.05  |
|CASP10   |Caspase 10    |Protein Co... |Q92851     |56    |GC02P201182 |78.14  |
|PRKCD    |Protein Ki... |Protein Co... |Q05655     |60    |GC03P053156 |77.18  |
|FASLG    |Fas Ligand    |Protein Co... |P48023     |57    |GC01P172659 |75.31  |
|ITCH     |Itchy E3 U... |Protein Co... |Q96J02     |55    |GC20P034363 |67.8   |
|COPA     |COPI Coat ... |Protein Co... |P53621     |50    |GC01M160288 |63.31  |
|STAT1    |Signal Tra... |Protein Co... |P42224     |61    |GC02M190908 |56.55  |
|PTPN22   |Protein Ty... |Protein Co... |Q9Y2R2     |55    |GC01M113813 |55.01  |
|HLA-DRB1 |Major Hist... |Protein Co... |P01911     |55    |GC06M090793 |54.62  |
|STAT3    |Signal Tra... |Protein Co... |P40763     |62    |GC17M042313 |54.2   |
|TNF      |Tumor Necr... |Protein Co... |P01375     |61    |GC06P125492 |50.9   |
|FOXP3    |Forkhead B... |Protein Co... |Q9BZS1     |56    |GC0XM049250 |50.67  |
|IL6      |Interleukin 6 |Protein Co... |P05231     |60    |GC07P022725 |49.63  |
|...      |...           |...           |...        |...   |...         |...    |

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

    CYP3A5, IL2, TNF, IL2RA, FAS, PRKCD, FASLG, STAT1,
STAT3, IL6, IL10, IFNG, TG, CASP8, KRAS, ACTA2, ZAP70, IL4,
INS, IL1B, NFKB1, MPO, SYK, PDCD1, HLA-B, TGFB1, TLR4,
CXCL8, PRTN3, STAT4, CD40LG, IL18, TPO, IL13, LTF,
TNFRSF1A, HLA-A, IL12B, IL1A, CCL2, ICAM1, SPP1, ABCB1,
ALB, TP53, CXCL10, TNFSF...

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

### 富集结果筛选

以 SIRT1 筛选显著富集的通路

Table \@ref(tab:Filter-by-match-genes) (下方表格) 为表格Filter by match genes概览。

**(对应文件为 `Figure+Table/Filter-by-match-genes.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有12行9列，以下预览的表格可能省略部分数据；表格含有12个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Filter-by-match-genes)Filter by match genes

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa04936 |Alcoho... |36/305    |142/8661 |1.4302... |1.4302... |5.4304... |207/71... |36    |
|hsa04068 |FoxO s... |29/305    |131/8661 |7.6038... |4.3450... |1.6498... |207/47... |29    |
|hsa04218 |Cellul... |29/305    |156/8661 |9.6984... |4.0530... |1.5389... |207/47... |29    |
|hsa04211 |Longev... |20/305    |89/8661  |2.0347... |6.8640... |2.6062... |207/94... |20    |
|hsa04213 |Longev... |16/305    |61/8661  |1.8294... |5.6291... |2.1373... |207/94... |16    |
|hsa04148 |Effero... |22/305    |156/8661 |2.3337... |6.2089... |2.3575... |240/38... |22    |
|hsa05206 |MicroR... |32/305    |310/8661 |3.7074... |9.5796... |3.6373... |5243/4... |32    |
|hsa04152 |AMPK s... |18/305    |121/8661 |2.0060... |4.9708... |1.8874... |207/59... |18    |
|hsa04310 |Wnt si... |13/305    |174/8661 |0.0083... |0.0144... |0.0055... |595/14... |13    |
|hsa05031 |Amphet... |6/305     |69/8661  |0.0340... |0.0554... |0.0210... |1644/2... |6     |
|hsa04922 |Glucag... |6/305     |107/8661 |0.1753... |0.2504... |0.0950... |207/23... |6     |
|hsa00760 |Nicoti... |2/305     |37/8661  |0.3763... |0.4878... |0.1852... |4860/2... |2     |

Figure \@ref(fig:Hsa04068-visualization) (下方图) 为图Hsa04068 visualization概览。

**(对应文件为 `Figure+Table/hsa04068.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-06_16_45_49.49341/hsa04068.pathview.png}
\caption{Hsa04068 visualization}\label{fig:Hsa04068-visualization}
\end{center}



