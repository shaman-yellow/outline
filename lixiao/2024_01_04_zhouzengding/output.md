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
网络药理学分析+蛋白对接模拟} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-15}}
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



## 第一次分析

脓毒症肺损伤+血管重塑+基因+糖酵解

- 糖酵解与肺血管病理性重塑（如果比较少，放宽到血管重塑remodeling）相关的基因集
    - 血管重塑基因 (\@ref(vr)) 和脓毒症肺损伤基因 (\@ref(sli)) 以及糖酵解相关基因 (\@ref(gly)) 取全交集 (Fig. \@ref(fig:Filtered-DEGs-intersection)) 
- 对基因集做功能通路富集分析
    - 分别对败血性肺损伤 (septic lung injury, SLI) 数据集 (Fig. \@ref(fig:KEGG-enrichment-with-enriched-genes)) 和上述交集后的基因集 (Fig. \@ref(fig:FDEGS-ids-KEGG-enrichment) 和 Fig. \@ref(fig:FDEGS-ids-GO-enrichment)) 做了富集分析
- 在这些基因集中找到kif2c（如果包含可能名次比较靠后了），及kif2c相关的基因，做PPI网络图
    - 找不到 KIF2F 基因。交集基因 PPI 图见 Fig. \@ref(fig:PPI-of-Filtered-DEGs)
- 目标靶基因是MYC，用分子对接模拟KIF2C与MYC蛋白互作
    - KIF2C 与 MYC 蛋白互作模拟结果见 \@ref(docking)
- 其他，看有能满足思路的花里胡哨的图都可以放上来


## 第二次分析

- 已放宽条件，使结果包含 KIF2C 与 MYC (见 \@ref(revise))
- KIF2C 与 MYC 蛋白互作放大细节，可到 <http://cadd.zju.edu.cn/hawkdock/result/liwenhua-1704765524163> 网站查看交互式结果。

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE165226**: we divided  6-8 weeks mice into  two groups - control and septic model and 6 mice per group.

- **GSE236713**: Patients  were recruited from four UK hospitals (Royal Glamorgan Hospital, Prince Charles Hospital, Bristol Royal Infirmary and University Hospitals Birmingham) between 2013 and 2015. Healthy volun...

## 方法

Mainly used method:

- R package `biomaRt` used for gene annotation[@MappingIdentifDurinc2009].
- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- R package `ClusterProfiler` used for GSEA enrichment[@ClusterprofilerWuTi2021].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- `LZerD` and `HawkDock` webservers used for protein–protein docking[@LzerdWebserverChrist2021; @HawkdockAWebWeng2019].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## Disease (database: PharmGKB, DisGeNet, GeneCards)

### 血管重塑 (Vascular Remodeling, VR)  {#vr}

从三个数据库获取相关基因：

Figure \@ref(fig:VR-Overall-targets-number-of-datasets) (下方图) 为图VR Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/VR-Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/VR-Overall-targets-number-of-datasets.pdf}
\caption{VR Overall targets number of datasets}\label{fig:VR-Overall-targets-number-of-datasets}
\end{center}

 
`VR targets of datasets' 数据已全部提供。

**(对应文件为 `Figure+Table/VR-targets-of-datasets`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/VR-targets-of-datasets共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_t.pharm.csv
\item 2\_t.dis.csv
\item 3\_t.genecard.csv
\end{enumerate}\end{tcolorbox}
\end{center}



### 败血性肺损伤 (septic lung injury, SLI)  GEO {#sli}

#### DEGs-mice

Figure \@ref(fig:SLI-Model-vs-Control-DEGs) (下方图) 为图SLI Model vs Control DEGs概览。

**(对应文件为 `Figure+Table/SLI-Model-vs-Control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SLI-Model-vs-Control-DEGs.pdf}
\caption{SLI Model vs Control DEGs}\label{fig:SLI-Model-vs-Control-DEGs}
\end{center}

Table \@ref(tab:SLI-data-Model-vs-Control-DEGs) (下方表格) 为表格SLI data Model vs Control DEGs概览。

