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
蛋白质数据绘制火山图} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-10}}
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



需求：蛋白质数据差异分析和火山图绘制

结果：

- Model vs Control 火山图见 Fig. \@ref(fig:PRO-Model-vs-Control-DEPs)，对应数据见 Tab. \@ref(tab:PRO-data-Model-vs-Control-DEPs)
- 除了 Model vs Control, 其他组别数据也已提供，见 \@ref(groups)

注：分析所使用的数据来源于 <http://101.66.242.136:5212/s/r7MTk?path=%2F> 中的 'txt/peptides.txt'

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 差异分析和火山图绘制

### Model vs Control

Figure \@ref(fig:PRO-Model-vs-Control-DEPs) (下方图) 为图PRO Model vs Control DEPs概览。

**(对应文件为 `Figure+Table/PRO-Model-vs-Control-DEPs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PRO-Model-vs-Control-DEPs.pdf}
\caption{PRO Model vs Control DEPs}\label{fig:PRO-Model-vs-Control-DEPs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
adj.P.Val cut-off
:}

\vspace{0.5em}

    0.05

\vspace{2em}


\textbf{
Log2(FC) cut-off
:}

\vspace{0.5em}

    1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/PRO-Model-vs-Control-DEPs-content`)**

Table \@ref(tab:PRO-data-Model-vs-Control-DEPs) (下方表格) 为表格PRO data Model vs Control DEPs概览。

**(对应文件为 `Figure+Table/PRO-data-Model-vs-Control-DEPs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2131行11列，以下预览的表格可能省略部分数据；含有1221个唯一`gene\_name'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_name:  GENCODE gene name
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:PRO-data-Model-vs-Control-DEPs)PRO data Model vs Control DEPs

|rownames |id    |gene_name |unipro... |Proteins       |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:--------|:-----|:---------|:---------|:--------------|:---------|:---------|:---------|:---------|:---------|
|27560    |27559 |Myh1      |Q5SX40    |sp&#124;Q5S... |-2.136... |7.3178... |-21.38... |2.3613... |0.0011... |
|19391    |19390 |Ighm      |A0A075... |tr&#124;A0A... |-2.009... |7.4110... |-19.35... |4.5213... |0.0011... |
|8591     |8590  |Hmgb1     |A0A0J9... |tr&#124;A0A... |2.4353... |7.7990... |16.608... |1.2218... |0.0011... |
|25892    |25891 |Hspa5     |Q3U9G2    |tr&#124;Q3U... |-1.099... |8.8830... |-17.93... |7.4249... |0.0011... |
|534      |533   |Lmnb1     |P14733    |sp&#124;P14... |1.7203... |6.2488... |15.712... |1.7491... |0.0011... |
|3609     |3608  |Mmp9      |Q3TTU7    |tr&#124;Q3T... |2.4949... |5.5360... |14.767... |2.6098... |0.0011... |
|11691    |11690 |Ca3       |P16015    |sp&#124;P16... |-2.389... |5.8003... |-14.52... |2.8998... |0.0011... |
|31046    |31045 |Hbbt1     |A8DUP7    |tr&#124;A8D... |-5.345... |4.7019... |-14.37... |3.1058... |0.0011... |
|12790    |12789 |Rps14     |Q3UJS5    |tr&#124;Q3U... |1.1565... |7.2399... |14.517... |2.9129... |0.0011... |
|14192    |14191 |Lcp1      |Q3U9M7    |tr&#124;Q3U... |1.6660... |6.4834... |14.031... |3.6264... |0.0011... |
|5699     |5698  |Ceacam1   |Q3LFS5    |tr&#124;Q3L... |-1.532... |6.4558... |-13.90... |3.8427... |0.0011... |
|8092     |8091  |Tf        |Q921I1    |sp&#124;Q92... |-1.233... |8.0005... |-14.77... |2.5981... |0.0011... |
|16104    |16103 |Atp2a1    |Q8R429    |sp&#124;Q8R... |-1.601... |7.8387... |-13.95... |3.7611... |0.0011... |
|35       |34    |Alb       |P07724    |sp&#124;P07... |-1.155... |8.6863... |-15.00... |2.3523... |0.0011... |
|16588    |16587 |Rcc2      |Q8BK67    |sp&#124;Q8B... |1.2754... |6.6191... |13.589... |4.4527... |0.0011... |
|...      |...   |...       |...       |...            |...       |...       |...       |...       |...       |

