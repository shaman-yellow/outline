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
  \usepackage{pgfornament}
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
生信文章修改甲基化测序} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-05-23}}
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



Whole-genome DNA methylation analysis in liver
tissue of offspring of Zuogui pill (ZGP)-intervened GD rats, trying to find evidence
for ZGP effect on epigenetics and potential pathways

Then, 92 DM-related differentially
methylated genes were identified. They were mainly enriched in
glycometabolism, receptors on the membrane, and protein kinases and
their regulators by GO analysis as well as in MAPK pathway by KEGG
analysis.

A core **network involved in PI3K/AKT signaling was
obtained.** The effect of ZGP on eugenics in the offspring of GD rats
may be achieved by affecting the liver methylation of the offspring,
with **PI3K/AKT pathway as one of targets.**

- differentially methylated regions (DMRs) identification
- Bismark was used for aligning clean reads to reference genome 
- profiles of extracted methylation sites were analyzed by **methylKit** to perform
  calling DMR between Model and Model-Cure group, with \|delta\| \> 0.3, FDR \<
  0.05, and annotate DMRs-related genes by Rattus norvegicus genome

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

- 许凯霞需求
- 浙江百越4例WGBS信息采集与分析





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:unnamed-chunk-10) (下方表格) 为表格unnamed chunk 10概览。

**(对应文件为 `Figure+Table/unnamed-chunk-10.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有12行29列，以下预览的表格可能省略部分数据；含有1个唯一`Sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item Sample:  样本名称。
\item Lib:  文库名称。
\item Total Reads:  总的读取数（reads）。
\item Mapped Reads:  成功比对到参考基因组的读取数。
\item Mapped Ratio:  成功比对的读取数占总读取数的比例。
\item Unique Reads:  成功比对且唯一比对的读取数。
\item Unique Ratio:  唯一比对的读取数占总读取数的比例。
\item PE Unique Reads:  成对读取（paired-end reads）中唯一比对的读取数。
\item PE Unique Ratio:  成对读取中唯一比对的读取数占总读取数的比例。
\item Unmapped Reads:  未成功比对的读取数。
\item Unmapped Ratio:  未成功比对的读取数占总读取数的比例。
\item Mutimapped Reads:  成功比对但多重比对的读取数。
\item Mutimapped Ratio:  多重比对的读取数占总读取数的比例。
\item Discarded Reads:  被丢弃的读取数。
\item Top Strand:  比对到正链（top strand）的读取数。
\item Bottom Strand:  比对到负链（bottom strand）的读取数。
\item Total C:  总的C位点数。
\item mCG:  甲基化的CG位点数。
\item mCHG:  甲基化的CHG位点数。
\item mCHH:  甲基化的CHH位点数。
\item mUn:  甲基化的未识别位点数。
\item unmCG:  未甲基化的CG位点数。
\item unmCHG:  未甲基化的CHG位点数。
\item unmCHH:  未甲基化的CHH位点数。
\item unmUn:  未甲基化的未识别位点数。
\item CG level:  CG位点的甲基化水平。
\item CHG level:  CHG位点的甲基化水平。
\item CHH level:  CHH位点的甲基化水平。
\item Un level:  未识别位点的甲基化水平。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:unnamed-chunk-10)Unnamed chunk 10

|Sample  |Lib       |Total ... |Mapped... |Mapped... |Unique... |Unique... |PE Uni... |PE Uni... |Unmapp... |... |
|:-------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---|
|Model-1 |220614... |32393432  |21860820  |67.49%    |19692844  |60.79%    |19692844  |60.8%     |10532612  |... |
|Model-1 |220614... |33843456  |22773076  |67.29%    |20512426  |60.61%    |20512426  |60.6%     |11070380  |... |
|Model-1 |220614... |31845426  |21656537  |68.01%    |19489323  |61.20%    |19489323  |61.2%     |10188889  |... |
|Model-1 |220614... |28307315  |18847140  |66.58%    |17005125  |60.07%    |17005125  |60.1%     |9460175   |... |
|Model-1 |220614... |34022926  |24091817  |70.81%    |21689901  |63.75%    |21689901  |63.8%     |9931109   |... |
|Model-1 |220614... |35655498  |25208927  |70.70%    |22696324  |63.65%    |22696324  |63.7%     |10446571  |... |
|Model-1 |220614... |33196722  |23690173  |71.36%    |21306552  |64.18%    |21306552  |64.2%     |9506549   |... |
|Model-1 |220614... |28994735  |20309191  |70.04%    |18310831  |63.15%    |18310831  |63.2%     |8685544   |... |
|Model-1 |220711... |9785946   |7364737   |75.26%    |6611903   |67.57%    |6611903   |67.6%     |2421209   |... |
|Model-1 |220711... |10175734  |7663477   |75.31%    |6881304   |67.62%    |6881304   |67.6%     |2512257   |... |
|Model-1 |220711... |9709125   |7332078   |75.52%    |6576371   |67.73%    |6576371   |67.7%     |2377047   |... |
|Model-1 |220711... |8564409   |6370360   |74.38%    |5727736   |66.88%    |5727736   |66.9%     |2194049   |... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

