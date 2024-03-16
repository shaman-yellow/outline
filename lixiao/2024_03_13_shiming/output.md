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
养阴通脑颗粒中关键成分对脑缺血再灌注的影响}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-15}}
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

- 养阴通脑颗粒中治疗脑缺血再灌注的关键成分及相应信号通路（信号通路需要创新性的），1-3条
- 同时重点分析水蛭素对应的治疗脑缺血再灌注的信号通路

养阴通脑颗粒：地黄15g、黄芪15g、葛根18g、石斛15g、水蛭3g、川芎9g

## 结果

### 整体复方

- 常规网络药理学，见 Fig. \@ref(fig:Network-pharmacology-with-disease), 富集结果见 Fig. \@ref(fig:HERBS-KEGG-enrichment)
- 额外对 CIR 的 GEO 数据差异分析，富集结果 Fig. \@ref(fig:MAP-KEGG-enrichment)
- 综合以上富集，发现 MARK 通路 (Fig. \@ref(fig:HERBS-hsa04010-visualization)) 可能是治疗的关键通路之一，其靶向成分见 Tab. \@ref(tab:Network-pharmacology-target-MARK-data)

### 权衡 Hirudin 的作用

HERBs 数据库 (其他数据库也是如此) 包含的 Hirudin 靶点较少。
这里，额外从 GeneCards 获取了 Hirudin 的靶点 (Tab. \@ref(tab:Hirudin-targets-from-GeneCards))。

为了缩小可选通路范围，这里尝试将以下的富集结果取共同的交集 (已在上述部分完成) ：

- 复方靶向 CIR (靶点来源见 Fig. \@ref(fig:Overall-targets-number-of-datasets)) 的通路
  (富集见 Fig. \@ref(fig:HERBS-KEGG-enrichment))
- GEO 数据集 (GSE163614) CIR DEGs 的富集结果的通路 (富集见 Fig. \@ref(fig:MAP-KEGG-enrichment))
- 获取了更多靶点信息 (因为 HERBS 数据库或其他数据库包含的靶点信息太少，不利于分析) 的 Hirudin 靶向 CIR (GEO DEGs) 的基因的富集分析  (Fig. \@ref(fig:HIRUDIN-CIR-KEGG-enrichment)) 

得到 (去除了名称包含其他疾病的通路)：Tab. \@ref(tab:All-pathways-intersection)

- HIF-1 signaling pathway
- Apelin signaling pathway

更多信息见 \@ref(he-t) 和 \@ref(hi-t)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE163614**: Examination of MCAO/R and Sham rat brain samples（n=3）

## 方法

Mainly used method:

