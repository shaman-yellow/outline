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






\begin{titlepage} \newgeometry{top=6.5cm}
\ThisCenterWallPaper{1.12}{~/outline/bosai//cover_page_analysis.pdf}
\begin{center} \textbf{\huge 骨肉瘤} \vspace{4em}
\begin{textblock}{10}(3,4.85) \Large
\textbf{\textcolor{black}{BSZD231122}}
\end{textblock} \begin{textblock}{10}(3,5.8)
\Large \textbf{\textcolor{black}{黄礼闯}}
\end{textblock} \begin{textblock}{10}(3,6.75)
\Large \textbf{\textcolor{black}{分析优化}}
\end{textblock} \begin{textblock}{10}(3,7.7)
\Large \textbf{\textcolor{black}{杨立宇}}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 分析流程 {#abstract}



# 材料和方法 {#introduction}




# 分析结果 {#workflow}



## Seurat 单细胞数据分析 (OS)





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/OS-Markers-in-cell-types.pdf}
\caption{OS Markers in cell types}\label{fig:OS-Markers-in-cell-types}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
query
:}

\vspace{0.5em}

    Identify cell types of Osteosarcoma cells using the
following markers separately for each row. Only provide the
cell type name (for each row). Show numbers before the
name. Some can be a mixture of multiple cell types
(separated by ' \& '). Then, provide 3 classical markers
that distinguish the cell type from other cells (separated
by '; ').  (e.g., 1. X Cell \& Y Cell; Marker1; Marker2;
Marker3) 1.
FTL,APOC1,APOE,LGMN,C1QB,CTSD,CTSB,C1QA,PSAP,TYROBP,RNASE1,FTH1,TREM2,C1QC,IGSF6,FOLR2,FCER1G,FCGBP,TMEM176B,FCGRT,CYBA,GYPC,CTSZ,CAPG,LGALS3,MS4A7,AIF1,CD68,CTSS,GPNMB
2.
MMP9,PTMA,VIM,RPS2,RPS6,ENO1,EMP3,RPS12,NDUFS8,RPS23,MALAT1,RPL13A,RPLP2,RPS14,COX4I1,PKM,COX5A,RPL8,RGS10,RPL27A,HSPE1,S100A4,ANXA2,ATP5MC3,HSPD1,PFN1,CYC1,RPL21,ATP5F1B,RPL32
3. LUM,RPL39,TIMP1,HLA-B,RPS27,ID3,RPL35,CLEC11...

\vspace{2em}


\textbf{
feedback
:}

\vspace{0.5em}

    1. Macrophage; CD68; AIF1; FCGR1A 2. Mesenchymal Stem
Cell; VIM; ENO1; S100A4 3. Fibroblast; TIMP1; DCN; THY1 4.
Monocyte; CD14; HLA-DMA; TYROBP 5. Mesenchymal Stem Cell;
STMN1; TUBB; TOP2A 6. Macrophage; CD68; TYROBP; FCGR1A 7.
Dendritic Cell; HLA-DRA; CD74; CCL3 8. Osteoblast; IBSP;
S100A13; RPL39 9. Osteoclast; CTSK; ACP5; MMP9 10.
Osteoblast; COL1A1; SPARC; BGN 11. Pericyte; RGS5; ACTA2;
MYL9 12. Endothelial Cell; CLDN5; ESAM; PLVAP 13. Dendritic
Cell; HLA-DRA; HLA-DPA1; CD74 14. T Cell; CD2; GZMA; CCL5
15. T Cell; CD3D; GZMA; CCL5 16. Dendritic Cell; HLA-DRA;
CD74; APOE 17. Fibroblast; COL6A1; CLEC11A; SPARCL1 18.
Mesenchymal Stem Cell; TUBA1B; STMN1; HMGB1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/OS-Markers-in-cell-types-content`)**

## CopyKAT 癌细胞鉴定 (BC2)



## CopyKAT 癌细胞鉴定 (BC3)





## scFEA 单细胞数据的代谢通量预测 (OS)




# 总结 {#conclusion}