### Other Group {#groups}

 
`All volcano plots' 数据已全部提供。

**(对应文件为 `Figure+Table/All-volcano-plots`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/All-volcano-plots共包含6个文件。

\begin{enumerate}\tightlist
\item 1\_Model - Control.pdf
\item 2\_Low - Model.pdf
\item 3\_Middle - Model.pdf
\item 4\_High - Model.pdf
\item 5\_High - Middle.pdf
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

 
`ALL data DEPs' 数据已全部提供。

**(对应文件为 `Figure+Table/ALL-data-DEPs`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/ALL-data-DEPs共包含6个文件。

\begin{enumerate}\tightlist
\item 1\_Model - Control.csv
\item 2\_Low - Model.csv
\item 3\_Middle - Model.csv
\item 4\_High - Model.csv
\item 5\_High - Middle.csv
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

Table \@ref(tab:RAW-quantification) (下方表格) 为表格RAW quantification概览。

**(对应文件为 `Figure+Table/RAW-quantification.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有33174行27列，以下预览的表格可能省略部分数据；含有10461个唯一`Proteins'。
\end{tcolorbox}
\end{center}

Table: (\#tab:RAW-quantification)RAW quantification

|Proteins       |Mass      |id  |Intensity |Intens......5 |Intens......6 |Intens......7 |Intens......8 |Intens......9 |... |
|:--------------|:---------|:---|:---------|:-------------|:-------------|:-------------|:-------------|:-------------|:---|
|tr&#124;Q6Z... |2031.9895 |0   |177160    |0             |0             |0             |31867         |0             |... |
|sp&#124;O70... |3186.471  |1   |35665     |0             |0             |13434         |22230         |0             |... |
|tr&#124;Q5J... |2047.0586 |2   |250350    |0             |67437         |0             |0             |79893         |... |
|sp&#124;A2A... |1888.8625 |3   |7268400   |91029         |140760        |1236600       |3638500       |0             |... |
|sp&#124;P63... |1520.6752 |4   |14545000  |2117500       |1889000       |173690        |747070        |2088200       |... |
|sp&#124;Q9R... |1943.9912 |5   |38486     |0             |0             |7531.9        |10726         |0             |... |
|sp&#124;P97... |1503.7205 |6   |347290    |18450         |1878.3        |80010         |188040        |19633         |... |
|tr&#124;Q3V... |1313.6939 |7   |56784     |0             |0             |0             |31003         |2961.5        |... |
|tr&#124;Q8C... |1735.8853 |8   |1491800   |43990         |19935         |93206         |68419         |228030        |... |
|tr&#124;Q0P... |970.49444 |9   |295650    |0             |0             |65125         |101240        |0             |... |
|sp&#124;Q9Z... |2716.4119 |10  |366870    |64761         |19275         |50407         |53458         |10873         |... |
|sp&#124;A2A... |1051.6026 |11  |2913000   |66586         |63995         |527650        |1114700       |1594.5        |... |
|tr&#124;A0A... |1415.762  |12  |699510    |54119         |32114         |71040         |81738         |0             |... |
|sp&#124;O70... |936.51411 |13  |1152200   |50337         |56782         |298300        |406900        |61515         |... |
|tr&#124;Z4Y... |1731.8614 |14  |42505     |0             |0             |0             |30772         |9345.3        |... |
|...            |...       |... |...       |...           |...           |...           |...           |...           |... |




