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
网络药理学和表观遗传学修饰筛选靶点} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-03-28}}
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



以中药复方参苓白术散为研究对象，脓毒症肠损伤为疾病，结合网络药理学、RNA-seq 分析、分子对接等多种技术方法，联合表观遗传学蛋白数据库，筛选该复方中能有效作用于脓毒症肠损伤的成分，并挖掘作用于 表观遗传学蛋白 的成分极其具体靶点和下游靶点。最终筛得成分： Betulin (CID: 72326) (见 Fig. \@ref(fig:Overall-combining-Affinity)) ，成功分子对接靶点 GADD45B (表观遗传学蛋白),
根据 KEGG (MARK) 通路图 (Fig. \@ref(fig:Hsa04010-visualization)) ，其可作用于 MAP3K4 和 TAOK3, 与脓毒症肠损伤有关。


# 前言 {#introduction}

脓毒症是宿主对感染综合征的反应失调，导致危及生命的器官功能障碍。脓毒症引起的肠道功能障碍是多系统器官衰竭进展的关键因素[@TargetingStingKobrit2023]。

核酸的表观遗传修饰是核酸领域最重要的研究领域之一，因为它使基因调控变得更加复杂，遗传也更加复杂，从而表明它对遗传、生长和疾病等方面产生了深远的影响[@EpigeneticModiChen2017]。

中药对表观遗传修饰调控作用而治疗疾病正成为研究焦点。例如，越来越多的研究表明，中药通过调节DNA甲基化修饰过程发挥着相当大的抗肿瘤作用。中药调控DNA甲基化修饰的研究主要集中在全基因组和活性成分或单一化合物以及中药配方（CHF）的异常甲基化状态。 中医理论的平衡和整体观念与肿瘤环境中DNA甲基化修饰的平衡不谋而合[@TraditionalChiZhuD2022]。

本研究以中药复方参苓白术散为研究对象，脓毒症肠损伤为疾病，结合网络药理学、RNA-seq 分析、分子对接等多种技术方法，从表观遗传学修饰调控的视角，探讨 参苓白术散的 脓毒症肠损伤的治疗作用。

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE202261**: A total of 5 C57BL/6 mice were randomly divided into 2 groups: CLP group (n=3), Sham group (n=2).The disinfected abdomen was incised 1 cm at midline to expose the cecum. Silk thread was subsequentl...

## 方法

Mainly used method:

- R package `biomaRt` used for gene annotation[@MappingIdentifDurinc2009].
- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol)[@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Database `EpiFactors` used for screening epigenetic regulators[@Epifactors2022Maraku2023].
- `Fastp` used for Fastq data preprocessing[@UltrafastOnePChen2023].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- R package `ClusterProfiler` used for GSEA enrichment[@ClusterprofilerWuTi2021].
- Website `HERB` <http://herb.ac.cn/> used for data source[@HerbAHighThFang2021].
- Python tool of `HOB` was used for prediction of human oral bioavailability[@HobpreAccuratWeiM2022].
- `Kallisto` used for RNA-seq mapping and quantification[@NearOptimalPrBray2016].
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- R package `ChemmineR` used for similar chemical compounds clustering[@ChemminerACoCaoY2008].
- R version 4.3.2 (2023-10-31); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 结果与讨论 {#results}

## 网络药理学成分靶点 {#pharm}


为了实现对 参苓白术散的 全面的网络药理学分析，本研究从 HERB 数据库挖掘 其成分和靶点信息[@HerbAHighThFang2021]。
该数据库记录的 参苓白术散中 各味中药的成分如 Fig. \@ref(fig:Main-fig-1)a 所示。
随后，这些成分的靶点信息被挖掘，整理以备网络药理学分析 (所有数据整理于 Tab. \@ref(tab:tables-of-Herbs-compounds-and-targets)) 。

脓毒症肠损伤的靶基因信息被收集。如 Fig. \@ref(fig:Main-fig-1)b 所示，
我们不仅仅收集了脓毒症肠损伤 (sepsis intestinal injury, SII) 的 (GeneCards) ，
还 收集了来自 DisGeNet 和 PharmGKB 的脓毒症相关的靶点，因为考虑到
中医用药辨证论治、治病求本的特性。由于 GeneCards 的数据来源有一定预测性成分，所以，我们随后还进行了脓毒症肠损伤的
RNA-seq 分析，以增强分析的可靠性 (见 \@ref(rna))。


Figure \@ref(fig:Main-fig-1) (下方图) 为图Main fig 1概览。

**(对应文件为 `./Figure+Table/fig1.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig1.pdf}
\caption{Main fig 1}\label{fig:Main-fig-1}
\end{center}



## 复方靶点的表观遗传学修饰靶点

表观遗传修饰 (epigenetic modification， EM) 包括 DNA 和 RNA 的表观遗传修饰。
为了尽可能囊括所有的 EM 相关蛋白，以全面探究 参苓白术散的靶向 EM 作用，
这里，我们收集了 EpiFactors 数据库的所有 EM 蛋白数据
(数据见 Tab. \@ref(tab:All-protein-of-epigenetic-regulators)) 。
之后，我们联合了 参苓白术散的成分靶点数据，疾病靶点数据，以及 EM 蛋白数据，
构建了 参苓白术散网络药理学靶向 EM 蛋白 治疗 SII 的网络体系。
见 Fig. \@ref(fig:Main-fig-2)，参苓白术散中各味药都具有多个成分可能通过
EM 对 SII 发挥治疗作用，其中以砂仁的成分为数量众多。


Figure \@ref(fig:Main-fig-2) (下方图) 为图Main fig 2概览。

**(对应文件为 `./Figure+Table/SLBJ-network-pharmacology-of-epigenetic-target.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/SLBJ-network-pharmacology-of-epigenetic-target.pdf}
\caption{Main fig 2}\label{fig:Main-fig-2}
\end{center}



## 脓毒症肠损伤 RNA-seq 分析 {#rna}

在 \@ref(pharm) 中，主要以 既定的数据库为来源筛选了 SII 或者 脓毒症的靶点信息。
这里，我们从 GEO 数据库补充了 SII 为研究对象的 RNA-seq 数据以用于差异分析，筛选
SII 差异表达基因 (DEGs) ，以补充、增强网络药理学分析的可靠性。
差异分析结果见 Fig. \@ref(fig:Main-fig-3)a。由于这一批数据是以 小鼠为来源的，
为了对应到 人类的药物网络药理学研究，这里使用 Biomart 将小鼠基因映射到
人类基因  (MGI symbol 转化为 HGNC symbol)，然后以 KEGG 富集分析  (GSEA 算法)，
富集见 Fig. \@ref(fig:Main-fig-3)b。
在 Fig. \@ref(fig:Main-fig-3)b 中，我们着重了三条通路，
这三条通路是通过 Fig. \@ref(fig:Main-fig-2) 中的 EM 相关靶基因为条件筛选出的
通路。
现在我们可以更加确信，参苓白术散可能通过 EM 调控治疗 SII，且涉及 Fig. \@ref(fig:Main-fig-3)b
所示的三条信号通路。
其中 MARK 通路的具体展示如 Fig. \@ref(fig:Main-fig-3) 所示
(将在后续的分子对接中，发现复方中的成分可能作用于其中的 EM 相关靶点) 。
随后，以 Fig. \@ref(fig:Main-fig-3)b 中三条的 EM 靶点为条件，
我们简化了 Fig. \@ref(fig:Main-fig-2) 的网络体系，呈现 Fig. \@ref(fig:Main-fig-3)d。
这将是 HERB 数据库所能提供的全部 参苓白术散 对 EM 的调控作用信息，且与 SII 疾病相关。



Figure \@ref(fig:Main-fig-3) (下方图) 为图Main fig 3概览。

**(对应文件为 `./Figure+Table/fig3.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig3.pdf}
\caption{Main fig 3}\label{fig:Main-fig-3}
\end{center}



## 分子对接筛选成分

Fig. \@ref(fig:Main-fig-3)d 所示，相关成分对三个靶点有调控作用，出于 HERB 数据库的性质，
这调控作用可能是间接的 (进入机体后代谢为其它成分作用于靶点；或者通过调控更上游的靶点，间接作用于下游) ，
可能是直接的 (进入机体后，该成分可直接与对应蛋白结合，发挥药理作用) 。
这里，我们尝试以分子对接的方式，筛选可直接作用的成分。
我们联合了 AutoDock Vina 和 ADFR 工具组，实现对分子和蛋白的全自动批量对接。
这一批的对接结果，总体所需能量均超过 1，对接能量过高，匹配性较差。
可以推测，这些成分更有可能是通过间接的方式作用于这些蛋白。

为了挖掘可能直接作用于相关 EM 靶点的活性成分，以下尝试筛选 参苓白术散中的其它成分。
须知，受限于 HERB 数据库或其他数据库的成分靶点记录，可能忽略一部分药物对于机体疾病的靶向作用。
这里，通过从头筛选、分子对接，将有助于挖掘直接作用于 EM 靶点的活性成分。
我们以 参苓白术散中的所有成分为研究对象，首先 以 HOB 工具，预测 这些成分的 20% 口服利用度 (HOB) ，
仅保留符合条件的成分以下一步研究。
可以通过 AutoDock vina 和 ADFR 工具组，实现对余下所有成分的对 EM 相关靶点的对接 (Fig. \@ref(fig:Main-fig-3)d 靶点) ，
然而这将耗费大量计算的时间。为了减小计算负担，之后，我们以 ChemmineR 对 余下成分按结构相似度聚类 (Binning clustering) ，
设定 Cut-off 为 0.4，然后将各个聚类团中随机抽取 3 个成分，以匹配 EM 相关靶点，尝试分子对接
(实际对接的成分 CID 和靶点蛋白 PDB 可见 \@ref(dock2))。

Fig. \@ref(fig:Main-fig-4)a 展示了三个 EM 靶点各自对应的对接能量最小前 5 的成分。
可知，参苓白术散中的更多的成分可能通过调控 GADD45B 发挥治疗 SII 的作用。
这里筛选得出的直接对接能量的成分为 Betulin (CID: 72326)，该成分可 作用于 EM 相关靶点 GADD45B 。
Fig. \@ref(fig:Main-fig-4)b 展示了 其分子对接结果的可视化呈现 (此外，Fig. \@ref(fig:Main-fig-4)c、d
展示了对接能量其次的两个分子的可视化) 。

联系 Fig. \@ref(fig:Main-fig-3)d，该 GEO 的 SII 数据，GADD45B 呈上调，而其下游 TAOK1 也呈上调趋势。
如 参苓白术散可对 EM 相关的 GADD45B 发挥调控作用治疗 SII，将有可能通过下调 GADD45B ，随后间接调控 TAOK1，
以发挥治疗 SII 的作用。这推测需要进一步实验论证。



Figure \@ref(fig:Main-fig-4) (下方图) 为图Main fig 4概览。

**(对应文件为 `./Figure+Table/fig4.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig4.pdf}
\caption{Main fig 4}\label{fig:Main-fig-4}
\end{center}



# 结论 {#dis}

筛得成分： Betulin (CID: 72326) (见 Fig. \@ref(fig:Overall-combining-Affinity)) ，成功分子对接靶点 GADD45B (表观遗传学蛋白),
根据 KEGG (MARK) 通路图 (Fig. \@ref(fig:Hsa04010-visualization)) ，其可作用于 MAP3K4 和 TAOK3, 与脓毒症肠损伤有关。

# 附：文件概要

- 从 HERB 数据库获取复方的成分信息和靶点信息，整理如 Tab. \@ref(tab:tables-of-Herbs-compounds-and-targets)。
- 从多个数据库获取脓毒症肠损伤 (SH) 相关靶点，见 Fig. \@ref(fig:Overall-targets-number-of-datasets)
- 表观遗传学蛋白的获取通过 EpiFactors 数据库。
- 在复方中存在的 表观遗传学相关靶点 见 Fig. \@ref(fig:SLBJ-network-pharmacology-of-epigenetic-target)
- 为了进一步筛选与 SH 相关的通路和靶点，以 GEO 的 SH 数据集做了差异分析 (Fig. \@ref(fig:SII-model-vs-control-DEGs)) 。
- 该数据集源于小鼠，这里将其映射到人类基因，然后富集分析 Fig. \@ref(fig:KEGG-enrichment)
- 在富集的通路中筛选包含 表观修饰相关靶点 ，见 Fig. \@ref(fig:KEGG-enrichment-with-enriched-genes)
- 通路具体可见 \@ref(epi-tar), \@ref(epi-path), 结果上述网络药理学，可发现相关化学成分为
  Fig. \@ref(fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway)
- 对 Fig. \@ref(fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway) 所示的
  成分与靶点关系进行分子对接，对接结果见 Fig. \@ref(fig:FIRST-Overall-combining-Affinity)。
- 由于 Fig. \@ref(fig:FIRST-Overall-combining-Affinity) 所示对接能量均过高，这里随后尝试
  挖掘复方中其它可能作用于其相关靶点的化学成分。
- 复方中的成分复杂，为了减少过度的分子对接计算量，以计算 HOB 和 化学结果相似聚类的方式，筛选了少数一批化学
  成分用以分子对接。
- 对接结果见 Fig. \@ref(fig:Overall-combining-Affinity)。其中，Betulin (CID: 72326) 对接 GADD45B 蛋白所需能量最少，
  对接可视化见 Fig. \@ref(fig:Docking-72326-into-GADD45B)
- 联系 Fig. \@ref(fig:Hsa04010-visualization) ，可知 GADD45B 下游调控的靶点。其中，TAOK3 是 SH 中上调的基因，
  GADD45B-TAOK3 的作用，可能是最佳结果，对应成分为 Betulin (CID: 72326)。

# 附：分析流程 {#workflow}



## 网络药理学分析

复方成分和靶点数据来源于 HERB 数据库。

### 成分

Table \@ref(tab:Herbs-information) (下方表格) 为表格Herbs information概览。

**(对应文件为 `Figure+Table/Herbs-information.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有10行18列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Herbs-information)Herbs information

|Herb_     |Herb_p... |Herb_c... |Herb_e... |Herb_l... |Proper... |Meridians |UsePart   |Function  |Indica... |... |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---|
|HERB00... |BAI BI... |白扁豆    |White ... |Semen ... |Minor ... |Spleen... |NA        |To inv... |Treatm... |... |
|HERB00... |BAI ZHU   |白术      |rhizom... |Rhizom... |Warm; ... |Spleen... |root      |To inv... |Spleen... |... |
|HERB00... |FU LING   |茯苓      |Indian... |Poria     |Mild; ... |Spleen... |sclero... |To cau... |Neuras... |... |
|HERB00... |GAN CAO   |甘草      |Root o... |Radix ... |Mild; ... |Lung; ... |root a... |To rei... |1. Its... |... |
|HERB00... |JIE GENG  |桔梗      |Platyc... |Radix ... |Mild; ... |Lung      |root      |To rel... |Cough ... |... |
|HERB00... |LIAN ZI   |莲子      |Hindu ... |Nelumb... |Mild; ... |Spleen... |seed      |To sup... |Chroni... |... |
|HERB00... |REN SHEN  |人参      |Ginseng   |Radix ... |Minor ... |Lung; ... |root      |To rei... |Qi vac... |... |
|HERB00... |SHA REN   |砂仁      |Villou... |Fructu... |Warm; ... |Spleen... |ripe f... |To eli... |Abdomi... |... |
|HERB00... |SHAN YAO  |山药      |Common... |Rhizom... |Mild; ... |Lung; ... |rhizome   |To rep... |Reduce... |... |
|HERB00... |YI YI REN |薏苡仁    |seed o... |semen ... |Minor ... |Lung; ... |seed      |1. To ... |Edema,... |... |

Table \@ref(tab:Components-of-Herbs) (下方表格) 为表格Components of Herbs概览。

**(对应文件为 `Figure+Table/Components-of-Herbs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1870行4列，以下预览的表格可能省略部分数据；表格含有10个唯一`herb\_id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Components-of-Herbs)Components of Herbs

|herb_id    |Ingredient.id |Ingredient.name      |Ingredient.alias     |
|:----------|:-------------|:--------------------|:--------------------|
|HERB006568 |HBIN000890    |1,2linoleic acid-... |NA                   |
|HERB006568 |HBIN005609    |2-ethyl-3-hydroxy... |NA                   |
|HERB006568 |HBIN006106    |2-Monoolein          |2-monoolein; [2-h... |
|HERB006568 |HBIN006366    |[(2R)-2,3-dihydro... |(Z)-octadec-9-eno... |
|HERB006568 |HBIN012837    |(6Z,10E,14E,18E)-... |NA                   |
|HERB006568 |HBIN015611    |α-monolinolein       |NA                   |
|HERB006568 |HBIN015675    |α-sitosterol         |alpha-sitosterol     |
|HERB006568 |HBIN016562    |Arabinose            |arabinose            |
|HERB006568 |HBIN016720    |arginine             |AC1ODX8E; [(4S)-5... |
|HERB006568 |HBIN018278    |beta-sitosterol      |24.alpha.-Ethylch... |
|HERB006568 |HBIN019257    |cadmium              |NA                   |
|HERB006568 |HBIN019351    |calcium              |NA                   |
|HERB006568 |HBIN019475    |campesterol          |campesterol ; FT-... |
|HERB006568 |HBIN019688    |caprylic acid        |Octanoic acid (mi... |
|HERB006568 |HBIN021150    |CLR                  |5-Cholesten-3b-ol... |
|...        |...           |...                  |...                  |

Figure \@ref(fig:intersection-of-all-compounds) (下方图) 为图intersection of all compounds概览。

**(对应文件为 `Figure+Table/intersection-of-all-compounds.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/intersection-of-all-compounds.pdf}
\caption{Intersection of all compounds}\label{fig:intersection-of-all-compounds}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/intersection-of-all-compounds-content`)**

### 成分靶点

Table \@ref(tab:tables-of-Herbs-compounds-and-targets) (下方表格) 为表格tables of Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/tables-of-Herbs-compounds-and-targets.tsv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有56685行9列，以下预览的表格可能省略部分数据；表格含有1661个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:tables-of-Herbs-compounds-and-targets)Tables of Herbs compounds and targets

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target... |Databa... |Paper.id |... |
|:-------------|:---------|:-------------|:-------------|:---------|:---------|:---------|:--------|:---|
|HBIN00...     |FU LING   |10-hyd...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |BAI BI... |10-non...     |(10R)-...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |NR3C1     |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |AR        |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |NR3C1     |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |AR        |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |NR3C1     |NA        |NA       |... |
|HBIN00...     |GAN CAO   |11-deo...     |11-Deo...     |HBTAR0... |AR        |NA        |NA       |... |
|HBIN00...     |FU LING   |1,2,3,...     |Pentag...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |BAI ZHU   |12-(α-...     |12-(α-...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |BAI ZHU   |12-(α-...     |[(4E,6...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |YI YI REN |1,2lin...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |GAN CAO   |12-met...     |12-met...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |REN SHEN  |12-O-N...     |12-o-n...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |BAI ZHU   |12-Oxo...     |(5aR,9...     |HBTAR0... |NR3C1     |NA        |NA       |... |
|...           |...       |...           |...           |...       |...       |...       |...      |... |

### 疾病靶点

取以下基因集的合集：

Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}



## 表观遗传学蛋白

自数据库 <https://epifactors.autosome.org/> 获取相关蛋白。

Table \@ref(tab:All-protein-of-epigenetic-regulators) (下方表格) 为表格All protein of epigenetic regulators概览。

**(对应文件为 `Figure+Table/All-protein-of-epigenetic-regulators.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有801行25列，以下预览的表格可能省略部分数据；表格含有801个唯一`Id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:All-protein-of-epigenetic-regulators)All protein of epigenetic regulators

|Id  |HGNC_s... |Status |HGNC_ID |HGNC_name |GeneID |UniPro......7 |UniPro......8 |Domain    |MGI_sy... |
|:---|:---------|:------|:-------|:---------|:------|:-------------|:-------------|:---------|:---------|
|1   |A1CF      |#      |24086   |APOBEC... |29974  |Q9NQ94        |A1CF_H...     |DND1_D... |A1cf      |
|2   |ACINU     |New    |17066   |Apopto... |22985  |Q9UKV3        |ACINU_...     |PF1629... |Acin1     |
|3   |ACTB      |#      |132     |actin,... |60     |P60709        |ACTB_H...     |Actin ... |Actb      |
|4   |ACTL6A    |#      |24124   |actin-... |86     |O96019        |ACL6A_...     |Actin ... |Actl6a    |
|5   |ACTL6B    |#      |160     |actin-... |51412  |O94805        |ACL6B_...     |Actin ... |Actl6b    |
|6   |ACTR3B    |#      |17256   |ARP3 a... |57180  |Q9P1U1        |ARP3B_...     |Actin ... |Actr3b    |
|7   |ACTR5     |#      |14671   |ARP5 a... |79913  |Q9H9F9        |ARP5_H...     |Actin ... |Actr5     |
|8   |ACTR6     |#      |24025   |ARP6 a... |64431  |Q9GZN1        |ARP6_H...     |Actin ... |Actr6     |
|9   |ACTR8     |#      |14672   |ARP8 a... |93973  |Q9H981        |ARP8_H...     |Actin ... |Actr8     |
|10  |ADNP      |#      |15766   |activi... |23394  |Q9H2P0        |ADNP_H...     |Homeob... |Adnp      |
|11  |AEBP2     |#      |24051   |AE bin... |121536 |Q6ZN18        |AEBP2_...     |Pfam-B... |Aebp2     |
|12  |AICDA     |#      |13203   |activa... |57379  |Q9GZX7        |AICDA_...     |APOBEC... |Aicda     |
|13  |AIRE      |#      |360     |autoim... |326    |O43918        |AIRE_H...     |PHD PF... |Aire      |
|14  |ALKBH1    |#      |17911   |alkB, ... |8846   |Q13686        |ALKB1_...     |2OG-Fe... |Alkbh1    |
|15  |ALKBH1    |New    |17911   |Nuclei... |8846   |Q13686        |ALKB1_...     |PF13532   |Alkbh1    |
|... |...       |...    |...     |...       |...    |...           |...           |...       |...       |



## 筛选表观遗传学靶点

### 复方成分与表观遗传学靶点

Figure \@ref(fig:SLBJ-network-pharmacology-of-epigenetic-target) (下方图) 为图SLBJ network pharmacology of epigenetic target概览。

**(对应文件为 `Figure+Table/SLBJ-network-pharmacology-of-epigenetic-target.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SLBJ-network-pharmacology-of-epigenetic-target.pdf}
\caption{SLBJ network pharmacology of epigenetic target}\label{fig:SLBJ-network-pharmacology-of-epigenetic-target}
\end{center}

Table \@ref(tab:SLBJ-Herbs-compounds-and-targets-of-epigenetic-target) (下方表格) 为表格SLBJ Herbs compounds and targets of epigenetic target概览。

**(对应文件为 `Figure+Table/SLBJ-Herbs-compounds-and-targets-of-epigenetic-target.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有583行3列，以下预览的表格可能省略部分数据；表格含有10个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:SLBJ-Herbs-compounds-and-targets-of-epigenetic-target)SLBJ Herbs compounds and targets of epigenetic target

|Herb_pinyin_name |Ingredient.name   |Target.name |
|:----------------|:-----------------|:-----------|
|SHA REN          |acetic acid       |HDAC8       |
|SHA REN          |acetic acid       |PKM         |
|SHA REN          |acetic acid       |HDAC8       |
|SHA REN          |acetic acid       |PKM         |
|JIE GENG         |adeninenucleoside |ACTB        |
|JIE GENG         |adeninenucleoside |CDK9        |
|JIE GENG         |adeninenucleoside |MAP3K7      |
|JIE GENG         |adeninenucleoside |TP53        |
|JIE GENG         |adeninenucleoside |PPARGC1A    |
|JIE GENG         |adeninenucleoside |ACTB        |
|JIE GENG         |adeninenucleoside |CDK9        |
|JIE GENG         |adeninenucleoside |MAP3K7      |
|JIE GENG         |adeninenucleoside |TP53        |
|JIE GENG         |adeninenucleoside |PPARGC1A    |
|JIE GENG         |adeninenucleoside |ACTB        |
|...              |...               |...         |



## 脓毒症肠损伤的 GEO 数据分析

### 数据来源

注：由于该数据的原作者没有上传定量后的原始 Count，不利于差异分析；因此，这里下载了 SRA 原始数据，使用 Kallisto 重新定量。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE202261

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Raw data (raw reads) of fastq format were firstly
processed using fastp(version 0.20.0) softeware with
default parameters in pair end mode.

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    The clean data were obtained for downstream analyses by
removing reads containing adapter, reads containing ploy-N
and low-quality reads from raw data.

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    The clean reads were mapped to reference of mouse mRNAs
and lncRNAs using bowtie2(version 2.3.1) with parameters -q
-L 16 --phred64 -p 6

\vspace{2em}


\textbf{
data\_processing.3
:}

\vspace{0.5em}

    TPM value and read counts of each transcript were
obtained by eXpress(version 1.5.1) with parameters
--no-update-check --rf-stranded.

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/SII-GSE202261-content`)**

Table \@ref(tab:SII-metadata) (下方表格) 为表格SII metadata概览。

**(对应文件为 `Figure+Table/SII-metadata.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行8列，以下预览的表格可能省略部分数据；表格含有4个唯一`sample'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item sample:  样品名称
\item group:  分组名称
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:SII-metadata)SII metadata

|sample    |group   |lib.size  |norm.f... |file      |directory |sample1   |gsm       |
|:---------|:-------|:---------|:---------|:---------|:---------|:---------|:---------|
|SRR211... |control |206657... |1         |kallis... |kallis... |SRR211... |GSM646... |
|SRR211... |control |194806... |1         |kallis... |kallis... |SRR211... |GSM646... |
|SRR211... |model   |205782... |1         |kallis... |kallis... |SRR211... |GSM646... |
|SRR211... |model   |230056... |1         |kallis... |kallis... |SRR211... |GSM646... |

### fastp 质控

 
`Fastp QC' 数据已全部提供。

**(对应文件为 `./fastp_report/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./fastp\_report/共包含4个文件。

\begin{enumerate}\tightlist
\item SRR21101636.html
\item SRR21101637.html
\item SRR21101638.html
\item SRR21101639.html
\end{enumerate}\end{tcolorbox}
\end{center}

### RNA 定量

使用小鼠 cDNA 作为参考基因组 (Mus\_musculus.GRCm39.cdna.all.fa.gz), `Kallisto` 定量。 

Table \@ref(tab:Quantification) (下方表格) 为表格Quantification概览。

**(对应文件为 `Figure+Table/Quantification.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有116873行5列，以下预览的表格可能省略部分数据；表格含有116873个唯一`target\_id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Quantification)Quantification

|target_id          |SRR211016361 |SRR211016371 |SRR211016381 |SRR211016391 |
|:------------------|:------------|:------------|:------------|:------------|
|ENSMUST00000196221 |0            |0            |0            |0            |
|ENSMUST00000179664 |0            |0            |0            |0            |
|ENSMUST00000177564 |0            |0            |0            |0            |
|ENSMUST00000178537 |0            |0            |0            |0            |
|ENSMUST00000178862 |0            |0            |0            |0            |
|ENSMUST00000179520 |0            |0            |0            |0            |
|ENSMUST00000179883 |0            |0            |0            |0            |
|ENSMUST00000195858 |0            |0            |0            |0            |
|ENSMUST00000179932 |0            |0            |0            |0            |
|ENSMUST00000180001 |0            |0            |0            |0            |
|ENSMUST00000178815 |0            |0            |0            |0            |
|ENSMUST00000177965 |0            |0            |0            |0            |
|ENSMUST00000178909 |0            |0            |0            |0            |
|ENSMUST00000177646 |0            |0            |0            |0            |
|ENSMUST00000178230 |0            |0            |0            |0            |
|...                |...          |...          |...          |...          |

### 差异分析

使用 limma 差异分析

Figure \@ref(fig:SII-model-vs-control-DEGs) (下方图) 为图SII model vs control DEGs概览。

**(对应文件为 `Figure+Table/SII-model-vs-control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SII-model-vs-control-DEGs.pdf}
\caption{SII model vs control DEGs}\label{fig:SII-model-vs-control-DEGs}
\end{center}

### 将小鼠基因 symbol 映射到人类 (hgnc\_symbol)

使用 biomart 将基因映射

Table \@ref(tab:Mapped-DEGs) (下方表格) 为表格Mapped DEGs概览。

**(对应文件为 `Figure+Table/Mapped-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4409行13列，以下预览的表格可能省略部分数据；表格含有4338个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item mgi\_symbol:  基因名 (Mice)
\item logFC:  estimate of the log2-fold-change corresponding to the effect or contrast (for ‘topTableF’ there may be several columns of log-fold-changes)
\item AveExpr:  average log2-expression for the probe over all arrays and channels, same as ‘Amean’ in the ‘MarrayLM’ object
\item t:  moderated t-statistic (omitted for ‘topTableF’)
\item P.Value:  raw p-value
\item B:  log-odds that the gene is differentially expressed (omitted for ‘topTreat’)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Mapped-DEGs)Mapped DEGs

|hgnc_s... |mgi_sy... |logFC     |P.Value   |rownames |ensemb......6 |ensemb......7 |entrez... |descri... |... |
|:---------|:---------|:---------|:---------|:--------|:-------------|:-------------|:---------|:---------|:---|
|ENPP7     |Enpp7     |-3.851... |1.8936... |43380    |ENSMUS...     |ENSMUS...     |238011    |ectonu... |... |
|THBS1     |Thbs1     |2.7918... |3.2577... |94883    |ENSMUS...     |ENSMUS...     |21825     |thromb... |... |
|DNASE1    |Dnase1    |-3.650... |2.6636... |26241    |ENSMUS...     |ENSMUS...     |13419     |deoxyr... |... |
|ANPEP     |Anpep     |-1.838... |1.0218... |50217    |ENSMUS...     |ENSMUS...     |16790     |alanyl... |... |
|CLIC5     |Clic5     |-2.664... |8.8784... |45278    |ENSMUS...     |ENSMUS...     |224796    |chlori... |... |
|ZBTB16    |Zbtb16    |3.8536... |5.3567... |5449     |ENSMUS...     |ENSMUS...     |235320    |zinc f... |... |
|CEP85     |Cep85     |2.4595... |1.1643... |45584    |ENSMUS...     |ENSMUS...     |70012     |centro... |... |
|REG1B     |Reg3b     |4.2139... |9.5036... |25543    |ENSMUS...     |ENSMUS...     |18489     |regene... |... |
|IGFBP5    |Igfbp5    |2.5428... |1.5655... |72899    |ENSMUS...     |ENSMUS...     |16011     |insuli... |... |
|PMAIP1    |Pmaip1    |3.3882... |1.7795... |14956    |ENSMUS...     |ENSMUS...     |58801     |phorbo... |... |
|CYP4F2    |Cyp4f14   |-1.967... |2.2471... |66083    |ENSMUS...     |ENSMUS...     |64385     |cytoch... |... |
|PRR15     |Prr15     |-2.404... |2.0582... |38200    |ENSMUS...     |ENSMUS...     |78004     |prolin... |... |
|FKBP5     |Fkbp5     |2.8596... |2.2370... |54319    |ENSMUS...     |ENSMUS...     |14229     |FK506 ... |... |
|ERRFI1    |Errfi1    |2.3357... |2.1310... |90849    |ENSMUS...     |ENSMUS...     |74155     |ERBB r... |... |
|LGMN      |Lgmn      |2.5094... |2.3522... |59306    |ENSMUS...     |ENSMUS...     |19141     |leguma... |... |
|...       |...       |...       |...       |...      |...           |...           |...       |...       |... |




### 富集分析 (GSEA)

Figure \@ref(fig:KEGG-enrichment) (下方图) 为图KEGG enrichment概览。

**(对应文件为 `Figure+Table/KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/KEGG-enrichment.pdf}
\caption{KEGG enrichment}\label{fig:KEGG-enrichment}
\end{center}

Table \@ref(tab:KEGG-enrichment-data) (下方表格) 为表格KEGG enrichment data概览。

**(对应文件为 `Figure+Table/KEGG-enrichment-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5行13列，以下预览的表格可能省略部分数据；表格含有5个唯一`ID'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item pvalue:  显著性 P。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:KEGG-enrichment-data)KEGG enrichment data

|ID       |Descri... |setSize |enrich... |NES       |pvalue    |p.adjust  |qvalue    |rank |leadin... |
|:--------|:---------|:-------|:---------|:---------|:---------|:---------|:---------|:----|:---------|
|hsa04610 |Comple... |20      |0.6129... |2.1798... |0.0002... |0.0444... |0.0415... |789  |tags=5... |
|hsa04920 |Adipoc... |29      |0.5336... |2.1079... |0.0004... |0.0444... |0.0415... |1541 |tags=8... |
|hsa04010 |MAPK s... |109     |0.3242... |1.7682... |0.0004... |0.0444... |0.0415... |1026 |tags=4... |
|hsa00340 |Histid... |10      |-0.726... |-2.053... |0.0008... |0.0496... |0.0464... |536  |tags=7... |
|hsa04657 |IL-17 ... |29      |0.5129... |2.0264... |0.0008... |0.0496... |0.0464... |704  |tags=5... |



## 复方成分表观遗传学靶点的通路调控

### 富集表观修饰蛋白的通路

以 Fig. \@ref(fig:SLBJ-network-pharmacology-of-epigenetic-target)
的靶点筛选，发现存在三条通路：

Figure \@ref(fig:KEGG-enrichment-with-enriched-genes) (下方图) 为图KEGG enrichment with enriched genes概览。

**(对应文件为 `Figure+Table/KEGG-enrichment-with-enriched-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/KEGG-enrichment-with-enriched-genes.pdf}
\caption{KEGG enrichment with enriched genes}\label{fig:KEGG-enrichment-with-enriched-genes}
\end{center}

Figure \@ref(fig:GSEA-plot-of-the-pathways) (下方图) 为图GSEA plot of the pathways概览。

**(对应文件为 `Figure+Table/GSEA-plot-of-the-pathways.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/GSEA-plot-of-the-pathways.pdf}
\caption{GSEA plot of the pathways}\label{fig:GSEA-plot-of-the-pathways}
\end{center}

### 表观修饰靶点 {#epi-tar}

这三条通路存在的表观遗传学修饰靶点为：

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Adipocytokine signaling pathway
:}

\vspace{0.5em}

    PRKAB1

\vspace{2em}


\textbf{
MAPK signaling pathway
:}

\vspace{0.5em}

    MAP3K7, GADD45B

\vspace{2em}


\textbf{
IL-17 signaling pathway
:}

\vspace{0.5em}

    MAP3K7

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/unnamed-chunk-40-content`)**

### 上下游 {#epi-path}

Figure \@ref(fig:Hsa04920-visualization) (下方图) 为图Hsa04920 visualization概览。

**(对应文件为 `Figure+Table/hsa04920.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-22_17_39_29.870039/hsa04920.pathview.png}
\caption{Hsa04920 visualization}\label{fig:Hsa04920-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04920}

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:Hsa04010-visualization) (下方图) 为图Hsa04010 visualization概览。

**(对应文件为 `Figure+Table/hsa04010.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-22_17_39_29.870039/hsa04010.pathview.png}
\caption{Hsa04010 visualization}\label{fig:Hsa04010-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04010}

\vspace{2em}
\end{tcolorbox}
\end{center}

Figure \@ref(fig:Hsa04657-visualization) (下方图) 为图Hsa04657 visualization概览。

**(对应文件为 `Figure+Table/hsa04657.pathview.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-03-22_17_39_29.870039/hsa04657.pathview.png}
\caption{Hsa04657 visualization}\label{fig:Hsa04657-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04657}

\vspace{2em}
\end{tcolorbox}
\end{center}

### 相关成分

Figure \@ref(fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway) (下方图) 为图SLBJ network pharmacology Target epigenetic related pathway概览。

**(对应文件为 `Figure+Table/SLBJ-network-pharmacology-Target-epigenetic-related-pathway.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SLBJ-network-pharmacology-Target-epigenetic-related-pathway.pdf}
\caption{SLBJ network pharmacology Target epigenetic related pathway}\label{fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway}
\end{center}

Table \@ref(tab:SLBJ-network-pharmacology-Target-epigenetic-related-pathway-data) (下方表格) 为表格SLBJ network pharmacology Target epigenetic related pathway data概览。

**(对应文件为 `Figure+Table/SLBJ-network-pharmacology-Target-epigenetic-related-pathway-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有42行3列，以下预览的表格可能省略部分数据；表格含有8个唯一`Herb\_pinyin\_name'。
\end{tcolorbox}
\end{center}

Table: (\#tab:SLBJ-network-pharmacology-Target-epigenetic-related-pathway-data)SLBJ network pharmacology Target epigenetic related pathway data

|Herb_pinyin_name |Ingredient.name   |Target.name |
|:----------------|:-----------------|:-----------|
|JIE GENG         |adeninenucleoside |MAP3K7      |
|JIE GENG         |adeninenucleoside |MAP3K7      |
|JIE GENG         |adeninenucleoside |MAP3K7      |
|JIE GENG         |adeninenucleoside |MAP3K7      |
|REN SHEN         |adeninenucleoside |MAP3K7      |
|REN SHEN         |adeninenucleoside |MAP3K7      |
|REN SHEN         |adeninenucleoside |MAP3K7      |
|REN SHEN         |adeninenucleoside |MAP3K7      |
|SHAN YAO         |adeninenucleoside |MAP3K7      |
|SHAN YAO         |adeninenucleoside |MAP3K7      |
|SHAN YAO         |adeninenucleoside |MAP3K7      |
|SHAN YAO         |adeninenucleoside |MAP3K7      |
|JIE GENG         |betulin           |PRKAB1      |
|JIE GENG         |betulin           |PRKAB1      |
|JIE GENG         |betulin           |PRKAB1      |
|...              |...               |...         |



## 分子对接

### 第一批对接

根据 HERB 数据库记录的成分靶点信息，
Fig. \@ref(fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway)
中的成分能作用于其对应的靶点。
以下尝试分子对接。


Figure \@ref(fig:FIRST-Overall-combining-Affinity) (下方图) 为图FIRST Overall combining Affinity概览。

**(对应文件为 `Figure+Table/FIRST-Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FIRST-Overall-combining-Affinity.pdf}
\caption{FIRST Overall combining Affinity}\label{fig:FIRST-Overall-combining-Affinity}
\end{center}

Fig. \@ref(fig:FIRST-Overall-combining-Affinity) 显示，候选分子与对应靶点的对接能量均较大。



### 以口服利用度筛选其他成分

由于 Fig. \@ref(fig:FIRST-Overall-combining-Affinity) 所示对接能量过大，
以下尝试挖掘复方中其它能够作用于 Fig. \@ref(fig:SLBJ-network-pharmacology-Target-epigenetic-related-pathway)
表观遗传修饰靶点的成分。

以下通过 HOB 筛选成分 (预测是否达到 20% HOB)。

Figure \@ref(fig:HOB-20-prediction) (下方图) 为图HOB 20 prediction概览。

**(对应文件为 `Figure+Table/HOB-20-prediction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HOB-20-prediction.pdf}
\caption{HOB 20 prediction}\label{fig:HOB-20-prediction}
\end{center}



### 第二批对接 {#dock2}

对于 Fig. \@ref(fig:HOB-20-prediction) 满足 HOB 条件的化合物，尝试分子对接；
然而由于化合物数量过多，运算过于将过于耗时，这里，以 ChemmineR 对化合物结构聚类 (0.4 cut-off) ，
每个聚类团随机抽取三个化合物，最后用于分子对接。

实际对接的有：

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
543854
:}

\vspace{0.5em}

    7NTI, 7MYJ, gadd45b

\vspace{2em}


\textbf{
480873
:}

\vspace{0.5em}

    7NTI, 7MYJ, gadd45b

\vspace{2em}


\textbf{
6992244
:}

\vspace{0.5em}

    7NTI, 7MYJ, gadd45b

\vspace{2em}


\textbf{
6553876
:}

\vspace{0.5em}

    7NTI, 7MYJ, gadd45b

\vspace{2em}


\textbf{
20055133
:}

\vspace{0.5em}

    7NTI, 7MYJ, gadd45b

\vspace{2em}


\textbf{
(Others)
:}

\vspace{0.5em}

    ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/unnamed-chunk-51-content`)**

对每个靶点都选择了对接能量最小的 Top 5，结果如下：

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

### 对接可视化  (Top 3)

Figure \@ref(fig:Docking-72326-into-GADD45B) (下方图) 为图Docking 72326 into GADD45B概览。

**(对应文件为 `Figure+Table/72326_into_GADD45B.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/72326_into_GADD45B/72326_into_GADD45B.png}
\caption{Docking 72326 into GADD45B}\label{fig:Docking-72326-into-GADD45B}
\end{center}

Figure \@ref(fig:Docking-12313579-into-GADD45B) (下方图) 为图Docking 12313579 into GADD45B概览。

**(对应文件为 `Figure+Table/12313579_into_GADD45B.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/12313579_into_GADD45B/12313579_into_GADD45B.png}
\caption{Docking 12313579 into GADD45B}\label{fig:Docking-12313579-into-GADD45B}
\end{center}

Figure \@ref(fig:Docking-5316891-into-GADD45B) (下方图) 为图Docking 5316891 into GADD45B概览。

**(对应文件为 `Figure+Table/5316891_into_GADD45B.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/5316891_into_GADD45B/5316891_into_GADD45B.png}
\caption{Docking 5316891 into GADD45B}\label{fig:Docking-5316891-into-GADD45B}
\end{center}