- The `BindingDB` database was used for discovering association between Ligands and Receptors[@BindingdbIn20Gilson2016].
- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- Website `HERB` <http://herb.ac.cn/> used for data source[@HerbAHighThFang2021].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `PubChemR` used for querying compounds information.
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- Web tool of `Super-PRED` used for drug-targets relationship prediction[@SuperpredUpdaNickel2014].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- R package `UniProt.ws` used for querying Gene or Protein information.
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 养阴通脑颗粒

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行18列，以下预览的表格可能省略部分数据；表格含有6个唯一`Herb\_'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Herb_     |Herb_p... |Herb_c... |Herb_e... |Herb_l... |Proper... |Meridians |UsePart   |Function  |Indica... |... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---|
|HERB00... |CHUAN ... |川芎      |Chuanx... |Radix ... |Warm; ... |Liver;... |rhizome   |1. To ... |Cerebr... |... |
|HERB00... |DI HUANG  |地黄      |Radix ... |NA        |NA        |NA        |NA        |NA        |NA        |... |
|HERB00... |GE GEN    |葛根      |root o... |Radix ... |Cool; ... |Spleen... |tuberoid  |To rel... |Angina... |... |
|HERB00... |HUANG QI  |黄芪      |root o... |Radix ... |Warm; ... |Lung; ... |root      |To rei... |Common... |... |
|HERB00... |SHI HU    |石斛      |Dendro... |Herba ... |Minor ... |Stomac... |Dendro... |Treatm... |1. Den... |... |
|HERB00... |SHUI ZHI  |水蛭      |Bigflo... |Garden... |Mild; ... |Liver     |fruit     |To cle... |Heat t... |... |

Table \@ref(tab:Components-of-Herbs) (下方表格) 为表格Components of Herbs概览。

**(对应文件为 `Figure+Table/Components-of-Herbs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有725行4列，以下预览的表格可能省略部分数据；表格含有696个唯一`Ingredient.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Components-of-Herbs)Components of Herbs

|herb_id    |Ingredient.id |Ingredient.name      |Ingredient.alias     |
|:----------|:-------------|:--------------------|:--------------------|
|HERB002560 |HBIN001244    |13-hydroxy-9,11-o... |NA                   |
|HERB002560 |HBIN002016    |1,7-Dihydroxy-3,9... |1,7-dihydroxy-3,9... |
|HERB002560 |HBIN003405    |20-Hexadecanoylin... |20-hexadecanoylin... |
|HERB002560 |HBIN003436    |20(r)-21,24-cyclo... |20(r)-21,24-cyclo... |
|HERB002560 |HBIN004319    |2&apos;,4&apos; -... |2&apos;, 4&apos;-... |
|HERB002560 |HBIN005731    |2&apos;-hydroxy-3    |NA                   |
|HERB002560 |HBIN005735    |2&apos;-hydroxy-3... |NA                   |
|HERB002560 |HBIN005744    |2-hydroxy-3-metho... |NA                   |
|HERB002560 |HBIN006143    |2-Nonyl acetate      |ANW-21203; SCHEMB... |
|HERB002560 |HBIN006743    |(2S)-4-methoxy-7-... |(2S)-4-methoxy-7-... |
|HERB002560 |HBIN007657    |3,5-dimethoxystil... |78916-49-1; TR-03... |
|HERB002560 |HBIN007848    |3,9-di-O-methylni... |NA                   |
|HERB002560 |HBIN008647    |3-Hydroxy-2-picoline |BTB 09012; 3-Hydr... |
|HERB002560 |HBIN008667    |3&apos;-hydroxy-4... |NA                   |
|HERB002560 |HBIN008668    |3&apos;-Hydroxy-4... |3-(3-hydroxy-4-me... |
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

### 成分靶点

Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/tables-of-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有13356行9列，以下预览的表格可能省略部分数据；表格含有696个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target... |Databa... |Paper.id |... |
|:-------------|:---------|:-------------|:-------------|:---------|:---------|:---------|:--------|:---|
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ATIC      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |FPGS      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |GART      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD1    |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD2    |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ALDH1L1   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD1L   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTFMT     |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ALDH1L2   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD2L   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10β,13...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |CHUAN ... |10-(be...     |10-(β-...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |CHUAN ... |1,1-Di...     |3658-9...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |CHUAN ... |1,2,3,...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |CHUAN ... |1,3,8-...     |1,3,8-...     |HBTAR0... |ACHE      |NA        |NA       |... |
|...           |...       |...           |...           |...       |...       |...       |...      |... |

### 脑缺血再灌注 cerebral ischemia reperfusion (CIR) 靶点

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

    cerebral ischemia reperfusion

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
\end{center}Table \@ref(tab:CIR-GeneCards-used-data) (下方表格) 为表格CIR GeneCards used data概览。

**(对应文件为 `Figure+Table/CIR-GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有139行7列，以下预览的表格可能省略部分数据；表格含有139个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:CIR-GeneCards-used-data)CIR GeneCards used data

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|BDNF-AS  |BDNF Antis... |RNA Gene      |           |28    |GC11P027466 |11.94 |
|CERNA3   |Competing ... |RNA Gene      |           |19    |GC08P056101 |6.64  |
|MEG3     |Maternally... |RNA Gene      |           |34    |GC14P115583 |6.13  |
|SNHG12   |Small Nucl... |RNA Gene      |Q9BXW3     |29    |GC01M030655 |6.06  |
|MIR211   |MicroRNA 211  |RNA Gene      |           |28    |GC15M031065 |5.85  |
|SNHG14   |Small Nucl... |RNA Gene      |           |24    |GC15P147532 |5.69  |
|SOD2-OT1 |SOD2 Overl... |RNA Gene      |           |18    |GC06M159772 |5.41  |
|H19      |H19 Imprin... |RNA Gene      |           |34    |GC11M001995 |4.64  |
|GAS5     |Growth Arr... |RNA Gene      |           |30    |GC01M173947 |4.56  |
|TUG1     |Taurine Up... |Protein Co... |A0A6I8PU40 |32    |GC22P030969 |4.15  |
|MIR496   |MicroRNA 496  |RNA Gene      |           |16    |GC14P115621 |4.07  |
|BCL2     |BCL2 Apopt... |Protein Co... |P10415     |59    |GC18M063123 |3.7   |
|MIR532   |MicroRNA 532  |RNA Gene      |           |23    |GC0XP056752 |3.7   |
|SCARNA5  |Small Caja... |RNA Gene      |           |23    |GC02P233275 |3.7   |
|NFE2L2   |NFE2 Like ... |Protein Co... |Q16236     |60    |GC02M177227 |3.64  |
|...      |...           |...           |...        |...   |...         |...   |

### 网络药理-疾病

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

    IL10, HMOX1, MMP9, PTGS2, SOD2, MPO, NOS2, IL6, CAT,
CXCL2, TLR4, ALOX5, RELA, CCL2, CASP3, SELE, XDH, FOS,
EDN1, TLR2, PLAT, PTEN, MAPK8, PPARA, CDKN1A, KDR, ADORA2A,
CXCL1, PLAU, BCL2, SOD1, PPARG, NOS3, TNF, IL1B, MAPK9,
ICAM1, TERT, JUN, ADORA2B, EFNB2, HGF, CD36, IRAK3, SLPI,
IL12A, CXCL8, C...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**

