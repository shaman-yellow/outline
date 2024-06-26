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
  \usepackage{tikz}
  \usepackage{auto-pst-pdf}
  \usepackage{pgfornament}
  \usepackage{pstricks-add}
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
\begin{center} \textbf{\Huge HNRNPH1、Wnt
与瘢痕增生的关联性挖掘} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-06-20}}
\end{textblock} \begin{textblock}{10}(3,7.3)
\Large \textcolor{black}{LiChuang Huang}
\end{textblock} \begin{textblock}{10}(3,11.3)
\Large \textcolor{black}{@立效研究院}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 摘要 {#abstract}





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-1) (下方图) 为图MAIN Fig 1概览。

**(对应文件为 `Figure+Table/MAIN-Fig-1.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig1.pdf}
\caption{MAIN Fig 1}\label{fig:MAIN-Fig-1}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/Treat-vs-control-DEGs.pdf \newline
./Figure+Table/DEG-hsa04310-visualization.png

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-2) (下方图) 为图MAIN Fig 2概览。

**(对应文件为 `Figure+Table/MAIN-Fig-2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig2.pdf}
\caption{MAIN Fig 2}\label{fig:MAIN-Fig-2}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/SCSA-Cell-type-annotation.pdf \newline
./Figure+Table/Violing-plot-of-Wnt-DEGs-of-Curcumin-affected.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}





\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Tiff figures' 数据已全部提供。

**(对应文件为 `Figure+Table/TIFF2`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/TIFF2共包含2个文件。

\begin{enumerate}\tightlist
\item MAIN-Fig-1.tiff
\item MAIN-Fig-2.tiff
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

# 结论 {#dis}


\newpage

# 附：分析流程 {#workflow}


