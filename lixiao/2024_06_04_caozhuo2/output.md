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
\begin{center} \textbf{\Huge
空代+空转+单细胞的联合分析} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-06-19}}
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

在本研究中，我们通过空间代谢组学和空间转录组学方法分析了肺癌患者样本，以探讨癌细胞和癌周组织之间的代谢和基因表达差异。发现了癌细胞与癌周组织的转化途径。进一步的差异分析揭示了多个差异代谢物，通过scFEA工具预测细胞水平的代谢通量变化，结合单细胞数据和空间代谢组数据验证了 3 个共同的差异代谢物，Glutamic acid (C00025), Uridine 5'-monophosphate (C00105), Adenosine 5'-monophosphate (C00020)。拟时分析进一步揭示了癌变过程中的关键基因，并通过PPI网络构建发现了这些基因与代谢变化相关的直接物理作用，有 4 个基因被筛选为可进一步分析验证: SOX2, A2M, CD74, DSP。



曹卓订单，空代+空转+单细胞的联合分析

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- The R package `Cardinal` used for analyzing mass spectrometry imaging datasets[@CardinalV3ABemis2023].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- R package `Seurat` used for multiple dataset integration[@IntegratedAnalHaoY2021; @ComprehensiveIStuart2019].
- R package `FELLA` used for metabolite enrichment analysis[@FellaAnRPacPicart2018].
- The `scFEA` (python) was used to estimate cell-wise metabolic via single cell RNA-seq data[@AGraphNeuralAlgham2021].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `Monocle3` used for cell pseudotime analysis[@ReversedGraphQiuX2017; @TheDynamicsAnTrapne2014].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- R package `Seurat` used for spatial scRNA-seq analysis[@IntegratedAnalHaoY2021; @ComprehensiveIStuart2019].
- The R package `Seurat` used for scRNA-seq processing[@IntegratedAnalHaoY2021; @ComprehensiveIStuart2019].
- `SCSA` (python) used for cell type annotation[@ScsaACellTyCaoY2020].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

## 空间代谢组分析

在空间代谢组分析部分，对数据集预处理后，首先对样本进行 PCA 聚类，见 Fig. \@ref(fig:MAIN-Fig-1)a，
Tumor 和 Peritumor 的聚类结果呈现了同一性和异同性，提示两者之间的转化途经。
随后，我们对两组数据进行差异分析，差异代谢物见 Tab. \@ref(tab:INTEGRATE-Significant-differences-features)，
Fig. \@ref(fig:MAIN-Fig-1)b 展示了 Top 10 的代谢物的峰强度。
将差异代谢物以 FELLA 包提供的 PageRank (Fig. \@ref(fig:MAIN-Fig-1)c) 和 Hypergeom (Fig. \@ref(fig:MAIN-Fig-1)d)
算法进行 KEGG 富集分析。PageRank 提供的富集网络可以帮助理解差异代谢物彼此之间关联以及与通路、模块、酶反应之间
的联系。一共有 12 个差异代谢物被富集。
Fig. \@ref(fig:MAIN-Fig-1)d, "Nucleotide metabolism" 等通路的富集，揭示了癌变后细胞代谢的变化
(癌细胞快速增殖，需要大量的核苷酸来支持DNA和RNA的合成) 。
值得注意的是，"bile secretion" 等通路，在单细胞数据集的拟时分析中得到印证 (Fig. \@ref(fig:MAIN-Fig-5)c)。





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

    ./Figure+Table/INTEGRATE-PCA-plot.pdf \newline
./Figure+Table/INTEGRATE-boxplot-of-top-features.pdf
\newline
./Figure+Table/TOPS-enrichment-with-algorithm-PageRank.pdf
\newline
./Figure+Table/Tops-Compounds-hypergeom-KEGG-enrichment.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 空间转录组分析

以癌组织切片和癌周组织切片进行空间转录组数据分析。我们首先分别对两组数据进行细胞聚类、注释，
Fig. \@ref(fig:MAIN-Fig-2)a、b。其中，癌组织以 copyKAT 预测非整倍体 (Fig. \@ref(fig:MAIN-Fig-2)c)，判断为癌细胞。
 (注，这部分内容取自前一次该客户的分析结果，没有重新分析。) 
 随后，将两部分的单细胞数据集成，以备后续分析 (Fig. \@ref(fig:MAIN-Fig-2)d)。
 随后，我们将主要关注于 Epithelial_cell_Peritumoral_cell, Cancer_cell。





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

    ./Figure+Table/CANCER-The-scsa-cell.pdf \newline
./Figure+Table/PERI-The-scsa-cell.pdf \newline
./Figure+Table/copyKAT-prediction-of-aneuploidy.png
\newline ./Figure+Table/The-Integrated-cells.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 单细胞数据集预测代谢通量

空间转录组和空间代谢组的样本数据都来自于肺癌患者的样本数据，那么它们的本质将揭示相同的病机。
应该认为，代谢变化与单细胞水平的基因表达变化是相互反映的。
这里，通过借用 scFEA 工具，以单细胞数据 (取 Epithelial_cell_Peritumoral_cell, Cancer_cell)
预测细胞水平的代谢通量变化，随后和我们的空间代谢组分析结果
相互印证。Fig. \@ref(fig:MAIN-Fig-3)a 为 scFEA 训练数据时的收敛曲线。
预测细胞水平的代谢通量变化，随后进行差异分析 Fig. \@ref(fig:MAIN-Fig-3)b。
差异分析结果表格见 Tab. \@ref(tab:FLUX-data-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs)。
之后，将这里代谢通量变化的对应代谢物，与空间转录组的差异代谢物，取交集，Fig. \@ref(fig:MAIN-Fig-3)c。
我们发现了三个同时在空间转录组水平和空间代谢组水平反映的差异代谢物：
Glutamic acid (C00025), Uridine 5'-monophosphate (C00105), Adenosine 5'-monophosphate (C00020)。
回到空间代谢组数据考察三个代谢物在癌症组织和癌周组织的含量水平。
一共有 4 个 Feature 被鉴定为这三个代谢物 (可能是不同的加合离子型)， 
Fig. \@ref(fig:MAIN-Fig-3)d、e、f、g。

