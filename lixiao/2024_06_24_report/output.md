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
\begin{center} \textbf{\Huge } \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-06-24}}
\end{textblock} \begin{textblock}{10}(3,7.3)
\Large \textcolor{black}{LiChuang Huang}
\end{textblock} \begin{textblock}{10}(3,11.3)
\Large \textcolor{black}{@立效研究院}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents

\newpage

\pagenumbering{arabic}


# 摘要

使用 Rmarkdown + Latex + 自定义的 R 程序，在分析的同时，生成美观、规范的报告文档。

# 具体优化

## 目录

- 除了内容目录，还提供图片索引、表格索引。


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-00-24.png}
\caption{Unnamed chunk 5}\label{fig:unnamed-chunk-5}
\end{center}


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-01-26.png}
\caption{Unnamed chunk 6}\label{fig:unnamed-chunk-6}
\end{center}


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-01-32.png}
\caption{Unnamed chunk 7}\label{fig:unnamed-chunk-7}
\end{center}

## Figure

### 组图

- 图片所在定位。
- 组图所用材料定位。
- 自动化 figure 标记。
- 注释分界线 (避免内容混淆) 


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-03-13.png}
\caption{Unnamed chunk 8}\label{fig:unnamed-chunk-8}
\end{center}

### 分图

在组图的特点的基础上：

- 特定 Figure，将自动触发类似如下参数注释


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-06-22.png}
\caption{Unnamed chunk 9}\label{fig:unnamed-chunk-9}
\end{center}


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-08-49.png}
\caption{Unnamed chunk 10}\label{fig:unnamed-chunk-10}
\end{center}

## Table

- 类似 Figure 的文件定位。
- 所有提供的表格，都将在报告中提供概览。
- 必要内容，可触发自动列名称注释。


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-09-51.png}
\caption{Unnamed chunk 11}\label{fig:unnamed-chunk-11}
\end{center}

## 附加文件

包含附加文件时，触发对文件注释说明。


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-12-39.png}
\caption{Unnamed chunk 12}\label{fig:unnamed-chunk-12}
\end{center}

## 分析流程

### 自动化生成标题

- 标题格式为：分级+方法+分析内容+标记
- 分析与标题生成同步，分析结束后，可借程序生成如下内容，发送 AI 获取注释 (见 \@ref(ai)) 


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-22-04.png}
\caption{Unnamed chunk 13}\label{fig:unnamed-chunk-13}
\end{center}

### AI 注释 (ChatGPT 4 分析流程说明) {#ai}

结合自动标题，可对分析流程进行 AI 注释，嵌入文档。


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-18-25.png}
\caption{Unnamed chunk 14}\label{fig:unnamed-chunk-14}
\end{center}

## 原代码 (如必要) 

- 如必要，可生成代码块，与分析内容一一对应。


\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-06-24 16-26-21.png}
\caption{Unnamed chunk 15}\label{fig:unnamed-chunk-15}
\end{center}

