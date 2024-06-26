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
筛选研究对象AA菌-BB代谢产物-XX基因} \vspace{4em}
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

# 摘要 {#abstract}



## 要求

肠道菌-代谢物-基因关联数据为此前分析数据。
选择差异最大的基因前5，寻找关联代谢物和菌。

## 结果

主要思路，结合此前分析得到的数据，再以 RNA-seq  (胆结石) 差异分析，根据显著性排序基因。

- 肝脏见 Tab. \@ref(tab:Res-liver)。
- 回肠见 Tab. \@ref(tab:Res-ileum)。


# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE66430**: RNA-seq of four female human gallbladders (3 healthy controls and 1 case with chronic gallstones) and one liver sample from the gallstone case.

## 方法

Mainly used method:

- R package `biomaRt` used for gene annotation[@MappingIdentifDurinc2009].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}


\newpage

# 附：分析流程 {#workflow}

## GEO 数据获取 (GALLSTONE)

我们首先从GEO数据库中获取了与胆结石相关的数据。通过查询并筛选相关的实验，我们下载了数据集并进行了预处理。预处理步骤包括数据标准化和质量控制，以确保后续分析的准确性。





\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE66430

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Sequencing data were demultiplexed and converted to
FASTQ format.

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    Paired-end reads were aligned to RefSeq (hg19) using
TopHat (v2.0.9) with the parameter setting: -g 1 -N 2 -r
200.

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    RNA reads-per-kilobase-per million mapped (RPKM) was
calculated with RSeQC v2.3.6.

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    Genome\_build: GRCh37 (hg19)

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/GALLSTONE-GSE66430-content`)**


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:GALLSTONE-GSE66430-metadata) (下方表格) 为表格GALLSTONE GSE66430 metadata概览。

**(对应文件为 `Figure+Table/GALLSTONE-GSE66430-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5行6列，以下预览的表格可能省略部分数据；含有5个唯一`rownames'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GALLSTONE-GSE66430-metadata)GALLSTONE GSE66430 metadata

|rownames   |title         |age..years... |disease.st... |gender.ch1 |tissue.ch1   |
|:----------|:-------------|:-------------|:-------------|:----------|:------------|
|GSM1622382 |Non-diseas... |34            |healthy       |female     |gall bladder |
|GSM1622383 |Non-diseas... |46            |healthy       |female     |gall bladder |
|GSM1622384 |Non-diseas... |64            |healthy       |female     |gall bladder |
|GSM1622385 |Diseased G... |71            |chronic ga... |female     |gall bladder |
|GSM1622386 |Diseased L... |71            |chronic ga... |female     |liver        |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## Biomart 基因注释 (REFSEQ)

接下来，我们使用 Biomart 工具对基因进行了注释。通过链接REFSEQ数据库，我们将基因表达数据与基因注释信息进行匹配。




## Limma 差异分析 (GALLSTONE)

使用Limma软件包，我们进行了胆结石相关样本的差异表达分析。通过对比正常和疾病状态下的基因表达数据，我们识别出显著差异表达的基因。




\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:GALLSTONE-Disease-vs-Control) (下方图) 为图GALLSTONE Disease vs Control概览。

**(对应文件为 `Figure+Table/GALLSTONE-Disease-vs-Control.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GALLSTONE-Disease-vs-Control.pdf}
\caption{GALLSTONE Disease vs Control}\label{fig:GALLSTONE-Disease-vs-Control}
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

    0.5

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/GALLSTONE-Disease-vs-Control-content`)**


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:GALLSTONE-data-Disease-vs-Control) (下方表格) 为表格GALLSTONE data Disease vs Control概览。

**(对应文件为 `Figure+Table/GALLSTONE-data-Disease-vs-Control.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有101行11列，以下预览的表格可能省略部分数据；含有101个唯一`rownames；含有37个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:GALLSTONE-data-Disease-vs-Control)GALLSTONE data Disease vs Control

|rownames |gene   |accession |hgnc_s... |isIntron |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:--------|:------|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:---------|
|294507   |294507 |NM_001... |HP        |TRUE     |6.3561... |0.1962... |12.777... |5.9012... |0.0098... |
|298099   |298099 |NM_001... |NA        |TRUE     |6.8136... |-0.777... |12.589... |6.8856... |0.0098... |
|112356   |112356 |NM_002... |HMGCS1    |TRUE     |3.6763... |3.5944... |9.6243... |1.0579... |0.0224... |
|292286   |292286 |NM_001... |ACSM2B    |TRUE     |6.9353... |-1.200... |11.603... |1.5969... |0.0133... |
|292299   |292299 |NM_182... |ACSM2B    |TRUE     |6.9494... |-1.287... |11.283... |2.1265... |0.0133... |
|101714   |101714 |NM_000... |FGA       |TRUE     |6.9766... |-1.416... |11.176... |2.3443... |0.0133... |
|150259   |150259 |NM_017... |CYP3A4    |TRUE     |4.9985... |-0.306... |9.9083... |7.9150... |0.0224... |
|150294   |150294 |NM_001... |CYP3A4    |TRUE     |4.9985... |-0.306... |9.9083... |7.9150... |0.0224... |
|124063   |124063 |NR_033... |NA        |TRUE     |3.1808... |3.9078... |8.9243... |2.2292... |0.0302... |
|112365   |112365 |NM_001... |HMGCS1    |TRUE     |3.6700... |3.3268... |8.9506... |2.1659... |0.0302... |
|150260   |150260 |NM_017... |CYP3A4    |TRUE     |5.4308... |-0.822... |9.5937... |1.0919... |0.0224... |
|150295   |150295 |NM_001... |CYP3A4    |TRUE     |5.4308... |-0.822... |9.5937... |1.0919... |0.0224... |
|318508   |318508 |NM_002... |KRT19     |TRUE     |3.8891... |2.2275... |8.5802... |3.2703... |0.0304... |
|233713   |233713 |NM_005... |FGF19     |TRUE     |3.6670... |1.7986... |8.5826... |3.2617... |0.0304... |
|85809    |85809  |NM_001... |TF        |TRUE     |5.5575... |-0.804... |9.2766... |1.5233... |0.0228... |
|...      |...    |...       |...       |...      |...       |...       |...       |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 肠道菌-代谢物-基因关联数据



### 前一次的分析数据

在这部分中，我们引用了之前的分析数据。


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:liver-data) (下方表格) 为表格liver data概览。

**(对应文件为 `Figure+Table/liver-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10454行10列，以下预览的表格可能省略部分数据；含有22个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:liver-data)Liver data

