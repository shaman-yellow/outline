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
\textbf{\textcolor{white}{2024-02-27}}
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

## 需求概要

数据分组：

- con: Control
- A: colitis
- B: colon precancerous lesions

肠道菌群测序结果+生信分析，得出：菌群+对应代谢产物介导+机制研究+再闭环回到临床。

具体：

溃疡性结肠炎和结肠癌的肠道菌群之间的区别和关联，进而研究其对应的机制，研究结肠炎向结肠癌发展的关键机制，为临床早期筛查提供理论支持

## 分析结果

- 基本分析：
    - alpha、beta 多样性，A、B、C 组均无显著性差异 (\@ref(alpha), \@ref(beta))。
    - 差异菌筛选 (level 6, Species) ，筛得差异菌 (Fig. \@ref(fig:Ancom-test-group-level-6-volcano))：d__Bacteria;p__Proteobacteria;c__Alphaproteobacteria;o__Rhizobiales;f__Beijerinckiaceae;g__Methylobacterium-Methylorubrum 
      该差异菌主要存在于 A、B 组，不存在 (或少量于) 于 C (对照) 组。
      含量见 Fig. \@ref(fig:Ancom-test-group-level-6-Percentile-abundance)
    - ...
    - 差异菌 (level 2, Phylum) (Fig. \@ref(fig:Ancom-test-group-level-2-volcano)), 同样的有：d__Bacteria;p__Proteobacteria
      该差异菌主要存在于 A、B 组，不存在 (或少量于) 于 C (对照) 组。
      含量见 Fig. \@ref(fig:Ancom-test-group-level-2-Percentile-abundance)
- 从肠道菌到相关代谢物：
    - 使用 gutMDisorder 未发现相关代谢物。
    - 从一孟德尔随机化相关研究中[@MendelianRandoLiuX2022]，发现了与差异菌相关的代谢物，见
      Tab. \@ref(tab:MendelianRandoLiuX2022-matched-data)。
      这些代谢物为 (详细信息见 Tab. \@ref(tab:compounds-ID))：
      5-methyltetrahydrofolic acid, selenium, L-cystine, Glutamic acid
    - 用 MetaboAnalystR 对相关代谢物进行富集分析，富集到两条通路 (见 Fig. \@ref(fig:MetaboAnalyst-kegg-enrichment))
    - 用 FELLA 对相关代谢物富集分析, 可以发现相关联的更多通路或反应模块
      (结果见 Fig. \@ref(fig:Enrichment-with-algorithm-PageRank),
      Tab. \@ref(tab:Data-of-enrichment-with-algorithm-PageRank))
