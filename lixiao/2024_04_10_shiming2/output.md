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
水蛭素与缺血性脑卒中} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-22}}
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

- 复方：地黄15g、黄芪15g、葛根18g、石斛15g、水蛭3g、川芎9g
- 有效成分：水蛭中水蛭素 Hirudin（重点关注）
- 疾病：缺血性脑卒中
- 机制：血管生成
- 目标：找到水蛭素通过XX靶点及XX靶点涉及的通路YY影响缺血性脑卒中的血管生成

请注意，网药有效成分筛选时确认包括水蛭素，如不包括，请及时联系
 
## 结果

这是以上一份文档 (名为：养阴通脑颗粒中关键成分对脑缺血再灌注的影响) 为基础修改的 PDF 文档 。

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- Website `HERB` <http://herb.ac.cn/> used for TCM data source[@HerbAHighThFang2021].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- R package `UniProt.ws` used for querying Gene or Protein information.
- R version 4.3.3 (2024-02-29); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}



## 养阴通脑颗粒

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有6行18列，以下预览的表格可能省略部分数据；含有6个唯一`Herb\_；含有6个唯一`Herb\_pinyin\_name'。
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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有725行4列，以下预览的表格可能省略部分数据；含有6个唯一`herb\_id；含有696个唯一`Ingredient.name'。
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

### 成分靶点

#### GeneCards 获取化合物靶点

HERBs 数据库包含的 Hirudin 靶点较少：

bindingdb, drugbank, 以及预测工具 Super-Pred 等都难以获取更多关于 hirudin 靶点信息。
因此，这里使用 `GeneCards` 搜索。

Table \@ref(tab:Hirudin-targets-from-GeneCards) (下方表格) 为表格Hirudin targets from GeneCards概览。

