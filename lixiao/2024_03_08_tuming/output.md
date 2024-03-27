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
\begin{center} \textbf{\Huge VASH2 序列分析}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-27}}
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



## 需求

为了鉴定 VASH2 被 PRMT5 甲基化的精氨酸残基 (methylarginine)，使用甲基化预测工具包括 PRmePred 和 GPS-MSP 分析 VASH2 的蛋白序列

protein post-translational modification site (PTM)

## 结果

VASH2 的序列见 \@ref(seq)。

共尝试使用了以下三种工具预测位点。

- MusiteDeep <https://www.musite.net> <https://github.com/duolinwang/MusiteDeep_web>
- GPS-MSP <https://msp.biocuckoo.org/>
- PRmePred <http://bioinfo.icgeb.res.in/PRmePRed/>

更推荐 MusiteDeep 的预测结果 [@MusitedeepADWang2020] (发表于 Nucleic Acids Research)，其结果已整理，见 
Fig. \@ref(fig:PTM-score), 和 Tab. \@ref(tab:Prediction-PTM-of-Methylarginine)。

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Python tool `MusiteDeep` was used for protein post-translational modification site prediction and visualization[@MusitedeepADWang2020].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 获取蛋白序列 {#seq}

 
`VASH2 protein fasta' 数据已提供。

**(对应文件为 `fasta/Seq.fasta`)**

## 预测位点

使用以下工具：

### MusiteDeep

Table \@ref(tab:Prediction-PTM-of-Methylarginine) (下方表格) 为表格Prediction PTM of Methylarginine概览。

**(对应文件为 `Figure+Table/Prediction-PTM-of-Methylarginine.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有29行5列，以下预览的表格可能省略部分数据；表格含有1个唯一`Sequence\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Prediction-PTM-of-Methylarginine)Prediction PTM of Methylarginine

|Sequence_name |PTM_type       |Position |Residue |PTM_score |
|:-------------|:--------------|:--------|:-------|:---------|
|VASH2         |Methylarginine |309      |R       |0.7       |
|VASH2         |Methylarginine |102      |R       |0.43      |
|VASH2         |Methylarginine |177      |R       |0.258     |
|VASH2         |Methylarginine |65       |R       |0.215     |
|VASH2         |Methylarginine |307      |R       |0.198     |
|VASH2         |Methylarginine |203      |R       |0.151     |
|VASH2         |Methylarginine |10       |R       |0.146     |
|VASH2         |Methylarginine |212      |R       |0.137     |
|VASH2         |Methylarginine |85       |R       |0.132     |
|VASH2         |Methylarginine |211      |R       |0.113     |
|VASH2         |Methylarginine |134      |R       |0.107     |
|VASH2         |Methylarginine |21       |R       |0.081     |
|VASH2         |Methylarginine |316      |R       |0.072     |
|VASH2         |Methylarginine |324      |R       |0.071     |
|VASH2         |Methylarginine |23       |R       |0.069     |
|...           |...            |...      |...     |...       |

Table \@ref(tab:High-score-prediction-PTM-of-Methylarginine) (下方表格) 为表格High score prediction PTM of Methylarginine概览。

**(对应文件为 `Figure+Table/High-score-prediction-PTM-of-Methylarginine.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行5列，以下预览的表格可能省略部分数据；表格含有1个唯一`Sequence\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:High-score-prediction-PTM-of-Methylarginine)High score prediction PTM of Methylarginine

|Sequence_name |PTM_type       |Position |Residue |PTM_score |
|:-------------|:--------------|:--------|:-------|:---------|
|VASH2         |Methylarginine |309      |R       |0.7       |

Figure \@ref(fig:PTM-score) (下方图) 为图PTM score概览。

**(对应文件为 `Figure+Table/PTM-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PTM-score.pdf}
\caption{PTM score}\label{fig:PTM-score}
\end{center}



### GPS-MSP 

该网络服务器好像并没有提供 甲基化的精氨酸残基 (methylarginine) 位点预测工具  (没有 type: R.Me) 。

<https://msp.biocuckoo.org/online.php>

### PRmePred

<http://bioinfo.icgeb.res.in/PRmePRed/>

Table \@ref(tab:PRmePred-results) (下方表格) 为表格PRmePred results概览。

**(对应文件为 `Figure+Table/PRmePred-results.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有19行4列，以下预览的表格可能省略部分数据；表格含有1个唯一`SeqId'。
\end{tcolorbox}
\end{center}

Table: (\#tab:PRmePred-results)PRmePred results

|SeqId |R site |Peptides            |Prediction Score |
|:-----|:------|:-------------------|:----------------|
|VASH2 |10     |MTGSAADTHRCPHPKGAKG |0.753787         |
|VASH2 |21     |PHPKGAKGTRSRSSHARPV |0.939423         |
|VASH2 |23     |PKGAKGTRSRSSHARPVSL |0.837776         |
|VASH2 |28     |GTRSRSSHARPVSLATSGG |0.959969         |
|VASH2 |85     |KGGEMVGAIRNAAFLAKPS |0.651501         |
|VASH2 |134    |HTGTQFFEIRKMRPLSGLM |0.532284         |
|VASH2 |151    |LMETAKEMTRESLPIKCLE |0.602389         |
|VASH2 |203    |VVLGIYCNGRYGSLGMSRR |0.884941         |
|VASH2 |211    |GRYGSLGMSRRAELMDKPL |0.815102         |
|VASH2 |212    |RYGSLGMSRRAELMDKPLT |0.7399           |
|VASH2 |307    |ASAHSPTQVRSRGKSLSPR |0.963406         |
|VASH2 |309    |AHSPTQVRSRGKSLSPRRR |0.98479          |
|VASH2 |316    |RSRGKSLSPRRRQASPPRR |0.819054         |
|VASH2 |317    |SRGKSLSPRRRQASPPRRL |0.921694         |
|VASH2 |318    |RGKSLSPRRRQASPPRRLG |0.96432          |
|...   |...    |...                 |...              |