针对这三个代谢物，我们重新进行了富集分析，Fig. \@ref(fig:MAIN-Fig-4)a、b。
富集结果与此前的富集分析结果一致，体现了癌变后细胞内的特征性代谢变化。
此外，Fig. \@ref(fig:MAIN-Fig-4)b 的网络图体现了三个代谢物在机体内的密切关联。
随后，我们通过获取 scFEA 反映代谢通量变化的基因，对其进行 KEGG 富集分析，
Fig. \@ref(fig:MAIN-Fig-4)d。
Fig. \@ref(fig:MAIN-Fig-4)a 和 Fig. \@ref(fig:MAIN-Fig-4)d 共同揭示了一些通路，
我们将其汇总于 Fig. \@ref(fig:MAIN-Fig-4)c。
“Nicotinate and nicotinamide metabolism” 的发现，与文献报道的相一致[@IntegratedMetaFahrma2017]。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-3) (下方图) 为图MAIN Fig 3概览。

**(对应文件为 `Figure+Table/MAIN-Fig-3.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig3.pdf}
\caption{MAIN Fig 3}\label{fig:MAIN-Fig-3}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/INTEGRATED-Convergency-of-the-loss-terms-during-training.png
\newline
./Figure+Table/FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs.pdf
\newline
./Figure+Table/Intersection-of-Diff-flux-with-Diff-meta.pdf
\newline
./Figure+Table/Feature-image-visualizations/1\_Feature\_13\_C00025.pdf
\newline
./Figure+Table/Feature-image-visualizations/2\_Feature\_25\_C00025.pdf
\newline
./Figure+Table/Feature-image-visualizations/3\_Feature\_123\_C00105.pdf
\newline
./Figure+Table/Feature-image-visualizations/4\_Feature\_131\_C00020.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-4) (下方图) 为图MAIN Fig 4概览。

**(对应文件为 `Figure+Table/MAIN-Fig-4.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig4.pdf}
\caption{MAIN Fig 4}\label{fig:MAIN-Fig-4}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/INTERSECT-Compounds-hypergeom-KEGG-enrichment.pdf
\newline
./Figure+Table/INTERSECT-enrichment-with-algorithm-PageRank.pdf
\newline ./Figure+Table/FLUX-Co-enriched-KEGG-pathway.pdf
\newline ./Figure+Table/FLUX-KEGG-enrichment.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 癌细胞拟时分析

对 Epithelial_cell_Peritumoral_cell, Cancer_cell 进行拟时分析。
拟时分析结果揭示了明确的癌变过程，Fig. \@ref(fig:MAIN-Fig-5)a、b。
随后，根据拟时分析图像，以 "Graph test" 筛选拟时变化过程中的关键基因。
对 Top 50 的基因进行了富集分析，以及拟时热图注释。

随后，为了发现拟时变化过程中的关键基因与此前揭示的代谢物之间 (控制代谢变化相关的基因，即 scFEA 与代谢通量相关的基因)
的关联，我们将这些对应基因以 STRINGdb 构建 PPI 网络 Fig. \@ref(fig:MAIN-Fig-6)a。
通过深入挖掘这些蛋白质 (基因) 之间的关联，获取 Fig. \@ref(fig:MAIN-Fig-6)b，
可以发现，一共有 4 个拟时变化过程中的关键基因 (蛋白质) ，与代谢变化对应的基因 (蛋白质) 有直接物理作用 (physical) 。
这些基因为：SOX2, A2M, CD74, DSP。
其中，SOX2 是与其它蛋白质关联最为密切的对象 (MCC 得分) 。
它们在单细胞数据集中的表达见 Fig. \@ref(fig:MAIN-Fig-6)c。
其中，SOX2 主要在癌细胞中高表达，而 A2M 在癌细胞中的表达量下降了 (结合 Fig. \@ref(fig:MAIN-Fig-5)a、b) 。
这些基因在空间转录组的组织切片中的表达见 Fig. \@ref(fig:MAIN-Fig-6)d。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-5) (下方图) 为图MAIN Fig 5概览。

**(对应文件为 `Figure+Table/MAIN-Fig-5.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig5.pdf}
\caption{MAIN Fig 5}\label{fig:MAIN-Fig-5}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/INTEGRATED-principal-points.pdf \newline
./Figure+Table/INTEGRATED-pseudotime.pdf \newline
./Figure+Table/GRAPHTOPS-KEGG-enrichment.pdf \newline
./Figure+Table/INTEGRATED-Pseudotime-heatmap-of-genes.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:MAIN-Fig-6) (下方图) 为图MAIN Fig 6概览。

**(对应文件为 `Figure+Table/MAIN-Fig-6.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/fig6.pdf}
\caption{MAIN Fig 6}\label{fig:MAIN-Fig-6}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Composition
:}

\vspace{0.5em}

    ./Figure+Table/PPI-raw-PPI-network.pdf \newline
./Figure+Table/PPI-Top-MCC-score.pdf \newline
./Figure+Table/Dimension-plot-of-expression-level-of-the-genes.pdf
\newline ./Figure+Table/Spatial-feature-plot.pdf

\vspace{2em}
\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}






\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Tiff figures' 数据已全部提供。

**(对应文件为 `Figure+Table/TIFF`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/TIFF共包含6个文件。

\begin{enumerate}\tightlist
\item MAIN-Fig-1.tiff
\item MAIN-Fig-2.tiff
\item MAIN-Fig-3.tiff
\item MAIN-Fig-4.tiff
\item MAIN-Fig-5.tiff
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

# 结论 {#dis}

见 \@ref(abstract) 和 \@ref(results)

\newpage

# 附：分析流程 {#workflow}




## 空间代谢组数据分析

空间代谢组数据分析包括数据收集、预处理和分析。使用不同的分析工具和方法，我们可以揭示样本中代谢物的空间分布和变化情况。这部分的重点是数据的整合和分析流程的描述，以确保结果的准确性和可重复性。


### Cardinal 空间代谢组数据分析 (INTEGRATE)

Cardinal 是一种用于空间代谢组数据分析的强大工具，能够处理和分析高维数据。通过对数据进行整合和分析，我们可以揭示样本中代谢物的空间分布和动态变化，从而为进一步的生物学研究提供线索。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:INTEGRATE-all-features) (下方表格) 为表格INTEGRATE all features概览。

