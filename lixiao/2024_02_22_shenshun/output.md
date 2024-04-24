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
筛选差异蛋白和对应配体蛋白} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-04-24}}
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

- 研究对象：乳腺癌或结直肠癌
- 耐药：5-氟尿嘧啶或顺铂

## 需求

### 首次分析

1、寻找差异致癌膜蛋白及对应配体蛋白；
2、耐药差异膜蛋白及对应抗体蛋白或互作抑制其表达蛋白。

现需要利用数据库分析正常组与疾病组间的差异表达膜蛋白AA（在癌中高表达的）和对应靶向癌细胞特异性高表达的膜蛋白AA的配体蛋白AA’；
以及非耐药组与耐药组间的差异表达膜蛋白XX（在耐药组中高表达的）和对应XX的抗体蛋白或相互作用能抑制其表达的蛋白XX’。

### 进一步分析 {#fur}

1. 查询正常组与结直肠癌组相比，TSC1的表达情况。期望TSC1仅在结肠癌的耐药群体种高表达，在正常组以及癌组织的非耐药中不表达或低表达。若在癌组织中高表达，则仅看“2”；若在正常组中高表达，则仅看“3”。
2. 生信分析结果已知，与TSC1有相互作用且抑制的蛋白有5种（YWHAE、HSPA8、PTGES3、PSMG2、PLK2），但是能否直接结合作为筛选靶点未知，麻烦进行分子对接研究TSC1与5种蛋白直接结合的可能性。届时将选择直接结合的对子进行实验。
3. 生信分析结果已知，差异癌膜蛋白AA为：AIFM1, TFRC, ITGAM, PECAM1 ，其对应的相互作用的蛋白AA‘分别有9、7、4、1个。请将这21对相互作用的蛋白做一下关联分析，找到非抑制的对子（可以促进表达也可以没有促进抑制关系）；然后进行分子对接，需要了解AA和AA'直接结合的可能性。届时将选择直接结合的对子进行实验。



## 结果

### 寻找差异致癌膜蛋白及对应配体蛋白

这一部分思路较简单，找到可用的蛋白质组数据[@ProteomicsProfShao2022]，筛选差异蛋白，
再以 UniTmp 数据库筛选跨膜蛋白 (膜蛋白受体主要为跨膜蛋白) ，再借助 STRINGdb 构建
PPI 网络，寻找互作蛋白，再结合富集分析 (\@ref(cut-ppi))，进一步缩小范围。

注意，以上 PPI 构建的来源是所有筛选到的差异蛋白 (拟从差异蛋白中找到候选的配体蛋白)。

差异癌膜蛋白为：AIFM1, TFRC, ITGAM, PECAM1
最终筛选的蛋白和对应候选配体关系见：Fig. \@ref(fig:PPS-DPS-filtered-by-KEGG-and-formated-PPI-network)

### 耐药差异膜蛋白及对应抗体蛋白或互作抑制其表达蛋白

这部分思路稍复杂。由于无法直接获得包含耐药性分组的蛋白表达数据，因此需要另寻思路，
即，获取 TCGA-COAD 的基因表达数据和蛋白定量数据，以 `pRRophetic` 根据基因表达数据
分析耐药性 (顺铂 Cisplatin)，再对样本分组，随后分析蛋白定量数据。

后续和上一部分近似：筛选差异蛋白，再以 UniTmp 数据库筛选跨膜蛋白，再借助 STRINGdb 构建
PPI 网络，寻找互作蛋白，再结合富集分析。到这里，筛选蛋白 (TSC1) 和互作蛋白关系见
Fig. \@ref(fig:TCGA-DPS-filtered-and-formated-PPI-network-logFC)。
后续的富集分析结果可能有一定参考价值，富集到 TSC1
(hsa04151, Fig. \@ref(fig:TCGA-TSC1-in-hsa04151-visualization))

注意，以上 PPI 构建的来源是筛选的膜蛋白 (TSC1)，和 RNA-seq 的 DEGs (拟从差异蛋白中找到候选的配体蛋白)。

但这部分还需要指定互作抑制的蛋白，因此又结合了关联分析，挖掘 RNA 表达中呈负相关性的蛋白
(Fig. \@ref(fig:TCGA-RNA-correlation-heatmap))。

最终可参考的表格：Tab. \@ref(tab:TCGA-RNA-TSC1-negtive-correlated)

### 进一步分析的结果 (蛋白对接) {#res-fur}

- 见 Fig. \@ref(fig:compare-tsc1-in-cancer-and-control),
  TSC1 在正常组与癌症中无显著差异。因此，后续分析将依据 \@ref(fur) 中的 “3” 展开。
- 筛选非负相关性的蛋白 (非抑制关系) ，共 19 对, 见 Tab. \@ref(tab:PPS-correlation-details)。
- 为了筛选具有结合可能的蛋白对，采取以下两步：
    - STRINGdb 数据库中，具有物理 (直接) 结合，并有实验基础 (experiments 得分) 的蛋白对，最后获得 Tab. \@ref(tab:EXP-pair)
    - 以 cluspro 蛋白对接，获取得分 Fig. \@ref(fig:Overview-of-protein-docking-results)
      和模型 (这里只展示Top 5的模型, Top 1 见 Fig. \@ref(fig:Top1-Protein-docking-of-HMGB1-ITGAM))。
- 取上述两步 (蛋白对接设置了 -1000 cut-off) 的综合，见 Fig. \@ref(fig:Intersection-of-StringDB-exp--with-Protein-docking)
  和 Tab. \@ref(tab:intersected-data)。
  共有 5 对：FTH1_TFRC, SERPINA1_TFRC, HSPA8_TFRC, DDX3X_AIFM1, HMGB1_ITGAM



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to ProteomicsProfShao2022[@ProteomicsProfShao2022].

## 方法

Mainly used method:

- The `ClusPro` server used for Protein-Protein docking[@TheClusproWebKozako2017].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- `HawkDock` webservers used for protein–protein docking[@HawkdockAWebWeng2019].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R Package `pRRophetic` was used for Prediction of Clinical Chemotherapeutic Response[@PrropheticAnGeeleh2014].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- R package `TCGAbiolinks` used for abtain TCGA dataset[@TcgabiolinksAColapr2015].
- The UNIfied database of TransMembrane Proteins (UniTmp) was used for transmembrane protein information retrieving[@UnitmpUnifiedDobson2024; @TheHumanTransDobson2015].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- R version 4.3.3 (2024-02-29); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程——寻找差异致癌膜蛋白及对应配体蛋白 {#workflow1}



## 结直肠癌差异蛋白

### 数据来源

Proteomics profiling of colorectal cancer progression identifies PLOD2 as a potential therapeutic target
[@ProteomicsProfShao2022]

Table \@ref(tab:PUBLISHED-ProteomicsProfShao2022-metadata-used-sample) (下方表格) 为表格PUBLISHED ProteomicsProfShao2022 metadata used sample概览。

**(对应文件为 `Figure+Table/PUBLISHED-ProteomicsProfShao2022-metadata-used-sample.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有31行5列，以下预览的表格可能省略部分数据；含有2个唯一`group'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:PUBLISHED-ProteomicsProfShao2022-metadata-used-sample)PUBLISHED ProteomicsProfShao2022 metadata used sample

|sample |Gender |Age |Pathology.Type |group   |
|:------|:------|:---|:--------------|:-------|
|P1     |Female |74  |Normal Colon   |Control |
|P2     |Female |49  |Normal Colon   |Control |
|P5     |Male   |51  |Normal Colon   |Control |
|P6     |Female |56  |Normal Colon   |Control |
|P7     |Male   |53  |Normal Colon   |Control |
|P8     |Male   |70  |Normal Colon   |Control |
|P9     |Male   |62  |Normal Colon   |Control |
|P11    |Male   |48  |Normal Colon   |Control |
|P13    |Female |43  |Normal Colon   |Control |
|P14    |Female |61  |Normal Colon   |Control |
|P15    |Female |81  |Normal Colon   |Control |
|P16    |Male   |67  |Normal Colon   |Control |
|P17    |Male   |60  |Normal Colon   |Control |
|P18    |Female |59  |Normal Colon   |Control |
|P19    |Male   |64  |Normal Colon   |Control |
|...    |...    |... |...            |...     |

### 差异蛋白

Figure \@ref(fig:PPS-Cancer-vs-Control-DEGs) (下方图) 为图PPS Cancer vs Control DEGs概览。

**(对应文件为 `Figure+Table/PPS-Cancer-vs-Control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-Cancer-vs-Control-DEGs.pdf}
\caption{PPS Cancer vs Control DEGs}\label{fig:PPS-Cancer-vs-Control-DEGs}
\end{center}

Table \@ref(tab:PPS-data-Cancer-vs-Control-DPs) (下方表格) 为表格PPS data Cancer vs Control DPs概览。

**(对应文件为 `Figure+Table/PPS-data-Cancer-vs-Control-DPs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有509行8列，以下预览的表格可能省略部分数据；含有509个唯一`Gene\_name'。
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

Table: (\#tab:PPS-data-Cancer-vs-Control-DPs)PPS data Cancer vs Control DPs

|Gene_name |logFC     |rownames |AveExpr   |t         |P.Value   |adj.P.Val |B         |
|:---------|:---------|:--------|:---------|:---------|:---------|:---------|:---------|
|EFEMP1    |2.2381... |Q12805   |5.4470... |8.2464... |3.7745... |1.8231... |10.666... |
|P4HA1     |2.2015... |P13674   |4.8852... |6.6539... |2.4728... |0.0004... |6.8779... |
|FN1       |2.0416... |P02751   |10.551... |6.6301... |2.6380... |0.0004... |6.8187... |
|CHGA      |-2.716... |P10645   |6.4443... |-6.428... |4.5698... |0.0005... |6.3149... |
|MXRA5     |1.8876... |Q9NR99   |5.3248... |6.3504... |5.6622... |0.0005... |6.1181... |
|MYO1A     |-2.702... |Q9UBC5   |6.3290... |-6.217... |8.1508... |0.0006... |5.7832... |
|BYSL      |2.0924... |Q13895   |3.1862... |5.9689... |1.6215... |0.0010... |5.1497... |
|TIMP1     |1.8810... |P01033   |5.1452... |5.9401... |1.7564... |0.0010... |5.0760... |
|PLOD2     |12.715... |O00469   |-5.707... |5.8680... |2.1455... |0.0011... |4.8915... |
|CES2      |-3.227... |O00748   |6.7662... |-5.570... |4.9174... |0.0023... |4.1256... |
|DHRS11    |-2.886... |Q6UWP2   |5.2052... |-5.491... |6.1300... |0.0026... |3.9219... |
|AEBP1     |2.2654... |Q8IUX7   |5.3752... |5.4328... |7.2234... |0.0027... |3.7701... |
|ANPEP     |-3.097... |P15144   |5.2534... |-5.425... |7.3809... |0.0027... |3.7501... |
|TKT       |0.7599... |P29401   |8.6760... |5.3887... |8.1722... |0.0028... |3.6559... |
|PTMS      |0.9114... |P20962   |8.2150... |5.3443... |9.2531... |0.0029... |3.5410... |
|...       |...       |...      |...       |...       |...       |...       |...       |



## 膜蛋白筛选

受体蛋白主要分为：

- 离子通道受体 (Ligand-gated ion channel, LICs, LGIC)
- 催化受体 (酶受体) (catalytic receptor)
    - 鸟苷酸酰化酶受体
    - 酪氨酸激酶受体
- G蛋白偶联受体 (G protein-coupled receptors) (GPCRs) (https://gpcrdb.org/)

以上都是跨膜蛋白类型。
因此以下筛选将从跨膜蛋白出发。

### Unitmp

UniTmp: unified resources for transmembrane proteins [@UnitmpUnifiedDobson2024]

Table \@ref(tab:UniTmp-data-of-htp-all) (下方表格) 为表格UniTmp data of htp all概览。

**(对应文件为 `Figure+Table/UniTmp-data-of-htp-all.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5499行5列，以下预览的表格可能省略部分数据；含有5499个唯一`id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item evidence:  证据，相关文献中的描述。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:UniTmp-data-of-htp-all)UniTmp data of htp all

|id          |transmembrane |evidence   |Protein_name         |Gene_Name |
|:-----------|:-------------|:----------|:--------------------|:---------|
|ACD10_HUMAN |yes           |Exists     |Acyl-CoA dehydrog... |ACAD10    |
|ASPH_HUMAN  |yes           |3D         |Aspartyl/asparagi... |ASPH      |
|ATP8_HUMAN  |yes           |3D         |ATP synthase prot... |MT-ATP8   |
|BFAR_HUMAN  |yes           |Exists     |Bifunctional apop... |BFAR      |
|BAMBI_HUMAN |yes           |Exists     |BMP and activin m... |BAMBI     |
|ATRAP_HUMAN |yes           |Exists     |Type-1 angiotensi... |AGTRAP    |
|AOFA_HUMAN  |yes           |3D         |Amine oxidase [fl... |MAOA      |
|BAP29_HUMAN |yes           |3D         |B-cell receptor-a... |BCAP29    |
|BAP31_HUMAN |yes           |3D         |B-cell receptor-a... |BCAP31    |
|C144C_HUMAN |yes           |Prediction |Putative coiled-c... |CCDC144CP |
|CJ105_HUMAN |yes           |Prediction |Uncharacterized p... |C10orf105 |
|CJ111_HUMAN |yes           |Prediction |Putative uncharac... |RPP38-DT  |
|CLM2_HUMAN  |yes           |Exists     |CMRF35-like molec... |CD300E    |
|CK024_HUMAN |yes           |Experiment |Uncharacterized p... |C11orf24  |
|CK087_HUMAN |yes           |Exists     |Uncharacterized p... |C11orf87  |
|...         |...           |...        |...                  |...       |



### 与高表达差异蛋白 (DPs-Up) 交集

Figure \@ref(fig:PPS-Intersection-of-DPs-Up-with-TransMemPs) (下方图) 为图PPS Intersection of DPs Up with TransMemPs概览。

**(对应文件为 `Figure+Table/PPS-Intersection-of-DPs-Up-with-TransMemPs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-Intersection-of-DPs-Up-with-TransMemPs.pdf}
\caption{PPS Intersection of DPs Up with TransMemPs}\label{fig:PPS-Intersection-of-DPs-Up-with-TransMemPs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    CEACAM5, APP, LAMP1, MUC1, SFXN3, THY1, SLC25A6,
TACSTD2, MTX1, AIFM1, NSDHL, PECAM1, HSD17B12, MRC2, ASPH,
LEMD2, SSR3, LMO7, ITGAM, TFRC, SPINT2, SORT1, ACSL3, SFXN1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/PPS-Intersection-of-DPs-Up-with-TransMemPs-content`)**



## 以蛋白互作筛选配体蛋白

### PPI

Figure \@ref(fig:PPS-DPS-filtered-and-formated-PPI-network) (下方图) 为图PPS DPS filtered and formated PPI network概览。

**(对应文件为 `Figure+Table/PPS-DPS-filtered-and-formated-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-DPS-filtered-and-formated-PPI-network.pdf}
\caption{PPS DPS filtered and formated PPI network}\label{fig:PPS-DPS-filtered-and-formated-PPI-network}
\end{center}



### 富集分析

Figure \@ref(fig:PPS-PPI-KEGG-enrichment) (下方图) 为图PPS PPI KEGG enrichment概览。

**(对应文件为 `Figure+Table/PPS-PPI-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-PPI-KEGG-enrichment.pdf}
\caption{PPS PPI KEGG enrichment}\label{fig:PPS-PPI-KEGG-enrichment}
\end{center}

Figure \@ref(fig:PPS-PPI-GO-enrichment) (下方图) 为图PPS PPI GO enrichment概览。

**(对应文件为 `Figure+Table/PPS-PPI-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-PPI-GO-enrichment.pdf}
\caption{PPS PPI GO enrichment}\label{fig:PPS-PPI-GO-enrichment}
\end{center}

坏死性凋亡信号通路在肿瘤发生发展、肿瘤坏死、肿瘤转移和肿瘤免疫反应中发挥作用；坏死性凋亡可能促进或抗肿瘤发生，具体取决于肿瘤的类型[@NecroptosisAndYanJ2022]。

Figure \@ref(fig:PPS-PPI-hsa04217-visualization) (下方图) 为图PPS PPI hsa04217 visualization概览。

**(对应文件为 `Figure+Table/hsa04217.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-08_13_57_04.806626/hsa04217.pathview.png}
\caption{PPS PPI hsa04217 visualization}\label{fig:PPS-PPI-hsa04217-visualization}
\end{center}

70-kDa 热休克蛋白 (HSP70) 在癌症中大量存在，通过抑制多种凋亡途径、调节坏死、绕过细胞衰老程序、干扰肿瘤免疫、促进血管生成和支持转移，为恶性细胞提供选择优势 [@Hsp70MultiFunAlbako2020]

Figure \@ref(fig:PPS-PPI-hsa04612-visualization) (下方图) 为图PPS PPI hsa04612 visualization概览。

**(对应文件为 `Figure+Table/hsa04612.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-08_13_57_04.806626/hsa04612.pathview.png}
\caption{PPS PPI hsa04612 visualization}\label{fig:PPS-PPI-hsa04612-visualization}
\end{center}



### 根据富集结果缩减 PPI {#cut-ppi}

由于富集结果可以凸显肿瘤的性质，这里尝试根据 KEGG top 10 通路的富集基因缩减 PPI

Figure \@ref(fig:PPS-DPS-filtered-by-KEGG-and-formated-PPI-network) (下方图) 为图PPS DPS filtered by KEGG and formated PPI network概览。

**(对应文件为 `Figure+Table/PPS-DPS-filtered-by-KEGG-and-formated-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-DPS-filtered-by-KEGG-and-formated-PPI-network.pdf}
\caption{PPS DPS filtered by KEGG and formated PPI network}\label{fig:PPS-DPS-filtered-by-KEGG-and-formated-PPI-network}
\end{center}

Figure \@ref(fig:PPS-DPS-filtered-by-KEGG-Top-MCC-score) (下方图) 为图PPS DPS filtered by KEGG Top MCC score概览。

**(对应文件为 `Figure+Table/PPS-DPS-filtered-by-KEGG-Top-MCC-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-DPS-filtered-by-KEGG-Top-MCC-score.pdf}
\caption{PPS DPS filtered by KEGG Top MCC score}\label{fig:PPS-DPS-filtered-by-KEGG-Top-MCC-score}
\end{center}





# 附：分析流程——耐药差异膜蛋白及对应抗体蛋白或互作抑制其表达蛋白 {#workflow2}

## 结肠癌差异蛋白

注：由于无法直接获得包含耐药性分组的蛋白表达数据，因此这部分的内容另寻思路，
即，获取 TCGA-COAD 的基因表达数据和蛋白定量数据，以 `pRRophetic` 根据基因表达数据
分析耐药性，再对样本分组，随后分析蛋白定量数据。

### 数据来源 

共使用了 TCGA-COAD 的 RNA, protein, clinical 数据 (使用了三者都包含的病人的样本数据)。

Table \@ref(tab:TCGA-COAD-clinical-metadata) (下方表格) 为表格TCGA COAD clinical metadata概览。

**(对应文件为 `Figure+Table/TCGA-COAD-clinical-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有459行19列，以下预览的表格可能省略部分数据；含有459个唯一`rownames'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-COAD-clinical-metadata)TCGA COAD clinical metadata

|rownames |id        |data_f... |cases     |access |file_name |submit... |data_c... |type      |file_size |
|:--------|:---------|:---------|:---------|:------|:---------|:---------|:---------|:---------|:---------|
|1        |080f87... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |29118     |
|2        |77638e... |BCR XML   |TCGA-C... |open   |nation... |nation... |Clinical  |clinic... |54636     |
|3        |c58a3b... |BCR XML   |TCGA-D... |open   |nation... |nation... |Clinical  |clinic... |29261     |
|4        |e67964... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |28673     |
|5        |568223... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |31577     |
|6        |d77499... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |31559     |
|7        |0efd65... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |29185     |
|8        |7aaa95... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |52563     |
|9        |75bb5e... |BCR XML   |TCGA-G... |open   |nation... |nation... |Clinical  |clinic... |54330     |
|10       |5d3d27... |BCR XML   |TCGA-D... |open   |nation... |nation... |Clinical  |clinic... |29453     |
|11       |0f0694... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |24277     |
|12       |d05b7b... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |34479     |
|13       |ef4172... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |24264     |
|14       |f64700... |BCR XML   |TCGA-G... |open   |nation... |nation... |Clinical  |clinic... |29321     |
|15       |849b28... |BCR XML   |TCGA-A... |open   |nation... |nation... |Clinical  |clinic... |24215     |
|...      |...       |...       |...       |...    |...       |...       |...       |...       |...       |

Table \@ref(tab:TCGA-COAD-protein-metadata) (下方表格) 为表格TCGA COAD protein metadata概览。

**(对应文件为 `Figure+Table/TCGA-COAD-protein-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有363行24列，以下预览的表格可能省略部分数据；含有363个唯一`id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-COAD-protein-metadata)TCGA COAD protein metadata

|id        |data_f... |cases     |access |file_name |submit... |data_c... |type      |platform |file_size |
|:---------|:---------|:---------|:------|:---------|:---------|:---------|:---------|:--------|:---------|
|7b5dc5... |TSV       |TCGA-C... |open   |TCGA-C... |TCGA-C... |Proteo... |protei... |RPPA     |22135     |
|7d66e7... |TSV       |TCGA-S... |open   |TCGA-S... |TCGA-S... |Proteo... |protei... |RPPA     |22022     |
|8ecf75... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |24055     |
|5e4ec1... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |23999     |
|e45a96... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |24027     |
|47c932... |TSV       |TCGA-C... |open   |TCGA-C... |TCGA-C... |Proteo... |protei... |RPPA     |22100     |
|44f0f7... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |24049     |
|9fe863... |TSV       |TCGA-C... |open   |TCGA-C... |TCGA-C... |Proteo... |protei... |RPPA     |22071     |
|e06fe7... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |24065     |
|cf9c71... |TSV       |TCGA-Q... |open   |TCGA-Q... |TCGA-Q... |Proteo... |protei... |RPPA     |22099     |
|335dae... |TSV       |TCGA-G... |open   |TCGA-G... |TCGA-G... |Proteo... |protei... |RPPA     |22154     |
|4f0d60... |TSV       |TCGA-D... |open   |TCGA-D... |TCGA-D... |Proteo... |protei... |RPPA     |22155     |
|f36bba... |TSV       |TCGA-G... |open   |TCGA-G... |TCGA-G... |Proteo... |protei... |RPPA     |22109     |
|f185df... |TSV       |TCGA-A... |open   |TCGA-A... |TCGA-A... |Proteo... |protei... |RPPA     |24011     |
|be6d80... |TSV       |TCGA-F... |open   |TCGA-F... |TCGA-F... |Proteo... |protei... |RPPA     |22109     |
|...       |...       |...       |...    |...       |...       |...       |...       |...      |...       |

Table \@ref(tab:TCGA-COAD-RNA-metadata) (下方表格) 为表格TCGA COAD RNA metadata概览。

**(对应文件为 `Figure+Table/TCGA-COAD-RNA-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有524行29列，以下预览的表格可能省略部分数据；含有524个唯一`id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-COAD-RNA-metadata)TCGA COAD RNA metadata

|id        |data_f... |cases     |access |file_name |submit... |data_c... |type      |file_size |create... |
|:---------|:---------|:---------|:------|:---------|:---------|:---------|:---------|:---------|:---------|
|efdcda... |TSV       |TCGA-C... |open   |a45a75... |9a7d8c... |Transc... |gene_e... |4240354   |2022-0... |
|66905c... |TSV       |TCGA-A... |open   |40b98f... |7070f7... |Transc... |gene_e... |4233852   |2022-0... |
|8820d9... |TSV       |TCGA-A... |open   |58369b... |a6da34... |Transc... |gene_e... |4210387   |2022-0... |
|5302ca... |TSV       |TCGA-C... |open   |45a267... |c5db3d... |Transc... |gene_e... |4209007   |2022-0... |
|a7affc... |TSV       |TCGA-A... |open   |3ef878... |97c2f0... |Transc... |gene_e... |4208716   |2022-0... |
|3456d4... |TSV       |TCGA-A... |open   |524723... |4d8cb5... |Transc... |gene_e... |4216110   |2022-0... |
|ab6d59... |TSV       |TCGA-G... |open   |085e42... |228266... |Transc... |gene_e... |4231843   |2022-0... |
|3db2cc... |TSV       |TCGA-A... |open   |e1d0ac... |2b637e... |Transc... |gene_e... |4210406   |2022-0... |
|a761bd... |TSV       |TCGA-A... |open   |d837c3... |738864... |Transc... |gene_e... |4201059   |2022-0... |
|04981c... |TSV       |TCGA-A... |open   |4bafe8... |53e5cd... |Transc... |gene_e... |4214788   |2022-0... |
|8ac00c... |TSV       |TCGA-A... |open   |0ae6d3... |0e343a... |Transc... |gene_e... |4219902   |2022-0... |
|e929b2... |TSV       |TCGA-C... |open   |a82c20... |99e86d... |Transc... |gene_e... |4223537   |2022-0... |
|c403bb... |TSV       |TCGA-A... |open   |e5ae4a... |8e4b41... |Transc... |gene_e... |4211960   |2022-0... |
|756b10... |TSV       |TCGA-A... |open   |b3e428... |fe34e7... |Transc... |gene_e... |4229447   |2022-0... |
|700b39... |TSV       |TCGA-A... |open   |fd618c... |afa933... |Transc... |gene_e... |4229363   |2022-0... |
|...       |...       |...       |...    |...       |...       |...       |...       |...       |...       |



## 预测耐药性

### 使用 RNA 数据集预测

以 `pRRophetic` 预测药物敏感性 (Cisplatin)。

Figure \@ref(fig:QQ-plot-for-distribution-of-the-transformed-IC50-data) (下方图) 为图QQ plot for distribution of the transformed IC50 data概览。

**(对应文件为 `Figure+Table/QQ-plot-for-distribution-of-the-transformed-IC50-data.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/QQ-plot-for-distribution-of-the-transformed-IC50-data.pdf}
\caption{QQ plot for distribution of the transformed IC50 data}\label{fig:QQ-plot-for-distribution-of-the-transformed-IC50-data}
\end{center}

Fig. \@ref(fig:QQ-plot-for-distribution-of-the-transformed-IC50-data) 表明，
Cisplatin 的 IC~50~ 数据特征基本符合正太分布，可以用于线形预测 Cisplatin 敏感性。

Figure \@ref(fig:Estimate-prediction-accuracy) (下方图) 为图Estimate prediction accuracy概览。

**(对应文件为 `Figure+Table/Estimate-prediction-accuracy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Estimate-prediction-accuracy.pdf}
\caption{Estimate prediction accuracy}\label{fig:Estimate-prediction-accuracy}
\end{center}

Table \@ref(tab:Predicted-drug-sensitivity) (下方表格) 为表格Predicted drug sensitivity概览。

**(对应文件为 `Figure+Table/Predicted-drug-sensitivity.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有357行3列，以下预览的表格可能省略部分数据；含有357个唯一`sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\end{enumerate}\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
k-means clustering
:}

\vspace{0.5em}

    Centers = 3

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:Predicted-drug-sensitivity)Predicted drug sensitivity

|sample           |sensitivity      |kmeans_group |
|:----------------|:----------------|:------------|
|TCGA-3L-AA1B-01A |4.14816093273104 |2            |
|TCGA-4N-A93T-01A |4.40190686256072 |2            |
|TCGA-4T-AA8H-01A |4.15648471482818 |2            |
|TCGA-5M-AAT6-01A |2.62116649131769 |3            |
|TCGA-A6-2671-11A |4.03864919730421 |2            |
|TCGA-A6-2672-01A |2.76158089020952 |3            |
|TCGA-A6-2676-01A |2.10216420226229 |3            |
|TCGA-A6-2677-01A |3.02480062454453 |1            |
|TCGA-A6-2678-11A |3.85525962252971 |2            |
|TCGA-A6-2680-01A |4.07942930425798 |2            |
|TCGA-A6-2681-01A |3.95239422637806 |2            |
|TCGA-A6-2683-11A |3.64057626378351 |1            |
|TCGA-A6-2684-01C |2.93670056076102 |3            |
|TCGA-A6-2685-01A |4.32047341962156 |2            |
|TCGA-A6-2686-11A |3.87165483393886 |2            |
|...              |...              |...          |



## 差异蛋白筛选

### 元数据

根据 Tab. \@ref(tab:Predicted-drug-sensitivity) k-means 聚类结果，将
样品分为三组：耐药组、中等组、低耐药性组 (非耐药组) 。

Table \@ref(tab:TCGA-COAD-proteome-metadata) (下方表格) 为表格TCGA COAD proteome metadata概览。

**(对应文件为 `Figure+Table/TCGA-COAD-proteome-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有178行4列，以下预览的表格可能省略部分数据；含有2个唯一`group'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
k-means clustering
:}

\vspace{0.5em}

    Centers = 3

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-COAD-proteome-metadata)TCGA COAD proteome metadata

|sample       |group          |sensitivity      |kmeans_group |
|:------------|:--------------|:----------------|:------------|
|TCGA-3L-AA1B |Resistance     |4.14816093273104 |2            |
|TCGA-4N-A93T |Resistance     |4.40190686256072 |2            |
|TCGA-4T-AA8H |Resistance     |4.15648471482818 |2            |
|TCGA-5M-AAT6 |Non_resistance |2.62116649131769 |3            |
|TCGA-A6-2671 |Resistance     |4.03864919730421 |2            |
|TCGA-A6-2672 |Non_resistance |2.76158089020952 |3            |
|TCGA-A6-2676 |Non_resistance |2.10216420226229 |3            |
|TCGA-A6-2678 |Resistance     |3.85525962252971 |2            |
|TCGA-A6-2680 |Resistance     |4.07942930425798 |2            |
|TCGA-A6-2681 |Resistance     |3.95239422637806 |2            |
|TCGA-A6-2684 |Non_resistance |2.93670056076102 |3            |
|TCGA-A6-2685 |Resistance     |4.32047341962156 |2            |
|TCGA-A6-2686 |Resistance     |3.87165483393886 |2            |
|TCGA-A6-3808 |Non_resistance |2.93134891159939 |3            |
|TCGA-A6-3809 |Non_resistance |1.43580359549368 |3            |
|...          |...            |...              |...          |

### 差异蛋白

Figure \@ref(fig:TCGA-Resistance-vs-Non-resistance-DEPs) (下方图) 为图TCGA Resistance vs Non resistance DEPs概览。

**(对应文件为 `Figure+Table/TCGA-Resistance-vs-Non-resistance-DEPs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-Resistance-vs-Non-resistance-DEPs.pdf}
\caption{TCGA Resistance vs Non resistance DEPs}\label{fig:TCGA-Resistance-vs-Non-resistance-DEPs}
\end{center}

Table \@ref(tab:TCGA-data-Resistance-vs-Non-resistance-DEPs) (下方表格) 为表格TCGA data Resistance vs Non resistance DEPs概览。

**(对应文件为 `Figure+Table/TCGA-data-Resistance-vs-Non-resistance-DEPs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有30行9列，以下预览的表格可能省略部分数据；含有30个唯一`rownames'。
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

Table: (\#tab:TCGA-data-Resistance-vs-Non-resistance-DEPs)TCGA data Resistance vs Non resistance DEPs

|rownames  |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |B         |peptid... |Gene_name |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|AGID00319 |-0.598... |0.0565... |-7.018... |4.6950... |2.1691... |14.789... |Granzy... |Granzy... |
|AGID00015 |-0.903... |0.7403... |-5.932... |1.5134... |2.3504... |9.2486... |CASPAS... |CASPAS... |
|AGID00155 |0.3382... |0.2485... |5.9309... |1.5262... |2.3504... |9.2406... |TSC1      |TSC1      |
|AGID00366 |-0.845... |1.0622... |-5.114... |8.1696... |5.3919... |5.4545... |IDO       |IDO       |
|AGID00193 |-0.371... |-0.473... |-4.922... |1.9302... |0.0001... |4.6336... |ANNEXIN1  |ANNEXIN1  |
|AGID00268 |0.4910... |-0.646... |4.7228... |4.7425... |0.0002... |3.7904... |ATRX      |ATRX      |
|AGID02153 |0.3689... |0.4742... |4.6151... |7.4803... |0.0003... |3.3539... |INPP4B    |INPP4B    |
|AGID00053 |-0.486... |0.1941... |-4.609... |7.6492... |0.0003... |3.3328... |PAI1      |PAI1      |
|AGID00450 |0.4087... |0.5620... |4.5837... |8.5582... |0.0003... |3.2270... |EGFR_p... |EGFR_p... |
|AGID00235 |-1.143... |-0.300... |-4.562... |9.4475... |0.0003... |3.1408... |EMA       |EMA       |
|AGID00394 |-0.365... |0.1766... |-4.503... |1.2172... |0.0003... |2.9023... |Enolase-1 |Enolase-1 |
|AGID00031 |-0.384... |-0.126... |-4.410... |1.7819... |0.0004... |2.5371... |FIBRON... |FIBRON... |
|AGID00290 |0.3109... |-0.549... |4.3319... |2.4809... |0.0006... |2.2336... |Lasu1     |Lasu1     |
|AGID00148 |0.6118... |0.3484... |4.3171... |2.6150... |0.0006... |2.1771... |ECADHERIN |ECADHERIN |
|AGID00301 |-0.312... |-0.132... |-4.125... |5.6927... |0.0011... |1.4564... |B7-H3     |B7-H3     |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |



## 膜蛋白筛选

### Unitmp

UniTmp: unified resources for transmembrane proteins [@UnitmpUnifiedDobson2024]

见 Tab. \@ref(tab:UniTmp-data-of-htp-all)

### 与高表达差异蛋白 (TCGA-dps-Up) 交集

Figure \@ref(fig:TCGA-Intersection-of-DPs-Up-with-TransMemPs) (下方图) 为图TCGA Intersection of DPs Up with TransMemPs概览。

**(对应文件为 `Figure+Table/TCGA-Intersection-of-DPs-Up-with-TransMemPs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-Intersection-of-DPs-Up-with-TransMemPs.pdf}
\caption{TCGA Intersection of DPs Up with TransMemPs}\label{fig:TCGA-Intersection-of-DPs-Up-with-TransMemPs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    TSC1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/TCGA-Intersection-of-DPs-Up-with-TransMemPs-content`)**



## 以蛋白互作筛选配体蛋白

### TCGA-COAD 的 RNA-seq 差异表达

为了筛选 Fig. \@ref(fig:TCGA-Intersection-of-DPs-Up-with-TransMemPs) 的配体，
以 TCGA-COAD 的差异表达基因作为候选。

Figure \@ref(fig:TCGA-RNA-Resistance-vs-Non-resistance-DEGs) (下方图) 为图TCGA RNA Resistance vs Non resistance DEGs概览。

**(对应文件为 `Figure+Table/TCGA-RNA-Resistance-vs-Non-resistance-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-RNA-Resistance-vs-Non-resistance-DEGs.pdf}
\caption{TCGA RNA Resistance vs Non resistance DEGs}\label{fig:TCGA-RNA-Resistance-vs-Non-resistance-DEGs}
\end{center}

Table \@ref(tab:TCGA-RNA-data-Resistance-vs-Non-resistance-DEGs) (下方表格) 为表格TCGA RNA data Resistance vs Non resistance DEGs概览。

**(对应文件为 `Figure+Table/TCGA-RNA-data-Resistance-vs-Non-resistance-DEGs.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10108行22列，以下预览的表格可能省略部分数据；含有10108个唯一`rownames'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\item gene\_id:  GENCODE/Ensembl gene ID
\item gene\_name:  GENCODE gene name
\item strand:  genomic strand
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-RNA-data-Resistance-vs-Non-resistance-DEGs)TCGA RNA data Resistance vs Non resistance DEGs

|rownames  |gene_id   |seqnames |start     |end       |width  |strand |source |type |score |
|:---------|:---------|:--------|:---------|:---------|:------|:------|:------|:----|:-----|
|ENSG00... |ENSG00... |chr5     |132822141 |132830659 |8519   |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr16    |89818179  |89871319  |53141  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr12    |98613405  |98645113  |31709  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr16    |3027682   |3036944   |9263   |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr7     |1542235   |1560821   |18587  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr9     |128108581 |128118693 |10113  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr20    |32443059  |32585074  |142016 |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr11    |417933    |442011    |24079  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr14    |67360328  |67386516  |26189  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr7     |101195007 |101201038 |6032   |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr12    |56230049  |56237846  |7798   |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr3     |48403854  |48430086  |26233  |-      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr3     |42489299  |42537573  |48275  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr17    |79074824  |79088599  |13776  |+      |HAVANA |gene |NA    |
|ENSG00... |ENSG00... |chr2     |219054424 |219060921 |6498   |-      |HAVANA |gene |NA    |
|...       |...       |...      |...       |...       |...    |...    |...    |...  |...   |

Figure \@ref(fig:TCGA-RNA-DEGs-type) (下方图) 为图TCGA RNA DEGs type概览。

**(对应文件为 `Figure+Table/TCGA-RNA-DEGs-type.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-RNA-DEGs-type.pdf}
\caption{TCGA RNA DEGs type}\label{fig:TCGA-RNA-DEGs-type}
\end{center}



### PPI

以 Fig. \@ref(fig:TCGA-Intersection-of-DPs-Up-with-TransMemPs) 和 Tab. \@ref(tab:TCGA-RNA-data-Resistance-vs-Non-resistance-DEGs) top 2000 构建 PPI 网络。

Figure \@ref(fig:TCGA-raw-PPI-network) (下方图) 为图TCGA raw PPI network概览。

**(对应文件为 `Figure+Table/TCGA-raw-PPI-network.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-raw-PPI-network.pdf}
\caption{TCGA raw PPI network}\label{fig:TCGA-raw-PPI-network}
\end{center}

将 PPI 网络过滤，凸显 Fig. \@ref(fig:TCGA-Intersection-of-DPs-Up-with-TransMemPs) 交集蛋白 (MCC 筛选高分相连的其他蛋白)

Figure \@ref(fig:TCGA-DPS-filtered-and-formated-PPI-network-logFC) (下方图) 为图TCGA DPS filtered and formated PPI network logFC概览。

**(对应文件为 `Figure+Table/TCGA-DPS-filtered-and-formated-PPI-network-logFC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-DPS-filtered-and-formated-PPI-network-logFC.pdf}
\caption{TCGA DPS filtered and formated PPI network logFC}\label{fig:TCGA-DPS-filtered-and-formated-PPI-network-logFC}
\end{center}

Figure \@ref(fig:TCGA-DPS-filtered-and-formated-PPI-network-MCC) (下方图) 为图TCGA DPS filtered and formated PPI network MCC概览。

**(对应文件为 `Figure+Table/TCGA-DPS-filtered-and-formated-PPI-network-MCC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-DPS-filtered-and-formated-PPI-network-MCC.pdf}
\caption{TCGA DPS filtered and formated PPI network MCC}\label{fig:TCGA-DPS-filtered-and-formated-PPI-network-MCC}
\end{center}



### 富集分析

TSC1 在通路可见 Fig. \@ref(fig:TCGA-TSC1-in-hsa04151-visualization)

Figure \@ref(fig:TCGA-KEGG-enrichment) (下方图) 为图TCGA KEGG enrichment概览。

**(对应文件为 `Figure+Table/TCGA-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-KEGG-enrichment.pdf}
\caption{TCGA KEGG enrichment}\label{fig:TCGA-KEGG-enrichment}
\end{center}

Figure \@ref(fig:TCGA-GO-enrichment) (下方图) 为图TCGA GO enrichment概览。

**(对应文件为 `Figure+Table/TCGA-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-GO-enrichment.pdf}
\caption{TCGA GO enrichment}\label{fig:TCGA-GO-enrichment}
\end{center}

Figure \@ref(fig:TCGA-TSC1-in-hsa04151-visualization) (下方图) 为图TCGA TSC1 in hsa04151 visualization概览。

**(对应文件为 `Figure+Table/hsa04151.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-08_15_28_11.801928/hsa04151.pathview.png}
\caption{TCGA TSC1 in hsa04151 visualization}\label{fig:TCGA-TSC1-in-hsa04151-visualization}
\end{center}





### 通过关联分析筛选负相关性互作蛋白

Figure \@ref(fig:TCGA-RNA-correlation-heatmap) (下方图) 为图TCGA RNA correlation heatmap概览。

**(对应文件为 `Figure+Table/TCGA-RNA-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/TCGA-RNA-correlation-heatmap.pdf}
\caption{TCGA RNA correlation heatmap}\label{fig:TCGA-RNA-correlation-heatmap}
\end{center}

Table \@ref(tab:TCGA-RNA-TSC1-negtive-correlated) (下方表格) 为表格TCGA RNA TSC1 negtive correlated概览。

**(对应文件为 `Figure+Table/TCGA-RNA-TSC1-negtive-correlated.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5行7列，以下预览的表格可能省略部分数据；含有5个唯一`From'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item cor:  皮尔逊关联系数，正关联或负关联。
\item pvalue:  显著性 P。
\item -log2(P.value):  P 的对数转化。
\item significant:  显著性。
\item sign:  人为赋予的符号，参考 significant。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:TCGA-RNA-TSC1-negtive-correlated)TCGA RNA TSC1 negtive correlated

|From   |To   |cor   |pvalue |-log2(P.va... |significant |sign |
|:------|:----|:-----|:------|:-------------|:-----------|:----|
|YWHAE  |TSC1 |-0.34 |0      |16.6096404... |< 0.001     |**   |
|HSPA8  |TSC1 |-0.38 |0      |16.6096404... |< 0.001     |**   |
|PTGES3 |TSC1 |-0.15 |0.0497 |4.33061033... |< 0.05      |*    |
|PSMG2  |TSC1 |-0.2  |0.0061 |7.35697504... |< 0.05      |*    |
|PLK2   |TSC1 |-0.17 |0.0265 |5.23786383... |< 0.05      |*    |



# 附：进一步分析蛋白结合

## TSC1 在正常组与结直肠癌组的表达

TSC1 在正常组与癌症中无显著差异。因此，后续分析将依据 \@ref(fur) 中的 “3” 组织。

Figure \@ref(fig:compare-tsc1-in-cancer-and-control) (下方图) 为图compare tsc1 in cancer and control概览。

**(对应文件为 `Figure+Table/compare-tsc1-in-cancer-and-control.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/compare-tsc1-in-cancer-and-control.pdf}
\caption{Compare tsc1 in cancer and control}\label{fig:compare-tsc1-in-cancer-and-control}
\end{center}



## 差异癌膜蛋白AA 与候选结合蛋白的相关性

### 相关性

筛选非负相关的蛋白对

Figure \@ref(fig:PPS-correlation-heatmap) (下方图) 为图PPS correlation heatmap概览。

**(对应文件为 `Figure+Table/PPS-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPS-correlation-heatmap.pdf}
\caption{PPS correlation heatmap}\label{fig:PPS-correlation-heatmap}
\end{center}

具体如下：

Table \@ref(tab:PPS-correlation-details) (下方表格) 为表格PPS correlation details概览。

**(对应文件为 `Figure+Table/PPS-correlation-details.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有19行7列，以下预览的表格可能省略部分数据；含有18个唯一`from'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item cor:  皮尔逊关联系数，正关联或负关联。
\item pvalue:  显著性 P。
\item -log2(P.value):  P 的对数转化。
\item significant:  显著性。
\item sign:  人为赋予的符号，参考 significant。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:PPS-correlation-details)PPS correlation details

|from  |to    |cor   |pvalue |-log2(P.va... |significant |sign |
|:-----|:-----|:-----|:------|:-------------|:-----------|:----|
|C4B   |ITGAM |0.64  |1e-04  |13.2877123... |< 0.001     |**   |
|CLU   |AIFM1 |0.16  |0.3759 |1.41157917... |> 0.05      |-    |
|DDX3X |AIFM1 |0.38  |0.0348 |4.84476888... |< 0.05      |*    |
|FGB   |ITGAM |0.28  |0.1235 |3.01741705... |> 0.05      |-    |
|FGG   |ITGAM |0.31  |0.0915 |3.45008444... |> 0.05      |-    |
|FTH1  |TFRC  |0.18  |0.3414 |1.55046503... |> 0.05      |-    |
|HMGB1 |ITGAM |0.31  |0.0952 |3.39289461... |> 0.05      |-    |
|HSPA4 |TFRC  |0.39  |0.0311 |5.00694160... |< 0.05      |*    |
|HSPA8 |AIFM1 |0.36  |0.0439 |4.50963525... |< 0.05      |*    |
|HSPA8 |TFRC  |0.45  |0.0117 |6.41734765... |< 0.05      |*    |
|HSPD1 |ITGAM |-0.04 |0.8262 |0.27543703... |> 0.05      |-    |
|KNG1  |ITGAM |0.03  |0.8907 |0.16698850... |> 0.05      |-    |
|MMP2  |ITGAM |0.52  |0.0027 |8.53282487... |< 0.05      |*    |
|MPO   |ITGAM |0.81  |0      |16.6096404... |< 0.001     |**   |
|PPIA  |AIFM1 |0.26  |0.154  |2.69899774... |> 0.05      |-    |
|...   |...   |...   |...    |...           |...         |...  |



### stringDB 数据库中有实验基础的

依据 Tab. \@ref(tab:PPS-correlation-details)

获取 stringDB 有直接物理作用的蛋白数据，并且取得有实验基础的蛋白对
 (experiments score &gt; 100)



Table \@ref(tab:EXP-scores) (下方表格) 为表格EXP scores概览。

**(对应文件为 `Figure+Table/EXP-scores.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有17行10列，以下预览的表格可能省略部分数据；含有9个唯一`from'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item experiments:  相关实验。
\end{enumerate}\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
STRINGdb network type:
:}

\vspace{0.5em}

    physical

\vspace{2em}


\textbf{
Filter experiments score:
:}

\vspace{0.5em}

    At least score 100

\vspace{2em}


\textbf{
Filter textmining score:
:}

\vspace{0.5em}

    At least score 0

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:EXP-scores)EXP scores

|from   |to       |homology |experi......4 |experi......5 |database |databa... |textmi......8 |textmi......9 |... |
|:------|:--------|:--------|:-------------|:-------------|:--------|:---------|:-------------|:-------------|:---|
|FGB    |CLU      |0        |224           |0             |0        |0         |275           |0             |... |
|FGB    |FGG      |0        |946           |582           |900      |0         |920           |0             |... |
|HSPA4  |HSPD1    |0        |225           |0             |0        |0         |0             |287           |... |
|CLU    |HSPD1    |0        |292           |0             |0        |0         |0             |0             |... |
|AIFM1  |TXN      |0        |593           |0             |0        |0         |0             |132           |... |
|HMGB1  |TXN      |0        |362           |0             |0        |0         |0             |0             |... |
|FTH1   |TFRC     |0        |852           |0             |0        |0         |779           |49            |... |
|FGB    |SERPINA1 |0        |235           |0             |0        |0         |167           |0             |... |
|CLU    |SERPINA1 |0        |235           |0             |0        |0         |688           |0             |... |
|AIFM1  |PPIA     |0        |292           |0             |800      |0         |186           |133           |... |
|HSPA4  |HSPA8    |0        |642           |83            |500      |0         |978           |91            |... |
|HSPD1  |HSPA8    |0        |628           |0             |0        |0         |0             |206           |... |
|HMGB1  |HSPA8    |0        |292           |0             |0        |0         |414           |0             |... |
|PECAM1 |PTPN11   |0        |549           |0             |900      |0         |959           |0             |... |
|AIFM1  |DDX3X    |0        |329           |0             |0        |0         |0             |0             |... |
|...    |...      |...      |...           |...           |...      |...       |...           |...           |... |

Figure \@ref(fig:EXP-with-experiments-score) (下方图) 为图EXP with experiments score概览。

**(对应文件为 `Figure+Table/EXP-with-experiments-score.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/EXP-with-experiments-score.pdf}
\caption{EXP with experiments score}\label{fig:EXP-with-experiments-score}
\end{center}

Table \@ref(tab:EXP-pair) (下方表格) 为表格EXP pair概览。

**(对应文件为 `Figure+Table/EXP-pair.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15行2列，以下预览的表格可能省略部分数据；含有13个唯一`from'。
\end{tcolorbox}
\end{center}

Table: (\#tab:EXP-pair)EXP pair

|from     |to     |
|:--------|:------|
|CLU      |AIFM1  |
|TXN      |AIFM1  |
|MMP2     |TFRC   |
|FTH1     |TFRC   |
|HSPA4    |TFRC   |
|SERPINA1 |TFRC   |
|PPIA     |AIFM1  |
|HSPA8    |TFRC   |
|MMP2     |PECAM1 |
|PTPN11   |PECAM1 |
|DDX3X    |AIFM1  |
|MPO      |ITGAM  |
|HSPA4    |ITGAM  |
|FGB      |ITGAM  |
|HMGB1    |ITGAM  |

### 蛋白对接

依据 Tab. \@ref(tab:PPS-correlation-details),
在 cluspro 服务器进行蛋白对接。

注：总共有 19 对蛋白，由于 HSPA4 未找到 PDB (蛋白结构文件)，因此实际对接的为 18 对。



Figure \@ref(fig:Overview-of-protein-docking-results) (下方图) 为图Overview of protein docking results概览。

**(对应文件为 `Figure+Table/Overview-of-protein-docking-results.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overview-of-protein-docking-results.pdf}
\caption{Overview of protein docking results}\label{fig:Overview-of-protein-docking-results}
\end{center}

Table \@ref(tab:Overview-of-protein-docking-results-data) (下方表格) 为表格Overview of protein docking results data概览。

**(对应文件为 `Figure+Table/Overview-of-protein-docking-results-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有18行11列，以下预览的表格可能省略部分数据；含有18个唯一`Name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Overview-of-protein-docking-results-data)Overview of protein docking results data

|Name      |pro1     |pro2   |Cluster |Members |Center  |Lowest... |value   |pdb1 |pdb2 |
|:---------|:--------|:------|:-------|:-------|:-------|:---------|:-------|:----|:----|
|HMGB1_... |HMGB1    |ITGAM  |0       |45      |-2270.7 |-2270.7   |-2270.7 |6OEO |7USM |
|HSPA8_... |HSPA8    |TFRC   |0       |67      |-1792.1 |-1792.1   |-1792.1 |6ZYJ |7ZQS |
|SERPIN... |SERPINA1 |TFRC   |0       |84      |-1336.4 |-1456.1   |-1456.1 |9API |7ZQS |
|FTH1_TFRC |FTH1     |TFRC   |0       |21      |-1335.4 |-1426.7   |-1426.7 |8DNP |7ZQS |
|DDX3X_... |DDX3X    |AIFM1  |0       |61      |-1229.3 |-1410     |-1410   |7LIU |5KVI |
|KNG1_I... |KNG1     |ITGAM  |0       |27      |-1139   |-1249.1   |-1249.1 |7F6I |7USM |
|YWHAZ_... |YWHAZ    |ITGAM  |0       |96      |-805.3  |-1013.2   |-1013.2 |8AH2 |7USM |
|MPO_ITGAM |MPO      |ITGAM  |0       |15      |-999.5  |-999.5    |-999.5  |7OIH |7USM |
|C4B_ITGAM |C4B      |ITGAM  |0       |24      |-883.5  |-973.4    |-973.4  |6YSQ |7USM |
|HSPD1_... |HSPD1    |ITGAM  |0       |22      |-730.8  |-973.3    |-973.3  |7L7S |7USM |
|CLU_AIFM1 |CLU      |AIFM1  |0       |96      |-707.3  |-883.7    |-883.7  |7zet |5KVI |
|FGB_ITGAM |FGB      |ITGAM  |0       |37      |-800.3  |-829.5    |-829.5  |3HUS |7USM |
|MMP2_I... |MMP2     |ITGAM  |0       |32      |-629    |-827.8    |-827.8  |1RTG |7USM |
|PTPN11... |PTPN11   |PECAM1 |0       |33      |-759.2  |-803.5    |-803.5  |7VXG |5GNI |
|PPIA_A... |PPIA     |AIFM1  |0       |152     |-550.8  |-755.1    |-755.1  |7TA8 |5KVI |
|...       |...      |...    |...     |...     |...     |...       |...     |...  |...  |

Figure \@ref(fig:Top1-Protein-docking-of-HMGB1-ITGAM) (下方图) 为图Top1 Protein docking of HMGB1 ITGAM概览。

**(对应文件为 `Figure+Table/ITGAM..7USM._with_HMGB1..6OEO..png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ITGAM..7USM._with_HMGB1..6OEO..png}
\caption{Top1 Protein docking of HMGB1 ITGAM}\label{fig:Top1-Protein-docking-of-HMGB1-ITGAM}
\end{center}

 
`Top 5 visualization' 数据已全部提供。

**(对应文件为 `Figure+Table/Top-5-visualization`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Top-5-visualization共包含5个文件。

\begin{enumerate}\tightlist
\item 1\_Top\_1\_HMGB1\_ITGAM.txt
\item 2\_Top\_2\_HSPA8\_TFRC.txt
\item 3\_Top\_3\_SERPINA1\_TFRC.txt
\item 4\_Top\_4\_FTH1\_TFRC.txt
\item 5\_Top\_5\_DDX3X\_AIFM1.txt
\end{enumerate}\end{tcolorbox}
\end{center}



### 同时满足 stringdb 实验得分和蛋白对接的
 
若设置对接阈值 (Lowest.Energy) 为 -1000，则

Figure \@ref(fig:Intersection-of-StringDB-exp--with-Protein-docking) (下方图) 为图Intersection of StringDB exp  with Protein docking概览。

**(对应文件为 `Figure+Table/Intersection-of-StringDB-exp--with-Protein-docking.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-StringDB-exp--with-Protein-docking.pdf}
\caption{Intersection of StringDB exp  with Protein docking}\label{fig:Intersection-of-StringDB-exp--with-Protein-docking}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    FTH1\_TFRC, SERPINA1\_TFRC, HSPA8\_TFRC, DDX3X\_AIFM1,
HMGB1\_ITGAM

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-StringDB-exp--with-Protein-docking-content`)**

Table \@ref(tab:intersected-data) (下方表格) 为表格intersected data概览。

**(对应文件为 `Figure+Table/intersected-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5行11列，以下预览的表格可能省略部分数据；含有5个唯一`pro1'。
\end{tcolorbox}
\end{center}

Table: (\#tab:intersected-data)Intersected data

|pro1     |pro2  |Name      |Cluster |Members |Center  |Lowest... |value   |pdb1 |pdb2 |
|:--------|:-----|:---------|:-------|:-------|:-------|:---------|:-------|:----|:----|
|HMGB1    |ITGAM |HMGB1_... |0       |45      |-2270.7 |-2270.7   |-2270.7 |6OEO |7USM |
|HSPA8    |TFRC  |HSPA8_... |0       |67      |-1792.1 |-1792.1   |-1792.1 |6ZYJ |7ZQS |
|SERPINA1 |TFRC  |SERPIN... |0       |84      |-1336.4 |-1456.1   |-1456.1 |9API |7ZQS |
|FTH1     |TFRC  |FTH1_TFRC |0       |21      |-1335.4 |-1426.7   |-1426.7 |8DNP |7ZQS |
|DDX3X    |AIFM1 |DDX3X_... |0       |61      |-1229.3 |-1410     |-1410   |7LIU |5KVI |



