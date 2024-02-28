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
乙肝病毒HBx利用泛素化系统降解XXX上调YYY诱导肝癌线粒体自噬}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-02-27}}
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

乙肝病毒HBx利用泛素化系统降解XXX上调YYY诱导肝癌线粒体自噬

筛选建议：

1、筛选乙肝病毒HBx (乙型肝炎病毒的外壳蛋白) 处理诱导肝癌细胞差异表达基因集A；

2、基因集A与线粒体自噬相关基因B的相关性（PPI）；

3、筛选最佳相关性组合XXX和YYY。

## 结果

注：与上述建议有不同之处，考虑了与泛素化相关基因的关联。

- 以 GSE186862 数据集差异分析获得基因集 DEGs (Fig. \@ref(fig:L02-Model-vs-Control-DEGs)，
  Tab. \@ref(tab:L02-data-Model-vs-Control-DEGs)) 
- 获取自噬相关基因集 Mitophagy (Tab. \@ref(tab:MIT-related-targets-from-GeneCards))
- 分析 DEGs 中的上调、下调组与 Mitophagy 的交集 (Fig. \@ref(fig:UpSet-Intersection-DEGs-with-Mitophagy-related))。
- DEGs 构建 PPI 网络 (Fig. \@ref(fig:Raw-PPI-network))：
    - 预计泛素化会导致基因的表达量下降[@UbiquitinationPopovi2014]，因此这里推断，受泛素化的 XXX 基因主要存在于 DEGs-down;
      随后，挖掘 DEGs-up-with-Mitophagy (DEGs-up 与 Mitophagy 交集) 与 DEGs-down 的关联
      (Fig. \@ref(fig:Filtered-and-formated-PPI-network))。
    - 根据 DEGs-down 的 MCC score 筛选 Top 10 (Fig. \@ref(fig:Top-MCC-score)) 。
- 获取泛素化相关基因集 (Tab. \@ref(tab:UBI-related-targets-from-GeneCards))
- 泛素化相关的筛选：
    - 将 Tab. \@ref(tab:UBI-related-targets-from-GeneCards) 和 Fig. \@ref(fig:Top-MCC-score) 中的 Top 10 DEGs-down 关联分析 (GSE186862 数据集)，获得关联热图 (Fig. \@ref(fig:L02-correlation-heatmap)) 。
    - 以 P-value < 0.001 筛选 Fig. \@ref(fig:L02-correlation-heatmap)，得到 Fig. \@ref(fig:Correlation-filtered)。
- 整合上述过程的数据：泛素化 -> DEGs-down -> DEGs-up-Mitophagy，Fig. \@ref(fig:integrated-relationship)
- 将整合后的所有基因富集分析，Fig. \@ref(fig:INTE-KEGG-enrichment)，Fig. \@ref(fig:INTE-GO-enrichment)：
    - 主要关注两条通路 (分别与泛素化和自噬相关) ：Fig. \@ref(fig:INTE-hsa04120-visualization)，Fig. \@ref(fig:INTE-hsa04137-visualization)
    - 两条通路有交错的基因 (\@ref(path-intersect)): HUWE1, RPS27A
    - 根据交错基因重新整理 Fig. \@ref(fig:integrated-relationship)，
      得到 Fig. \@ref(fig:co-Exists-in-integrated-relationship)，Tab. \@ref(tab:co-Exists-in-integrated-relationship-data)
- 最终筛选：
    - 建议：结合通路 Mitophagy (Fig. \@ref(fig:INTE-hsa04137-visualization))，
      和 Fig. \@ref(fig:co-Exists-in-integrated-relationship)，
      可发现： HUWE1 -> RPS27A (UB) -> ULK1 之间存在关联。
    - 额外：可根据 Tab. \@ref(tab:co-Exists-in-integrated-relationship) 筛选其他可能。




# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE186862**: mRNA profiles of L02-vector and L02-HBx cells

## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- R package `ClusterProfiler` used for GSEA enrichment[@ClusterprofilerWuTi2021].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 乙肝病毒 HBx 处理 DEGs

### 数据来源

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE186862

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Illumina Casava1.7 software used for basecalling.

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    Sequenced reads were trimmed for adaptor sequence, and
masked for low-complexity or low-quality sequence, then
mapped to mm8 whole genome using bowtie v0.12.2 with
parameters -q -p 4 -e 100 -y -a -m 10 --best --strata

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    Reads Per Kilobase of exon per Megabase of library size
(RPKM) were calculated using a protocol from Chepelev et
al., Nucleic Acids Research, 2009. In short, exons from all
isoforms of a gene were merged to create one
meta-transcript. The number of reads falling in the exons
of this meta-transcri...

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    Genome\_build: HG19

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}