**(对应文件为 `Figure+Table/INTEGRATE-all-features.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有218行15列，以下预览的表格可能省略部分数据；含有218个唯一`i'。
\end{tcolorbox}
\end{center}

Table: (\#tab:INTEGRATE-all-features)INTEGRATE all features

|i   |mz        |count  |freq      |mz.sub   |m.z       |Name      |Notation  |Formula  |KEGG   |
|:---|:---------|:------|:---------|:--------|:---------|:---------|:---------|:--------|:------|
|1   |96.000... |118    |0.0005... |96.0007  |96.000... |NA        |[M-H]-    |NA       |NA     |
|2   |96.960... |230943 |0.9866... |96.9603  |96.960... |sulfate   |[M-H]-    |H2O4S    |NA     |
|3   |98.956... |1      |4.2722... |98.956   |98.956... |NA        |[M-H-H]2- |NA       |NA     |
|4   |99.925... |7      |2.9905... |99.926   |99.926... |NA        |[M-H]-    |NA       |NA     |
|5   |102.05... |2      |8.5444... |102.0562 |102.05... |Dimeth... |[M-H]-    |C4H9NO2  |C01026 |
|6   |108.00... |379    |0.0016... |108.0006 |108.00... |NA        |[M-H]-    |NA       |NA     |
|7   |111.00... |26     |0.0001... |111.0089 |111.00... |Glutac... |[M-H-H... |C5H6O4   |C02214 |
|8   |115.92... |1      |4.2722... |115.9207 |115.92... |NA        |[M-H]-    |NA       |NA     |
|9   |118.89... |9      |3.8449... |118.8996 |118.89... |NA        |[M-H]-    |NA       |NA     |
|10  |120.00... |135    |0.0005... |120.0006 |120.00... |NA        |[M-H-H]2- |NA       |NA     |
|11  |121.00... |26     |0.0001... |121.0083 |121.00... |NA        |[M-H]-    |NA       |NA     |
|12  |124.00... |233542 |0.9977... |124.0074 |124.00... |Taurine   |[M-H]-    |C2H7NO3S |C00245 |
|13  |128.03... |2469   |0.0105... |128.0354 |128.03... |Glutam... |[M-H-H... |C5H9NO4  |C00025 |
|14  |128.89... |170277 |0.7274... |128.8922 |128.89... |NA        |[M-H]-    |NA       |NA     |
|15  |132.00... |321    |0.0013... |132.0006 |132.00... |NA        |[M-H]-    |NA       |NA     |
|... |...       |...    |...       |...      |...       |...       |...       |...      |...    |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATE-PCA-plot) (下方图) 为图INTEGRATE PCA plot概览。

**(对应文件为 `Figure+Table/INTEGRATE-PCA-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATE-PCA-plot.pdf}
\caption{INTEGRATE PCA plot}\label{fig:INTEGRATE-PCA-plot}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:INTEGRATE-Significant-differences-features) (下方表格) 为表格INTEGRATE Significant differences features概览。

**(对应文件为 `Figure+Table/INTEGRATE-Significant-differences-features.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有97行16列，以下预览的表格可能省略部分数据；含有97个唯一`i'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:INTEGRATE-Significant-differences-features)INTEGRATE Significant differences features

|i   |mz        |statistic |pvalue    |fdr       |mz.sub   |m.z       |Name      |Notation  |Formula   |
|:---|:---------|:---------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|
|2   |96.960... |15.186... |9.7420... |0.0005... |96.9603  |96.960... |sulfate   |[M-H]-    |H2O4S     |
|11  |121.00... |8.3623... |0.0038... |0.0104... |121.0083 |121.00... |NA        |[M-H]-    |NA        |
|12  |124.00... |20.761... |5.2004... |8.0979... |124.0074 |124.00... |Taurine   |[M-H]-    |C2H7NO3S  |
|13  |128.03... |19.401... |1.0590... |0.0001... |128.0354 |128.03... |Glutam... |[M-H-H... |C5H9NO4   |
|21  |140.02... |15.018... |0.0001... |0.0006... |140.0119 |140.01... |O-Phos... |[M-H]-    |C2H8NO4P  |
|24  |144.86... |11.260... |0.0007... |0.0029... |144.8697 |144.86... |NA        |[M-H]-    |NA        |
|25  |146.04... |17.324... |3.1515... |0.0002... |146.0459 |146.04... |Glutam... |[M-H]-    |C5H9NO4   |
|26  |146.86... |9.0877... |0.0025... |0.0073... |146.8668 |146.86... |NA        |[M-H]-    |NA        |
|28  |151.89... |9.8327... |0.0017... |0.0054... |NA       |NA        |NA        |NA        |NA        |
|29  |152.99... |6.5953... |0.0102... |0.0254... |152.9958 |152.99... |3-phos... |[M-H]-    |C3H7O5P   |
|31  |154.91... |11.696... |0.0006... |0.0024... |154.9168 |154.91... |NA        |[M-H]-    |NA        |
|36  |160.00... |6.5840... |0.0102... |0.0254... |160.0074 |160.00... |NA        |[M-H]-    |NA        |
|37  |160.84... |17.149... |3.4541... |0.0002... |160.8421 |160.84... |NA        |[M-H]-    |NA        |
|41  |168.04... |9.6952... |0.0018... |0.0057... |168.0432 |168.04... |Phosph... |[M-H]-    |C4H12NO4P |
|43  |169.90... |8.7556... |0.0030... |0.0087... |NA       |NA        |NA        |NA        |NA        |
|... |...       |...       |...       |...       |...      |...       |...       |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATE-boxplot-of-top-features) (下方图) 为图INTEGRATE boxplot of top features概览。

**(对应文件为 `Figure+Table/INTEGRATE-boxplot-of-top-features.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATE-boxplot-of-top-features.pdf}
\caption{INTEGRATE boxplot of top features}\label{fig:INTEGRATE-boxplot-of-top-features}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

### FELLA 代谢物富集分析 (TOPS)

FELLA 工具用于代谢物富集分析，通过将代谢物与已知的代谢通路进行比对，可以识别出富集的代谢通路。这有助于我们理解代谢物的功能和其在生物过程中的角色。






\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:TOPS-enrichment-with-algorithm-PageRank) (下方图) 为图TOPS enrichment with algorithm PageRank概览。

**(对应文件为 `Figure+Table/TOPS-enrichment-with-algorithm-PageRank.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TOPS-enrichment-with-algorithm-PageRank.pdf}
\caption{TOPS enrichment with algorithm PageRank}\label{fig:TOPS-enrichment-with-algorithm-PageRank}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Tops-Compounds-hypergeom-KEGG-enrichment) (下方图) 为图Tops Compounds hypergeom KEGG enrichment概览。

**(对应文件为 `Figure+Table/Tops-Compounds-hypergeom-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Tops-Compounds-hypergeom-KEGG-enrichment.pdf}
\caption{Tops Compounds hypergeom KEGG enrichment}\label{fig:Tops-Compounds-hypergeom-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:TOPS-data-of-enrichment-with-algorithm-PageRank) (下方表格) 为表格TOPS data of enrichment with algorithm PageRank概览。

**(对应文件为 `Figure+Table/TOPS-data-of-enrichment-with-algorithm-PageRank.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有249行7列，以下预览的表格可能省略部分数据；含有249个唯一`name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TOPS-data-of-enrichment-with-algorithm-PageRank)TOPS data of enrichment with algorithm PageRank

|name     |com |NAME          |label         |input  |abbrev.name   |type    |
|:--------|:---|:-------------|:-------------|:------|:-------------|:-------|
|hsa00061 |1   |Fatty acid... |Fatty acid... |Others |Fatty acid... |Pathway |
|hsa00062 |1   |Fatty acid... |Fatty acid... |Others |Fatty acid... |Pathway |
|hsa00120 |1   |Primary bi... |Primary bi... |Others |Primary bi... |Pathway |
|hsa00230 |1   |Purine met... |Purine met... |Others |Purine met... |Pathway |
|hsa00430 |1   |Taurine an... |Taurine an... |Others |Taurine an... |Pathway |
|hsa00563 |1   |Glycosylph... |Glycosylph... |Others |Glycosylph... |Pathway |
|hsa00564 |1   |Glyceropho... |Glyceropho... |Others |Glyceropho... |Pathway |
|hsa00590 |1   |Arachidoni... |Arachidoni... |Others |Arachidoni... |Pathway |
|hsa01040 |1   |Biosynthes... |Biosynthes... |Others |Biosynthes... |Pathway |
|hsa01232 |1   |Nucleotide... |Nucleotide... |Others |Nucleotide... |Pathway |
|hsa04071 |1   |Sphingolip... |Sphingolip... |Others |Sphingolip... |Pathway |
|hsa04080 |1   |Neuroactiv... |Neuroactiv... |Others |Neuroactiv... |Pathway |
|hsa04146 |1   |Peroxisome... |Peroxisome... |Others |Peroxisome... |Pathway |
|hsa04151 |1   |PI3K-Akt s... |PI3K-Akt s... |Others |PI3K-Akt s... |Pathway |
|hsa04216 |1   |Ferroptosi... |Ferroptosi... |Others |Ferroptosi... |Pathway |
|...      |... |...           |...           |...    |...           |...     |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:TOPS-data-of-enrichment-with-algorithm-Hypergeom) (下方表格) 为表格TOPS data of enrichment with algorithm Hypergeom概览。

**(对应文件为 `Figure+Table/TOPS-data-of-enrichment-with-algorithm-Hypergeom.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15行6列，以下预览的表格可能省略部分数据；含有15个唯一`KEGG.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:TOPS-data-of-enrichment-with-algorithm-Hypergeom)TOPS data of enrichment with algorithm Hypergeom

|KEGG.id  |Description   |Count |CompoundsI... |pvalue        |Compound_R... |
|:--------|:-------------|:-----|:-------------|:-------------|:-------------|
|hsa00430 |Taurine an... |6     |93            |1.26333822... |0.5           |
|hsa04976 |Bile secre... |7     |161           |1.26333822... |0.58333333... |
|hsa04151 |PI3K-Akt s... |5     |57            |2.94176160... |0.41666666... |
|hsa04146 |Peroxisome... |7     |279           |0.00023384... |0.58333333... |
|hsa00120 |Primary bi... |5     |130           |0.00090942... |0.41666666... |
|hsa04216 |Ferroptosi... |4     |59            |0.00090942... |0.33333333... |
|hsa01040 |Biosynthes... |5     |157           |0.00171085... |0.41666666... |
|hsa01232 |Nucleotide... |5     |154           |0.00171085... |0.41666666... |
|hsa04727 |GABAergic ... |3     |35            |0.00394520... |0.25          |
|hsa05169 |Epstein-Ba... |3     |36            |0.00394520... |0.25          |
|hsa04723 |Retrograde... |3     |39            |0.00456905... |0.25          |
|hsa04080 |Neuroactiv... |3     |41            |0.00487000... |0.25          |
|hsa00230 |Purine met... |5     |218           |0.00508159... |0.41666666... |
|hsa01523 |Antifolate... |3     |45            |0.00552169... |0.25          |
|hsa00770 |Pantothena... |4     |125           |0.00655730... |0.33333333... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 空间转录组分析

空间转录组分析通过整合空间信息和基因表达数据，揭示细胞在空间上的异质性和基因表达的空间分布。这部分的重点在于数据的获取、处理及分析方法的选择，以确保结果的准确性和生物学意义。


### Seurat 空间转录组分析 (CANCER)

Seurat 是一种广泛使用的单细胞数据分析工具，适用于空间转录组数据。通过 Seurat，我们可以分析癌症样本中的基因表达和细胞异质性，揭示其在空间上的分布和功能。


注：这部分内容取自上一回该客户业务的结果。



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:copyKAT-prediction-of-aneuploidy) (下方图) 为图copyKAT prediction of aneuploidy概览。