- 尝试从已有的关于结肠炎或结肠癌的研究中验证上述发现：
    - 从结肠癌相关研究中匹配到 [@LossOfSymbiotSadegh2024] (Tab.
      \@ref(tab:LossOfSymbiotSadegh2024-matched-Phylum-microbiota))：d__Bacteria;p__Proteobacteria
      (注：在 Phylum 水平上得到验证)
    - 未从其它文献中匹配到代谢物或差异肠道菌 (见 \@ref(valids)。
- 结肠炎向结肠癌之间的转化：
    - A 为结肠炎，B 为结肠癌前病变； A 与 B 组间无显著差异菌，因此无法从这一批数据探究可能的发展机制 (A -> B)。

      



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to[@MendelianRandoLiuX2022].

## 方法

Mainly used method:

- R package `FELLA` used for metabolite enrichment analysis[@FellaAnRPacPicart2018].
- `Fastp` used for Fastq data preprocessing[@UltrafastOnePChen2023].
- Database `gutMDisorder` used for finding associations between gut microbiota and metabolites[@GutmdisorderACheng2019].
- R package `MicrobiotaProcess` used for microbiome data visualization[@MicrobiotaproceXuSh2023].
- `MetaboAnalyst` used for metabolomic data analysis[@Metaboanalyst4Chong2018].
- `Qiime2` used for gut microbiome 16s rRNA analysis[@ReproducibleIBolyen2019; @TheBiologicalMcdona2012; @Dada2HighResCallah2016; @ErrorCorrectinHamday2008; @MicrobialCommuHamday2009].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

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

1. <https://forum.qiime2.org/t/how-to-interpret-ancom-results/1958>
2. <https://forum.qiime2.org/t/specify-w-cutoff-for-anacom/1844>

Figure \@ref(fig:Ancom-test-group-level-2-volcano) (下方图) 为图Ancom test group level 2 volcano概览。

**(对应文件为 `Figure+Table/Ancom-test-group-level-2-volcano.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ancom-test-group-level-2-volcano.pdf}
\caption{Ancom test group level 2 volcano}\label{fig:Ancom-test-group-level-2-volcano}
\end{center}

Figure \@ref(fig:Ancom-test-group-level-2-Percentile-abundance) (下方图) 为图Ancom test group level 2 Percentile abundance概览。

**(对应文件为 `Figure+Table/Ancom-test-group-level-2-Percentile-abundance.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ancom-test-group-level-2-Percentile-abundance.pdf}
\caption{Ancom test group level 2 Percentile abundance}\label{fig:Ancom-test-group-level-2-Percentile-abundance}
\end{center}

Figure \@ref(fig:Ancom-test-group-level-6-volcano) (下方图) 为图Ancom test group level 6 volcano概览。

**(对应文件为 `Figure+Table/Ancom-test-group-level-6-volcano.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ancom-test-group-level-6-volcano.pdf}
\caption{Ancom test group level 6 volcano}\label{fig:Ancom-test-group-level-6-volcano}
\end{center}

Figure \@ref(fig:Ancom-test-group-level-6-Percentile-abundance) (下方图) 为图Ancom test group level 6 Percentile abundance概览。

**(对应文件为 `Figure+Table/Ancom-test-group-level-6-Percentile-abundance.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ancom-test-group-level-6-Percentile-abundance.pdf}
\caption{Ancom test group level 6 Percentile abundance}\label{fig:Ancom-test-group-level-6-Percentile-abundance}
\end{center}

'level 2' 对应 Ontology 中的 Phylum。
'level 6' 对应 Ontology 中的 Species。

其余结果的可视化见：

 
`Ancom test visualization' 数据已全部提供。

**(对应文件为 `Figure+Table/Ancom-test-visualization`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ancom-test-visualization共包含8个文件。

\begin{enumerate}\tightlist
\item 1\_ancom\_test\_group\_level\_2.pdf
\item 1\_ancom\_test\_group\_level\_4.pdf
\item 2\_ancom\_test\_group\_level\_3.pdf
\item 2\_ancom\_test\_group\_level\_5.pdf
\item 3\_ancom\_test\_group\_level\_4.pdf
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

 
`Ancom test Percentile abundance' 数据已全部提供。

**(对应文件为 `Figure+Table/Ancom-test-Percentile-abundance`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ancom-test-Percentile-abundance共包含5个文件。

\begin{enumerate}\tightlist
\item 1\_ancom\_test\_group\_level\_2.pdf
\item 2\_ancom\_test\_group\_level\_3.pdf
\item 3\_ancom\_test\_group\_level\_4.pdf
\item 4\_ancom\_test\_group\_level\_5.pdf
\item 5\_ancom\_test\_group\_level\_6.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

 
`Ancom test results' 数据已全部提供。

**(对应文件为 `Figure+Table/Ancom-test-results`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ancom-test-results共包含8个文件。

\begin{enumerate}\tightlist
\item 1\_ancom\_test\_group\_level\_2.csv
\item 1\_ancom\_test\_group\_level\_4.csv
\item 2\_ancom\_test\_group\_level\_3.csv
\item 2\_ancom\_test\_group\_level\_5.csv
\item 3\_ancom\_test\_group\_level\_4.csv
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}



### 差异菌关联到代谢物

#### 从 gutMDisorder 数据库检索关联代谢物

使用的数据库如下：

Table \@ref(tab:GutMDisorder-database) (下方表格) 为表格GutMDisorder database概览。

**(对应文件为 `Figure+Table/GutMDisorder-database.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有724行12列，以下预览的表格可能省略部分数据；表格含有289个唯一`Gut.Microbiota'。
\end{tcolorbox}
\end{center}

Table: (\#tab:GutMDisorder-database)GutMDisorder database

|Gut.Mi......1 |Gut.Mi......2 |Gut.Mi......3 |Classi... |Substrate |Substr......6 |Substr......7 |... |
|:-------------|:-------------|:-------------|:---------|:---------|:-------------|:-------------|:---|
|Christ...     |NA            |gm0883        |strain    |D-Glucose |5793          |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |Salicin   |439503        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |D-Xylose  |135191        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |L-Arab... |439195        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |L-Rham... |25310         |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |D-Mannose |18950         |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |D-Glucose |5793          |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |Salicin   |439503        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |D-Xylose  |135191        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |L-Arab... |439195        |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |L-Rham... |25310         |HMDB00...     |... |
|Christ...     |NA            |gm0883        |strain    |D-Mannose |18950         |HMDB00...     |... |
|Entero...     |1343173       |gm0884        |species   |Orientin  |5281675       |HMDB00...     |... |
|Clostr...     |29347         |gm0885        |strain    |Bile acid |439520        |              |... |
|Clostr...     |29347         |gm0885        |strain    |Cholic... |221493        |HMDB00...     |... |
|...           |...           |...           |...       |...       |...           |...           |... |

使用差异肠道菌匹配：

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Content
:}

\vspace{0.5em}

    Proteobacteria, Alphaproteobacteria, Rhizobiales,
Beijerinckiaceae, Methylobacterium-Methylorubrum

\vspace{2em}
\end{tcolorbox}
\end{center}

未找到相关代谢物。



#### 尝试从已发表研究 (孟德尔随机化相关) 中寻找关联代谢物 {#mr-match}

请参考 [@MendelianRandoLiuX2022]

匹配到 Phylum 水平的菌群关联的代谢物:

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Content
:}

\vspace{0.5em}

    5-methyltetrahydrofolic acid, selenium, Cystine,
Glutamic acid

\vspace{2em}
\end{tcolorbox}
\end{center}

Table \@ref(tab:MendelianRandoLiuX2022-matched-data) (下方表格) 为表格MendelianRandoLiuX2022 matched data概览。

**(对应文件为 `Figure+Table/MendelianRandoLiuX2022-matched-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行25列，以下预览的表格可能省略部分数据；表格含有1个唯一`X1'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MendelianRandoLiuX2022-matched-data)MendelianRandoLiuX2022 matched data

|X1        |X2        |beta      |se        |p         |beta.1    |se.1      |p.1       |p_MRPR... |beta.2    |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|p_Prot... |5-meth... |-0.15312  |0.0313679 |1.0532... |-0.097... |0.0417018 |0.0188806 |0.1756    |-0.166... |
|p_Prot... |selenium  |-0.122431 |0.0289698 |2.3772... |-0.032... |0.0412256 |0.431953  |0.189     |-0.192... |
|p_Prot... |Cystine   |-0.097... |0.0221977 |1.0141... |-0.045... |0.0323047 |0.16131   |0.4752    |-0.101... |
|p_Prot... |Glutam... |0.175275  |0.0392992 |8.1952... |0.0363522 |0.0368746 |0.324216  |0.0082    |0.1929... |



### 代谢物的富集分析

将匹配到的代谢物 (\@ref(mr-match)) 进行代谢物富集分析。

以下是代谢物的数据库匹配：

Table \@ref(tab:compounds-ID) (下方表格) 为表格compounds ID概览。

**(对应文件为 `Figure+Table/compounds-ID.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行7列，以下预览的表格可能省略部分数据；表格含有4个唯一`Query'。
\end{tcolorbox}
\end{center}

Table: (\#tab:compounds-ID)Compounds ID

|Query         |Match         |HMDB        |PubChem |KEGG   |SMILES        |Comment |
|:-------------|:-------------|:-----------|:-------|:------|:-------------|:-------|
|5-methylte... |5-Methylte... |HMDB0001396 |439234  |C00440 |CN1C(CNC2=... |1       |
|selenium      |Selenium      |HMDB0001349 |NA      |C01529 |[Se++]        |1       |
|L-cystine     |L-Cystine     |HMDB0000192 |67678   |C00491 |N[C@@H](CS... |1       |
|Glutamic acid |Glutamic acid |HMDB0000148 |33032   |C00302 |N[C@@H](CC... |1       |



Figure \@ref(fig:MetaboAnalyst-kegg-enrichment) (下方图) 为图MetaboAnalyst kegg enrichment概览。

**(对应文件为 `Figure+Table/metabolites_ORA_dot_kegg_pathway_dpi72.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{figs/metabolites_ORA_dot_kegg_pathway_dpi72.pdf}
\caption{MetaboAnalyst kegg enrichment}\label{fig:MetaboAnalyst-kegg-enrichment}
\end{center}

Figure \@ref(fig:Enrichment-with-algorithm-PageRank) (下方图) 为图Enrichment with algorithm PageRank概览。

**(对应文件为 `Figure+Table/Enrichment-with-algorithm-PageRank.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Enrichment-with-algorithm-PageRank.pdf}
\caption{Enrichment with algorithm PageRank}\label{fig:Enrichment-with-algorithm-PageRank}
\end{center}

Table \@ref(tab:Data-of-enrichment-with-algorithm-PageRank) (下方表格) 为表格Data of enrichment with algorithm PageRank概览。

**(对应文件为 `Figure+Table/Data-of-enrichment-with-algorithm-PageRank.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有39行7列，以下预览的表格可能省略部分数据；表格含有39个唯一`name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Data-of-enrichment-with-algorithm-PageRank)Data of enrichment with algorithm PageRank

|name     |com |NAME          |label         |input  |abbrev.name   |type    |
|:--------|:---|:-------------|:-------------|:------|:-------------|:-------|
|hsa00220 |1   |Arginine b... |Arginine b... |Others |Arginine b... |Pathway |
|hsa00250 |1   |Alanine, a... |Alanine, a... |Others |Alanine, a... |Pathway |
|hsa00270 |1   |Cysteine a... |Cysteine a... |Others |Cysteine a... |Pathway |
|hsa00380 |1   |Tryptophan... |Tryptophan... |Others |Tryptophan... |Pathway |
|hsa00450 |1   |Selenocomp... |Selenocomp... |Others |Selenocomp... |Pathway |
|hsa00670 |1   |One carbon... |One carbon... |Others |One carbon... |Pathway |
|hsa01200 |1   |Carbon met... |Carbon met... |Others |Carbon met... |Pathway |
|hsa01523 |1   |Antifolate... |Antifolate... |Others |Antifolate... |Pathway |
|hsa02010 |1   |ABC transp... |ABC transp... |Others |ABC transp... |Pathway |
|hsa04216 |1   |Ferroptosi... |Ferroptosi... |Others |Ferroptosi... |Pathway |
|hsa04974 |1   |Protein di... |Protein di... |Others |Protein di... |Pathway |
|hsa04975 |1   |Fat digest... |Fat digest... |Others |Fat digest... |Pathway |
|M00017   |2   |Methionine... |Methionine... |Others |Methionine... |Module  |
|M00170   |2   |C4-dicarbo... |C4-dicarbo... |Others |C4-dicarbo... |Module  |
|M00171   |2   |C4-dicarbo... |C4-dicarbo... |Others |C4-dicarbo... |Module  |
|...      |... |...           |...           |...    |...           |...     |



### 从结肠炎或结肠癌已发表的代谢物研究中验证 {#valids}

#### DepressionAndYuan2021 结肠炎 (肠道菌)

Depression and anxiety in patients with active ulcerative colitis: crosstalk of gut microbiota, metabolomics and proteomics [@DepressionAndYuan2021]

以下是整理自该文献的差异肠道菌汇总：

Table \@ref(tab:DepressionAndYuan2021-published-data-significant-microbiota) (下方表格) 为表格DepressionAndYuan2021 published data significant microbiota概览。

**(对应文件为 `Figure+Table/DepressionAndYuan2021-published-data-significant-microbiota.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有91行4列，以下预览的表格可能省略部分数据；表格含有91个唯一`Taxonomy'。
\end{tcolorbox}
\end{center}

Table: (\#tab:DepressionAndYuan2021-published-data-significant-microbiota)DepressionAndYuan2021 published data significant microbiota

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

未从 Fig. \@ref(tab:DepressionAndYuan2021-published-data-significant-microbiota) 中匹配到
客户数据筛选出的肠道菌。





#### AlterationsInScovil2018 结肠炎 (代谢物)

Alterations in Lipid, Amino Acid, and Energy Metabolism Distinguish Crohn’s Disease from Ulcerative Colitis and Control Subjects by Serum Metabolomic Profiling [@AlterationsInScovil2018].

以下是整理自该文献的代谢物汇总：

Table \@ref(tab:AlterationsInScovil2018-published-data-metabolites) (下方表格) 为表格AlterationsInScovil2018 published data metabolites概览。

**(对应文件为 `Figure+Table/AlterationsInScovil2018-published-data-metabolites.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有565行22列，以下预览的表格可能省略部分数据；表格含有565个唯一`Metabolite'。
\end{tcolorbox}
\end{center}

Table: (\#tab:AlterationsInScovil2018-published-data-metabolites)AlterationsInScovil2018 published data metabolites

|Metabo... |Pathway   |Sub-Pa... |Platform  |RI     |Mass     |MSI Id... |PUBCHEM |KEGG   |HMDB      |
|:---------|:---------|:---------|:---------|:------|:--------|:---------|:-------|:------|:---------|
|alanine   |Amino ... |Alanin... |LC/MS ... |2780.3 |88.0404  |1         |5950    |C00041 |HMDB00161 |
|aspara... |Amino ... |Alanin... |LC/MS ... |2951.1 |131.0462 |1         |6267    |C00152 |HMDB00168 |
|aspartate |Amino ... |Alanin... |LC/MS Neg |640    |132.0302 |1         |5960    |C00049 |HMDB00191 |
|N-acet... |Amino ... |Alanin... |LC/MS ... |1564.8 |130.051  |1         |88064   |C02847 |HMDB00766 |
|N-acet... |Amino ... |Alanin... |LC/MS ... |785    |175.0713 |1         |99715   |NA     |HMDB06028 |
|N-acet... |Amino ... |Alanin... |LC/MS ... |3143   |174.0408 |1         |65065   |C01042 |HMDB00812 |
|creatine  |Amino ... |Creati... |LC/MS ... |2920   |130.0622 |1         |586     |C00300 |HMDB00064 |
|creati... |Amino ... |Creati... |LC/MS ... |2055   |114.0662 |1         |588     |C00791 |HMDB00562 |
|guanid... |Amino ... |Creati... |LC/MS ... |2884   |116.0466 |1         |763     |C00581 |HMDB00128 |
|glutamate |Amino ... |Glutam... |LC/MS ... |1500   |148.0604 |1         |611     |C00025 |HMDB00148 |
|glutamine |Amino ... |Glutam... |LC/MS ... |1291   |147.0764 |1         |5961    |C00064 |HMDB00641 |
|N-acet... |Amino ... |Glutam... |LC/MS ... |1035   |305.098  |1         |5255    |C12270 |HMDB01067 |
|N-acet... |Amino ... |Glutam... |LC/MS ... |3106   |188.0564 |1         |70914   |C00624 |HMDB01138 |
|N-acet... |Amino ... |Glutam... |LC/MS Neg |771    |187.0724 |1         |182230  |C02716 |HMDB06029 |
|pyrogl... |Amino ... |Glutam... |LC/MS ... |1900   |129.0659 |2         |134508  |NA     |NA        |
|...       |...       |...       |...       |...    |...      |...       |...     |...    |...       |

未从 Tab. \@ref(tab:AlterationsInScovil2018-published-data-metabolites) 中匹配到
\@ref(mr-match) 中的关联代谢物。



#### LossOfSymbiotSadegh2024 结肠癌 (肠道菌) {#valid}

Loss of symbiotic and increase of virulent bacteria through microbial networks
in Lynch syndrome colon carcinogenesis [@LossOfSymbiotSadegh2024]

以下是整理自该文献的关联肠道菌汇总：

Table \@ref(tab:LossOfSymbiotSadegh2024-published-data-microbiota) (下方表格) 为表格LossOfSymbiotSadegh2024 published data microbiota概览。

**(对应文件为 `Figure+Table/LossOfSymbiotSadegh2024-published-data-microbiota.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有34行6列，以下预览的表格可能省略部分数据；表格含有34个唯一`taxon'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LossOfSymbiotSadegh2024-published-data-microbiota)LossOfSymbiotSadegh2024 published data microbiota

|taxon         |proportion... |position.i... |mean.auc..... |sd.auc..test. |Value.with... |
|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|k_Bacteria... |0.992         |numerator     |1             |0             |stool         |
|k_Bacteria... |0.998         |numerator     |1             |0             |stool         |
|k_Bacteria... |0.956         |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |0.982         |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |0.996         |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|k_Bacteria... |1             |numerator     |1             |0             |stool         |
|...           |...           |...           |...           |...           |...           |

匹配到的肠道菌 (Phylum 水平)：

Table \@ref(tab:LossOfSymbiotSadegh2024-matched-Phylum-microbiota) (下方表格) 为表格LossOfSymbiotSadegh2024 matched Phylum microbiota概览。

**(对应文件为 `Figure+Table/LossOfSymbiotSadegh2024-matched-Phylum-microbiota.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3行6列，以下预览的表格可能省略部分数据；表格含有3个唯一`taxon'。
\end{tcolorbox}
\end{center}

Table: (\#tab:LossOfSymbiotSadegh2024-matched-Phylum-microbiota)LossOfSymbiotSadegh2024 matched Phylum microbiota

|taxon         |proportion... |position.i... |mean.auc..... |sd.auc..test. |Value.with... |
|:-------------|:-------------|:-------------|:-------------|:-------------|:-------------|
|k_Bacteria... |1             |denominator   |1             |0             |stool         |
|k_Bacteria... |1             |denominator   |1             |0             |stool         |
|k_Bacteria... |1             |denominator   |1             |0             |stool         |



#### IntegratedAnalChen2022 结肠癌 (肠道菌和代谢物)

Integrated analysis of the faecal metagenome and serum metabolome reveals the
role of gut microbiome-associated metabolites in the detection of colorectal
cancer and adenoma [@IntegratedAnalChen2022]

以下是整理自该文献的肠道菌和代谢物数据 (PDF 识别结果)：

Table \@ref(tab:IntegratedAnalChen2022-published-data-microbiota) (下方表格) 为表格IntegratedAnalChen2022 published data microbiota概览。

**(对应文件为 `Figure+Table/IntegratedAnalChen2022-published-data-microbiota.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有782行4列，以下预览的表格可能省略部分数据；表格含有3个唯一`Type'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:IntegratedAnalChen2022-published-data-microbiota)IntegratedAnalChen2022 published data microbiota

|Type                 |Species              |Metabolites         |pvalue      |
|:--------------------|:--------------------|:-------------------|:-----------|
|Tumor_promoting_b... |Alistipes_finegoldii |X23.4_476.011mz_pos |3.87e-07    |
|Tumor_promoting_b... |Alistipes_finegoldii |X21.4_494.68mz_pos  |0.000232816 |
|Tumor_promoting_b... |Alistipes_finegoldii |X24.5_504.692mz_pos |0.000162744 |
|Tumor_promoting_b... |Alistipes_finegoldii |X26.1_509.03mz_pos  |0.000793675 |
|Tumor_promoting_b... |Alistipes_finegoldii |X26.3_514.705mz_pos |0.000881926 |
|Tumor_promoting_b... |Bilophila_wadswor... |X23.4_476.011mz_pos |4.45e-05    |
|Tumor_promoting_b... |Fusobacterium_nuc... |X21.2_512.336mz_neg |0.000581862 |
|Tumor_promoting_b... |Fusobacterium_nuc... |X19.2_536.299mz_neg |0.000431165 |
|Tumor_promoting_b... |Fusobacterium_sp.... |X21.2_512.336mz_neg |0.000850936 |
|Tumor_promoting_b... |Fusobacterium_sp.... |X19.2_536.299mz_neg |9.61e-05    |
|Tumor_promoting_b... |Odoribacter_splan... |X23.4_476.011mz_pos |1.93e-06    |
|Tumor_promoting_b... |Odoribacter_splan... |X21.4_494.68mz_pos  |3.38e-05    |
|Tumor_promoting_b... |Odoribacter_splan... |X24.8_495.024mz_pos |0.000618015 |
|Tumor_promoting_b... |Odoribacter_splan... |X22.9_499.686mz_pos |0.000395014 |
|Tumor_promoting_b... |Odoribacter_splan... |X24.5_504.692mz_pos |0.000898428 |
|...                  |...                  |...                 |...         |

Table \@ref(tab:IntegratedAnalChen2022-published-data-metabolites) (下方表格) 为表格IntegratedAnalChen2022 published data metabolites概览。

**(对应文件为 `Figure+Table/IntegratedAnalChen2022-published-data-metabolites.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有969行19列，以下预览的表格可能省略部分数据；表格含有905个唯一`V1'。
\end{tcolorbox}
\end{center}

Table: (\#tab:IntegratedAnalChen2022-published-data-metabolites)IntegratedAnalChen2022 published data metabolites

|V1        |V2        |V3        |V4        |V5        |V6        |V7        |V8        |V9        |V10       |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|Supple... |material  |placed    |on        |this      |supple... |material  |which     |has       |been      |
|Table     |S2.       |List      |of        |colore... |abnormal  |associ... |metabo... |          |          |
|Metabo... |feature   |Metabo... |annota... |approach  |F_meanN   |F_meanC   |F_meanA   |anova_... |anova_... |
|X10.3_... |(-)-Fo... |exact     |mass      |match     |7748.8... |5053.5... |5527.3... |0.0000... |7.36E-08  |
|X12.4_... |(-)-Or... |exact     |mass      |match     |45226.... |31316.... |27721.... |0.0000... |0.0000327 |
|X10.9_... |(-)-tr... |glucos... |mass      |match     |364.39... |8542.0151 |9965.7... |0.0026... |0.0009... |
|X15_26... |(+)-2,... |Goniot... |mass      |match     |32595.... |22986.... |25975.... |0.0012... |0.0013... |
|X20.8_... |(+/-)-... |mass      |match     |6812.3... |10133.... |3573.2... |0.0042... |0.0002535 |0.1164... |
|X12.5_... |(±)15-... |exact     |mass      |match     |11931.... |8063.3... |8309.9... |3.99E-10  |3.99E-10  |
|X14.9_... |(±)-Go... |exact     |mass      |match     |24851.... |16540.... |15696.... |0.0022... |0.0001... |
|X15.1_... |(±)-Pa... |exact     |mass      |match     |78154.... |37693.... |61456.... |0.0000... |0.0004... |
|X24_35... |(1S)-1... |mass      |match     |2067.0... |6783.2... |10613.... |0.0000... |0.0001... |0.5843... |
|X20.7_... |(20R)-... |Rh2       |exact     |mass      |match     |19519.... |12756.... |12327.... |4.39E-10  |
|X11_42... |(22E)-... |          |          |          |          |          |          |          |          |
|exact     |mass      |match     |97120.... |          |          |          |          |          |          |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |

未从上述数据中匹配到客户数据的差异肠道菌或其关联的代谢物。











