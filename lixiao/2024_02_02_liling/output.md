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
\ThisCenterWallPaper{1.12}{~/outline/lixiao//cover_page.pdf}
\begin{center} \textbf{\Huge
筛选主动脉-下腔静脉瘘ACF模型 DEGs 并功能分析}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-02-02}}
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



需求：

生物信息学分析筛选对照组动物和ACF动物之间有差异表达的XXX mRNA（若缺少动物数据库，可以筛选血液透析患者的血管差异基因）。GO和KEGG分析与内皮-间质转化相关的显著富集的通路YYY。

结果：

- 筛选的差异表达基因见 Fig. \@ref(fig:Intersection-of-ET-with-DEGs)
- 富集结果见 Fig. \@ref(fig:Ids-KEGG-enrichment) 和 Fig. \@ref(fig:Ids-GO-enrichment)
    - GO:0048771 'tissue remodeling' 为显著富集并与 ET 相关的通路。

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE232594**: Comparative gene expression profiling analysis of RNA-seq  data for right atrium free wall myocardium in volume overload and sham-operated C57/BL6 mice on postnatal day21.

## 方法

Mainly used method:

- R package `biomaRt` used for gene annotation[@MappingIdentifDurinc2009].
- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- `Fastp` used for Fastq data preprocessing[@UltrafastOnePChen2023].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- `Kallisto` used for RNA-seq mapping and quantification[@NearOptimalPrBray2016].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 数据来源 GSE232594

由于该数据集 (以及相似的其它数据集) 的原作者没有导出 Count 数据 (适应于差异分析)，因此这里下载了 SRA (PRJNA972912) 原始数据从头开始分析该 RNA-seq 数据集。

Table \@ref(tab:GSE-metadata) (下方表格) 为表格GSE metadata概览。