|.id  |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:----|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|588  |Metabo... |          |2-Imin...     |Clostr... |CD59      |creati...     |0.4459... |6.9021... |1.8504... |... |
|750  |Substrate |Glycine   |Acetyl...     |Clostr... |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|750  |Metabo... |          |Glycine       |Blautia   |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|750  |Metabo... |          |Glycine       |Lactob... |GHR       |glycine       |-0.425... |4.5068... |2.4165... |... |
|5793 |Substrate |D-Glucose |Acetate       |Christ... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Butyrate      |Christ... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetoin       |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetoin       |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |2,3-Bu...     |Escher... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Ethanol       |Lactob... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Acetate       |Clostr... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|5793 |Substrate |D-Glucose |Butyrate      |Clostr... |PLXNB2    |glucose       |0.3849... |1.3255... |3.5538... |... |
|...  |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:ileum-data) (下方表格) 为表格ileum data概览。

**(对应文件为 `Figure+Table/ileum-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有9208行10列，以下预览的表格可能省略部分数据；含有22个唯一`.id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item META\_Rho:  关联分析结果的关联系数，绝对值越大，说明关联性越强 (源自文献的分析)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\item META\_P:  关联分析结果 P 的值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:ileum-data)Ileum data

|.id |.id_from  |Substrate |Metabo......4 |Gut.Mi... |Target... |Metabo......7 |META_Rho  |META_Q    |META_P    |... |
|:---|:---------|:---------|:-------------|:---------|:---------|:-------------|:---------|:---------|:---------|:---|
|588 |Metabo... |          |2-Imin...     |Clostr... |B2M       |creati...     |0.5130... |0         |0         |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |DSC2      |creati...     |0.5128... |0         |0         |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |RGMB      |creati...     |0.4166... |5.3138... |1.4246... |... |
|750 |Substrate |Glycine   |Acetyl...     |Clostr... |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|750 |Metabo... |          |Glycine       |Blautia   |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|750 |Metabo... |          |Glycine       |Lactob... |RET       |glycine       |-0.407... |9.5712... |5.1320... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |JAM2      |creati...     |0.4070... |2.8618... |7.6726... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |CST6      |creati...     |0.3307... |2.1455... |5.7522... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |SPOCK2    |creati...     |-0.321... |1.3977... |1.1241... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |LCN2      |creati...     |0.3110... |2.0900... |1.1206... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |TNFRSF21  |creati...     |0.3098... |7.2094... |7.7313... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |SMOC1     |creati...     |0.3071... |2.8839... |7.7317... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |TNFRSF19  |creati...     |0.2890... |4.7330... |1.2689... |... |
|588 |Metabo... |          |2-Imin...     |Clostr... |COL18A1   |creati...     |0.2883... |3.0855... |3.3089... |... |
|750 |Substrate |Glycine   |Acetyl...     |Clostr... |SLITRK5   |glycine       |0.2801... |1.7545... |4.7038... |... |
|... |...       |...       |...           |...       |...       |...           |...       |...       |...       |... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### 结合 GALLSTONE RNA-seq 差异分析筛选