### PPI 网络

Figure \@ref(fig:HERBS-raw-PPI-network) (下方图) 为图HERBS raw PPI network概览。

**(对应文件为 `Figure+Table/HERBS-raw-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HERBS-raw-PPI-network.pdf}
\caption{HERBS raw PPI network}\label{fig:HERBS-raw-PPI-network}
\end{center}

Figure \@ref(fig:HERBS-Top30-MCC-score) (下方图) 为图HERBS Top30 MCC score概览。

**(对应文件为 `Figure+Table/HERBS-Top30-MCC-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HERBS-Top30-MCC-score.pdf}
\caption{HERBS Top30 MCC score}\label{fig:HERBS-Top30-MCC-score}
\end{center}

### 富集分析 (Top30)

Figure \@ref(fig:HERBS-KEGG-enrichment) (下方图) 为图HERBS KEGG enrichment概览。

**(对应文件为 `Figure+Table/HERBS-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HERBS-KEGG-enrichment.pdf}
\caption{HERBS KEGG enrichment}\label{fig:HERBS-KEGG-enrichment}
\end{center}

Table \@ref(tab:HERBS-KEGG-enrichment-data) (下方表格) 为表格HERBS KEGG enrichment data概览。

**(对应文件为 `Figure+Table/HERBS-KEGG-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有181行9列，以下预览的表格可能省略部分数据；表格含有181个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:HERBS-KEGG-enrichment-data)HERBS KEGG enrichment data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa05167 |Kaposi... |19/29     |194/8661 |3.0530... |5.5259... |1.0605... |207/59... |19    |
|hsa05212 |Pancre... |14/29     |76/8661  |3.1769... |2.8751... |5.5178... |207/59... |14    |
|hsa05205 |Proteo... |17/29     |205/8661 |4.7725... |2.8794... |5.5261... |207/85... |17    |
|hsa05418 |Fluid ... |15/29     |139/8661 |3.5822... |1.6209... |3.1109... |207/85... |15    |
|hsa05161 |Hepati... |15/29     |162/8661 |3.8556... |1.3957... |2.6786... |207/13... |15    |
|hsa05208 |Chemic... |16/29     |223/8661 |1.1000... |3.3185... |6.3688... |207/19... |16    |
|hsa04917 |Prolac... |12/29     |70/8661  |1.3458... |3.4799... |6.6785... |207/59... |12    |
|hsa04933 |AGE-RA... |13/29     |100/8661 |1.6908... |3.8255... |7.3418... |207/59... |13    |
|hsa04010 |MAPK s... |17/29     |301/8661 |3.5870... |7.2139... |1.3844... |207/13... |17    |
|hsa05210 |Colore... |12/29     |86/8661  |1.8784... |3.4000... |6.5252... |207/59... |12    |
|hsa05235 |PD-L1 ... |12/29     |89/8661  |2.9003... |4.4268... |8.4958... |207/19... |12    |
|hsa05417 |Lipid ... |15/29     |215/8661 |2.9349... |4.4268... |8.4958... |207/23... |15    |
|hsa04151 |PI3K-A... |17/29     |359/8661 |7.1506... |9.9559... |1.9106... |207/13... |17    |
|hsa01522 |Endocr... |12/29     |98/8661  |9.7631... |1.2622... |2.4224... |207/59... |12    |
|hsa01521 |EGFR t... |11/29     |79/8661  |5.3600... |6.2132... |1.1924... |207/19... |11    |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |

### CIR 的 GEO 数据差异分析

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE163614

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    paired-end reads were harvested from Illumina NovaSeq
6000 sequencer, and were quality controlled by Q30.

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    After 3’ adaptor-trimming and low quality reads
removing by cutadapt software (v1.9.3), the high quality
trimmed reads were aligned to the rat reference genome
(UCSC RN5).

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    Then, guided by the Ensembl gtf gene annotation file
with hisat2 software (v2.0.4), cuffdiff software (v2.2.1,
part of cufflinks) was used to get the gene level FPKM as
the expression profiles of mRNA, and fold change and
p-value were calculated based on FPKM, differentially
expressed mRNA were i...

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    Genome\_build: UCSC RN5

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}

Table \@ref(tab:RAT-metadata) (下方表格) 为表格RAT metadata概览。

**(对应文件为 `Figure+Table/RAT-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行9列，以下预览的表格可能省略部分数据；表格含有6个唯一`sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:RAT-metadata)RAT metadata

|sample |group   |lib.size  |norm.f... |rownames  |title    |strain... |time.p... |tissue... |
|:------|:-------|:---------|:---------|:---------|:--------|:---------|:---------|:---------|
|MCAO1  |Model   |523780... |1         |GSM498... |MCAO/R-1 |Spragu... |24 h      |brain     |
|MCAO2  |Model   |531002... |1         |GSM498... |MCAO/R-2 |Spragu... |24 h      |brain     |
|MCAO3  |Model   |582734... |1         |GSM498... |MCAO/R-3 |Spragu... |24 h      |brain     |
|Sham1  |Control |599207... |1         |GSM498... |Sham-1   |Spragu... |24 h      |brain     |
|Sham2  |Control |585317... |1         |GSM498... |Sham-2   |Spragu... |24 h      |brain     |
|Sham3  |Control |588288... |1         |GSM498... |Sham-3   |Spragu... |24 h      |brain     |