Table \@ref(tab:L02-metadata) (下方表格) 为表格L02 metadata概览。

**(对应文件为 `Figure+Table/L02-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行9列，以下预览的表格可能省略部分数据；表格含有6个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:L02-metadata)L02 metadata

|rownames |sample |group   |lib.size |norm.f... |title     |cell.l... |cell.t... |genoty... |
|:--------|:------|:-------|:--------|:---------|:---------|:---------|:---------|:---------|
|A        |A      |Control |16890967 |1         |L02-ve... |L02       |liver ... |control   |
|C        |C      |Control |13575225 |1         |L02-ve... |L02       |liver ... |control   |
|E        |E      |Control |14827232 |1         |L02-ve... |L02       |liver ... |control   |
|B        |B      |Model   |21985666 |1         |L02-HBx1  |L02       |liver ... |HBx ex... |
|D        |D      |Model   |16595110 |1         |L02-HBx2  |L02       |liver ... |HBx ex... |
|F        |F      |Model   |19786946 |1         |L02-HBx3  |L02       |liver ... |HBx ex... |

注：该 GSE 数据集的补充材料没有注明样品分组 (即，A、B、C……等样品是属于哪个组别) ，
元数据表格中的分组信息，是我根据原文 Figure 和 LogFC 数值推断的[@HbxIncreasesCZheng2022]。

### DEGs

Figure \@ref(fig:L02-Model-vs-Control-DEGs) (下方图) 为图L02 Model vs Control DEGs概览。

**(对应文件为 `Figure+Table/L02-Model-vs-Control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/L02-Model-vs-Control-DEGs.pdf}
\caption{L02 Model vs Control DEGs}\label{fig:L02-Model-vs-Control-DEGs}
\end{center}

Table \@ref(tab:L02-data-Model-vs-Control-DEGs) (下方表格) 为表格L02 data Model vs Control DEGs概览。

**(对应文件为 `Figure+Table/L02-data-Model-vs-Control-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2352行12列，以下预览的表格可能省略部分数据；表格含有2205个唯一`Symbol'。
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

Table: (\#tab:L02-data-Model-vs-Control-DEGs)L02 data Model vs Control DEGs

|rownames |AccID     |AccID.1   |Symbol    |Strand    |KeggID    |logFC     |AveExpr   |t         |P.Value   |
|:--------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|38934    |ENSG00... |NM_019... |UGT1A7    |hsa:54577 |UDP gl... |-3.200... |5.1819... |-24.69... |2.2577... |
|12949    |ENSG00... |NM_153... |HSPA8     |hsa:3312  |heat s... |-2.694... |10.198... |-23.85... |3.1834... |
|15559    |ENSG00... |NM_006472 |TXNIP     |hsa:10628 |thiore... |3.6547... |5.2722... |24.094... |2.8880... |
|22453    |ENSG00... |NM_003... |STC2      |hsa:8614  |stanni... |2.6030... |7.9409... |22.909... |4.7679... |
|56468    |ENSG00... |NM_052... |FAM129A   |hsa:11... |family... |2.2312... |7.2870... |18.291... |4.4197... |
|52927    |ENSG00... |NM_144... |IL20RB    |hsa:53833 |interl... |2.3520... |4.4217... |16.820... |1.0066... |
|22482    |ENSG00... |NM_004... |ATF3      |hsa:467   |activa... |2.9807... |4.1438... |16.708... |1.0745... |
|15033    |ENSG00... |NM_005... |SGK1      |hsa:6446  |serum/... |-1.942... |6.7155... |-16.43... |1.2627... |
|49697    |ENSG00... |NM_001... |GADD45A   |hsa:1647  |growth... |2.1993... |5.0430... |16.435... |1.2622... |
|23878    |ENSG00... |NR_120... |LINC01468 |hsa:10... |long i... |-2.572... |3.8734... |-16.50... |1.2116... |
|39631    |ENSG00... |NM_014... |PPP1R15A  |hsa:23645 |protei... |1.8632... |6.8100... |15.752... |1.9102... |
|5042     |ENSG00... |NM_004... |F2RL2     |hsa:2151  |coagul... |2.3576... |3.9660... |15.718... |1.9511... |
|7150     |ENSG00... |NM_002... |PTX3      |hsa:5806  |pentra... |3.0542... |3.7001... |15.552... |2.1645... |
|3587     |ENSG00... |NM_002... |CXCL2     |hsa:2920  |chemok... |2.0506... |4.7692... |15.311... |2.5193... |
|58151    |ENSG00... |NM_005... |HSPA1A    |hsa:3303  |heat s... |-2.338... |6.8642... |-15.26... |2.5935... |
|...      |...       |...       |...       |...       |...       |...       |...       |...       |...       |



### 富集分析 (尝试)

Figure \@ref(fig:L02-KEGG-enrichment-with-enriched-genes) (下方图) 为图L02 KEGG enrichment with enriched genes概览。

**(对应文件为 `Figure+Table/L02-KEGG-enrichment-with-enriched-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/L02-KEGG-enrichment-with-enriched-genes.pdf}
\caption{L02 KEGG enrichment with enriched genes}\label{fig:L02-KEGG-enrichment-with-enriched-genes}
\end{center}

Figure \@ref(fig:L02-GSEA-plot-of-the-pathways) (下方图) 为图L02 GSEA plot of the pathways概览。

**(对应文件为 `Figure+Table/L02-GSEA-plot-of-the-pathways.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/L02-GSEA-plot-of-the-pathways.pdf}
\caption{L02 GSEA plot of the pathways}\label{fig:L02-GSEA-plot-of-the-pathways}
\end{center}



## 线粒体自噬

### GeneCards

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by filtering:
:}

\vspace{0.5em}

    Score > 1

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:MIT-related-targets-from-GeneCards) (下方表格) 为表格MIT related targets from GeneCards概览。