我们将胆结石RNA-seq差异分析的结果与肠道菌-代谢物-基因关联数据相结合。


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Res-liver) (下方表格) 为表格Res liver概览。

**(对应文件为 `Figure+Table/Res-liver.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有25行6列，以下预览的表格可能省略部分数据；含有5个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Res-liver)Res liver

|hgnc_symbol |logFC         |adj.P.Val     |related_me... |related_mi... |META_Q        |
|:-----------|:-------------|:-------------|:-------------|:-------------|:-------------|
|ALB         |7.09094053... |0.03042149... |Acetyl pho... |Clostridium   |2.41950093... |
|ALB         |7.09094053... |0.03042149... |Glycine       |Blautia       |2.41950093... |
|ALB         |7.09094053... |0.03042149... |Glycine       |Lactobacil... |2.41950093... |
|ALB         |7.09094053... |0.03042149... |Serine        |Blautia       |3.22595060... |
|ALB         |7.09094053... |0.03042149... |3-Indolepr... |Lachnospir... |7.78730300... |
|CYP3A4      |4.99857331... |0.02242949... |2-Imino-1-... |Clostridium   |1.75386285... |
|CYP3A4      |4.99857331... |0.02242949... |Leucine       |Blautia       |4.16629071... |
|CYP3A4      |4.99857331... |0.02242949... |Creatine      |Akkermansia   |1.00303219... |
|CYP3A4      |4.99857331... |0.02242949... |Creatine      |Lactobacillus |1.00303219... |
|CYP3A4      |4.99857331... |0.02242949... |Creatine      |Lactobacil... |1.00303219... |
|HP          |6.35613254... |0.00982207... |Indoxyl su... |Lachnospir... |0.00525339... |
|HP          |6.35613254... |0.00982207... |Indoxyl su... |Escherichia   |0.00525339... |
|HP          |6.35613254... |0.00982207... |Indoxyl su... |Oscillibacter |0.00525339... |
|HP          |6.35613254... |0.00982207... |10-Keto-12... |Lactobacil... |0.01756457... |
|HP          |6.35613254... |0.00982207... |10-Oxo-11-... |Lactobacil... |0.01756457... |
|...         |...           |...           |...           |...           |...           |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Res-ileum) (下方表格) 为表格Res ileum概览。

**(对应文件为 `Figure+Table/Res-ileum.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行6列，以下预览的表格可能省略部分数据；含有2个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item META\_Q:  关联分析结果 P 的校正值 (源自文献的分析)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Res-ileum)Res ileum

|hgnc_symbol |logFC         |adj.P.Val     |related_me... |related_mi... |META_Q        |
|:-----------|:-------------|:-------------|:-------------|:-------------|:-------------|
|FGF19       |3.66703440... |0.03042149... |Glycocholi... |Escherichia   |7.27153355... |
|FGF19       |3.66703440... |0.03042149... |Glycocholi... |Akkermansia   |7.27153355... |
|FGF19       |3.66703440... |0.03042149... |3-Phenylpr... |Clostridiu... |1.32242917... |
|FGF19       |3.66703440... |0.03042149... |Deoxycholi... |Clostridiu... |8.88195779... |
|FGF19       |3.66703440... |0.03042149... |Deoxycholi... |Clostridiu... |8.88195779... |
|TF          |5.55755215... |0.02287326... |Serine        |Blautia       |1.40340968... |
|TF          |5.55755215... |0.02287326... |Indole-3-l... |Clostridiu... |1.49009106... |
|TF          |5.55755215... |0.02287326... |2-Imino-1-... |Clostridium   |6.10598737... |
|TF          |5.55755215... |0.02287326... |Leucine       |Blautia       |1.08359110... |
|TF          |5.55755215... |0.02287326... |Acetyl pho... |Clostridium   |1.72172512... |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}



