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
结肠炎和结肠癌的差异菌群} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-18}}
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



需求：

结肠炎和结肠癌的差异菌

结果 (主要思路)：

- 获取结肠炎 (UC) 和结肠癌的差异菌分析数据。
- 以包含完整 logFC 和 p-value 数据为主数据 (其余作验证) ，评估 Cancer vs UC，
  见 \@ref(assess1) 和 \@ref(assess2)。(因为 UC
  的数据集包含多个国家的来源，因此这里也对各个国家都分析了一遍，但 Cancer
  用的只是同一个数据集)。
  评估方式见 Fig. \@ref(fig:US-change-summary) 下方注释。
  (**注意，为了应对不同数据集信息的不一致性，分析是以属 (genus) 为基本单位展开的**)。
- 对各个国家的结果取交集，获得 Cancer vs UC 的菌为上升 (Fig. \@ref(fig:UpSets-Up)) 的和下降 (Fig. \@ref(fig:UpSets-down)) 的集。
  这些被整理于 Tab. \@ref(tab:All-changed-microbiota-genus)。
- 尝试以更多数据集验证这些菌是否为 Cancer 或 UC 的差异菌 (前提) 。最终结果见 Tab. \@ref(tab:change-validated)


# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to TransplantationSinha2022[@TransplantationSinha2022].
- Supplementary file from article refer to TargetedSuppreFederi2022[@TargetedSuppreFederi2022].
- Supplementary file from article refer to DepressionAndYuan2021[@DepressionAndYuan2021].
- Supplementary file from article refer to AnIntegratedTRoelan2023[@AnIntegratedTRoelan2023].
- Supplementary file from article refer to LocationAndCoSambru2023[@LocationAndCoSambru2023].
- Supplementary file from article refer to FunctionalChanDaniel2017[@FunctionalChanDaniel2017].

## 方法

Mainly used method:

- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 数据来源

### 结肠炎数据

#### TargetedSuppreFederi2022 结肠炎 {#main1}

 
`TargetedSuppreFederi2022 data' 数据已全部提供。

**(对应文件为 `Figure+Table/TargetedSuppreFederi2022-data`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/TargetedSuppreFederi2022-data共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Corrected France.csv
\item 2\_Corrected Israel.csv
\item 3\_Corrected US.csv
\item 4\_Corrected Germany.csv
\end{enumerate}\end{tcolorbox}
\end{center}



### 结肠癌数据

#### AnIntegratedTRoelan2023 结肠癌 {#main2}

Table \@ref(tab:AnIntegratedTRoelan2023-data) (下方表格) 为表格AnIntegratedTRoelan2023 data概览。

**(对应文件为 `Figure+Table/AnIntegratedTRoelan2023-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有74行15列，以下预览的表格可能省略部分数据；表格含有1个唯一`sheet'。
\end{tcolorbox}
\end{center}

Table: (\#tab:AnIntegratedTRoelan2023-data)AnIntegratedTRoelan2023 data

|sheet     |Taxonomy  |p_val     |FDR       |wilcox... |mean_N    |mean_T    |median_N  |median_T  |Direction |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|Supple... |D_0__B... |2.8875... |4.2447... |1965      |0.0121... |0.0524... |0.0006... |0.0059... |Enrich... |
|Supple... |D_0__B... |6.6405... |4.8807... |657       |0.0018... |0.0095... |0         |0         |Enrich... |
|Supple... |D_0__B... |7.1087... |3.4833... |21023.5   |0.0190... |0.0126... |0.0128... |0.0067... |Enrich... |
|Supple... |D_0__B... |2.8160... |1.0348... |18604     |0.0132... |0.0087... |0.0078... |0.0041... |Enrich... |
|Supple... |D_0__B... |1.7251... |5.0718... |11985     |0.0070... |0.0043... |0.0034... |0.0019... |Enrich... |
|Supple... |D_0__B... |5.0924... |1.2476... |7227.5    |0.0126... |0.0315... |0.0031... |0.0076... |Enrich... |
|Supple... |D_0__B... |9.2218... |1.9365... |223.5     |0.0002... |0.0052... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.5535... |2.8547... |16631.5   |0.0106... |0.0076... |0.0064... |0.0041... |Enrich... |
|Supple... |D_0__B... |2.1475... |3.5075... |1494      |0.0022... |0.0076... |0         |0         |Enrich... |
|Supple... |D_0__B... |4.3690... |6.2979... |62        |0.0001... |0.0026... |0         |0         |Enrich... |
|Supple... |D_0__B... |4.7127... |6.2979... |20341     |0.0280... |0.0232... |0.0228... |0.0170... |Enrich... |
|Supple... |D_0__B... |7.9474... |9.7356... |237.5     |0.0008... |0.0058... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.6820... |1.9019... |4806.5    |0.0040... |0.0026... |0         |0         |Enrich... |
|Supple... |D_0__B... |1.5690... |1.5376... |4009      |0.0025... |0.0039... |0.0006... |0.0013... |Enrich... |
|Supple... |D_0__B... |1.5362... |1.5376... |12107.5   |0.0075... |0.0059... |0.0017... |0.0012... |Enrich... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |



## 数据预处理

结肠炎 TargetedSuppreFederi2022 与结肠癌 AnIntegratedTRoelan2023 数据较为完整 (即，\@ref(main1), \@ref(main2))，
因此作为主要数据。

由于数据来源不同，格式不统一，需要根据微生物种属 (Taxonomy) 对信息补充或改动。

### 结肠炎

 
`Formated TargetedSuppreFederi2022' 数据已全部提供。

