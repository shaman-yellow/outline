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
列线图模型建立与验证} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-01}}
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

列线图模型的建立与验证进行分析, 并按参考文献2描述所使用的统计方法

- 自发性蛛网膜下腔出血
    - 预后良好组
    - 预后不良组

结果见 \@ref(res)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `pROC` used for building ROC curve.
- R package `rms` used for Logistic regression and nomogram visualization.
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}




## 预处理表格

Table \@ref(tab:Formatted-data) (下方表格) 为表格Formatted data概览。

**(对应文件为 `Figure+Table/Formatted-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有80行5列，以下预览的表格可能省略部分数据；表格含有2个唯一`Group'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Formatted-data)Formatted data

|Group    |WFNS分级 |迟发性脑缺血 |肺部感染 |颅内出血 |
|:--------|:--------|:------------|:--------|:--------|
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |有       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |IV 级    |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |有       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |IV 级    |无           |无       |无       |
|预后良好 |I 级     |无           |无       |无       |
|预后良好 |I 级     |有           |无       |无       |
|...      |...      |...          |...      |...      |



## 结果 {#res}


\noindent \textbf{Logistic Regression Model}

\begin{verbatim}
rms::lrm(formula = formula, data = data, x = T, y = T)
\end{verbatim}

{\fontfamily{phv}\selectfont \begin{center}\begin{tabular}{|c|c|c|c|}\hline
&Model Likelihood&Discrimination&Rank Discrim.\\
&Ratio Test&Indexes&Indexes\\\hline
Obs~\hfill 80&LR $\chi^{2}$~\hfill 58.51&$R^{2}$~\hfill 0.704&$C$~\hfill 0.945\\
~~预后良好~\hfill 49&d.f.~\hfill 6&$R^{2}_{6,80}$~\hfill 0.481&$D_{xy}$~\hfill 0.889\\
~~预后不良~\hfill 31&Pr$(>\chi^{2})$~\hfill \textless 0.0001&$R^{2}_{6,57}$~\hfill 0.602&$\gamma$~\hfill 0.904\\
$\max|\frac{\partial\log L}{\partial \beta}|$~\hfill $5\!\times\!10^{-9}$&&Brier~\hfill 0.093&$\tau_{a}$~\hfill 0.428\\
\hline
\end{tabular}
\end{center}}

\setlongtables\begin{longtable}{lrrrr}\hline
\multicolumn{1}{l}{}&\multicolumn{1}{c}{$\hat{\beta}$}&\multicolumn{1}{c}{S.E.}&\multicolumn{1}{c}{Wald $Z$}&\multicolumn{1}{c}{Pr$(>|Z|)$}\tabularnewline
\hline
\endhead
\hline
\endfoot
Intercept&~-3.4744~&~0.8083~&-4.30&\textless 0.0001\tabularnewline
WFNS分级=II 级&~ 0.8666~&~1.0481~& 0.83&0.4084\tabularnewline
WFNS分级=IV 级&~ 2.2416~&~0.9605~& 2.33&0.0196\tabularnewline
WFNS分级=V 级&~ 2.9983~&~1.4807~& 2.02&0.0429\tabularnewline
迟发性脑缺血=有&~ 3.4377~&~1.0671~& 3.22&0.0013\tabularnewline
肺部感染=有&~ 2.7851~&~0.8830~& 3.15&0.0016\tabularnewline
颅内出血=有&~ 2.5947~&~1.3415~& 1.93&0.0531\tabularnewline
\hline
\end{longtable}
\addtocounter{table}{-1}

Figure \@ref(fig:eff-Nomogram-plot) (下方图) 为图eff Nomogram plot概览。

**(对应文件为 `Figure+Table/eff-Nomogram-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/eff-Nomogram-plot.pdf}
\caption{Eff Nomogram plot}\label{fig:eff-Nomogram-plot}
\end{center}

Figure \@ref(fig:eff-Bootstrap-calibration) (下方图) 为图eff Bootstrap calibration概览。

**(对应文件为 `Figure+Table/eff-Bootstrap-calibration.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/eff-Bootstrap-calibration.pdf}
\caption{Eff Bootstrap calibration}\label{fig:eff-Bootstrap-calibration}
\end{center}

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Re-sample
:}

\vspace{0.5em}

    500

\vspace{2em}


\textbf{
C-index
:}

\vspace{0.5em}

    0.955419953063854

\vspace{2em}


\textbf{
P-value
:}

\vspace{0.5em}

    1.99802984677255e-08

\vspace{2em}


\textbf{
95\% CI
:}

\vspace{0.5em}

    0.896247585330518 ~ 0.985578548943049

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:eff-ROC) (下方图) 为图eff ROC概览。

**(对应文件为 `Figure+Table/eff-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/eff-ROC.pdf}
\caption{Eff ROC}\label{fig:eff-ROC}
\end{center}

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
AUC
:}

\vspace{0.5em}

    0.944700460829493

\vspace{2em}


\textbf{
95\% CI
:}

\vspace{0.5em}

    0.899605215216947, 0.989795706442039

\vspace{2em}


\textbf{
P-value
:}

\vspace{0.5em}

    3.12831012478442e-83

\vspace{2em}
\end{tcolorbox}
\end{center}

Table \@ref(tab:eff-ROC-data) (下方表格) 为表格eff ROC data概览。

**(对应文件为 `Figure+Table/eff-ROC-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有22行2列，以下预览的表格可能省略部分数据；表格含有19个唯一`Sensitivities'。
\end{tcolorbox}
\end{center}

Table: (\#tab:eff-ROC-data)Eff ROC data

|Sensitivities     |Specificities     |
|:-----------------|:-----------------|
|1                 |0                 |
|1                 |0.653061224489796 |
|0.967741935483871 |0.693877551020408 |
|0.935483870967742 |0.795918367346939 |
|0.903225806451613 |0.816326530612245 |
|0.870967741935484 |0.857142857142857 |
|0.870967741935484 |0.877551020408163 |
|0.774193548387097 |0.918367346938776 |
|0.741935483870968 |0.918367346938776 |
|0.709677419354839 |0.959183673469388 |
|0.67741935483871  |0.959183673469388 |
|0.483870967741935 |0.979591836734694 |
|0.451612903225806 |0.979591836734694 |
|0.32258064516129  |0.979591836734694 |
|0.32258064516129  |1                 |
|...               |...               |