#### 差异分析

Figure \@ref(fig:RAT-Model-vs-Control-DEGs) (下方图) 为图RAT Model vs Control DEGs概览。

**(对应文件为 `Figure+Table/RAT-Model-vs-Control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/RAT-Model-vs-Control-DEGs.pdf}
\caption{RAT Model vs Control DEGs}\label{fig:RAT-Model-vs-Control-DEGs}
\end{center}

#### 由大鼠基因映射到人类基因

使用 biomart 将基因映射。

Table \@ref(tab:RAT-Mapped-DEGs) (下方表格) 为表格RAT Mapped DEGs概览。

**(对应文件为 `Figure+Table/RAT-Mapped-DEGs.tsv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2921行23列，以下预览的表格可能省略部分数据；表格含有2921个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item pathway:  相关通路。
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_id:  GENCODE/Ensembl gene ID
\item strand:  genomic strand
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:RAT-Mapped-DEGs)RAT Mapped DEGs

|hgnc_s... |rgd_sy... |rownames |gene_id   |gene_s... |biotype   |strand |locus     |Synonyms       |dbXrefs   |
|:---------|:---------|:--------|:---------|:---------|:---------|:------|:---------|:--------------|:---------|
|GPNMB     |Gpnmb     |4927     |ENSRNO... |Gpnmb     |protei... |+      |chr4:1... |-              |RGD:71... |
|PDPN      |Pdpn      |8530     |ENSRNO... |Pdpn      |protei... |-      |chr5:1... |E11&#124;Gp... |RGD:61... |
|STAT3     |Stat3     |11467    |ENSRNO... |Stat3     |protei... |-      |chr10:... |-              |RGD:37... |
|CNN3      |Cnn3      |6554     |ENSRNO... |Cnn3      |protei... |+      |chr2:2... |-              |RGD:71... |
|DDX21     |Ddx21     |18611    |ENSRNO... |Ddx21     |protei... |-      |chr20:... |Ddx21a...      |RGD:13... |
|FLNC      |Flnc      |4001     |ENSRNO... |Flnc      |protei... |+      |chr4:5... |ABP-L&#124;... |RGD:13... |
|IGFBP3    |Igfbp3    |4835     |ENSRNO... |Igfbp3    |protei... |-      |chr14:... |IGF-BP3        |RGD:28... |
|MMP9      |Mmp9      |10085    |ENSRNO... |Mmp9      |protei... |+      |chr3:1... |-              |RGD:62... |
|PDE10A    |Pde10a    |6404     |ENSRNO... |Pde10a    |protei... |-      |chr1:5... |Pde10a3        |RGD:68... |
|SBNO2     |Sbno2     |7959     |ENSRNO... |Sbno2     |protei... |+      |chr7:1... |RGD130...      |RGD:13... |
|SERPINA3  |Serpina3n |5928     |ENSRNO... |Serpina3n |protei... |+      |chr6:1... |CPi-26...      |RGD:37... |
|CSF2RB    |Csf2rb    |83       |ENSRNO... |Csf2rb    |protei... |+      |chr7:1... |Csf2rb1        |RGD:62... |
|FLNA      |Flna      |17331    |ENSRNO... |Flna      |protei... |+      |chr1:1... |RGD156...      |RGD:15... |
|LCP1      |Lcp1      |5808     |ENSRNO... |Lcp1      |protei... |+      |chr15:... |-              |RGD:13... |
|MAST3     |Mast3     |12964    |ENSRNO... |Mast3     |protei... |+      |chr16:... |-              |RGD:15... |
|...       |...       |...      |...       |...       |...       |...    |...       |...            |...       |

#### 富集分析

Figure \@ref(fig:MAP-KEGG-enrichment) (下方图) 为图MAP KEGG enrichment概览。