**(对应文件为 `Figure+Table/formated-TargetedSuppreFederi2022`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/formated-TargetedSuppreFederi2022共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Corrected France.csv
\item 2\_Corrected Germany.csv
\item 3\_Corrected Israel.csv
\item 4\_Corrected US.csv
\end{enumerate}\end{tcolorbox}
\end{center}



### 结肠癌

Table \@ref(tab:formated-AnIntegratedTRoelan2023) (下方表格) 为表格formated AnIntegratedTRoelan2023概览。

**(对应文件为 `Figure+Table/formated-AnIntegratedTRoelan2023.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有70行6列，以下预览的表格可能省略部分数据；表格含有70个唯一`Taxonomy'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:formated-AnIntegratedTRoelan2023)Formated AnIntegratedTRoelan2023

|Taxonomy      |Log2.Fold.... |FDR           |logFC         |genus         |taxon         |
|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|D_0__Bacte... |2.11202492... |4.24476048... |2.11202492... |Fusobacterium |d__Bacteri... |
|D_0__Bacte... |2.34581040... |4.88079358... |2.34581040... |Campylobacter |d__Bacteri... |
|D_0__Bacte... |-0.5903992... |3.48331113... |-0.5903992... |Parabacter... |d__Bacteri... |
|D_0__Bacte... |-0.6046987... |1.03488157... |-0.6046987... |Alistipes     |d__Bacteri... |
|D_0__Bacte... |-0.7020994... |5.07188395... |-0.7020994... |Phascolarc... |d__Bacteri... |
|D_0__Bacte... |1.32218708... |1.24765615... |1.32218708... |Streptococcus |d__Bacteri... |
|D_0__Bacte... |4.25806815... |1.93658213... |4.25806815... |Leptotrichia  |d__Bacteri... |
|D_0__Bacte... |-0.4918291... |2.85471118... |-0.4918291... |Fusicateni... |d__Bacteri... |
|D_0__Bacte... |1.78225934... |3.50758843... |1.78225934... |Gemella       |d__Bacteri... |
|D_0__Bacte... |4.58804189... |6.29791077... |4.58804189... |Selenomonas   |d__Bacteri... |
|D_0__Bacte... |-0.2729061... |6.29791077... |-0.2729061... |Blautia       |d__Bacteri... |
|D_0__Bacte... |2.79144013... |9.73561642... |2.79144013... |Selenomonas   |d__Bacteri... |
|D_0__Bacte... |0.63148802... |1.53763848... |0.63148802... |Lachnospir... |d__Bacteri... |
|D_0__Bacte... |-0.3387620... |1.53763848... |-0.3387620... |Barnesiella   |d__Bacteri... |
|D_0__Bacte... |-0.6863772... |1.87594484... |-0.6863772... |Paraprevot... |d__Bacteri... |
|...           |...           |...           |...           |...           |...           |



## 结肠炎与结肠癌差异菌比较

### US (示例) {#assess1}

Figure \@ref(fig:US-change-detail) (下方图) 为图US change detail概览。

**(对应文件为 `Figure+Table/US-change-detail.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/US-change-detail.pdf}
\caption{US change detail}\label{fig:US-change-detail}
\end{center}

Figure \@ref(fig:US-change-summary) (下方图) 为图US change summary概览。

**(对应文件为 `Figure+Table/US-change-summary.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/US-change-summary.pdf}
\caption{US change summary}\label{fig:US-change-summary}
\end{center}

说明：

- value 1 或 2, 代表 log2(FC) &gt; 0, 该属 (genus) 包含差异菌为丰度升高的。
- value 0, 包含 log2(FC) &gt; 0 或 log2(FC) &lt; 0, 但该属 (genus) 整体不确定的 (因为不利于 Cancer vs UC 的推断)。
- value -1, 或 -2, 代表 log2(FC) &lt; 0, 该属 (genus) 包含差异菌为丰度下降的 。

### 其他 {#assess2}

 
`Change detail' 数据已全部提供。

**(对应文件为 `Figure+Table/Change-detail`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Change-detail共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Corrected France.pdf
\item 2\_Corrected Germany.pdf
\item 3\_Corrected Israel.pdf
\item 4\_Corrected US.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

 
`Change summary' 数据已全部提供。

**(对应文件为 `Figure+Table/Change-summary`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Change-summary共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_Corrected France.pdf
\item 2\_Corrected Germany.pdf
\item 3\_Corrected Israel.pdf
\item 4\_Corrected US.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

### 数据集的汇总

Figure \@ref(fig:UpSets-Up) (下方图) 为图UpSets Up概览。

**(对应文件为 `Figure+Table/UpSets-Up.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/UpSets-Up.pdf}
\caption{UpSets Up}\label{fig:UpSets-Up}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    Alcanivorax, Anaerosporobacter, Campylobacter,
Eikenella, Gemella, Halomonas, Hungatella,
Lachnoanaerobaculum, Leptotrichia, Porphyromonas,
Selenomonas, Treponema

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/UpSets-Up-content`)**

Figure \@ref(fig:UpSets-down) (下方图) 为图UpSets down概览。

**(对应文件为 `Figure+Table/UpSets-down.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/UpSets-down.pdf}
\caption{UpSets down}\label{fig:UpSets-down}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    Agathobacter, Azospirillum, Bacteroides, Blautia,
Butyricimonas, Christensenellaceae, Desulfovibrio,
Erysipelotrichaceae, Eubacterium, Flavonifractor,
Fournierella, Fusicatenibacter, Klebsiella,
Negativibacillus, Parabacteroides, Parasutterella,
Prevotellaceae, Rikenellaceae, Ruminiclostridium, R...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/UpSets-down-content`)**

Table \@ref(tab:All-changed-microbiota-genus) (下方表格) 为表格All changed microbiota genus概览。

**(对应文件为 `Figure+Table/All-changed-microbiota-genus`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有34行2列，以下预览的表格可能省略部分数据；表格含有34个唯一`name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-changed-microbiota-genus)All changed microbiota genus

|name                |type |
|:-------------------|:----|
|Agathobacter        |Down |
|Azospirillum        |Down |
|Bacteroides         |Down |
|Blautia             |Down |
|Butyricimonas       |Down |
|Christensenellaceae |Down |
|Desulfovibrio       |Down |
|Erysipelotrichaceae |Down |
|Eubacterium         |Down |
|Flavonifractor      |Down |
|Fournierella        |Down |
|Fusicatenibacter    |Down |
|Klebsiella          |Down |
|Negativibacillus    |Down |
|Parabacteroides     |Down |
|...                 |...  |




## 在更多数据集验证

### 数据来源

#### DepressionAndYuan2021 结肠炎

Table \@ref(tab:DepressionAndYuan2021-data) (下方表格) 为表格DepressionAndYuan2021 data概览。

**(对应文件为 `Figure+Table/DepressionAndYuan2021-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有91行4列，以下预览的表格可能省略部分数据；表格含有91个唯一`Taxonomy'。
\end{tcolorbox}
\end{center}

Table: (\#tab:DepressionAndYuan2021-data)DepressionAndYuan2021 data

|Taxonomy             |p.value              |MRA.in.UC            |MRA.in.HC            |
|:--------------------|:--------------------|:--------------------|:--------------------|
|p__Gemmatimonadetes  |0.00049553252446827  |0.00171119907683608  |0.000160190585722501 |
|p__Actinobacteria    |0.00834784591709094  |0.0617033057472256   |0.0389112516772091   |
|p__Firmicutes        |0.00478686441960355  |0.589610871565727    |0.499806265231797    |
|p__Bacteroidetes     |9.60337999115942e-05 |0.250752809840626    |0.403687121772228    |
|p__unidentified      |1.40986578996555e-07 |0.000640301130981834 |2.05372545798078e-06 |
|c__Actinobacteria    |0.00353055167754535  |0.046725454341533    |0.0237116295626934   |
|c__Longimicrobia     |7.16632518063251e-07 |0.00145496100157866  |0                    |
|c__Bacteroidia       |6.38198131772293e-05 |0.24518920382048     |0.403287329883075    |
|c__Deinococci        |3.17450175630301e-06 |0.00131123215732429  |0                    |
|c__Bacilli           |0.00330587139663399  |0.0649165901033199   |0.0154563377967633   |
|c__Cytophagia        |2.10636789003367e-05 |0.0016664310495747   |4.24436594649361e-05 |
|c__unidentified      |2.64154914758447e-08 |0.0016652538833675   |8.83101946931736e-05 |
|c__Flavobacteriia    |5.26714172360768e-05 |0.00167703418517471  |5.95580382814426e-05 |
|o__Oceanospirillales |0.00495867783478051  |0.000461817587592187 |2.05372545798077e-06 |
|o__Bifidobacteriales |0.00354779153342515  |0.0443044462799416   |0.0224465346805772   |
|...                  |...                  |...                  |...                  |





#### TransplantationSinha2022 结肠炎

Table \@ref(tab:TransplantationSinha2022-data) (下方表格) 为表格TransplantationSinha2022 data概览。

**(对应文件为 `Figure+Table/TransplantationSinha2022-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有141行12列，以下预览的表格可能省略部分数据；表格含有83个唯一`W'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TransplantationSinha2022-data)TransplantationSinha2022 data

|W   |detect......2 |detect......3 |detect......4 |detect......5 |Kingdom   |Phylum    |Class     |Order     |Family    |... |
|:---|:-------------|:-------------|:-------------|:-------------|:---------|:---------|:---------|:---------|:---------|:---|
|121 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Rikene... |... |
|89  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Rikene... |... |
|87  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Marini... |... |
|94  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|125 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|94  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|95  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Barnes... |... |
|135 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Prevot... |... |
|138 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Bacter... |Bacter... |Bacter... |Prevot... |... |
|103 |FALSE         |FALSE         |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Lactob... |Entero... |... |
|134 |TRUE          |TRUE          |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|118 |FALSE         |TRUE          |TRUE          |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|90  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|87  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|95  |FALSE         |FALSE         |FALSE         |TRUE          |d__Bac... |Firmic... |Bacilli   |Erysip... |Erysip... |... |
|... |...           |...           |...           |...           |...       |...       |...       |...       |...       |... |



#### LocationAndCoSambru2023 结肠癌

Table \@ref(tab:LocationAndCoSambru2023-data) (下方表格) 为表格LocationAndCoSambru2023 data概览。

**(对应文件为 `Figure+Table/LocationAndCoSambru2023-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有44行2列，以下预览的表格可能省略部分数据；表格含有44个唯一`tax\_id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LocationAndCoSambru2023-data)LocationAndCoSambru2023 data

|tax_id  |taxon_name                     |
|:-------|:------------------------------|
|40545   |Sutterella_wadsworthensis      |
|214856  |Alistipes_finegoldii           |
|328814  |Alistipes_shahii               |
|674529  |Bacteroides_faecis             |
|333367  |[Clostridium]_asparagiforme    |
|437898  |Sutterella_parvirubra          |
|74426   |Collinsella_aerofaciens        |
|1531    |[Clostridium]_clostridioforme  |
|239935  |Akkermansia_muciniphila        |
|901     |Desulfovibrio_piger            |
|1892897 |Shigella_sp._FC569             |
|68259   |Streptomyces_purpurogeneisc... |
|1450439 |Bacteroides_sp._UW             |
|585543  |Bacteroides_sp._D20            |
|1581131 |Actinomyces_sp._HMSC08A01      |
|...     |...                            |



#### FunctionalChanDaniel2017 结肠癌

Table \@ref(tab:FunctionalChanDaniel2017-data) (下方表格) 为表格FunctionalChanDaniel2017 data概览。

**(对应文件为 `Figure+Table/FunctionalChanDaniel2017-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有9行3列，以下预览的表格可能省略部分数据；表格含有9个唯一`Name(s)'。
\end{tcolorbox}
\end{center}

Table: (\#tab:FunctionalChanDaniel2017-data)FunctionalChanDaniel2017 data

|Name(s)                        |Relationship                   |genus           |
|:------------------------------|:------------------------------|:---------------|
|Citrobacter rodentium          |Min mice inoculated with th... |Citrobacter     |
|Enterococcus faecalis          |Produces superoxide and hyd... |Enterococcus    |
|Clostridium cluster XVIa (C... |Can produce secondary bile ... |Clostridium     |
|Acidovorax species             |Associated with increased r... |Acidovorax      |
|Enterotoxigenic Bacteroides... |Produces a toxin that cause... |Enterotoxigenic |
|Streptococcus gallolyticus     |Present in approximately 20... |Streptococcus   |
|Escherichia coli NC101         |Produces genotoxic colibact... |Escherichia     |
|Fusobacterium nucleatum        |Induces hyperproliferation ... |Fusobacterium   |
|Akkermansia muciniphila        |Mucin-degrading species wer... |Akkermansia     |




### 结果

Table \@ref(tab:change-validated) (下方表格) 为表格change validated概览。

**(对应文件为 `Figure+Table/change-validated.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有34行7列，以下预览的表格可能省略部分数据；表格含有34个唯一`name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:change-validated)Change validated

|name          |type |Other_data... |Depression... |Transplant... |LocationAn... |Functional... |
|:-------------|:----|:-------------|:-------------|:-------------|:-------------|:-------------|
|Agathobacter  |Down |0             |FALSE         |FALSE         |FALSE         |FALSE         |
|Azospirillum  |Down |0             |FALSE         |FALSE         |FALSE         |FALSE         |
|Bacteroides   |Down |2             |FALSE         |TRUE          |TRUE          |FALSE         |
|Blautia       |Down |2             |TRUE          |TRUE          |FALSE         |FALSE         |
|Butyricimonas |Down |2             |TRUE          |TRUE          |FALSE         |FALSE         |
|Christense... |Down |1             |FALSE         |TRUE          |FALSE         |FALSE         |
|Desulfovibrio |Down |3             |TRUE          |TRUE          |TRUE          |FALSE         |
|Erysipelot... |Down |0             |FALSE         |FALSE         |FALSE         |FALSE         |
|Eubacterium   |Down |3             |TRUE          |TRUE          |TRUE          |FALSE         |
|Flavonifra... |Down |2             |TRUE          |TRUE          |FALSE         |FALSE         |
|Fournierella  |Down |0             |FALSE         |FALSE         |FALSE         |FALSE         |
|Fusicateni... |Down |1             |TRUE          |FALSE         |FALSE         |FALSE         |
|Klebsiella    |Down |0             |FALSE         |FALSE         |FALSE         |FALSE         |
|Negativiba... |Down |1             |FALSE         |TRUE          |FALSE         |FALSE         |
|Parabacter... |Down |2             |FALSE         |TRUE          |TRUE          |FALSE         |
|...           |...  |...           |...           |...           |...           |...           |