**(对应文件为 `Figure+Table/copyKAT-prediction-of-aneuploidy.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{/home/echo/outline/lixiao/2023_10_06_lunST/Figure+Table/copykat_heatmap.png}
\caption{CopyKAT prediction of aneuploidy}\label{fig:copyKAT-prediction-of-aneuploidy}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:CANCER-The-scsa-cell) (下方图) 为图CANCER The scsa cell概览。

**(对应文件为 `Figure+Table/CANCER-The-scsa-cell.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/CANCER-The-scsa-cell.pdf}
\caption{CANCER The scsa cell}\label{fig:CANCER-The-scsa-cell}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

### Seurat 空间转录组分析 (PERI)

使用 Seurat 工具对空间转录组数据进行分析，可以揭示样本中基因表达的空间模式。PERI 分析特别关注特定区域的基因表达情况，帮助我们理解这些区域的功能和其在生物过程中的角色。


注：这部分内容取自上一回该客户业务的结果。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PERI-The-scsa-cell) (下方图) 为图PERI The scsa cell概览。

**(对应文件为 `Figure+Table/PERI-The-scsa-cell.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PERI-The-scsa-cell.pdf}
\caption{PERI The scsa cell}\label{fig:PERI-The-scsa-cell}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


### 集成单细胞数据分析

集成单细胞数据分析通过整合来自不同来源的单细胞数据，揭示细胞异质性和基因表达的多样性。这部分的重点在于数据的整合和分析方法的选择，以确保结果的准确性和生物学意义。


#### Seurat 集成单细胞数据分析

Seurat 工具适用于集成不同单细胞数据集，通过整合分析，我们可以揭示不同样本或条件下细胞的异质性和基因表达差异。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:The-Integrated-cells) (下方图) 为图The Integrated cells概览。

**(对应文件为 `Figure+Table/The-Integrated-cells.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/The-Integrated-cells.pdf}
\caption{The Integrated cells}\label{fig:The-Integrated-cells}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