**(对应文件为 `Figure+Table/MIT-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1686行7列，以下预览的表格可能省略部分数据；表格含有1686个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MIT-related-targets-from-GeneCards)MIT related targets from GeneCards

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|PRKN     |Parkin RBR... |Protein Co... |O60260     |57    |GC06M161348 |19.14 |
|PINK1    |PTEN Induc... |Protein Co... |Q9BXM7     |55    |GC01P020634 |18.01 |
|MAP1LC3B |Microtubul... |Protein Co... |Q9GZQ8     |50    |GC16P087413 |11.07 |
|VDAC1    |Voltage De... |Protein Co... |P21796     |54    |GC05M133975 |10.11 |
|FUNDC1   |FUN14 Doma... |Protein Co... |Q8IVP5     |37    |GC0XM044523 |9.21  |
|MFN2     |Mitofusin 2   |Protein Co... |O95140     |57    |GC01P011980 |9.05  |
|SQSTM1   |Sequestoso... |Protein Co... |Q13501     |58    |GC05P179806 |8.40  |
|MAP1LC3A |Microtubul... |Protein Co... |Q9H492     |48    |GC20P034546 |7.92  |
|ULK1     |Unc-51 Lik... |Protein Co... |O75385     |54    |GC12P131894 |7.22  |
|UBC      |Ubiquitin C   |Protein Co... |P0CG48     |51    |GC12M124911 |6.81  |
|PHB2     |Prohibitin 2  |Protein Co... |Q99623     |49    |GC12M006965 |6.75  |
|ATG13    |Autophagy ... |Protein Co... |O75143     |49    |GC11P047383 |6.54  |
|SOD2-OT1 |SOD2 Overl... |RNA Gene      |           |18    |GC06M159772 |6.47  |
|TOMM20   |Translocas... |Protein Co... |Q15388     |48    |GC01M235109 |6.45  |
|AMBRA1   |Autophagy ... |Protein Co... |Q9C0C7     |46    |GC11M120823 |6.26  |
|...      |...           |...           |...        |...   |...         |...   |



## DEGs 与线粒体自噬

### 交集 (Inter-DEGs-Mito)

Figure \@ref(fig:Venn-Intersection-DEGs-with-Mitophagy-related) (下方图) 为图Venn Intersection DEGs with Mitophagy related概览。

**(对应文件为 `Figure+Table/Venn-Intersection-DEGs-with-Mitophagy-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Venn-Intersection-DEGs-with-Mitophagy-related.pdf}
\caption{Venn Intersection DEGs with Mitophagy related}\label{fig:Venn-Intersection-DEGs-with-Mitophagy-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    HSPA8, HSPA1A, SESN2, HMGCS1, RNF41, PSAT1, NDRG1,
DNAJA1, PCK2, ZC3HAV1, SLFN11, RCAN1, KPNA2, BNIP3, UGP2,
SHMT2, LDHA, VDAC1, PLOD2, ANLN, BNIP3L, NSDHL, PCYOX1,
PHGDH, TRIM25, PDP1, SQSTM1, HSPH1, PLSCR1, SLC3A2,
GABARAPL1, HK2, HSP90AA1, APAF1, LMO7, ARHGEF2, GPCPD1,
NFKB1, CUL3, SMAD3, NFKB...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Venn-Intersection-DEGs-with-Mitophagy-related-content`)**

Figure \@ref(fig:UpSet-Intersection-DEGs-with-Mitophagy-related) (下方图) 为图UpSet Intersection DEGs with Mitophagy related概览。

**(对应文件为 `Figure+Table/UpSet-Intersection-DEGs-with-Mitophagy-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/UpSet-Intersection-DEGs-with-Mitophagy-related.pdf}
\caption{UpSet Intersection DEGs with Mitophagy related}\label{fig:UpSet-Intersection-DEGs-with-Mitophagy-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/UpSet-Intersection-DEGs-with-Mitophagy-related-content`)**




### PPI

构建 DEGs 的 PPI 网络。

Figure \@ref(fig:Raw-PPI-network) (下方图) 为图Raw PPI network概览。

**(对应文件为 `Figure+Table/Raw-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Raw-PPI-network.pdf}
\caption{Raw PPI network}\label{fig:Raw-PPI-network}
\end{center}