**(对应文件为 `Figure+Table/MAP-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MAP-KEGG-enrichment.pdf}
\caption{MAP KEGG enrichment}\label{fig:MAP-KEGG-enrichment}
\end{center}

Table \@ref(tab:MAP-KEGG-enrichment-data) (下方表格) 为表格MAP KEGG enrichment data概览。

**(对应文件为 `Figure+Table/MAP-KEGG-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有337行9列，以下预览的表格可能省略部分数据；表格含有337个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:MAP-KEGG-enrichment-data)MAP KEGG enrichment data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa04724 |Glutam... |57/1486   |115/8661 |9.1917... |3.0976... |1.6641... |107/19... |57    |
|hsa05033 |Nicoti... |27/1486   |40/8661  |2.0977... |3.5346... |1.8989... |773/77... |27    |
|hsa04010 |MAPK s... |98/1486   |301/8661 |2.5161... |2.8264... |1.5185... |10000/... |98    |
|hsa04727 |GABAer... |42/1486   |89/8661  |4.4346... |3.7361... |2.0072... |18/107... |42    |
|hsa05205 |Proteo... |73/1486   |205/8661 |9.9744... |6.7227... |3.6117... |60/71/... |73    |
|hsa05163 |Human ... |76/1486   |225/8661 |7.0361... |3.9519... |2.1231... |107/19... |76    |
|hsa04971 |Gastri... |36/1486   |76/8661  |9.5518... |4.5985... |2.4705... |60/71/... |36    |
|hsa04925 |Aldost... |42/1486   |98/8661  |1.8482... |7.7857... |4.1828... |107/19... |42    |
|hsa04510 |Focal ... |69/1486   |203/8661 |3.2209... |1.2060... |6.4794... |60/71/... |69    |
|hsa04933 |AGE-RA... |42/1486   |100/8661 |3.8738... |1.3054... |7.0136... |183/10... |42    |
|hsa04015 |Rap1 s... |70/1486   |210/8661 |6.3009... |1.8176... |9.7653... |60/71/... |70    |
|hsa05032 |Morphi... |39/1486   |91/8661  |7.0065... |1.8176... |9.7653... |107/19... |39    |
|hsa04360 |Axon g... |63/1486   |182/8661 |7.0117... |1.8176... |9.7653... |655/65... |63    |
|hsa04611 |Platel... |48/1486   |124/8661 |7.7305... |1.8608... |9.9974... |60/71/... |48    |
|hsa04670 |Leukoc... |45/1486   |115/8661 |1.5365... |3.4520... |1.8546... |60/71/... |45    |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |

可以发现，'MARK' 通路居于首位。以下展示 Fig. \@ref(fig:HERBS-KEGG-enrichment) 富集结果的 'MARK' 通路：

Figure \@ref(fig:HERBS-hsa04010-visualization) (下方图) 为图HERBS hsa04010 visualization概览。

**(对应文件为 `Figure+Table/hsa04010.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-14_14_08_35.864097/hsa04010.pathview.png}
\caption{HERBS hsa04010 visualization}\label{fig:HERBS-hsa04010-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04010}

\vspace{2em}
\end{tcolorbox}
\end{center}

### 复方靶点通路与 CIR DEGs 富集结果的共同富集通路

Table \@ref(tab:HERBS-pathways-intersection) (下方表格) 为表格HERBS pathways intersection概览。

**(对应文件为 `Figure+Table/HERBS-pathways-intersection.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有99行9列，以下预览的表格可能省略部分数据；表格含有99个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:HERBS-pathways-intersection)HERBS pathways intersection

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa05167 |Kaposi... |19/29     |194/8661 |3.0530... |5.5259... |1.0605... |207/59... |19    |
|hsa05212 |Pancre... |14/29     |76/8661  |3.1769... |2.8751... |5.5178... |207/59... |14    |
|hsa05205 |Proteo... |17/29     |205/8661 |4.7725... |2.8794... |5.5261... |207/85... |17    |
|hsa05418 |Fluid ... |15/29     |139/8661 |3.5822... |1.6209... |3.1109... |207/85... |15    |
|hsa05161 |Hepati... |15/29     |162/8661 |3.8556... |1.3957... |2.6786... |207/13... |15    |
|hsa04933 |AGE-RA... |13/29     |100/8661 |1.6908... |3.8255... |7.3418... |207/59... |13    |
|hsa04010 |MAPK s... |17/29     |301/8661 |3.5870... |7.2139... |1.3844... |207/13... |17    |
|hsa05210 |Colore... |12/29     |86/8661  |1.8784... |3.4000... |6.5252... |207/59... |12    |
|hsa05417 |Lipid ... |15/29     |215/8661 |2.9349... |4.4268... |8.4958... |207/23... |15    |
|hsa04151 |PI3K-A... |17/29     |359/8661 |7.1506... |9.9559... |1.9106... |207/13... |17    |
|hsa01522 |Endocr... |12/29     |98/8661  |9.7631... |1.2622... |2.4224... |207/59... |12    |
|hsa04510 |Focal ... |14/29     |203/8661 |5.4923... |6.2132... |1.1924... |207/85... |14    |
|hsa05207 |Chemic... |14/29     |212/8661 |1.0132... |1.0787... |2.0703... |207/13... |14    |
|hsa05163 |Human ... |14/29     |225/8661 |2.3412... |2.3542... |4.5181... |207/13... |14    |
|hsa04926 |Relaxi... |12/29     |129/8661 |2.9702... |2.8295... |5.4304... |207/13... |12    |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |

### 复方对 MARK 通路

Figure \@ref(fig:Network-pharmacology-target-MARK) (下方图) 为图Network pharmacology target MARK概览。

