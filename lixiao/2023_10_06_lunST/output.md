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
\begin{center} \textbf{\Huge re-map} \vspace{4em}
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



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 主图 {#abstract}





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-1) (下方图) 为图MAIN Fig 1概览。

**(对应文件为 `Figure+Table/MAIN-Fig-1.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/fig1.pdf}
\caption{MAIN Fig 1}\label{fig:MAIN-Fig-1}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/SCSA-annotation.pdf \newline
./Figure+Table/copykat\_heatmap.png \newline
./Figure+Table/cell-mapped-of-copyKAT-prediction.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-2) (下方图) 为图MAIN Fig 2概览。

**(对应文件为 `Figure+Table/MAIN-Fig-2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/fig2.pdf}
\caption{MAIN Fig 2}\label{fig:MAIN-Fig-2}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/re-classify-of-cancer-cells.pdf \newline
./Figure+Table/gene-module-of-co-expression-analysis.pdf
\newline ./Figure+Table/pseudotime-add.pdf \newline
./Figure+Table/cancer-cells-subtypes.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-3) (下方图) 为图MAIN Fig 3概览。

**(对应文件为 `Figure+Table/MAIN-Fig-3.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/fig3.pdf}
\caption{MAIN Fig 3}\label{fig:MAIN-Fig-3}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/cancer-cells-in-epithelial--or-basal-cells.pdf
\newline
./Figure+Table/enrichment-of-markers-of-cancer-2-cells.pdf
\newline
./Figure+Table/enrichment-of-markers-of-cancer-3-cells.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-4) (下方图) 为图MAIN Fig 4概览。

**(对应文件为 `Figure+Table/MAIN-Fig-4.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/fig4.pdf}
\caption{MAIN Fig 4}\label{fig:MAIN-Fig-4}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/cell-communication-heatmap.pdf \newline
./Figure+Table/visualization-of-communication-between-macrophage-and-cancer-cells.pdf
\newline ./Figure+Table/hsa04151.pathview.png \newline
./Figure+Table/selected-pseudo-genes.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}




\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Tiff figures' 数据已全部提供。

**(对应文件为 `Figure+Table/TIFF`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/TIFF共包含4个文件。

\begin{enumerate}\tightlist
\item MAIN-Fig-1.tiff
\item MAIN-Fig-2.tiff
\item MAIN-Fig-3.tiff
\item MAIN-Fig-4.tiff
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}


# 附图  (可选) 

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-16) (下方图) 为图unnamed chunk 16概览。

**(对应文件为 `./Figure+Table/spatial-sample-QC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/spatial-sample-QC.pdf}
\caption{Unnamed chunk 16}\label{fig:unnamed-chunk-16}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-17) (下方图) 为图unnamed chunk 17概览。

**(对应文件为 `./Figure+Table/PCA-ranking.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/PCA-ranking.pdf}
\caption{Unnamed chunk 17}\label{fig:unnamed-chunk-17}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-18) (下方图) 为图unnamed chunk 18概览。

**(对应文件为 `./Figure+Table/overview-of-cells-communication.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/overview-of-cells-communication.pdf}
\caption{Unnamed chunk 18}\label{fig:unnamed-chunk-18}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-19) (下方图) 为图unnamed chunk 19概览。

**(对应文件为 `./Figure+Table/all-cells-communication-significance.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/all-cells-communication-significance.pdf}
\caption{Unnamed chunk 19}\label{fig:unnamed-chunk-19}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