预计泛素化会导致基因的表达量下降[@UbiquitinationPopovi2014]，因此这里可以推断，受泛素化的 XXX 基因主要存在于 DEGs-down。

挖掘 DEGs-up-with-Mitophagy (DEGs-up 与 Mitophagy 交集) 与 DEGs-down 的关联。

Figure \@ref(fig:Filtered-and-formated-PPI-network) (下方图) 为图Filtered and formated PPI network概览。

**(对应文件为 `Figure+Table/Filtered-and-formated-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filtered-and-formated-PPI-network.pdf}
\caption{Filtered and formated PPI network}\label{fig:Filtered-and-formated-PPI-network}
\end{center}

根据 DEGs-down 的 MCC score 筛选 Top 10。

Figure \@ref(fig:Top-MCC-score) (下方图) 为图Top MCC score概览。

**(对应文件为 `Figure+Table/Top-MCC-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Top-MCC-score.pdf}
\caption{Top MCC score}\label{fig:Top-MCC-score}
\end{center}






## 泛素化

### GeneCards

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by filtering:
:}

\vspace{0.5em}

    Score > 15

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:UBI-related-targets-from-GeneCards) (下方表格) 为表格UBI related targets from GeneCards概览。

**(对应文件为 `Figure+Table/UBI-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有161行7列，以下预览的表格可能省略部分数据；表格含有161个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:UBI-related-targets-from-GeneCards)UBI related targets from GeneCards

|Symbol |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|RPS27A |Ribosomal ... |Protein Co... |P62979     |51    |GC02P055231 |41.57 |
|PRKN   |Parkin RBR... |Protein Co... |O60260     |57    |GC06M161348 |40.64 |
|UBC    |Ubiquitin C   |Protein Co... |P0CG48     |51    |GC12M124911 |37.54 |
|UBE2D1 |Ubiquitin ... |Protein Co... |P51668     |52    |GC10P058334 |37.22 |
|UBE2D3 |Ubiquitin ... |Protein Co... |P61077     |52    |GC04M102794 |35.79 |
|UBE2D2 |Ubiquitin ... |Protein Co... |P62837     |51    |GC05P139526 |35.33 |
|UBE2L3 |Ubiquitin ... |Protein Co... |P68036     |54    |GC22P021549 |33.3  |
|UBE2N  |Ubiquitin ... |Protein Co... |P61088     |55    |GC12M093406 |32.84 |
|RBX1   |Ring-Box 1    |Protein Co... |P62877     |51    |GC22P040951 |30.81 |
|USP7   |Ubiquitin ... |Protein Co... |Q93009     |57    |GC16M008892 |30.55 |
|VCP    |Valosin Co... |Protein Co... |P55072     |58    |GC09M035056 |30.55 |
|UBE3A  |Ubiquitin ... |Protein Co... |Q05086     |56    |GC15M025333 |30.26 |
|MDM2   |MDM2 Proto... |Protein Co... |Q00987     |62    |GC12P068808 |30.23 |
|STUB1  |STIP1 Homo... |Protein Co... |Q9UNE7     |54    |GC16P064961 |30.01 |
|UBE4B  |Ubiquitina... |Protein Co... |O95155     |49    |GC01P010032 |29.68 |
|...    |...           |...           |...        |...   |...         |...   |



## 泛素化基因集与筛选基因集 (DEGs-down) 的相关性

### 关联热图

将 Tab. \@ref(tab:UBI-related-targets-from-GeneCards) 和 Fig. \@ref(fig:Top-MCC-score) 中的 Top 10 DEGs-down
关联分析 (GSE186862 数据集)。

Figure \@ref(fig:L02-correlation-heatmap) (下方图) 为图L02 correlation heatmap概览。

**(对应文件为 `Figure+Table/L02-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/L02-correlation-heatmap.pdf}
\caption{L02 correlation heatmap}\label{fig:L02-correlation-heatmap}
\end{center}