**(对应文件为 `Figure+Table/Network-pharmacology-target-MARK.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-target-MARK.pdf}
\caption{Network pharmacology target MARK}\label{fig:Network-pharmacology-target-MARK}
\end{center}

#### 复方作用于 MARK 通路的成分

Table \@ref(tab:Network-pharmacology-target-MARK-data) (下方表格) 为表格Network pharmacology target MARK data概览。

**(对应文件为 `Figure+Table/Network-pharmacology-target-MARK-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有297行3列，以下预览的表格可能省略部分数据；表格含有6个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Network-pharmacology-target-MARK-data)Network pharmacology target MARK data

|Herb_pinyin_name |Ingredient.name                |Target.name |
|:----------------|:------------------------------|:-----------|
|HUANG QI         |1,7-Dihydroxy-3,9-dimethoxy... |MAPK14      |
|CHUAN XIONG      |1-Acetyl-beta-carboline        |MAPK14      |
|CHUAN XIONG      |1-beta-ethylacrylate-7-alde... |MAPK14      |
|HUANG QI         |3,9-di-O-methylnissolin        |MAPK14      |
|CHUAN XIONG      |3-butylidene-phalide           |TP53        |
|GE GEN           |3&apos;-Methoxydaidzein        |MAPK14      |
|HUANG QI         |5&apos;-hydroxyiso-muronula... |RELA        |
|HUANG QI         |(6aR,11aR)-9,10-dimethoxy-6... |MAPK14      |
|GE GEN           |7,8,4&apos;-Trihydroxyisofl... |MAPK14      |
|HUANG QI         |7-O-methylisomucronulatol      |MAPK14      |
|HUANG QI         |acetic acid                    |FOS         |
|HUANG QI         |acetic acid                    |RELA        |
|HUANG QI         |acetic acid                    |FOS         |
|HUANG QI         |acetic acid                    |RELA        |
|HUANG QI         |adeninenucleoside              |FOS         |
|...              |...                            |...         |







## 水蛭素 Hirudin

### Hirudin 靶点 (获取更多靶点) 

HERBs 数据库包含的 Hirudin 靶点较少：

Table \@ref(tab:Hirudin-targets-in-HERB-database) (下方表格) 为表格Hirudin targets in HERB database概览。

**(对应文件为 `Figure+Table/Hirudin-targets-in-HERB-database.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行3列，以下预览的表格可能省略部分数据；表格含有1个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Hirudin-targets-in-HERB-database)Hirudin targets in HERB database

|Herb_pinyin_name |Ingredient.name |Target.name |
|:----------------|:---------------|:-----------|
|SHUI ZHI         |hirudin         |F2          |
|SHUI ZHI         |hirudin         |F3          |
|SHUI ZHI         |hirudin         |F5          |
|SHUI ZHI         |hirudin         |MIF         |



#### GeneCards 获取化合物靶点

bindingdb, drugbank, 以及预测工具 Super-Pred 等都难以获取更多关于 hirudin 靶点信息。
因此，这里使用 `GeneCards` 搜索。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    hirudin

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

    Score > 0

\vspace{2em}


\textbf{
Advance search:
:}

\vspace{0.5em}

    [compounds] ( hirudin )

\vspace{2em}
\end{tcolorbox}
\end{center}Table \@ref(tab:Hirudin-targets-from-GeneCards) (下方表格) 为表格Hirudin targets from GeneCards概览。

**(对应文件为 `Figure+Table/Hirudin-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有45行7列，以下预览的表格可能省略部分数据；表格含有45个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Hirudin-targets-from-GeneCards)Hirudin targets from GeneCards

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|F2       |Coagulatio... |Protein Co... |P00734     |58    |GC11P047386 |2.58  |
|F2R      |Coagulatio... |Protein Co... |P25116     |55    |GC05P076716 |2.23  |
|F10      |Coagulatio... |Protein Co... |P00742     |58    |GC13P113122 |1.76  |
|FGA      |Fibrinogen... |Protein Co... |P02671     |58    |GC04M154583 |1.76  |
|PLAT     |Plasminoge... |Protein Co... |P00750     |57    |GC08M042174 |1.76  |
|F3       |Coagulatio... |Protein Co... |P13726     |54    |GC01M094825 |1.76  |
|PLG      |Plasminogen   |Protein Co... |P00747     |58    |GC06P160702 |1.59  |
|CPA1     |Carboxypep... |Protein Co... |P15085     |51    |GC07P130380 |1.12  |
|PLAU     |Plasminoge... |Protein Co... |P00749     |60    |GC10P073909 |0.64  |
|SERPINE1 |Serpin Fam... |Protein Co... |P05121     |59    |GC07P101127 |0.64  |
|CCL2     |C-C Motif ... |Protein Co... |P13500     |58    |GC17P034255 |0.64  |
|CD40LG   |CD40 Ligand   |Protein Co... |P29965     |58    |GC0XP136649 |0.64  |
|CD55     |CD55 Molec... |Protein Co... |P08174     |58    |GC01P207321 |0.64  |
|SERPINC1 |Serpin Fam... |Protein Co... |P01008     |58    |GC01M174899 |0.64  |
|TBXA2R   |Thromboxan... |Protein Co... |P21731     |58    |GC19M003594 |0.64  |
|...      |...           |...           |...        |...   |...         |...   |

