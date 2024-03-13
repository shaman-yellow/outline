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
\begin{center} \textbf{\Huge 建立风险模型}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-12}}
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



## 方法

Mainly used method:

- R package `pROC` used for building ROC curve.
- R package `rms` used for Logistic regression and nomogram visualization.
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 数据预处理



## 结果


\noindent \textbf{Logistic Regression Model}

\begin{verbatim}
rms::lrm(formula = formula, data = data, x = T, y = T)
\end{verbatim}

{\fontfamily{phv}\selectfont \begin{center}\begin{tabular}{|c|c|c|c|}\hline
&Model Likelihood&Discrimination&Rank Discrim.\\
&Ratio Test&Indexes&Indexes\\\hline
Obs~\hfill 390&LR $\chi^{2}$~\hfill 357.02&$R^{2}$~\hfill 0.833&$C$~\hfill 0.974\\
~~No arrhythmia~\hfill 260&d.f.~\hfill 7&$R^{2}_{7,390}$~\hfill 0.592&$D_{xy}$~\hfill 0.948\\
~~Arrhythmia~\hfill 130&Pr$(>\chi^{2})$~\hfill \textless 0.0001&$R^{2}_{7,260}$~\hfill 0.740&$\gamma$~\hfill 0.948\\
$\max|\frac{\partial\log L}{\partial \beta}|$~\hfill $1\!\times\!10^{-5}$&&Brier~\hfill 0.053&$\tau_{a}$~\hfill 0.423\\
\hline
\end{tabular}
\end{center}}

\setlongtables\begin{longtable}{lrrrr}\hline
\multicolumn{1}{l}{}&\multicolumn{1}{c}{$\hat{\beta}$}&\multicolumn{1}{c}{S.E.}&\multicolumn{1}{c}{Wald $Z$}&\multicolumn{1}{c}{Pr$(>|Z|)$}\tabularnewline
\hline
\endhead
\hline
\endfoot
Intercept&~-16.6589~&~3.5388~&-4.71&\textless 0.0001\tabularnewline
Diastolic blood pressure (mmHg)&~ -0.0582~&~0.0189~&-3.08&0.0021\tabularnewline
Cardiac\_function\_classification=III-IV level&~  2.1983~&~0.4797~& 4.58&\textless 0.0001\tabularnewline
Creatinine (μmol/L)&~  0.0668~&~0.0191~& 3.49&0.0005\tabularnewline
CRP (mg/L)&~  0.3679~&~0.0805~& 4.57&\textless 0.0001\tabularnewline
NT-ProBNP peak (pg/mL)&~  0.0059~&~0.0009~& 6.92&\textless 0.0001\tabularnewline
TBIL (μmol/L)&~  0.0752~&~0.0335~& 2.25&0.0247\tabularnewline
RDW (\%)&~  0.1389~&~0.0572~& 2.43&0.0152\tabularnewline
\hline
\end{longtable}
\addtocounter{table}{-1}

Figure \@ref(fig:heart-Nomogram-plot) (下方图) 为图heart Nomogram plot概览。

**(对应文件为 `Figure+Table/heart-Nomogram-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/heart-Nomogram-plot.pdf}
\caption{Heart Nomogram plot}\label{fig:heart-Nomogram-plot}
\end{center}

Figure \@ref(fig:heart-Bootstrap-calibration) (下方图) 为图heart Bootstrap calibration概览。

**(对应文件为 `Figure+Table/heart-Bootstrap-calibration.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/heart-Bootstrap-calibration.pdf}
\caption{Heart Bootstrap calibration}\label{fig:heart-Bootstrap-calibration}
\end{center}

Figure \@ref(fig:heart-ROC) (下方图) 为图heart ROC概览。

**(对应文件为 `Figure+Table/heart-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/heart-ROC.pdf}
\caption{Heart ROC}\label{fig:heart-ROC}
\end{center}