**(对应文件为 `Figure+Table/Hirudin-targets-from-GeneCards.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有45行7列，以下预览的表格可能省略部分数据；含有45个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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
\end{center}

Table: (\#tab:Hirudin-targets-from-GeneCards)Hirudin targets from GeneCards

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|F2       |Coagulatio... |Protein Co... |P00734     |59    |GC11P047736 |2.58  |
|F2R      |Coagulatio... |Protein Co... |P25116     |55    |GC05P076716 |2.23  |
|F10      |Coagulatio... |Protein Co... |P00742     |59    |GC13P113122 |1.76  |
|FGA      |Fibrinogen... |Protein Co... |P02671     |58    |GC04M154583 |1.76  |
|PLAT     |Plasminoge... |Protein Co... |P00750     |58    |GC08M042174 |1.76  |
|F3       |Coagulatio... |Protein Co... |P13726     |54    |GC01M094873 |1.76  |
|PLG      |Plasminogen   |Protein Co... |P00747     |58    |GC06P160702 |1.59  |
|CPA1     |Carboxypep... |Protein Co... |P15085     |51    |GC07P130380 |1.12  |
|PLAU     |Plasminoge... |Protein Co... |P00749     |60    |GC10P073909 |0.64  |
|CD40LG   |CD40 Ligand   |Protein Co... |P29965     |59    |GC0XP136649 |0.64  |
|SERPINC1 |Serpin Fam... |Protein Co... |P01008     |59    |GC01M174949 |0.64  |
|SERPINE1 |Serpin Fam... |Protein Co... |P05121     |59    |GC07P101127 |0.64  |
|TBXA2R   |Thromboxan... |Protein Co... |P21731     |59    |GC19M003594 |0.64  |
|CCL2     |C-C Motif ... |Protein Co... |P13500     |58    |GC17P034255 |0.64  |
|CD55     |CD55 Molec... |Protein Co... |P08174     |58    |GC01P207321 |0.64  |
|...      |...           |...           |...        |...   |...         |...   |



#### 所有靶点

Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/tables-of-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有13446行9列，以下预览的表格可能省略部分数据；含有696个唯一`Ingredient.id；含有6个唯一`Herb\_pinyin\_name；含有696个唯一`Ingredient.name；含有2879个唯一`Target.name'。
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

取下方数据集的合集：

Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}

Table \@ref(tab:CIR-GeneCards-used-data) (下方表格) 为表格CIR GeneCards used data概览。

**(对应文件为 `Figure+Table/CIR-GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有144行7列，以下预览的表格可能省略部分数据；含有144个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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
\end{center}

Table: (\#tab:CIR-GeneCards-used-data)CIR GeneCards used data

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|BDNF-AS  |BDNF Antis... |RNA Gene (... |           |29    |GC11P027466 |11.93 |
|CERNA3   |Competing ... |RNA Gene (... |           |19    |GC08P056323 |6.6   |
|MEG3     |Maternally... |RNA Gene (... |           |34    |GC14P116735 |6.12  |
|SNHG12   |Small Nucl... |RNA Gene (... |Q9BXW3     |30    |GC01M031297 |6.05  |
|MIR211   |MicroRNA 211  |RNA Gene (... |           |29    |GC15M031065 |5.79  |
|SNHG14   |Small Nucl... |RNA Gene (... |           |24    |GC15P156537 |5.68  |
|SOD2-OT1 |SOD2 Overl... |RNA Gene (... |           |18    |GC06M159772 |5.4   |
|H19      |H19 Imprin... |RNA Gene (... |           |34    |GC11M001995 |4.64  |
|GAS5     |Growth Arr... |RNA Gene (... |           |31    |GC01M173947 |4.55  |
|MIR496   |MicroRNA 496  |RNA Gene (... |           |16    |GC14P116773 |4.06  |
|BCL2     |BCL2 Apopt... |Protein Co... |P10415     |59    |GC18M063123 |3.69  |
|TUG1     |Taurine Up... |Protein Co... |A0A6I8PU40 |32    |GC22P030969 |3.69  |
|SCARNA5  |Small Caja... |RNA Gene (... |           |23    |GC02P233275 |3.69  |
|NFE2L2   |NFE2 Like ... |Protein Co... |Q16236     |60    |GC02M177227 |3.64  |
|SOD1     |Superoxide... |Protein Co... |P00441     |61    |GC21P031659 |3.59  |
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
ICAM1, THBS1, TERT, JUN, ADORA2B, EFNB2, HGF, CD36, IRAK3,
SLPI, IL12A, C...

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
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有195行9列，以下预览的表格可能省略部分数据；含有195个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:HERBS-KEGG-enrichment-data)HERBS KEGG enrichment data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|
|hsa05161 |Hepati... |21/29     |162/8764 |4.0169... |7.8329... |1.1416... |207/13... |21    |
|hsa05417 |Lipid ... |22/29     |215/8764 |1.7025... |1.6599... |2.4194... |207/59... |22    |
|hsa05167 |Kaposi... |21/29     |194/8764 |2.1692... |1.4099... |2.0550... |207/83... |21    |
|hsa04933 |AGE-RA... |16/29     |100/8764 |1.4213... |6.9289... |1.0098... |207/59... |16    |
|hsa05162 |Measles   |17/29     |138/8764 |3.6237... |1.4132... |2.0598... |207/59... |17    |
|hsa05169 |Epstei... |18/29     |202/8764 |4.3574... |1.4161... |2.0640... |207/59... |18    |
|hsa04668 |TNF si... |15/29     |114/8764 |1.3331... |3.7136... |5.4126... |207/13... |15    |
|hsa04917 |Prolac... |13/29     |70/8764  |1.0206... |2.4877... |3.6258... |207/59... |13    |
|hsa01522 |Endocr... |14/29     |98/8764  |1.2349... |2.6756... |3.8997... |207/59... |14    |
|hsa05163 |Human ... |17/29     |225/8764 |1.9745... |3.8503... |5.6118... |207/13... |17    |
|hsa05210 |Colore... |13/29     |86/8764  |1.8209... |3.2280... |4.7048... |207/59... |13    |
|hsa04210 |Apoptosis |14/29     |135/8764 |1.3592... |2.2088... |3.2193... |207/59... |14    |
|hsa05142 |Chagas... |13/29     |102/8764 |1.9039... |2.8558... |4.1623... |207/84... |13    |
|hsa05418 |Fluid ... |14/29     |139/8764 |2.0751... |2.8903... |4.2126... |207/59... |14    |
|hsa04625 |C-type... |13/29     |104/8764 |2.4816... |3.2261... |4.7020... |207/84... |13    |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |

Table \@ref(tab:Compounds-contributes-to-Top30) (下方表格) 为表格Compounds contributes to Top30概览。

**(对应文件为 `Figure+Table/Compounds-contributes-to-Top30.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有291行3列，以下预览的表格可能省略部分数据；含有6个唯一`Herb\_pinyin\_name；含有106个唯一`Ingredient.name；含有30个唯一`Target.name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Compounds-contributes-to-Top30)Compounds contributes to Top30

|Herb_pinyin_name |Ingredient.name                |Target.name |
|:----------------|:------------------------------|:-----------|
|HUANG QI         |13-hydroxy-9,11-octadecadie... |PPARG       |
|HUANG QI         |1,7-Dihydroxy-3,9-dimethoxy... |PPARG       |
|HUANG QI         |1,7-Dihydroxy-3,9-dimethoxy... |MAPK14      |
|CHUAN XIONG      |1-Acetyl-beta-carboline        |MAPK14      |
|CHUAN XIONG      |1-beta-ethylacrylate-7-alde... |MAPK14      |
|HUANG QI         |3,9-di-O-methylnissolin        |PPARG       |
|HUANG QI         |3,9-di-O-methylnissolin        |MAPK14      |
|CHUAN XIONG      |3-Butylidene-7-hydroxyphtha... |PPARG       |
|CHUAN XIONG      |3-butylidene-phalide           |CCND1       |
|CHUAN XIONG      |3-butylidene-phalide           |CDKN1A      |
|CHUAN XIONG      |3-butylidene-phalide           |TP53        |
|GE GEN           |3&apos;-Methoxydaidzein        |PPARG       |
|GE GEN           |3&apos;-Methoxydaidzein        |MAPK14      |
|CHUAN XIONG      |4,7-Dihydroxy-3-butylphthalide |PPARG       |
|CHUAN XIONG      |4-hydroxy-3-butylphthalide     |PPARG       |
|...              |...                            |...         |



## 水蛭素 Hirudin

### 水蛭素-靶点-富集通路

Figure \@ref(fig:Hirudin-targets-of-disease) (下方图) 为图Hirudin targets of disease概览。

**(对应文件为 `Figure+Table/Hirudin-targets-of-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Hirudin-targets-of-disease.pdf}
\caption{Hirudin targets of disease}\label{fig:Hirudin-targets-of-disease}
\end{center}

Figure \@ref(fig:HIRU KEGG enrichment) (下方图) 为图HIRU KEGG enrichment概览。

**(对应文件为 `Figure+Table/HIRU KEGG enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HIRU KEGG enrichment.pdf}
\caption{HIRU KEGG enrichment}\label{fig:HIRU KEGG enrichment}
\end{center}

Figure \@ref(fig:HIRU GO enrichment) (下方图) 为图HIRU GO enrichment概览。

**(对应文件为 `Figure+Table/HIRU GO enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HIRU GO enrichment.pdf}
\caption{HIRU GO enrichment}\label{fig:HIRU GO enrichment}
\end{center}



### 分子对接