#### ClusterProfiler 富集分析 (STNCANCER)

ClusterProfiler 是一种用于基因富集分析的工具，通过识别出富集的基因集，可以帮助我们理解基因在生物过程中的功能及其在癌症研究中的角色。






\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:STNCANCER-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-KEGG-enrichment) (下方图) 为图STNCANCER Cancer cell vs Epithelial cell Peritumoral cell KEGG enrichment概览。

**(对应文件为 `Figure+Table/STNCANCER-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/STNCANCER-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-KEGG-enrichment.pdf}
\caption{STNCANCER Cancer cell vs Epithelial cell Peritumoral cell KEGG enrichment}\label{fig:STNCANCER-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

#### scFEA 单细胞数据的代谢通量预测 (INTEGRATED)

scFEA 工具用于单细胞数据的代谢通量预测，通过分析单细胞数据，可以预测细胞在不同条件下的代谢活动，揭示其代谢特征和变化。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATED-Convergency-of-the-loss-terms-during-training) (下方图) 为图INTEGRATED Convergency of the loss terms during training概览。

**(对应文件为 `Figure+Table/INTEGRATED-Convergency-of-the-loss-terms-during-training.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{scfea/loss_20240614-080259.png}
\caption{INTEGRATED Convergency of the loss terms during training}\label{fig:INTEGRATED-Convergency-of-the-loss-terms-during-training}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

#### Limma 代谢通量差异分析 (FLUX)

Limma 工具用于代谢通量的差异分析，通过比较不同条件下的代谢通量，可以揭示其在生物过程中的变化和作用。







\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs) (下方图) 为图FLUX Cancer cell vs Epithelial cell Peritumoral cell DEGs概览。

**(对应文件为 `Figure+Table/FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs.pdf}
\caption{FLUX Cancer cell vs Epithelial cell Peritumoral cell DEGs}\label{fig:FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
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

    0.3

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/FLUX-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs-content`)**



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:FLUX-data-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs) (下方表格) 为表格FLUX data Cancer cell vs Epithelial cell Peritumoral cell DEGs概览。

**(对应文件为 `Figure+Table/FLUX-data-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有122行11列，以下预览的表格可能省略部分数据；含有122个唯一`rownames'。
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

Table: (\#tab:FLUX-data-Cancer-cell-vs-Epithelial-cell-Peritumoral-cell-DEGs)FLUX data Cancer cell vs Epithelial cell Peritumoral cell DEGs

|rownames |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |name      |gene           |compounds      |
|:--------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:--------------|:--------------|
|M_3      |1.9518... |1.1240... |104.99... |0         |0         |1169.3... |G3P ->... |BPGM &#124;... |G3P &#124; 3PD |
|M_153    |-1.841... |1.0340... |-65.06... |0         |0         |783.55... |UMP ->... |CANT1 ...      |UMP &#124; CDP |
|M_6      |1.8399... |-9.576... |64.736... |0         |0         |779.68... |Pyruva... |LDHA &#124;... |Pyruva...      |
|M_2      |1.8075... |-9.279... |59.080... |4.0796... |1.7032... |711.97... |G6P ->... |ALDOA ...      |G6P &#124; G3P |
|M_155    |1.7719... |-4.982... |54.039... |1.7285... |5.7733... |648.36... |UTP ->... |CTPS1 ...      |UTP &#124; CDP |
|M_25     |1.6541... |-1.192... |42.502... |4.1359... |1.1511... |490.93... |Glutat... |GGCT &#124;... |Glutat...      |
|M_135    |-1.632... |1.4551... |-40.88... |5.5177... |1.3163... |467.61... |AICAR ... |ATIC &#124;... |AICAR ...      |
|M_133    |1.6248... |6.1442... |40.382... |8.2789... |1.7282... |460.30... |PRPP+G... |ADSL &#124;... |PRPP+G...      |
|M_158    |1.6239... |1.3231... |40.322... |1.9993... |3.7098... |459.42... |dCDP -... |CMPK1 ...      |dCDP &#124;... |
|M_33     |-1.541... |-1.347... |-35.28... |4.3329... |7.2359... |384.97... |G3P ->... |ALDOA ...      |G3P &#124; ... |
|M_30     |1.5272... |-1.458... |34.550... |2.8313... |4.2984... |373.89... |Methio... |AHCY &#124;... |Methio...      |
|M_4      |1.5080... |7.6787... |33.574... |6.8791... |9.5734... |359.19... |3PD ->... |BPGM &#124;... |3PD &#124; ... |
|M_54     |-1.464... |8.1183... |-31.50... |2.8664... |3.6823... |327.84... |Valine... |ABAT &#124;... |Valine...      |
|M_161    |1.4624... |1.9116... |31.429... |8.4922... |1.0130... |326.75... |dCDP -... |NME1 &#124;... |dCDP &#124;... |
|M_71     |1.4416... |2.5366... |30.525... |7.6516... |8.5188... |313.05... |Glucos... |SLC2A1...      |Glucos...      |
|...      |...       |...       |...       |...       |...       |...       |...       |...            |...            |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 联合空间代谢和空间转录组分析

联合空间代谢和空间转录组分析通过整合这两种数据类型，揭示基因表达和代谢活动在空间上的相互关系。这部分的重点在于数据的整合和分析方法的选择，以确保结果的准确性和生物学意义。


### 交集：差异代谢物+单细胞差异代谢通量相关代谢物

通过识别差异代谢物和单细胞差异代谢通量相关的代谢物，我们可以揭示它们在生物过程中的相互作用和关系。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Intersection-of-Diff-flux-with-Diff-meta) (下方图) 为图Intersection of Diff flux with Diff meta概览。

**(对应文件为 `Figure+Table/Intersection-of-Diff-flux-with-Diff-meta.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-Diff-flux-with-Diff-meta.pdf}
\caption{Intersection of Diff flux with Diff meta}\label{fig:Intersection-of-Diff-flux-with-Diff-meta}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    C00105, C00025, C00020

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-Diff-flux-with-Diff-meta-content`)**


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:FLUX-intersection-flux-data) (下方表格) 为表格FLUX intersection flux data概览。