### Hirudin 靶点与 CIR DEGs 交集

Figure \@ref(fig:Intersection-of-Hirudin-Targets-with-CIR-DEGs) (下方图) 为图Intersection of Hirudin Targets with CIR DEGs概览。

**(对应文件为 `Figure+Table/Intersection-of-Hirudin-Targets-with-CIR-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-Hirudin-Targets-with-CIR-DEGs.pdf}
\caption{Intersection of Hirudin Targets with CIR DEGs}\label{fig:Intersection-of-Hirudin-Targets-with-CIR-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    PLAT, PLAU, SERPINE1, VWF, THBD, SELP, THBS1, TIMP1,
PLAUR, F2RL1, SELE, PROCR, FGL2, SCG5

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-Hirudin-Targets-with-CIR-DEGs-content`)**

#### 交集基因的富集分析

Figure \@ref(fig:HIRUDIN-CIR-KEGG-enrichment) (下方图) 为图HIRUDIN CIR KEGG enrichment概览。

**(对应文件为 `Figure+Table/HIRUDIN-CIR-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HIRUDIN-CIR-KEGG-enrichment.pdf}
\caption{HIRUDIN CIR KEGG enrichment}\label{fig:HIRUDIN-CIR-KEGG-enrichment}
\end{center}

#### 与复方共同作用的信号通路

因为在 Hirudin 的富集分析前，额外从 GeneCards 获取了 Hirudin 的靶点，这一部分在复方分析中是不包含的；
因此，这里尝试寻找它们共同的靶向通路 (复方与获取了额外靶点的 Hirudin 的共同富集通路)。

Table \@ref(tab:HIRUDIN-Herbs-pathways-intersection) (下方表格) 为表格HIRUDIN Herbs pathways intersection概览。

**(对应文件为 `Figure+Table/HIRUDIN-Herbs-pathways-intersection.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有7行9列，以下预览的表格可能省略部分数据；表格含有7个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:HIRUDIN-Herbs-pathways-intersection)HIRUDIN Herbs pathways intersection

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa04933 |AGE-RA... |3/12      |100/8661 |0.0003... |0.0034... |0.0018... |6401/5... |3     |
|hsa05418 |Fluid ... |3/12      |139/8661 |0.0008... |0.0068... |0.0035... |5327/6... |3     |
|hsa05205 |Proteo... |3/12      |205/8661 |0.0024... |0.0139... |0.0073... |5328/5... |3     |
|hsa04115 |p53 si... |2/12      |75/8661  |0.0046... |0.0224... |0.0118... |5054/7057 |2     |
|hsa05215 |Prosta... |2/12      |97/8661  |0.0076... |0.0287... |0.0151... |5327/5328 |2     |
|hsa04066 |HIF-1 ... |2/12      |109/8661 |0.0095... |0.0324... |0.0170... |5054/7076 |2     |
|hsa04371 |Apelin... |2/12      |139/8661 |0.0151... |0.0469... |0.0247... |5327/5054 |2     |



## 最终筛选 (着重考虑 Hirudin)

为了缩小可选通路范围，这里尝试将以下的富集结果取共同的交集 (已在上述部分完成) ：

- 复方靶向 CIR (靶点来源见 Fig. \@ref(fig:Overall-targets-number-of-datasets)) 的通路
  (富集见 Fig. \@ref(fig:HERBS-KEGG-enrichment))
- GEO 数据集 (GSE163614) CIR DEGs 的富集结果的通路 (富集见 Fig. \@ref(fig:MAP-KEGG-enrichment))
- 获取了更多靶点信息 (因为 HERBS 数据库或其他数据库包含的靶点信息太少，不利于分析) 的 Hirudin 靶向 CIR (GEO DEGs) 的基因的富集分析  (Fig. \@ref(fig:HIRUDIN-CIR-KEGG-enrichment)) 

得到 (去除了名称包含其他疾病的通路)：

Table \@ref(tab:All-pathways-intersection) (下方表格) 为表格All pathways intersection概览。

**(对应文件为 `Figure+Table/All-pathways-intersection.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2行9列，以下预览的表格可能省略部分数据；表格含有2个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:All-pathways-intersection)All pathways intersection

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa04066 |HIF-1 ... |11/29     |109/8661 |2.1482... |1.4400... |2.7637... |207/10... |11    |
|hsa04371 |Apelin... |3/29      |139/8661 |0.0108... |0.0141... |0.0027... |207/59... |3     |

### 复方对筛选通路的靶向 {#he-t}

Figure \@ref(fig:HERBS-hsa04066-visualization) (下方图) 为图HERBS hsa04066 visualization概览。

**(对应文件为 `Figure+Table/hsa04066.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-14_14_08_35.864097/hsa04066.pathview.png}
\caption{HERBS hsa04066 visualization}\label{fig:HERBS-hsa04066-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04066}

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:HERBS-hsa04371-visualization) (下方图) 为图HERBS hsa04371 visualization概览。

