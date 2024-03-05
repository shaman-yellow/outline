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
Sepsis差异代谢物和热图绘制} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-04}}
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

- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}


## 数据来源


Lipid metabolic signatures deviate in sepsis survivors compared to non-survivors
(PMID:33304464) [@LipidMetabolicKhaliq2020]

Supplementary Table 7: Rat sepsis model biochemical and metabolomic data.

 
`LipidMetabolicKhaliq2020 S7' 数据已全部提供。

**(对应文件为 `Figure+Table/LipidMetabolicKhaliq2020-S7`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/LipidMetabolicKhaliq2020-S7共包含2个文件。

\begin{enumerate}\tightlist
\item 1\_Data.csv
\item 2\_legend.csv
\end{enumerate}\end{tcolorbox}
\end{center}



## 差异分析

Table \@ref(tab:Sepsis-vs-Control-metabolites) (下方表格) 为表格Sepsis vs Control metabolites概览。

**(对应文件为 `Figure+Table/Sepsis-vs-Control-metabolites.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有86行7列，以下预览的表格可能省略部分数据；表格含有86个唯一`rownames'。
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

Table: (\#tab:Sepsis-vs-Control-metabolites)Sepsis vs Control metabolites

|rownames      |logFC         |AveExpr       |t             |P.Value       |adj.P.Val     |B             |
|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|interleuki... |4.56047476... |9.12791682... |12.3429495... |1.30461220... |3.28762276... |21.0095510... |
|Oxytocin      |1.20738187... |4.78422477... |10.9425134... |2.89129286... |3.64302900... |17.9003821... |
|Noradrenaline |2.41244229... |1.15069029... |8.28652664... |2.04135641... |1.71473938... |11.3045654... |
|Aldosterone   |1.70242514... |7.46275850... |7.25768341... |3.29982741... |2.07889127... |8.50900615... |
|Testosterone  |-0.5954417... |6.86184959... |-7.1433392... |4.52972768... |2.28298275... |8.19116098... |
|interleukin-6 |4.56940891... |8.41883936... |6.81407920... |1.13632768... |4.77257629... |7.26902002... |
|Phosphatid... |-0.6949464... |-1.3426611... |-6.0618145... |9.62990090... |3.46676432... |5.13114219... |
|Adrenaline    |0.58302921... |12.9933938... |5.67339688... |2.94440285... |8.86195594... |4.01670761... |
|cardiac ou... |-0.4454982... |6.96508434... |-5.6245421... |3.39024672... |8.86195594... |3.87633322... |
|High-densi... |-0.5885086... |-0.2300975... |-5.4803299... |5.14207569... |0.00011780... |3.46194103... |
|stroke volume |-0.5317655... |-1.7342613... |-5.4240458... |6.05048026... |0.00012706... |3.30024247... |
|Proline       |-0.8965239... |7.70837944... |-5.2836024... |9.08106627... |0.00017603... |2.89700218... |
|B-type nat... |2.31639744... |8.34682229... |5.12133438... |1.45166920... |0.00026130... |2.43183728... |
|lysoPhosph... |-0.4674402... |6.38346176... |-4.8991930... |2.75688431... |0.00043155... |1.79717803... |
|Aspartate ... |1.19509294... |7.43782001... |4.89413846... |2.79736126... |0.00043155... |1.78277497... |
|...           |...           |...           |...           |...           |...           |...           |



## 热图

注：以下热图去除了包含缺失数据的代谢物。

Figure \@ref(fig:Defferential-metabolites) (下方图) 为图Defferential metabolites概览。

**(对应文件为 `Figure+Table/Defferential-metabolites.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Defferential-metabolites.pdf}
\caption{Defferential metabolites}\label{fig:Defferential-metabolites}
\end{center}