**(对应文件为 `Figure+Table/GSE-metadata.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行6列，以下预览的表格可能省略部分数据；表格含有6个唯一`rownames'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GSE-metadata)GSE metadata

|rownames   |title         |genotype.ch1 |strain.ch1 |tissue.ch1   |treatment.ch1 |
|:----------|:-------------|:------------|:----------|:------------|:-------------|
|GSM7359743 |RA, sham-o... |WT           |C57BL/6    |Right atrium |sham-operated |
|GSM7359744 |RA, sham-o... |WT           |C57BL/6    |Right atrium |sham-operated |
|GSM7359745 |RA, sham-o... |WT           |C57BL/6    |Right atrium |sham-operated |
|GSM7359746 |RA, Volume... |WT           |C57BL/6    |Right atrium |volume ove... |
|GSM7359747 |RA, Volume... |WT           |C57BL/6    |Right atrium |volume ove... |
|GSM7359748 |RA, Volume... |WT           |C57BL/6    |Right atrium |volume ove... |

### SRA

Table \@ref(tab:SRA-metadata) (下方表格) 为表格SRA metadata概览。

**(对应文件为 `Figure+Table/SRA-metadata.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行45列，以下预览的表格可能省略部分数据；表格含有6个唯一`Run'。
\end{tcolorbox}
\end{center}

Table: (\#tab:SRA-metadata)SRA metadata

|Run       |spots    |bases     |spots_... |avgLength |size_MB |Assemb... |downlo... |Experi... |Librar... |
|:---------|:--------|:---------|:---------|:---------|:-------|:---------|:---------|:---------|:---------|
|SRR245... |23554439 |706633... |23554439  |300       |2164    |NA        |https:... |SRX203... |GSM735... |
|SRR245... |23066894 |692006... |23066894  |300       |2125    |NA        |https:... |SRX203... |GSM735... |
|SRR245... |22691185 |680735... |22691185  |300       |2136    |NA        |https:... |SRX203... |GSM735... |
|SRR245... |23061459 |691843... |23061459  |300       |2141    |NA        |https:... |SRX203... |GSM735... |
|SRR245... |21413791 |642413... |21413791  |300       |2006    |NA        |https:... |SRX203... |GSM735... |
|SRR245... |21966609 |658998... |21966609  |300       |2050    |NA        |https:... |SRX203... |GSM735... |

## RNA-seq 前处理

### QC

 
`QC report' 数据已全部提供。

**(对应文件为 `./fastp_report/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./fastp\_report/共包含6个文件。

\begin{enumerate}\tightlist
\item SRR24578639.html
\item SRR24578640.html
\item SRR24578641.html
\item SRR24578642.html
\item SRR24578643.html
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

### 定量

cDNA 参考基因注释 (使用的是 mus musculus 的参考基因) 。
<https://ftp.ensembl.org/pub/release-110/fasta/mus_musculus/>

Table \@ref(tab:Quantification) (下方表格) 为表格Quantification概览。

**(对应文件为 `Figure+Table/Quantification.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有116873行7列，以下预览的表格可能省略部分数据；表格含有116873个唯一`target\_id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Quantification)Quantification

|target_id     |SRR245786391 |SRR245786401 |SRR245786411 |SRR245786421 |SRR245786431 |SRR245786441 |... |
|:-------------|:------------|:------------|:------------|:------------|:------------|:------------|:---|
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|ENSMUST000... |0            |0            |0            |0            |0            |0            |... |
|...           |...          |...          |...          |...          |...          |...          |... |

## 差异分析

### QC

Figure \@ref(fig:Filtered) (下方图) 为图Filtered概览。

**(对应文件为 `Figure+Table/Filtered.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filtered.pdf}
\caption{Filtered}\label{fig:Filtered}
\end{center}

Figure \@ref(fig:Normalization) (下方图) 为图Normalization概览。

**(对应文件为 `Figure+Table/Normalization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Normalization.pdf}
\caption{Normalization}\label{fig:Normalization}
\end{center}

### 结果

Figure \@ref(fig:Model-vs-control-DEGs) (下方图) 为图Model vs control DEGs概览。

**(对应文件为 `Figure+Table/Model-vs-control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Model-vs-control-DEGs.pdf}
\caption{Model vs control DEGs}\label{fig:Model-vs-control-DEGs}
\end{center}

Table \@ref(tab:Data-model-vs-control-DEGs) (下方表格) 为表格Data model vs control DEGs概览。

**(对应文件为 `Figure+Table/Data-model-vs-control-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2522行13列，以下预览的表格可能省略部分数据；表格含有2108个唯一`mgi\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Data-model-vs-control-DEGs)Data model vs control DEGs

|rownames |ensemb......2 |mgi_sy... |ensemb......4 |entrez... |hgnc_s... |descri... |logFC     |AveExpr   |... |
|:--------|:-------------|:---------|:-------------|:---------|:---------|:---------|:---------|:---------|:---|
|7133     |ENSMUS...     |Nppb      |ENSMUS...     |18158     |NA        |natriu... |-1.967... |7.6029... |... |
|31330    |ENSMUS...     |Asb2      |ENSMUS...     |65256     |          |ankyri... |-1.084... |6.5994... |... |
|89274    |ENSMUS...     |Rap1gap2  |ENSMUS...     |380711    |NA        |RAP1 G... |-1.912... |3.8988... |... |
|78044    |ENSMUS...     |Rpsa      |ENSMUS...     |16785     |NA        |riboso... |-1.184... |8.2501... |... |
|85206    |ENSMUS...     |Gapdh     |ENSMUS...     |14433     |NA        |glycer... |-2.180... |8.8656... |... |
|36842    |ENSMUS...     |Mb        |ENSMUS...     |17189     |NA        |myoglo... |-2.336... |6.9739... |... |
|96280    |ENSMUS...     |Fam220a   |ENSMUS...     |67238     |NA        |family... |-3.529... |2.4402... |... |
|96286    |ENSMUS...     |Fam220a   |ENSMUS...     |67238     |NA        |family... |-3.529... |2.4402... |... |
|70694    |ENSMUS...     |Fbxl22    |ENSMUS...     |74165     |NA        |F-box ... |-0.913... |6.5089... |... |
|60553    |ENSMUS...     |Rpl22l1   |ENSMUS...     |68028     |NA        |riboso... |-1.944... |3.7509... |... |
|82742    |ENSMUS...     |Copa      |ENSMUS...     |12847     |NA        |coatom... |-1.395... |5.2027... |... |
|13717    |ENSMUS...     |Ankrd1    |ENSMUS...     |107765    |NA        |ankyri... |-1.193... |10.790... |... |
|63231    |ENSMUS...     |Rps19     |ENSMUS...     |20085     |NA        |riboso... |2.8106... |3.0550... |... |
|51535    |ENSMUS...     |Fau       |ENSMUS...     |14109     |NA        |Finkel... |-2.483... |4.8874... |... |
|58716    |ENSMUS...     |Frmd5     |ENSMUS...     |228564    |NA        |FERM d... |-1.151... |4.5589... |... |
|...      |...           |...       |...           |...       |...       |...       |...       |...       |... |

### 基因名映射到人类的基因

Table \@ref(tab:Mapped-Data-model-vs-control-DEGs) (下方表格) 为表格Mapped Data model vs control DEGs概览。

**(对应文件为 `Figure+Table/Mapped-Data-model-vs-control-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2108行13列，以下预览的表格可能省略部分数据；表格含有1980个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Mapped-Data-model-vs-control-DEGs)Mapped Data model vs control DEGs

|hgnc_s... |mgi_sy... |logFC     |P.Value   |rownames |ensemb......6 |ensemb......7 |entrez... |descri... |... |
|:---------|:---------|:---------|:---------|:--------|:-------------|:-------------|:---------|:---------|:---|
|NPPB      |Nppb      |-1.967... |1.4872... |7133     |ENSMUS...     |ENSMUS...     |18158     |natriu... |... |
|ASB2      |Asb2      |-1.084... |2.1399... |31330    |ENSMUS...     |ENSMUS...     |65256     |ankyri... |... |
|RAP1GAP2  |Rap1gap2  |-1.912... |1.9290... |89274    |ENSMUS...     |ENSMUS...     |380711    |RAP1 G... |... |
|RPSAP58   |Rpsa      |-1.184... |3.6418... |78044    |ENSMUS...     |ENSMUS...     |16785     |riboso... |... |
|GAPDH     |Gapdh     |-2.180... |6.0987... |85206    |ENSMUS...     |ENSMUS...     |14433     |glycer... |... |
|MB        |Mb        |-2.336... |6.8296... |36842    |ENSMUS...     |ENSMUS...     |17189     |myoglo... |... |
|FAM220A   |Fam220a   |-3.529... |1.0560... |96280    |ENSMUS...     |ENSMUS...     |67238     |family... |... |
|FBXL22    |Fbxl22    |-0.913... |7.8460... |70694    |ENSMUS...     |ENSMUS...     |74165     |F-box ... |... |
|RPL22L1   |Rpl22l1   |-1.944... |6.3883... |60553    |ENSMUS...     |ENSMUS...     |68028     |riboso... |... |
|COPA      |Copa      |-1.395... |9.0391... |82742    |ENSMUS...     |ENSMUS...     |12847     |coatom... |... |
|ANKRD1    |Ankrd1    |-1.193... |9.7473... |13717    |ENSMUS...     |ENSMUS...     |107765    |ankyri... |... |
|RPS19     |Rps19     |2.8106... |7.4734... |63231    |ENSMUS...     |ENSMUS...     |20085     |riboso... |... |
|FAU       |Fau       |-2.483... |0.0001... |51535    |ENSMUS...     |ENSMUS...     |14109     |Finkel... |... |
|FRMD5     |Frmd5     |-1.151... |0.0001... |58716    |ENSMUS...     |ENSMUS...     |228564    |FERM d... |... |
|NA        |Rpl11     |-0.940... |0.0001... |54544    |ENSMUS...     |ENSMUS...     |67025     |riboso... |... |
|...       |...       |...       |...       |...      |...           |...           |...       |...       |... |

## 内皮-间质转化 (endothelial-to-mesenchymal transition, ET) 

### ET 来源

从 GeneCards 获取相关的基因集。

Table \@ref(tab:ET-related-targets-from-GeneCards) (下方表格) 为表格ET related targets from GeneCards概览。

**(对应文件为 `Figure+Table/ET-related-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有96行7列，以下预览的表格可能省略部分数据；表格含有96个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:ET-related-targets-from-GeneCards)ET related targets from GeneCards

|Symbol      |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:-----------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|TGFB1       |Transformi... |Protein Co... |P01137     |61    |GC19M041301 |5.71  |
|H19         |H19 Imprin... |RNA Gene      |           |34    |GC11M001995 |4.52  |
|MIR21       |MicroRNA 21   |RNA Gene      |           |31    |GC17P102034 |4.40  |
|BMP7        |Bone Morph... |Protein Co... |P18075     |55    |GC20M057168 |3.85  |
|MIR126      |MicroRNA 126  |RNA Gene      |           |29    |GC09P136670 |3.49  |
|MIRLET7C    |MicroRNA L... |RNA Gene      |           |28    |GC21P017033 |3.49  |
|CTNNB1      |Catenin Be... |Protein Co... |P35222     |62    |GC03P041194 |3.41  |
|TGFB2       |Transformi... |Protein Co... |P61812     |60    |GC01P218345 |3.41  |
|TMX2-CTNND1 |TMX2-CTNND... |RNA Gene      |           |23    |GC11P057712 |2.96  |
|BMPR2       |Bone Morph... |Protein Co... |Q13873     |59    |GC02P202376 |2.88  |
|ROCK1       |Rho Associ... |Protein Co... |Q13464     |57    |GC18M032996 |2.88  |
|SNAI1       |Snail Fami... |Protein Co... |O95863     |52    |GC20P049982 |2.88  |
|MALAT1      |Metastasis... |RNA Gene      |           |31    |GC11P084571 |2.88  |
|MIR532      |MicroRNA 532  |RNA Gene      |           |23    |GC0XP056752 |2.88  |
|RUNX3       |RUNX Famil... |Protein Co... |Q13761     |51    |GC01M024899 |2.78  |
|...         |...           |...           |...        |...   |...         |...   |

### 与 DEG 交集

Figure \@ref(fig:Intersection-of-ET-with-DEGs) (下方图) 为图Intersection of ET with DEGs概览。

**(对应文件为 `Figure+Table/Intersection-of-ET-with-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-ET-with-DEGs.pdf}
\caption{Intersection of ET with DEGs}\label{fig:Intersection-of-ET-with-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    CTNNB1, NFKB1, HSPB1, ACVRL1, ACTA2, FOXO1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-ET-with-DEGs-content`)**

## 富集分析

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






