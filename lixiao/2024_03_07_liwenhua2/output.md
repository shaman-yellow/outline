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
开源数据库结肠炎和结肠癌的菌群差异分析}
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



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to TransplantationSinha2022[@TransplantationSinha2022].
- Supplementary file from article refer to TargetedSuppreFederi2022[@TargetedSuppreFederi2022].
- Supplementary file from article refer to DepressionAndYuan2021[@DepressionAndYuan2021].
- Supplementary file from article refer to AnIntegratedTRoelan2023[@AnIntegratedTRoelan2023].
- Supplementary file from article refer to LocationAndCoSambru2023[@LocationAndCoSambru2023].

## 方法

Mainly used method:

- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 数据来源

### 结肠炎数据

#### TargetedSuppreFederi2022 结肠炎

 
`TargetedSuppreFederi2022 data' 数据已全部提供。

**(对应文件为 `Figure+Table/TargetedSuppreFederi2022-data`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/TargetedSuppreFederi2022-data共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Corrected France.csv
\item 2\_Corrected Israel.csv
\item 3\_Corrected US.csv
\item 4\_Corrected Germany.csv
\end{enumerate}\end{tcolorbox}
\end{center}



#### DepressionAndYuan2021 结肠炎

Table \@ref(tab:DepressionAndYuan2021-data) (下方表格) 为表格DepressionAndYuan2021 data概览。

**(对应文件为 `Figure+Table/DepressionAndYuan2021-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有91行4列，以下预览的表格可能省略部分数据；表格含有91个唯一`Taxonomy'。
\end{tcolorbox}
\end{center}

Table: (\#tab:DepressionAndYuan2021-data)DepressionAndYuan2021 data

|Taxonomy             |p.value              |MRA.in.UC            |MRA.in.HC            |
|:--------------------|:--------------------|:--------------------|:--------------------|
|p__Gemmatimonadetes  |0.00049553252446827  |0.00171119907683608  |0.000160190585722501 |
|p__Actinobacteria    |0.00834784591709094  |0.0617033057472256   |0.0389112516772091   |
|p__Firmicutes        |0.00478686441960355  |0.589610871565727    |0.499806265231797    |
|p__Bacteroidetes     |9.60337999115942e-05 |0.250752809840626    |0.403687121772228    |
|p__unidentified      |1.40986578996555e-07 |0.000640301130981834 |2.05372545798078e-06 |
|c__Actinobacteria    |0.00353055167754535  |0.046725454341533    |0.0237116295626934   |
|c__Longimicrobia     |7.16632518063251e-07 |0.00145496100157866  |0                    |
|c__Bacteroidia       |6.38198131772293e-05 |0.24518920382048     |0.403287329883075    |
|c__Deinococci        |3.17450175630301e-06 |0.00131123215732429  |0                    |
|c__Bacilli           |0.00330587139663399  |0.0649165901033199   |0.0154563377967633   |
|c__Cytophagia        |2.10636789003367e-05 |0.0016664310495747   |4.24436594649361e-05 |
|c__unidentified      |2.64154914758447e-08 |0.0016652538833675   |8.83101946931736e-05 |
|c__Flavobacteriia    |5.26714172360768e-05 |0.00167703418517471  |5.95580382814426e-05 |
|o__Oceanospirillales |0.00495867783478051  |0.000461817587592187 |2.05372545798077e-06 |
|o__Bifidobacteriales |0.00354779153342515  |0.0443044462799416   |0.0224465346805772   |
|...                  |...                  |...                  |...                  |





#### TransplantationSinha2022 结肠炎

Table \@ref(tab:TransplantationSinha2022-data) (下方表格) 为表格TransplantationSinha2022 data概览。

**(对应文件为 `Figure+Table/TransplantationSinha2022-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有141行12列，以下预览的表格可能省略部分数据；表格含有83个唯一`W'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TransplantationSinha2022-data)TransplantationSinha2022 data

|W   |detect......2 |detect......3 |detect......4 |detect......5 |Kingdom   |Phylum    |Class     |Order     |Family    |... |
|:---|:-------------|:-------------|:-------------|:-------------|:---------|:---------|:---------|:---------|:---------|:---|
|121 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Rikene... |... |
|89  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Rikene... |... |
|87  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Marini... |... |
|94  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|125 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|94  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|95  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|135 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Prevot... |... |
|138 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Prevot... |... |
|103 |FALSE         |FALSE         |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Lactob... |Entero... |... |
|134 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|118 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|90  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|87  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|95  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|... |...           |...           |...           |...           |...       |...       |...       |...       |...       |... |



### 结肠癌数据

#### AnIntegratedTRoelan2023 结肠癌

Table \@ref(tab:AnIntegratedTRoelan2023-data) (下方表格) 为表格AnIntegratedTRoelan2023 data概览。

**(对应文件为 `Figure+Table/AnIntegratedTRoelan2023-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有74行15列，以下预览的表格可能省略部分数据；表格含有1个唯一`sheet'。
\end{tcolorbox}
\end{center}

Table: (\#tab:AnIntegratedTRoelan2023-data)AnIntegratedTRoelan2023 data

|sheet     |Taxonomy  |p_val     |FDR       |wilcox... |mean_N    |mean_T    |median_N  |median_T  |Direction |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|Supple... |D_0__B... |2.8875... |4.2447... |1965      |0.0121... |0.0524... |0.0006... |0.0059... |Enrich... |
|Supple... |D_0__B... |6.6405... |4.8807... |657       |0.0018... |0.0095... |0         |0         |Enrich... |
|Supple... |D_0__B... |7.1087... |3.4833... |21023.5   |0.0190... |0.0126... |0.0128... |0.0067... |Enrich... |
|Supple... |D_0__B... |2.8160... |1.0348... |18604     |0.0132... |0.0087... |0.0078... |0.0041... |Enrich... |
|Supple... |D_0__B... |1.7251... |5.0718... |11985     |0.0070... |0.0043... |0.0034... |0.0019... |Enrich... |
|Supple... |D_0__B... |5.0924... |1.2476... |7227.5    |0.0126... |0.0315... |0.0031... |0.0076... |Enrich... |
|Supple... |D_0__B... |9.2218... |1.9365... |223.5     |0.0002... |0.0052... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.5535... |2.8547... |16631.5   |0.0106... |0.0076... |0.0064... |0.0041... |Enrich... |
|Supple... |D_0__B... |2.1475... |3.5075... |1494      |0.0022... |0.0076... |0         |0         |Enrich... |
|Supple... |D_0__B... |4.3690... |6.2979... |62        |0.0001... |0.0026... |0         |0         |Enrich... |
|Supple... |D_0__B... |4.7127... |6.2979... |20341     |0.0280... |0.0232... |0.0228... |0.0170... |Enrich... |
|Supple... |D_0__B... |7.9474... |9.7356... |237.5     |0.0008... |0.0058... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.6820... |1.9019... |4806.5    |0.0040... |0.0026... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.5690... |1.5376... |4009      |0.0025... |0.0039... |0.0006... |0.0013... |Enrich... |
|Supple... |D_0__B... |1.5362... |1.5376... |12107.5   |0.0075... |0.0059... |0.0017... |0.0012... |Enrich... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |



#### LocationAndCoSambru2023 结肠癌

Table \@ref(tab:LocationAndCoSambru2023-data) (下方表格) 为表格LocationAndCoSambru2023 data概览。

**(对应文件为 `Figure+Table/LocationAndCoSambru2023-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有44行2列，以下预览的表格可能省略部分数据；表格含有44个唯一`tax\_id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LocationAndCoSambru2023-data)LocationAndCoSambru2023 data

|tax_id  |taxon_name                     |
|:-------|:------------------------------|
|40545   |Sutterella_wadsworthensis      |
|214856  |Alistipes_finegoldii           |
|328814  |Alistipes_shahii               |
|674529  |Bacteroides_faecis             |
|333367  |[Clostridium]_asparagiforme    |
|437898  |Sutterella_parvirubra          |
|74426   |Collinsella_aerofaciens        |
|1531    |[Clostridium]_clostridioforme  |
|239935  |Akkermansia_muciniphila        |
|901     |Desulfovibrio_piger            |
|1892897 |Shigella_sp._FC569             |
|68259   |Streptomyces_purpurogeneisc... |
|1450439 |Bacteroides_sp._UW             |
|585543  |Bacteroides_sp._D20            |
|1581131 |Actinomyces_sp._HMSC08A01      |
|...     |...                            |



## 微生物注释




