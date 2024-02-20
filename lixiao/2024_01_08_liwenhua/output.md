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
菌群+对应代谢产物介导+机制研究} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-02-20}}
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

- con: Control
- A: colitis
- B: colon precancerous lesions

想要做肠道菌群测序结果+生信分析，然后找菌群+对应代谢产物介导+机制研究+再闭环回到临床。在沟通时客户提到想要做
溃疡性结肠炎和结肠癌的肠道菌群之间的区别和关联，进而研究其对应的机制，研究结肠炎向结肠癌发展的关键机制，为临床早期筛查提供理论支持



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- `Fastp` used for Fastq data preprocessing[@UltrafastOnePChen2023].
- R package `MicrobiotaProcess` used for microbiome data visualization[@MicrobiotaproceXuSh2023].
- `Qiime2` used for gut microbiome 16s rRNA analysis[@ReproducibleIBolyen2019; @TheBiologicalMcdona2012; @Dada2HighResCallah2016; @ErrorCorrectinHamday2008; @MicrobialCommuHamday2009].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

- A、B 组 Alpha 和 Beta 多样性无显著差异 (见 \@ref(alpha) 和 \@ref(beta))。
- A、B 组差异分析，未找到差异菌。

# 结论 {#dis}

# 附：分析流程 {#workflow}

## Microbiota 16s RNA

### Fastp QC

原始数据质控：

 
`Fastp QC' 数据已全部提供。

**(对应文件为 `./fastp_report/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./fastp\_report/共包含23个文件。

\begin{enumerate}\tightlist
\item A1.338F\_806R..html
\item A2.338F\_806R..html
\item A3.338F\_806R..html
\item A4.338F\_806R..html
\item A5.338F\_806R..html
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

### 元数据

Table \@ref(tab:microbiota-metadata) (下方表格) 为表格microbiota metadata概览。

**(对应文件为 `Figure+Table/microbiota-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有22行7列，以下预览的表格可能省略部分数据；表格含有22个唯一`SampleName'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:microbiota-metadata)Microbiota metadata

|SampleName |group |dirs          |reports       |Run     |forward-ab... |reverse-ab... |
|:----------|:-----|:-------------|:-------------|:-------|:-------------|:-------------|
|A1         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A2         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A3         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A4         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A5         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A6         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A7         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|A8         |A     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B1         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B2         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B3         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B4         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B5         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B6         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|B7         |B     |./material... |./material... |rawData |/home/echo... |/home/echo... |
|...        |...   |...           |...           |...     |...           |...           |

### Qiime2 分析

Microbiota 数据经 Qiime2 分析后，由 `MicrobiotaProcess` 下游分析和可视化。

### MicrobiotaProcess 分析

#### 样本聚类

Figure \@ref(fig:PCoA) (下方图) 为图PCoA概览。

**(对应文件为 `Figure+Table/PCoA.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PCoA.pdf}
\caption{PCoA}\label{fig:PCoA}
\end{center}

#### Alpha 多样性 {#alpha}

三组 alpha 多样性没有显著差异。

Figure \@ref(fig:Alpha-diversity) (下方图) 为图Alpha diversity概览。

**(对应文件为 `Figure+Table/Alpha-diversity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Alpha-diversity.pdf}
\caption{Alpha diversity}\label{fig:Alpha-diversity}
\end{center}

 
`Taxonomy abundance' 数据已全部提供。

**(对应文件为 `Figure+Table/Taxonomy-abundance`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Taxonomy-abundance共包含6个文件。

\begin{enumerate}\tightlist
\item 1\_Phylum.pdf
\item 2\_Class.pdf
\item 3\_Order.pdf
\item 4\_Family.pdf
\item 5\_Genus.pdf
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

#### Alpha 稀疏曲线

Figure \@ref(fig:Alpha-rarefaction) (下方图) 为图Alpha rarefaction概览。

**(对应文件为 `Figure+Table/Alpha-rarefaction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Alpha-rarefaction.pdf}
\caption{Alpha rarefaction}\label{fig:Alpha-rarefaction}
\end{center}

#### Beta 多样性 {#beta}

Beta 多样性无显著差异。

Figure \@ref(fig:Beta-diversity-group-test) (下方图) 为图Beta diversity group test概览。

**(对应文件为 `Figure+Table/Beta-diversity-group-test.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Beta-diversity-group-test.pdf}
\caption{Beta diversity group test}\label{fig:Beta-diversity-group-test}
\end{center}

 
`Taxonomy hierarchy' 数据已全部提供。

**(对应文件为 `Figure+Table/Taxonomy-hierarchy`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Taxonomy-hierarchy共包含6个文件。

\begin{enumerate}\tightlist
\item 1\_Phylum.pdf
\item 2\_Class.pdf
\item 3\_Order.pdf
\item 4\_Family.pdf
\item 5\_Genus.pdf
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

#### 差异分析

MicrobiotaProcess 的差异分析 (`MicrobiotaProcess::mp_diff_analysis`) 未发现差异菌，因此这里主要用的
`Qiime2` 的差异分析结果 (`accom test`)。

注：关于 `ancom test` 的结果的解释，可以参考：

- https://forum.qiime2.org/t/how-to-interpret-ancom-results/1958
- https://forum.qiime2.org/t/specify-w-cutoff-for-anacom/1844

Figure \@ref(fig:Ancom-test-group-level-6-volcano) (下方图) 为图Ancom test group level 6 volcano概览。

**(对应文件为 `Figure+Table/Ancom-test-group-level-6-volcano.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ancom-test-group-level-6-volcano.pdf}
\caption{Ancom test group level 6 volcano}\label{fig:Ancom-test-group-level-6-volcano}
\end{center}

'level 6' 对应 Ontology 中的 Species。

其余结果的可视化见：

 
`Ancom test visualization' 数据已全部提供。

**(对应文件为 `Figure+Table/Ancom-test-visualization`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ancom-test-visualization共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_ancom\_test\_group\_level\_4.pdf
\item 2\_ancom\_test\_group\_level\_5.pdf
\item 3\_ancom\_test\_group\_level\_6.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

 
`Ancom test results' 数据已全部提供。

**(对应文件为 `Figure+Table/Ancom-test-results`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ancom-test-results共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_ancom\_test\_group\_level\_4.csv
\item 2\_ancom\_test\_group\_level\_5.csv
\item 3\_ancom\_test\_group\_level\_6.csv
\end{enumerate}\end{tcolorbox}
\end{center}