**(对应文件为 `Figure+Table/hsa04371.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-14_14_08_35.864097/hsa04371.pathview.png}
\caption{HERBS hsa04371 visualization}\label{fig:HERBS-hsa04371-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04371}

\vspace{2em}
\end{tcolorbox}
\end{center}

#### 相关成分

Table \@ref(tab:Compounds-target-HIF-1-signaling-pathway) (下方表格) 为表格Compounds target HIF 1 signaling pathway概览。

**(对应文件为 `Figure+Table/Compounds-target-HIF-1-signaling-pathway.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有137行9列，以下预览的表格可能省略部分数据；表格含有38个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-target-HIF-1-signaling-pathway)Compounds target HIF 1 signaling pathway

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target... |Databa... |Paper.id |... |
|:-------------|:---------|:-------------|:-------------|:---------|:---------|:---------|:--------|:---|
|HBIN00...     |CHUAN ... |3-buty...     |NA            |HBTAR0... |CDKN1A    |NA        |NA       |... |
|HBIN01...     |HUANG QI  |5&apos...     |NA            |HBTAR0... |RELA      |NA        |NA       |... |
|HBIN01...     |HUANG QI  |acetic...     |AI3-02...     |HBTAR0... |RELA      |NA        |NA       |... |
|HBIN01...     |HUANG QI  |acetic...     |AI3-02...     |HBTAR0... |RELA      |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |HIF1A     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |VEGFA     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |HIF1A     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |VEGFA     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |HIF1A     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |VEGFA     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |HIF1A     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |adenin...     |NA            |HBTAR0... |VEGFA     |NA        |NA       |... |
|HBIN01...     |HUANG QI  |astram...     |AC1L3V...     |HBTAR0... |AKT1      |NA        |NA       |... |
|HBIN01...     |HUANG QI  |astram...     |AC1L3V...     |HBTAR0... |TEK       |NA        |NA       |... |
|HBIN01...     |HUANG QI  |beta c...     |Spectr...     |HBTAR0... |AKT1      |NA        |NA       |... |
|...           |...       |...           |...           |...       |...       |...       |...      |... |

Table \@ref(tab:Compounds-target-Apelin-signaling-pathway) (下方表格) 为表格Compounds target Apelin signaling pathway概览。

**(对应文件为 `Figure+Table/Compounds-target-Apelin-signaling-pathway.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有61行9列，以下预览的表格可能省略部分数据；表格含有17个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-target-Apelin-signaling-pathway)Compounds target Apelin signaling pathway

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target... |Databa... |Paper.id  |... |
|:-------------|:---------|:-------------|:-------------|:---------|:---------|:---------|:---------|:---|
|HBIN00...     |CHUAN ... |3-buty...     |NA            |HBTAR0... |CCND1     |NA        |NA        |... |
|HBIN01...     |HUANG QI  |5&apos...     |NA            |HBTAR0... |CCND1     |NA        |NA        |... |
|HBIN01...     |HUANG QI  |astram...     |AC1L3V...     |HBTAR0... |AKT1      |NA        |NA        |... |
|HBIN01...     |HUANG QI  |beta c...     |Spectr...     |HBTAR0... |AKT1      |NA        |NA        |... |
|HBIN01...     |HUANG QI  |beta c...     |Spectr...     |HBTAR0... |AKT1      |NA        |NA        |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |AKT1      |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |MAPK1     |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |AKT1      |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |MAPK1     |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |AKT1      |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |MAPK1     |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |AKT1      |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |MAPK1     |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |AKT1      |NA        |HBREF0... |... |
|HBIN01...     |HUANG QI  |calycosin     |HSDB 8...     |HBTAR0... |MAPK1     |NA        |HBREF0... |... |
|...           |...       |...           |...           |...       |...       |...       |...       |... |



### Hirudin 对筛选通路的靶向 {#hi-t}

Figure \@ref(fig:HIRUDIN-hsa04066-visualization) (下方图) 为图HIRUDIN hsa04066 visualization概览。

**(对应文件为 `Figure+Table/hsa04066.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-14_16_15_48.263803/hsa04066.pathview.png}
\caption{HIRUDIN hsa04066 visualization}\label{fig:HIRUDIN-hsa04066-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04066}

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:HIRUDIN-hsa04371-visualization) (下方图) 为图HIRUDIN hsa04371 visualization概览。

**(对应文件为 `Figure+Table/hsa04371.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-14_16_15_48.263803/hsa04371.pathview.png}
\caption{HIRUDIN hsa04371 visualization}\label{fig:HIRUDIN-hsa04371-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04371}

\vspace{2em}
\end{tcolorbox}
\end{center}