**(对应文件为 `Figure+Table/FLUX-intersection-flux-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有11行12列，以下预览的表格可能省略部分数据；含有11个唯一`rownames'。
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

Table: (\#tab:FLUX-intersection-flux-data)FLUX intersection flux data

|rownames |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |name      |gene           |compounds      |
|:--------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:--------------|:--------------|
|M_153    |-1.841... |1.0340... |-65.06... |0         |0         |783.55... |UMP ->... |CANT1 ...      |UMP &#124; CDP |
|M_25     |1.6541... |-1.192... |42.502... |4.1359... |1.1511... |490.93... |Glutat... |GGCT &#124;... |Glutat...      |
|M_138    |-1.403... |3.0980... |-28.95... |1.6973... |1.4918... |289.23... |AMP ->... |AK1 &#124; ... |AMP &#124; ... |
|M_48     |1.3245... |8.1225... |26.060... |1.5888... |1.0613... |245.58... |Glutam... |GLS &#124; ... |Glutam...      |
|M_136    |1.0740... |2.0540... |18.875... |2.0959... |8.9750... |141.81... |IMP ->... |ADSL &#124;... |IMP &#124; AMP |
|M_151    |1.0350... |-1.063... |17.944... |5.9310... |2.2511... |129.29... |Orotid... |UMPS           |Orotid...      |
|M_150    |0.9279... |-6.182... |15.560... |1.2410... |3.9857... |98.702... |PRPP -... |UMPS           |PRPP &#124;... |
|M_139    |0.9134... |-1.242... |15.256... |5.2227... |1.5858... |94.975... |AMP ->... |ADK &#124; ... |AMP &#124; ... |
|M_26     |0.8463... |4.3980... |13.888... |5.9781... |1.6921... |78.784... |Glutam... |GCLC &#124;... |Glutam...      |
|M_51     |0.6412... |3.5247... |10.081... |9.6264... |2.0349... |39.403... |Glutam... |GLUD1 ...      |Glutam...      |
|M_152    |0.5810... |2.7901... |9.0453... |8.6957... |1.6885... |30.383... |UMP ->... |DPYD &#124;... |UMP &#124; ... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:INTEGRATE-metadata-of-visualized-metabolites) (下方表格) 为表格INTEGRATE metadata of visualized metabolites概览。

**(对应文件为 `Figure+Table/INTEGRATE-metadata-of-visualized-metabolites.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行15列，以下预览的表格可能省略部分数据；含有4个唯一`i'。
\end{tcolorbox}
\end{center}

Table: (\#tab:INTEGRATE-metadata-of-visualized-metabolites)INTEGRATE metadata of visualized metabolites

|i   |mz        |count  |freq      |mz.sub   |m.z       |Name      |Notation  |Formula   |KEGG   |
|:---|:---------|:------|:---------|:--------|:---------|:---------|:---------|:---------|:------|
|13  |128.03... |2469   |0.0105... |128.0354 |128.03... |Glutam... |[M-H-H... |C5H9NO4   |C00025 |
|25  |146.04... |53307  |0.2277... |146.0459 |146.04... |Glutam... |[M-H]-    |C5H9NO4   |C00025 |
|123 |323.02... |19079  |0.0815... |323.0284 |323.02... |Uridin... |[M-H]-    |C9H13N... |C00105 |
|131 |346.05... |112118 |0.4789... |346.0561 |346.05... |Adenos... |[M-H]-    |C10H14... |C00020 |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATE-Feature-25-C00025-image-visualization) (下方图) 为图INTEGRATE Feature 25 C00025 image visualization概览。

**(对应文件为 `Figure+Table/INTEGRATE-Feature-25-C00025-image-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATE-Feature-25-C00025-image-visualization.pdf}
\caption{INTEGRATE Feature 25 C00025 image visualization}\label{fig:INTEGRATE-Feature-25-C00025-image-visualization}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}




\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Feature image visualizations' 数据已全部提供。

**(对应文件为 `Figure+Table/Feature-image-visualizations`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Feature-image-visualizations共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Feature\_13\_C00025.pdf
\item 2\_Feature\_25\_C00025.pdf
\item 3\_Feature\_123\_C00105.pdf
\item 4\_Feature\_131\_C00020.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

### FELLA 代谢物富集分析 (INTERSECT)

FELLA 工具用于富集分析，通过识别出富集的代谢通路，可以帮助我们理解代谢物在生物过程中的功能及其相互关系。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:INTERSECT-data-of-enrichment-with-algorithm-Hypergeom) (下方表格) 为表格INTERSECT data of enrichment with algorithm Hypergeom概览。

**(对应文件为 `Figure+Table/INTERSECT-data-of-enrichment-with-algorithm-Hypergeom.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15行6列，以下预览的表格可能省略部分数据；含有15个唯一`KEGG.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:INTERSECT-data-of-enrichment-with-algorithm-Hypergeom)INTERSECT data of enrichment with algorithm Hypergeom

|KEGG.id  |Description   |Count |CompoundsI... |pvalue        |Compound_R... |
|:--------|:-------------|:-----|:-------------|:-------------|:-------------|
|hsa00240 |Pyrimidine... |3     |173           |0.00448664... |1             |
|hsa00630 |Glyoxylate... |3     |147           |0.00448664... |1             |
|hsa00760 |Nicotinate... |3     |169           |0.00448664... |1             |
|hsa00770 |Pantothena... |3     |125           |0.00448664... |1             |
|hsa01232 |Nucleotide... |3     |154           |0.00448664... |1             |
|hsa00230 |Purine met... |3     |218           |0.00748364... |1             |
|hsa00983 |Drug metab... |3     |258           |0.00748364... |1             |
|hsa04727 |GABAergic ... |2     |35            |0.00748364... |0.66666666... |
|hsa04742 |Taste tran... |2     |36            |0.00748364... |0.66666666... |
|hsa05169 |Epstein-Ba... |2     |36            |0.00748364... |0.66666666... |
|hsa04068 |FoxO signa... |2     |42            |0.00885843... |0.66666666... |
|hsa01523 |Antifolate... |2     |45            |0.00933248... |0.66666666... |
|hsa04216 |Ferroptosi... |2     |59            |0.01485597... |0.66666666... |
|hsa00740 |Riboflavin... |2     |65            |0.01675415... |0.66666666... |
|hsa00220 |Arginine b... |2     |70            |0.01700766... |0.66666666... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTERSECT-Compounds-hypergeom-KEGG-enrichment) (下方图) 为图INTERSECT Compounds hypergeom KEGG enrichment概览。

**(对应文件为 `Figure+Table/INTERSECT-Compounds-hypergeom-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTERSECT-Compounds-hypergeom-KEGG-enrichment.pdf}
\caption{INTERSECT Compounds hypergeom KEGG enrichment}\label{fig:INTERSECT-Compounds-hypergeom-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTERSECT-enrichment-with-algorithm-PageRank) (下方图) 为图INTERSECT enrichment with algorithm PageRank概览。

**(对应文件为 `Figure+Table/INTERSECT-enrichment-with-algorithm-PageRank.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTERSECT-enrichment-with-algorithm-PageRank.pdf}
\caption{INTERSECT enrichment with algorithm PageRank}\label{fig:INTERSECT-enrichment-with-algorithm-PageRank}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

### ClusterProfiler 富集分析 (FLUX)

ClusterProfiler 工具用于基因富集分析，通过识别出富集的基因集，可以帮助我们理解基因在生物过程中的功能及其在代谢研究中的角色。






\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:FLUX-GO-enrichment) (下方图) 为图FLUX GO enrichment概览。

**(对应文件为 `Figure+Table/FLUX-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FLUX-GO-enrichment.pdf}
\caption{FLUX GO enrichment}\label{fig:FLUX-GO-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:FLUX-KEGG-enrichment) (下方图) 为图FLUX KEGG enrichment概览。

**(对应文件为 `Figure+Table/FLUX-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FLUX-KEGG-enrichment.pdf}
\caption{FLUX KEGG enrichment}\label{fig:FLUX-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

### 代谢物与基因共同富集的 KEGG 通路

通过分析代谢物与基因在 KEGG 通路中的共同富集情况，我们可以揭示其在生物过程中的相互作用和功能。






\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:FLUX-Co-enriched-KEGG-pathway) (下方图) 为图FLUX Co enriched KEGG pathway概览。

**(对应文件为 `Figure+Table/FLUX-Co-enriched-KEGG-pathway.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FLUX-Co-enriched-KEGG-pathway.pdf}
\caption{FLUX Co enriched KEGG pathway}\label{fig:FLUX-Co-enriched-KEGG-pathway}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:FLUX-Co-enriched-KEGG-pathway-data) (下方表格) 为表格FLUX Co enriched KEGG pathway data概览。

**(对应文件为 `Figure+Table/FLUX-Co-enriched-KEGG-pathway-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有11行11列，以下预览的表格可能省略部分数据；含有11个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:FLUX-Co-enriched-KEGG-pathway-data)FLUX Co enriched KEGG pathway data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |geneID...      |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|:--------------|
|hsa01232 |Nucleo... |48/87     |85/8840  |6.1247... |3.1235... |1.6117... |132/15... |48    |132 &#124; ... |
|hsa00240 |Pyrimi... |38/87     |58/8840  |6.7352... |1.7174... |8.8621... |124583... |38    |124583...      |
|hsa00983 |Drug m... |37/87     |81/8840  |8.8804... |1.5096... |7.7898... |51727/... |37    |51727 ...      |
|hsa00230 |Purine... |37/87     |128/8840 |8.9327... |9.1114... |4.7014... |132/15... |37    |132 &#124; ... |
|hsa00760 |Nicoti... |7/87      |38/8840  |6.9016... |2.1999... |1.1351... |30833/... |7     |30833 ...      |
|hsa00220 |Argini... |5/87      |23/8840  |2.4063... |6.8180... |3.5181... |2744/2... |5     |2744 &#124;... |
|hsa00770 |Pantot... |3/87      |21/8840  |0.0010... |0.0024... |0.0012... |1806/1... |3     |1806 &#124;... |
|hsa04727 |GABAer... |3/87      |89/8840  |0.0571... |0.1079... |0.0556... |2744/2... |3     |2744 &#124;... |
|hsa04216 |Ferrop... |2/87      |42/8840  |0.0639... |0.1165... |0.0601... |2729/2937 |2     |2729 &#124;... |
|hsa00630 |Glyoxy... |1/87      |31/8840  |0.2644... |0.3549... |0.1831... |2752      |1     |2752           |
|hsa05169 |Epstei... |3/87      |203/8840 |0.3226... |0.4219... |0.2177... |953/95... |3     |953 &#124; ... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


### 拟时分析 (发现拟时变化中的差异基因)

拟时分析用于揭示基因表达随时间变化的模式，通过识别差异基因，可以帮助我们理解这些基因在生物过程中的动态变化。


#### Monocle3 拟时分析 (INTEGRATED)

Monocle3 是一种用于拟时分析的工具，通过分析基因表达随时间的变化，揭示其动态变化模式和生物学意义。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATED-principal-points) (下方图) 为图INTEGRATED principal points概览。

**(对应文件为 `Figure+Table/INTEGRATED-principal-points.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATED-principal-points.pdf}
\caption{INTEGRATED principal points}\label{fig:INTEGRATED-principal-points}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATED-pseudotime) (下方图) 为图INTEGRATED pseudotime概览。

**(对应文件为 `Figure+Table/INTEGRATED-pseudotime.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATED-pseudotime.pdf}
\caption{INTEGRATED pseudotime}\label{fig:INTEGRATED-pseudotime}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Graph-Test-Significant-genes-Top50) (下方表格) 为表格Graph Test Significant genes Top50概览。

**(对应文件为 `Figure+Table/Graph-Test-Significant-genes-Top50.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有50行6列，以下预览的表格可能省略部分数据；含有50个唯一`gene\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item gene\_id:  GENCODE/Ensembl gene ID
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Graph-Test-Significant-genes-Top50)Graph Test Significant genes Top50

|gene_id    |status |p_value |morans_tes... |morans_I      |q_value |
|:----------|:------|:-------|:-------------|:-------------|:-------|
|IGKC       |OK     |0       |75.8062198... |0.67942383... |0       |
|SFTPC      |OK     |0       |69.5950802... |0.62419283... |0       |
|IQCH       |OK     |0       |68.4928396... |0.61428628... |0       |
|MIR205HG   |OK     |0       |68.3310378... |0.61282346... |0       |
|NTRK2      |OK     |0       |68.1731853... |0.61140579... |0       |
|FDCSP      |OK     |0       |68.0735909... |0.61049602... |0       |
|AC019117.2 |OK     |0       |67.3543910... |0.60403901... |0       |
|NAPSA      |OK     |0       |67.3373767... |0.60388367... |0       |
|KRT15      |OK     |0       |67.3218228... |0.60374698... |0       |
|DSG3       |OK     |0       |66.5485380... |0.59678432... |0       |
|ADAM23     |OK     |0       |66.2024864... |0.59369367... |0       |
|PKP1       |OK     |0       |66.1815915... |0.59350259... |0       |
|DSP        |OK     |0       |66.1350653... |0.59304932... |0       |
|SFTPD      |OK     |0       |66.0821697... |0.59261178... |0       |
|SLC34A2    |OK     |0       |65.7432638... |0.58956078... |0       |
|...        |...    |...     |...           |...           |...     |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

#### ClusterProfiler 富集分析 (GRAPHTOPS)

ClusterProfiler 工具用于基因富集分析，通过识别出富集的基因集，可以帮助我们理解基因在拟时分析中的功能及其在生物过程中的角色。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GRAPHTOPS-KEGG-enrichment) (下方图) 为图GRAPHTOPS KEGG enrichment概览。

**(对应文件为 `Figure+Table/GRAPHTOPS-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GRAPHTOPS-KEGG-enrichment.pdf}
\caption{GRAPHTOPS KEGG enrichment}\label{fig:GRAPHTOPS-KEGG-enrichment}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:GRAPHTOPS-KEGG-enrichment-data) (下方表格) 为表格GRAPHTOPS KEGG enrichment data概览。

**(对应文件为 `Figure+Table/GRAPHTOPS-KEGG-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有102行11列，以下预览的表格可能省略部分数据；含有102个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:GRAPHTOPS-KEGG-enrichment-data)GRAPHTOPS KEGG enrichment data

|ID       |Descri... |GeneRatio |BgRatio  |pvalue    |p.adjust  |qvalue    |geneID    |Count |geneID...      |
|:--------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:-----|:--------------|
|hsa04915 |Estrog... |4/30      |139/8840 |0.0011... |0.1191... |0.1057... |596/15... |4     |596 &#124; ... |
|hsa04976 |Bile s... |3/30      |90/8840  |0.0033... |0.1732... |0.1537... |358/36... |3     |358 &#124; ... |
|hsa04215 |Apopto... |2/30      |32/8840  |0.0051... |0.1762... |0.1564... |596/5366  |2     |596 &#124; ... |
|hsa05171 |Corona... |4/30      |238/8840 |0.0080... |0.2065... |0.1832... |3627/6... |4     |3627 &#124;... |
|hsa04210 |Apoptosis |3/30      |136/8840 |0.0106... |0.2177... |0.1932... |596/15... |3     |596 &#124; ... |
|hsa04145 |Phagosome |3/30      |157/8840 |0.0157... |0.2622... |0.2327... |653509... |3     |653509...      |
|hsa04978 |Minera... |2/30      |61/8840  |0.0179... |0.2622... |0.2327... |2512/1... |2     |2512 &#124;... |
|hsa05152 |Tuberc... |3/30      |180/8840 |0.0225... |0.2643... |0.2345... |596/97... |3     |596 &#124; ... |
|hsa01524 |Platin... |2/30      |75/8840  |0.0265... |0.2643... |0.2345... |596/5366  |2     |596 &#124; ... |
|hsa04115 |p53 si... |2/30      |75/8840  |0.0265... |0.2643... |0.2345... |596/5366  |2     |596 &#124; ... |
|hsa05133 |Pertussis |2/30      |78/8840  |0.0285... |0.2643... |0.2345... |653509... |2     |653509...      |
|hsa05210 |Colore... |2/30      |87/8840  |0.0348... |0.2792... |0.2478... |596/5366  |2     |596 &#124; ... |
|hsa04610 |Comple... |2/30      |88/8840  |0.0355... |0.2792... |0.2478... |2/7450    |2     |2 &#124; 7450  |
|hsa05150 |Staphy... |2/30      |100/8840 |0.0448... |0.3106... |0.2756... |3866/3872 |2     |3866 &#124;... |
|hsa04933 |AGE-RA... |2/30      |101/8840 |0.0456... |0.3106... |0.2756... |596/7412  |2     |596 &#124; ... |
|...      |...       |...       |...      |...       |...       |...       |...       |...   |...            |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

#### Pseudotime Heatmap

通过拟时分析的热图，我们可以直观地展示基因表达随时间的变化模式，帮助我们理解这些基因在生物过程中的动态变化。






\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:INTEGRATED-Pseudotime-heatmap-of-genes) (下方图) 为图INTEGRATED Pseudotime heatmap of genes概览。

**(对应文件为 `Figure+Table/INTEGRATED-Pseudotime-heatmap-of-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/INTEGRATED-Pseudotime-heatmap-of-genes.pdf}
\caption{INTEGRATED Pseudotime heatmap of genes}\label{fig:INTEGRATED-Pseudotime-heatmap-of-genes}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

#### STRINGdb PPI 分析 (PPI)

STRINGdb 工具用于蛋白质-蛋白质相互作用 (PPI) 分析，通过识别蛋白质之间的相互作用，可以帮助我们理解这些蛋白质在生物过程中的功能及其相互关系。





\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PPI-raw-PPI-network) (下方图) 为图PPI raw PPI network概览。

**(对应文件为 `Figure+Table/PPI-raw-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-raw-PPI-network.pdf}
\caption{PPI raw PPI network}\label{fig:PPI-raw-PPI-network}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:PPI-Top-MCC-score) (下方图) 为图PPI Top MCC score概览。

**(对应文件为 `Figure+Table/PPI-Top-MCC-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-Top-MCC-score.pdf}
\caption{PPI Top MCC score}\label{fig:PPI-Top-MCC-score}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Dimension-plot-of-expression-level-of-the-genes) (下方图) 为图Dimension plot of expression level of the genes概览。

**(对应文件为 `Figure+Table/Dimension-plot-of-expression-level-of-the-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Dimension-plot-of-expression-level-of-the-genes.pdf}
\caption{Dimension plot of expression level of the genes}\label{fig:Dimension-plot-of-expression-level-of-the-genes}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Spatial-feature-plot) (下方图) 为图Spatial feature plot概览。

**(对应文件为 `Figure+Table/Spatial-feature-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Spatial-feature-plot.pdf}
\caption{Spatial feature plot}\label{fig:Spatial-feature-plot}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}



