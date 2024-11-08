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
\ThisCenterWallPaper{1.12}{~/outline/bosai//cover_page.pdf}
\begin{center} \textbf{\huge 骨髓瘤思路设计}
\vspace{4em} \begin{textblock}{10}(3.2,9.25)
\huge \textbf{\textcolor{black}{2024-11-07}}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 研究背景 {#abstract}



Multiple myeloma (MM) 是一种基因复杂、异质性高的疾病，其发展是一个多步骤的过程，涉及肿瘤细胞基因改变的获得和骨髓微环境的变化 (2024, Nature reviews. Disease primers, **IF:76.9**, Q1)[@MultipleMyelomMalard2024]。

## 思路 {#introduction}

结合 MM 的 GWAS 研究 (变异与疾病的关系) ，预测基因表达变化水平 (即TWAS，基因与疾病的关系) ；MM 的 scRNA-seq 肿瘤细胞分析，并进一步预测肿瘤细胞的代谢变化; 最后，聚焦于基因对肿瘤细胞的代谢改变，以及对应的功能基因。

思路为： TWAS (GWAS + eQTL)  + scRNA-seq + metabolic

(TWAS 部分可能会相对耗时，因为该部分的方法为首次接触，需要配置程序)

# 可行性 {#methods}

## 以 `"Multiple myeloma" AND "metabolic"` 搜索文献，发现 MM 与代谢关联密切。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-07 14-37-56.png}
\caption{Unnamed chunk 6}\label{fig:unnamed-chunk-6}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 以 `"Multiple myeloma" AND "TWAS"` 搜索文献，已有借助 TWAS 研究 MM 的文章。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-07 14-36-52.png}
\caption{Unnamed chunk 7}\label{fig:unnamed-chunk-7}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 以 `"Multiple myeloma" AND "metabolic" AND "GWAS"` 搜索文献，发现一篇孟德尔随机化研究，MM 基因与代谢的关系。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-07 14-39-32.png}
\caption{Unnamed chunk 8}\label{fig:unnamed-chunk-8}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 创新性 {#results}

## 以 `"Multiple myeloma" AND "metabolic" AND "TWAS"` 搜索文献，未发现相关研究。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-07 14-40-57.png}
\caption{Unnamed chunk 9}\label{fig:unnamed-chunk-9}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 以 `"Multiple myeloma" AND "scRNA-seq" AND "metabolic" AND "GWAS"` 搜索 PubMed，未发现相关研究。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-07 14-41-29.png}
\caption{Unnamed chunk 10}\label{fig:unnamed-chunk-10}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 参考文献和数据集 {#workflow}

## TWAS 方法

- FUSION (2016, Nature Genetics, **IF:31.7**, Q1)[@IntegrativeAppGusev2016]
- FOCUS (2020, Human genetics, **IF:3.8**, Q2)[@APowerfulFineWuCh2020]

## 单细胞数据预测代谢通量的方法

- scFEA 通过scRNA-seq 预测代谢通量 (2021, Genome research, **IF:6.2**, Q1)[@AGraphNeuralAlgham2021]
- scFEA 的应用实例 (2023, Frontiers in endocrinology, **IF:3.9**, Q2)[@SingleCellCorAgoro2023]

## GWAS 数据



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}

Table: (\#tab:GWAS)GWAS

|id        |trait     |ncase |group_... |year |author  |consor... |sex       |pmid |popula... |
|:---------|:---------|:-----|:---------|:----|:-------|:---------|:---------|:----|:---------|
|ieu-b-... |Multip... |601   |public    |2021 |Burrows |UK Bio... |Males ... |NA   |European  |
|finn-b... |Multip... |598   |public    |2021 |NA      |NA        |Males ... |NA   |European  |
|finn-b... |Multip... |598   |public    |2021 |NA      |NA        |Males ... |NA   |European  |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## scRNA-seq

GEO 上有多数 MM 的 scRNA-seq 数据集，以下举一例。

- GSE271107



\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE271107

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Raw scRNA-seq data were preprocessed using the Cell
Ranger analysis pipelines (10x Genomics) version 6 with
reference genome of human genome (GRCh38) to demultiplex
for cell and transcript and generate count table.

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    The count table was loaded into R through Seurat
version 4 package for further analysis. Cells that have
gene numbers lesser than 200, greater than 7,000, and more
than 10% of unique molecular identifiers stemming from
mitochondrial genes were discarded from the analysis.

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    For individual sample, a principal component analysis
(PCA) was performed on significantly variable genes for
remained high-quality cells. Results of individual samples
were used for data integration across samples using
reciprocal PCA method to minimize technical differences
between samples.

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    The integration results were employed as input for
clustering using Louvain algorithm with multilevel
refinement and the Uniform Manifold Approximation and
Projection for Dimension Reduction (UMAP).

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/prods-content`)**

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}

Table: (\#tab:sample)Sample

|rownames   |title           |disease.state.ch1 |tissue.ch1           |
|:----------|:---------------|:-----------------|:--------------------|
|GSM8369863 |Healthy donor_1 |Healthy           |Bone marrow aspirate |
|GSM8369864 |Healthy donor_2 |Healthy           |Bone marrow aspirate |
|GSM8369865 |Healthy donor_3 |Healthy           |Bone marrow aspirate |
|GSM8369866 |Healthy donor_4 |Healthy           |Bone marrow aspirate |
|GSM8369867 |Healthy donor_5 |Healthy           |Bone marrow aspirate |
|GSM8369868 |MGUS_1          |MGUS              |Bone marrow aspirate |
|GSM8369869 |MGUS_2          |MGUS              |Bone marrow aspirate |
|GSM8369870 |MGUS_3          |MGUS              |Bone marrow aspirate |
|GSM8369871 |MGUS_4          |MGUS              |Bone marrow aspirate |
|GSM8369872 |MGUS_5          |MGUS              |Bone marrow aspirate |
|GSM8369873 |MGUS_6          |MGUS              |Bone marrow aspirate |
|GSM8369874 |SMM_1           |SMM               |Bone marrow aspirate |
|GSM8369875 |SMM_2           |SMM               |Bone marrow aspirate |
|GSM8369876 |SMM_3           |SMM               |Bone marrow aspirate |
|GSM8369877 |SMM_4           |SMM               |Bone marrow aspirate |
|...        |...             |...               |...                  |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