### 构建网络

以 P-value < 0.001 筛选 Fig. \@ref(fig:L02-correlation-heatmap)。

Figure \@ref(fig:Correlation-filtered) (下方图) 为图Correlation filtered概览。

**(对应文件为 `Figure+Table/Correlation-filtered.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Correlation-filtered.pdf}
\caption{Correlation filtered}\label{fig:Correlation-filtered}
\end{center}



## 整合：泛素化 -> DEGs-down -> DEGs-up-Mitophagy

Figure \@ref(fig:integrated-relationship) (下方图) 为图integrated relationship概览。

**(对应文件为 `Figure+Table/integrated-relationship.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/integrated-relationship.pdf}
\caption{Integrated relationship}\label{fig:integrated-relationship}
\end{center}



## 富集分析

### KEGG

Figure \@ref(fig:INTE-KEGG-enrichment) (下方图) 为图INTE KEGG enrichment概览。

**(对应文件为 `Figure+Table/INTE-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTE-KEGG-enrichment.pdf}
\caption{INTE KEGG enrichment}\label{fig:INTE-KEGG-enrichment}
\end{center}

Figure \@ref(fig:INTE-GO-enrichment) (下方图) 为图INTE GO enrichment概览。

**(对应文件为 `Figure+Table/INTE-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTE-GO-enrichment.pdf}
\caption{INTE GO enrichment}\label{fig:INTE-GO-enrichment}
\end{center}

### pathway visualization

Figure \@ref(fig:INTE-hsa04120-visualization) (下方图) 为图INTE hsa04120 visualization概览。

**(对应文件为 `Figure+Table/hsa04120.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-02-27_14_52_06.625626/hsa04120.pathview.png}
\caption{INTE hsa04120 visualization}\label{fig:INTE-hsa04120-visualization}
\end{center}

Figure \@ref(fig:INTE-hsa04137-visualization) (下方图) 为图INTE hsa04137 visualization概览。

**(对应文件为 `Figure+Table/hsa04137.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-02-27_14_52_06.625626/hsa04137.pathview.png}
\caption{INTE hsa04137 visualization}\label{fig:INTE-hsa04137-visualization}
\end{center}



### 富集于 hsa04120 (Ubiquitination) 与 hsa04137 (Mitophagy) 的基因 {#path-intersect}

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Content
:}

\vspace{0.5em}

    HUWE1, RPS27A

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:co-Exists-in-integrated-relationship) (下方图) 为图co Exists in integrated relationship概览。

**(对应文件为 `Figure+Table/co-Exists-in-integrated-relationship.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/co-Exists-in-integrated-relationship.pdf}
\caption{Co Exists in integrated relationship}\label{fig:co-Exists-in-integrated-relationship}
\end{center}

Table \@ref(tab:co-Exists-in-integrated-relationship-data) (下方表格) 为表格co Exists in integrated relationship data概览。

**(对应文件为 `Figure+Table/co-Exists-in-integrated-relationship-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有32行3列，以下预览的表格可能省略部分数据；表格含有2个唯一`Ubiquitination\_related'。
\end{tcolorbox}
\end{center}

Table: (\#tab:co-Exists-in-integrated-relationship-data)Co Exists in integrated relationship data

|Ubiquitination_related |DEGs_down |DEGs_up_Mitophagy |
|:----------------------|:---------|:-----------------|
|RPS27A                 |RPS27A    |AIMP2             |
|RPS27A                 |RPS27A    |NFKB1             |
|RPS27A                 |RPS27A    |DUSP1             |
|RPS27A                 |RPS27A    |NR1D1             |
|RPS27A                 |RPS27A    |DDB2              |
|RPS27A                 |RPS27A    |EP300             |
|RPS27A                 |RPS27A    |BAX               |
|RPS27A                 |RPS27A    |TRIM25            |
|RPS27A                 |RPS27A    |ULK1              |
|RPS27A                 |RPS27A    |SMAD3             |
|RPS27A                 |RPS27A    |RNF41             |
|RPS27A                 |RPS27A    |UBE2Z             |
|RPS27A                 |RPS27A    |NFKB2             |
|RPS27A                 |RPS27A    |SRC               |
|RPS27A                 |RPS27A    |SQSTM1            |
|...                    |...       |...               |