**(对应文件为 `Figure+Table/SLI-data-Model-vs-Control-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3242行7列，以下预览的表格可能省略部分数据；表格含有3242个唯一`rownames'。
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

Table: (\#tab:SLI-data-Model-vs-Control-DEGs)SLI data Model vs Control DEGs

|rownames |logFC         |AveExpr       |t             |P.Value       |adj.P.Val     |B             |
|:--------|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|Clec3b   |-1.9848536... |7.33363889... |-17.498042... |7.86788380... |2.40662829... |12.2053789... |
|Akr1c14  |2.81261598... |8.11883664... |15.3675634... |3.45102470... |3.90133653... |11.0637187... |
|Postn    |-1.7034833... |9.91717469... |-15.228085... |3.82634026... |3.90133653... |10.9810734... |
|Gm13749  |-2.2052006... |2.83326873... |-14.209839... |8.35339935... |5.48966386... |10.3444807... |
|Saa3     |6.85486850... |10.8792202... |14.1195879... |8.97355804... |5.48966386... |10.2850970... |
|Ifitm6   |4.80701587... |9.89669026... |13.8796505... |1.08773578... |5.54527703... |10.1247543... |
|Il1r2    |4.40115929... |7.69398107... |13.5044213... |1.47848787... |6.01193210... |9.86660629... |
|Gpr153   |-1.6801679... |8.62129465... |-13.430255... |1.57236356... |6.01193210... |9.81448518... |
|Col16a1  |-1.4026272... |7.91707219... |-13.287008... |1.77240443... |6.02381186... |9.71276692... |
|Fgfr4    |-2.6504553... |6.15492443... |-13.121581... |2.03819307... |6.03742187... |9.59355318... |
|Fcgr4    |2.77105360... |8.56146562... |13.0473547... |2.17116649... |6.03742187... |9.53944390... |
|Itgam    |3.15398369... |10.0245737... |12.6817126... |2.97807344... |7.59110922... |9.26717907... |
|Ces2e    |-2.6636707... |2.86681445... |-12.575583... |3.26902738... |7.69176996... |9.18633199... |
|Scube2   |-2.6771258... |6.83822578... |-12.405540... |3.80107102... |8.30479717... |9.05504426... |
|Tgfbi    |1.55482395... |10.2352866... |12.1160976... |4.93388623... |0.00010061... |8.82648927... |
|...      |...           |...           |...           |...           |...           |...           |



#### DEGs-human

使用 Biomart 将 mice 基因 (mgi symbol) 映射为 human 基因名 (hgnc symbol)

Table \@ref(tab:SLI-Genes-mapping) (下方表格) 为表格SLI Genes mapping概览。

**(对应文件为 `Figure+Table/SLI-Genes-mapping.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2471行8列，以下预览的表格可能省略部分数据；表格含有2362个唯一`mgi\_symbol'。
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

Table: (\#tab:SLI-Genes-mapping)SLI Genes mapping

|mgi_sy... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |hgnc_s... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|Clec3b    |-1.984... |7.3336... |-17.49... |7.8678... |2.4066... |12.205... |CLEC3B    |
|Postn     |-1.703... |9.9171... |-15.22... |3.8263... |3.9013... |10.981... |POSTN     |
|Ifitm6    |4.8070... |9.8966... |13.879... |1.0877... |5.5452... |10.124... |IFITM1    |
|Ifitm6    |4.8070... |9.8966... |13.879... |1.0877... |5.5452... |10.124... |IFITM3    |
|Ifitm6    |4.8070... |9.8966... |13.879... |1.0877... |5.5452... |10.124... |IFITM2    |
|Gpr153    |-1.680... |8.6212... |-13.43... |1.5723... |6.0119... |9.8144... |GPR153    |
|Il1r2     |4.4011... |7.6939... |13.504... |1.4784... |6.0119... |9.8666... |IL1R2     |
|Col16a1   |-1.402... |7.9170... |-13.28... |1.7724... |6.0238... |9.7127... |COL16A1   |
|Fcgr4     |2.7710... |8.5614... |13.047... |2.1711... |6.0374... |9.5394... |FCGR3B    |
|Fcgr4     |2.7710... |8.5614... |13.047... |2.1711... |6.0374... |9.5394... |FCGR3A    |
|Fgfr4     |-2.650... |6.1549... |-13.12... |2.0381... |6.0374... |9.5935... |FGFR4     |
|Itgam     |3.1539... |10.024... |12.681... |2.9780... |7.5911... |9.2671... |ITGAM     |
|Ces2e     |-2.663... |2.8668... |-12.57... |3.2690... |7.6917... |9.1863... |CES2      |
|Scube2    |-2.677... |6.8382... |-12.40... |3.8010... |8.3047... |9.0550... |SCUBE2    |
|Tgfbi     |1.5548... |10.235... |12.116... |4.9338... |0.0001... |8.8264... |TGFBI     |
|...       |...       |...       |...       |...       |...       |...       |...       |



## 糖酵解 (Glycolysis, G)  {#gly}

Table \@ref(tab:Glycolysis-related-genes-from-genecards) (下方表格) 为表格Glycolysis related genes from genecards概览。

**(对应文件为 `Figure+Table/Glycolysis-related-genes-from-genecards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1362行7列，以下预览的表格可能省略部分数据；表格含有1362个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Glycolysis-related-genes-from-genecards)Glycolysis related genes from genecards

|Symbol |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|TIGAR  |TP53 Induc... |Protein Co... |Q9NQ88     |42    |GC12P033681 |22.41 |
|PKM    |Pyruvate K... |Protein Co... |P14618     |53    |GC15M072199 |19.66 |
|HK2    |Hexokinase 2  |Protein Co... |P52789     |50    |GC02P074833 |19.44 |
|GAPDH  |Glyceralde... |Protein Co... |P04406     |54    |GC12P033726 |17.19 |
|LDHA   |Lactate De... |Protein Co... |P00338     |54    |GC11P018394 |15.83 |
|RRAD   |RRAD, Ras ... |Protein Co... |P55042     |42    |GC16M067144 |15.10 |
|HIF1A  |Hypoxia In... |Protein Co... |Q16665     |52    |GC14P061695 |14.96 |
|HK1    |Hexokinase 1  |Protein Co... |P19367     |53    |GC10P069269 |14.28 |
|ENO3   |Enolase 3     |Protein Co... |P13929     |51    |GC17P004948 |13.56 |
|TPI1   |Triosephos... |Protein Co... |P60174     |51    |GC12P006867 |13.21 |
|ENO1   |Enolase 1     |Protein Co... |P06733     |51    |GC01M008861 |13.07 |
|GLTC1  |Glycolysis... |RNA Gene      |           |2     |GC11U909607 |12.97 |
|PFKP   |Phosphofru... |Protein Co... |Q01813     |49    |GC10P003066 |12.85 |
|PGK1   |Phosphogly... |Protein Co... |P00558     |53    |GC0XP078104 |12.76 |
|GCK    |Glucokinase   |Protein Co... |P35557     |53    |GC07M044978 |12.38 |
|...    |...           |...           |...        |...   |...         |...   |



## 基因集 (Filtered-DEGs)

Figure \@ref(fig:Filtered-DEGs-intersection) (下方图) 为图Filtered DEGs intersection概览。

**(对应文件为 `Figure+Table/Filtered-DEGs-intersection.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filtered-DEGs-intersection.pdf}
\caption{Filtered DEGs intersection}\label{fig:Filtered-DEGs-intersection}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    SPHK1, COL4A5, HSPA4, PARP1, RUVBL2, TNFAIP3, PPBP,
MYH10, RAB4B-EGLN2, ANGPTL4, INSR, HMGA2, KDR, TNFSF10,
WWTR1, PARK7, HIF1AN, TKT, CA9, TRAF6, CASP1, AHR, NR4A1,
CHUK, MUC1, ROCK1, CDK2, TSC1, IRS1, PRKACA, MDM2

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Filtered-DEGs-intersection-content`)**



## 富集分析

### SLI-DEGs

Figure \@ref(fig:KEGG-enrichment-with-enriched-genes) (下方图) 为图KEGG enrichment with enriched genes概览。

**(对应文件为 `Figure+Table/KEGG-enrichment-with-enriched-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/KEGG-enrichment-with-enriched-genes.pdf}
\caption{KEGG enrichment with enriched genes}\label{fig:KEGG-enrichment-with-enriched-genes}
\end{center}



### Filtered-DEGs (FDEGs)

Figure \@ref(fig:FDEGS-ids-KEGG-enrichment) (下方图) 为图FDEGS ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/FDEGS-ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FDEGS-ids-KEGG-enrichment.pdf}
\caption{FDEGS ids KEGG enrichment}\label{fig:FDEGS-ids-KEGG-enrichment}
\end{center}

Figure \@ref(fig:FDEGS-ids-GO-enrichment) (下方图) 为图FDEGS ids GO enrichment概览。

**(对应文件为 `Figure+Table/FDEGS-ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FDEGS-ids-GO-enrichment.pdf}
\caption{FDEGS ids GO enrichment}\label{fig:FDEGS-ids-GO-enrichment}
\end{center}



## PPI

Figure \@ref(fig:PPI-of-Filtered-DEGs) (下方图) 为图PPI of Filtered DEGs概览。

**(对应文件为 `Figure+Table/PPI-of-Filtered-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-of-Filtered-DEGs.pdf}
\caption{PPI of Filtered DEGs}\label{fig:PPI-of-Filtered-DEGs}
\end{center}



## 蛋白互作模拟 {#docking}

使用了两种方法模拟对接 (LZerD 的服务器目前还没有出结果 (运行太久了)；HawkDock 的结果已出，已整理) 

- Results (可以到如下网址查看结果):
    - LZerD: <https://lzerd.kiharalab.org/view/b6748c34192e445686eec93fd455ce7a>
    - HawkDock: <http://cadd.zju.edu.cn/hawkdock/result/liwenhua-1704765524163>



### HawkDock results

Figure \@ref(fig:HawkDock-ranking-of-all-top-10-docking) (下方图) 为图HawkDock ranking of all top 10 docking概览。

**(对应文件为 `Figure+Table/HawkDock-ranking-of-all-top-10-docking.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HawkDock-ranking-of-all-top-10-docking.pdf}
\caption{HawkDock ranking of all top 10 docking}\label{fig:HawkDock-ranking-of-all-top-10-docking}
\end{center}

Figure \@ref(fig:HawkDock-docking-top-1) (下方图) 为图HawkDock docking top 1概览。

**(对应文件为 `Figure+Table/MYC..7T1Y_with_KIF2C..2HEH_top1.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/MYC..7T1Y_with_KIF2C..2HEH_top1.png}
\caption{HawkDock docking top 1}\label{fig:HawkDock-docking-top-1}
\end{center}

Figure \@ref(fig:HawkDock-docking-top-4) (下方图) 为图HawkDock docking top 4概览。

**(对应文件为 `Figure+Table/MYC..7T1Y_with_KIF2C..2HEH_top4.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/MYC..7T1Y_with_KIF2C..2HEH_top4.png}
\caption{HawkDock docking top 4}\label{fig:HawkDock-docking-top-4}
\end{center}



# 附：修改分析 {#revise}

## Sepsis

使用 GSE236713。

Figure \@ref(fig:SEPSIS-Sepsis-vs-Control-DEGs) (下方图) 为图SEPSIS Sepsis vs Control DEGs概览。

**(对应文件为 `Figure+Table/SEPSIS-Sepsis-vs-Control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SEPSIS-Sepsis-vs-Control-DEGs.pdf}
\caption{SEPSIS Sepsis vs Control DEGs}\label{fig:SEPSIS-Sepsis-vs-Control-DEGs}
\end{center}

Table \@ref(tab:SEPSIS-data-Sepsis-vs-Control-DEGs) (下方表格) 为表格SEPSIS data Sepsis vs Control DEGs概览。

**(对应文件为 `Figure+Table/SEPSIS-data-Sepsis-vs-Control-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有40559行8列，以下预览的表格可能省略部分数据；表格含有27040个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:SEPSIS-data-Sepsis-vs-Control-DEGs)SEPSIS data Sepsis vs Control DEGs

|rownames  |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |hgnc_s... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|A_23_P... |4.4138... |-0.408... |15.554... |5.4751... |2.7780... |75.512... |GRB10     |
|A_23_P... |3.9264... |-0.641... |15.406... |1.7125... |4.3445... |74.392... |PPARG     |
|A_33_P... |3.0600... |-0.447... |15.097... |1.8367... |3.1064... |72.060... |SYN2      |
|A_32_P... |4.9582... |-1.145... |14.709... |3.6446... |4.6231... |69.122... |FAM20A    |
|A_23_P... |3.2638... |-0.519... |14.601... |8.3719... |8.4956... |68.305... |ADM       |
|A_33_P... |5.8744... |-0.928... |14.345... |5.9868... |5.0627... |66.370... |ARG1      |
|A_23_P... |1.5869... |-0.260... |14.166... |2.3797... |1.7249... |65.013... |VDR       |
|A_23_P... |-2.156... |0.1492... |-14.14... |2.8133... |1.7843... |64.848... |FAIM3     |
|A_24_P... |-1.676... |0.1891... |-14.12... |3.1890... |1.7978... |64.725... |STMN3     |
|A_33_P... |2.1379... |-0.230... |13.976... |1.0246... |5.1989... |63.577... |PDLIM7    |
|A_24_P... |1.9611... |-0.231... |13.889... |1.9828... |9.1462... |62.928... |FGD4      |
|A_23_P... |4.2098... |-0.526... |13.857... |2.5493... |1.0779... |62.681... |GALNT14   |
|A_24_P... |-1.893... |0.2011... |-13.84... |2.8803... |1.1241... |62.561... |BCL9L     |
|A_24_P... |3.5706... |-0.437... |13.794... |4.1290... |1.4964... |62.206... |GRB10     |
|A_23_P... |1.9126... |-0.255... |13.728... |6.8477... |2.3163... |61.709... |SLC22A15  |
|...       |...       |...       |...       |...       |...       |...       |...       |



## Vascular Remodeling

相比于 \@ref(vr) 重设了阈值 (GeneCards Score &gt; 1) ，获取更多结果。

Figure \@ref(fig:VR-Overall-targets-number-of-datasets-2) (下方图) 为图VR Overall targets number of datasets 2概览。

**(对应文件为 `Figure+Table/VR-Overall-targets-number-of-datasets-2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/VR-Overall-targets-number-of-datasets-2.pdf}
\caption{VR Overall targets number of datasets 2}\label{fig:VR-Overall-targets-number-of-datasets-2}
\end{center}

 
`VR targets of datasets 2' 数据已全部提供。

**(对应文件为 `Figure+Table/VR-targets-of-datasets-2`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/VR-targets-of-datasets-2共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_t.pharm.csv
\item 2\_t.dis.csv
\item 3\_t.genecard.csv
\end{enumerate}\end{tcolorbox}
\end{center}





## Glycolysis

相比于 \@ref(gly) 重设了阈值 (GeneCards Score &gt; 0) ，获取更多结果。

Table \@ref(tab:Glycolysis-related-genes-from-genecards-2) (下方表格) 为表格Glycolysis related genes from genecards 2概览。

**(对应文件为 `Figure+Table/Glycolysis-related-genes-from-genecards-2.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3986行7列，以下预览的表格可能省略部分数据；表格含有3986个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Glycolysis-related-genes-from-genecards-2)Glycolysis related genes from genecards 2

|Symbol |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|TIGAR  |TP53 Induc... |Protein Co... |Q9NQ88     |42    |GC12P033681 |22.41 |
|PKM    |Pyruvate K... |Protein Co... |P14618     |53    |GC15M072199 |19.66 |
|HK2    |Hexokinase 2  |Protein Co... |P52789     |50    |GC02P074833 |19.44 |
|GAPDH  |Glyceralde... |Protein Co... |P04406     |54    |GC12P033726 |17.19 |
|LDHA   |Lactate De... |Protein Co... |P00338     |54    |GC11P018394 |15.83 |
|RRAD   |RRAD, Ras ... |Protein Co... |P55042     |42    |GC16M067144 |15.10 |
|HIF1A  |Hypoxia In... |Protein Co... |Q16665     |52    |GC14P061695 |14.96 |
|HK1    |Hexokinase 1  |Protein Co... |P19367     |53    |GC10P069269 |14.28 |
|ENO3   |Enolase 3     |Protein Co... |P13929     |51    |GC17P004948 |13.56 |
|TPI1   |Triosephos... |Protein Co... |P60174     |51    |GC12P006867 |13.21 |
|ENO1   |Enolase 1     |Protein Co... |P06733     |51    |GC01M008861 |13.07 |
|GLTC1  |Glycolysis... |RNA Gene      |           |2     |GC11U909607 |12.97 |
|PFKP   |Phosphofru... |Protein Co... |Q01813     |49    |GC10P003066 |12.85 |
|PGK1   |Phosphogly... |Protein Co... |P00558     |53    |GC0XP078104 |12.76 |
|GCK    |Glucokinase   |Protein Co... |P35557     |53    |GC07M044978 |12.38 |
|...    |...           |...           |...        |...   |...         |...   |



## 基因集 (Filtered-DEGs2)

Figure \@ref(fig:Filtered-DEGs-intersection-2) (下方图) 为图Filtered DEGs intersection 2概览。

**(对应文件为 `Figure+Table/Filtered-DEGs-intersection-2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Filtered-DEGs-intersection-2.pdf}
\caption{Filtered DEGs intersection 2}\label{fig:Filtered-DEGs-intersection-2}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    PPARG, ADM, ARG1, PDLIM7, SLPI, UBE2C, MMP9, SLC8A1,
S100A8, SLC16A3, IL10, SLC2A14, ADAM10, CBS, TLR2, GSN,
LDHB, AMPD3, GLA, SLC1A3, TRPM2, TET2, ATP6V0A1, SRSF7,
PYGL, INHBA, WASF1, FOXP1, HP, HMGB3, LMNB1, RUNX3, PRPS1,
DYSF, RETN, SMARCD3, SIRT7, NDRG2, DNAJA3, ASPH, RPL13A,
TLR4, ATM, EPAS1...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Filtered-DEGs-intersection-2-content`)**



## 富集分析

### Filtered-DEGs2 (FDEGs2)

Figure \@ref(fig:FDEGS2-ids-KEGG-enrichment) (下方图) 为图FDEGS2 ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/FDEGS2-ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FDEGS2-ids-KEGG-enrichment.pdf}
\caption{FDEGS2 ids KEGG enrichment}\label{fig:FDEGS2-ids-KEGG-enrichment}
\end{center}

Figure \@ref(fig:FDEGS2-ids-GO-enrichment) (下方图) 为图FDEGS2 ids GO enrichment概览。

**(对应文件为 `Figure+Table/FDEGS2-ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FDEGS2-ids-GO-enrichment.pdf}
\caption{FDEGS2 ids GO enrichment}\label{fig:FDEGS2-ids-GO-enrichment}
\end{center}



## PPI

Figure \@ref(fig:PPI-of-Filtered-DEGs2) (下方图) 为图PPI of Filtered DEGs2概览。

**(对应文件为 `Figure+Table/PPI-of-Filtered-DEGs2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-of-Filtered-DEGs2.pdf}
\caption{PPI of Filtered DEGs2}\label{fig:PPI-of-Filtered-DEGs2}
\end{center}




