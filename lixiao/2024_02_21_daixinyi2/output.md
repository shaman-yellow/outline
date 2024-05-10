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
\begin{center} \textbf{\Huge HNRNPH1、Wnt
与瘢痕增生的关联性挖掘} \vspace{4em}
\begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-05-10}}
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

1. 客户的 RNA-seq 数据集，以 DEGs 建立 PPI 网络，试分析 HNRNPH1 的作用，以及 wnt 通路。
2. scRNA-seq (可能需要两组数据，瘢痕增生 (SH) 和正常组织), HNRNPH1 的作用，免疫细胞的行为，免疫细胞的 DEGs。
  - 拟时分析，HNRNPH1 的拟时表达变化等
  - 细胞通讯，巨噬细胞等的通讯，Wnt 通路相关基因的表达和通讯
3. 姜黄素对 HNRNPH1 的作用 (直接作用还是间接，是否可以结合，可以尝试分子对接，或者从转录因子角度出发)
4. 视结果整理，可做一些新的分析，或探究一些新的方法。
5. 提供分析源代码



## 结果

1. 差异分析和 PPI 发现，姜黄素可对 HNRNPH1 和 Wnt 通路的基因具调控作用，且 HNRNPH1 和 Wnt 以 TP53 存在直接互作联系。
2. scRNA-seq 数据分析，未发现 HNRNPH1 的差异表达；发现了以 APCDD1 为代表的 Wnt 通路基因的表达量变化，且关联斑痕增生。
   拟时分析表明，拟时末期 APCDD1 在 Fibroblast 中表达量显著上升 (Top 2) 。而姜黄素的 RNA-seq 数据集中，APCDD1 表达量
   下调。APCDD1 表现为经典 Wnt 通路抑制作用。以上表明，Curcumin 可通过下调 APCDD1，激活经典 Wnt 通路，改善斑痕增生。
3. 分子对接进一步发现了，Curcumin 与 APCDD1 蛋白的优异结合能，说明 Curcumin 可能通过直接结合 APCDD1 发挥调控作用。
4. 额外的分析已包含在上述各部分中。
5. 本文档提供了与图表一一对应的分析源代码。
   如果客户需要根据源代码重现分析，请注意，所有的源代码和分析均实现于 Linux 系统 (Pop!\_OS 22.04 LTS)。
   更多系统和 R 配置信息请参考 \@ref(session)。
   此外，本分析涉及的软件和代码的简要说明见 \@ref(code)

详见 \@ref(results)

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料

All used GEO expression data and their design:

- **GSE156326**: Single-cell transcriptome of human hypertrophic scars and human skin, and 6 and 8 weeks old mouse scars
>>> Raw data are unvailable due to patient privacy concerns <<<

## 方法

Mainly used method:

- R package `CellChat` used for cell communication analysis[@InferenceAndAJinS2021].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- R package `ClusterProfiler` used for GSEA enrichment[@ClusterprofilerWuTi2021].
- GEO <https://www.ncbi.nlm.nih.gov/geo/> used for expression dataset aquisition.
- R package `Limma` and `edgeR` used for differential expression analysis[@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- R package `Monocle3` used for cell pseudotime analysis[@ReversedGraphQiuX2017; @TheDynamicsAnTrapne2014].
- The R package `Seurat` used for scRNA-seq processing[@IntegratedAnalHaoY2021; @ComprehensiveIStuart2019].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- R package `pathview` used for KEGG pathways visualization[@PathviewAnRLuoW2013].
- The MCC score was calculated referring to algorithm of `CytoHubba`[@CytohubbaIdenChin2014].
- `SCSA` (python) used for cell type annotation[@ScsaACellTyCaoY2020].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

## HNRNPH1、Wnt 与 PPI 网络分析

对姜黄素 (Curcumin) 的 mRNA 数据集进行差异分析， Fig. \@ref(fig:MAIN-Fig-1)a，
Wnt 通路为 Fig. \@ref(fig:MAIN-Fig-1)c，所示，Curcumin 可以调控 Wnt 中的多个基因。
将 HNRNPH1 与 Wnt 的各个调控基因建立 PPI 网络 (Phisical 网络) 。发现 HNRNPH1 与 TP53 存在直接作用。
而 TP53 与其它 Wnt 蛋白存在互作。



```r
fig1 <- cls(
  cl("./Figure+Table/Treat-vs-control-DEGs.pdf",
    "./Figure+Table/PPI-HNRNPH1-and-Wnt.pdf"),
  cl("./Figure+Table/DEG-hsa04310-visualization.png")
)
render(fig1)
```

Figure \@ref(fig:MAIN-Fig-1) (下方图) 为图MAIN Fig 1概览。

**(对应文件为 `./Figure+Table/fig1.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig1.pdf}
\caption{MAIN Fig 1}\label{fig:MAIN-Fig-1}
\end{center}

## HNRNPH1、Wnt 与斑痕的 scRNA-seq 分析

分析 GSE156326 的两组数据 (Scar 和 Skin) ，以 Seurat 初步分析，细胞聚类后注释如 Fig. \@ref(fig:SCSA-Cell-type-annotation)a 所示。
对 Scar 和 Skin 的各类细胞进行差异分析，见 Tab. \@ref(tab:DEGs-of-the-contrasts)，探究 HNRNPH1 和 Wnt 通路
各个基因的表达，发现 HNRNPH1 为非差异表达基因  (Fig. \@ref(fig:MAIN-Fig-2)b 。
而在 Fibroblast 细胞和 pericyte 细胞中，共有 6 个差异表达基因  (Fig. \@ref(fig:MAIN-Fig-2)c) 。
再对这 6 个基因的进一步考察中 (Fibroblast 细胞) ，发现 APCDD1 集中表达于特定区域 (Fig. \@ref(fig:MAIN-Fig-3)a) ，而其它
基因不具备此特点。

提取 Fibroblast 细胞并重聚类，以 Monocle3 进行拟时分析。这里将 APCDD1 高表达的区域定为拟时终点，随后我们发现
Fibroblast 可以主要分为 2 大 Branch，向拟时终点变化 (Fig. \@ref(fig:MAIN-Fig-3)b) 。
绘制 APCDD1 沿拟时轨迹的表达量变化可以发现，APCDD1 在拟时末期时呈上升趋势。进一步探究其来源可以发现，
APCDD1 在拟时末期时，主要在 Scar 中表达量增加。而结合 Fig. \@ref(fig:MAIN-Fig-1)c 可以知道，Curcumin 是可以
下调 APCDD1 的表达量。可以推测，Curcumin 对 Fibroblast 细胞 APCDD1 的下调作用，可能改善瘢痕增生。

随后，根据 Fibroblast 拟时图  (Fig. \@ref(fig:MAIN-Fig-3)b) 进行差异分析 (Graph test) 。
结果见 Tab. \@ref(tab:graph-test-significant-results)。其中，APCDD1 为 Top 2 的差异基因。
将 Top 50 的差异基因分 2 个分支 (根据 Fig. \@ref(fig:MAIN-Fig-2)) 绘制拟时热图 (Fig. \@ref(fig:MAIN-Fig-4)) ，
并结合了这些基因在 GO 的富集和是否存在于 Wnt 通路以及 Curcumin 是否对其有调控作用。
在这些基因中，APCDD1 和 JUN 基因属于 Wnt 通路，在 Curcumin 的数据中，仅 APCDD1 表现出被
Curcumin 调控表达量变化，为下调趋势。而其余差异基因与 Collagen、ECM 等相关。这些都可能是
与瘢痕增生密切关联的通路。

结合 Fig. \@ref(fig:MAIN-Fig-3)c，将 Fibroblast Pseudotime &gt; 10 的细胞分为 FB:ends, &lt; 10 的细胞分为
FB:begins, 和其他细胞做 CellChat 细胞通讯分析，以发现两部分细胞的差异点 (见 Fig. \@ref(fig:MAIN-Fig-5)a 和 b，
代表通讯数量和权重 (count，weight)) 。
在这些细胞中，COLLAGEN 通路在输入和输出通路都为强度最高的通路 (Fig. \@ref(fig:MAIN-Fig-5)c、d)。 
随后，我们对比了 FB:begins 和 FB:ends 和两种免疫细胞 Macrophage 和 Dendritic Cell 的通讯通路差异。
这些通路包括：CD99, COLLAGEN, MIF, MK (COLLAGEN 的通讯见 Fig. \@ref(fig:MAIN-Fig-5)e，其余可见 \@ref(diff-chat))。

由于 APCDD1 为 Fibroblast 显著差异表达基因 (Top 2) ，这里推测在 Scar 中上调的 APCDD1 所抑制的 Wnt 通路
会对 Fibroblast 与 免疫细胞之间的通讯带来调控效果。
因此，我们将 CD99, COLLAGEN, MIF, MK 所涉及的受体配体的基因，与 Wnt 通路的基因 (Curcumin 可调控的) 
创建功能关联的 PPI 网络，并且将 Curcumin RNA-seq 数据集中，这些基因的表达量变化映射为 Log~2~(FC)。
随后发现，Wnt 通路基因与上述这些受体配体蛋白存在诸多互作关系，且其中 CD44 可能受姜黄素调控影响。




```r
fig2 <- cl(
  rw("./Figure+Table/SCSA-Cell-type-annotation.pdf",
    "./Figure+Table/Violing-plot-of-expression-level-of-the-HNRNPH1.pdf"),
  rw("./Figure+Table/Violing-plot-of-Wnt-DEGs-of-Curcumin-affected.pdf")
)
render(fig2)
```

Figure \@ref(fig:MAIN-Fig-2) (下方图) 为图MAIN Fig 2概览。

**(对应文件为 `./Figure+Table/fig2.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig2.pdf}
\caption{MAIN Fig 2}\label{fig:MAIN-Fig-2}
\end{center}


```r
fig3 <- cls(
  cl("./Figure+Table/Dimension-plot-of-expression-level-of-the-Wnt-Degs.pdf"),
  cl("./Figure+Table/Pseudotime.pdf",
    "./Figure+Table/APCDD1-pseudotime-curve.pdf",
    "./Figure+Table/APCDD1-pseudotime-density.pdf")
)
render(fig3)
```

Figure \@ref(fig:MAIN-Fig-3) (下方图) 为图MAIN Fig 3概览。

**(对应文件为 `./Figure+Table/fig3.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig3.pdf}
\caption{MAIN Fig 3}\label{fig:MAIN-Fig-3}
\end{center}

Figure \@ref(fig:MAIN-Fig-4) (下方图) 为图MAIN Fig 4概览。

**(对应文件为 `./Figure+Table/Pseudotime-heatmap-of-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/Pseudotime-heatmap-of-genes.pdf}
\caption{MAIN Fig 4}\label{fig:MAIN-Fig-4}
\end{center}


```r
fig5 <- cl(
  # rw(),
  rw("./Figure+Table/Overall-communication-count.pdf",
    "./Figure+Table/Overall-communication-weight.pdf"),
  rw("./Figure+Table/ligand-receptor-roles/2_incoming.pdf",
    "./Figure+Table/ligand-receptor-roles/1_outgoing.pdf"),
  rw("./Figure+Table/Diff-path-COLLAGEN.pdf",
    "./Figure+Table/PPI-Wnt-LR.pdf")
)
render(fig5)
```

Figure \@ref(fig:MAIN-Fig-5) (下方图) 为图MAIN Fig 5概览。

**(对应文件为 `./Figure+Table/fig5.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig5.pdf}
\caption{MAIN Fig 5}\label{fig:MAIN-Fig-5}
\end{center}


## HNRNPH1、Wnt 与姜黄素

结合上述发现，Curcumin 可能作用 APCDD1 发挥改善瘢痕增生作用。
这种作用既可能是直接结合，也可能是间接作用。分子对接可以用以探究药物直接结合蛋白的可能性。
这里，我们将 Curcumin 与包括 APCDD1 在内的诸多 Wnt 通路的蛋白，以及 HNRNPH1 蛋白做分子对接。
对接亲和能见 Fig. \@ref(fig:MAIN-Fig-6)a 所示，APCDD1 有着与 Curcumin 优异的亲和性，且在
对接结果中排名最高 (对接图见 Fig. \@ref(fig:MAIN-Fig-6)b 和 c)。因此，Curcumin 将可能通过
直接结合 APCDD1 蛋白发挥其表达量调控作用，进而改善斑痕增生。



```r
fig6 <- cls(
  # rw(),
  cl("./Figure+Table/Overall-combining-Affinity.pdf"),
  cl("./Figure+Table/Docking-969516-into-APCDD1.png",
    "./Figure+Table/Docking-969516-into-APCDD1-detail.png")
)
render(fig6)
```

Figure \@ref(fig:MAIN-Fig-6) (下方图) 为图MAIN Fig 6概览。

**(对应文件为 `./Figure+Table/fig6.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{./Figure+Table/fig6.pdf}
\caption{MAIN Fig 6}\label{fig:MAIN-Fig-6}
\end{center}






# 结论 {#dis}

# 附：分析流程 {#workflow}

## 关于源代码的说明 {#code}

### 生成该 PDF 文档的源代码 

注：请忽略其中包含 `include = F`, 或者函数 `set_cover`, `set_index` 等的 R 代码块。 

 
`Output RMarkdown' 数据已提供。

**(对应文件为 `output.Rmd`)**

 
`Output Tex' 数据已提供。

**(对应文件为 `output.tex`)**

### 环境变量配置

大部分程序为 R 代码，但少数 (SCSA 注释、分子对接工具组) 等涉及了其它工具。
如果需要使用本文档提供的代码复现这些分析，请确保使用的是 Linux 系统，
且以下程序可运行
(即，通过 R 的 `system` 命令可以成功运行它们，例如 `system("mk_prepare_ligand.py")`,
你需要做的是安装这些程序，并配置到环境变量，例如 export 到 `.bashrc` 中。
)：


```r
list(
  mk_prepare_ligand.py = "mk_prepare_ligand.py",
  prepare_gpf.py = "prepare_gpf.py",
  autogrid4 = "autogrid4",
  scsa = "python3 ~/SCSA/SCSA.py",
  pymol = "pymol",
  obgen = "obgen"
)
```

### R 包

本文档使用的代码均为重新封装后的代码，而不是对应软件的原始代码。
因此，要复现本文档中的源代码，你需要加载这些代码的函数。
所有的函数提供在了 `utils.tool` (如没有明确的理由，请不要修改移动其中的任意文件，否则会出错) 中。

 
`R package files' 数据已全部提供。

**(对应文件为 `./utils.tool`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./utils.tool共包含6个文件。

\begin{enumerate}\tightlist
\item DESCRIPTION
\item LICENSE
\item LICENSE.md
\item NAMESPACE
\item R
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

当有需要运行本文档的任意代码时，请先使用以下代码加载该 R 包：
(若提示缺少依赖包，请自行安装它们，通过 `BiocManager::install` 或者 `devtools::install_github`) 


```r
devtools::load_all("./utils.tool")
```

## 关于本文档源代码中涉及的文件

 
`External files' 数据已全部提供。

**(对应文件为 `./material`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./material共包含5个文件。

\begin{enumerate}\tightlist
\item APCDD1.pdb
\item PLCB4.pdb
\item PRICKLE1
\item PRICKLE1.pdb
\item quant\_hg38\_mrna
\end{enumerate}\end{tcolorbox}
\end{center}

## HNRNPH1、Wnt 与 PPI 网络分析

### 姜黄素的 mRNA-seq 数据


```r
## file.copy("~/outline/lixiao/2023_07_07_eval/quant_hg38_mrna", "./material/", recursive = T)
lst_mrna <- read_kall_quant("../material/quant_hg38_mrna")

lst_mrna$metadata <- dplyr::mutate(lst_mrna$metadata,
  group = ifelse(grpl(sample, "^CT"), "control", "treat")
)
lst_mrna$metadata
lst_mrna$genes

mart <- new_biomart()
lst_mrna$genes <- filter_biomart(mart, general_attrs(F, T),
  "ensembl_transcript_id", lst_mrna$counts$target_id
)
```

### DEGs


```r
lm <- job_limma(new_dge(lst_mrna$metadata, lst_mrna$counts, lst_mrna$genes))
lm <- step1(lm)
lm <- step2(lm, treat - control, use = "P.Value", use.cut = .05, cut.fc = 1)
Tops <- lm@tables$step2$tops$`treat - control`
dplyr::filter(Tops, hgnc_symbol == "HNRNPH1")[, -(1:4)]
Tops
```

Figure \@ref(fig:Treat-vs-control-DEGs) (下方图) 为图Treat vs control DEGs概览。

**(对应文件为 `Figure+Table/Treat-vs-control-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Treat-vs-control-DEGs.pdf}
\caption{Treat vs control DEGs}\label{fig:Treat-vs-control-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
P.Value cut-off
:}

\vspace{0.5em}

    0.05

\vspace{2em}


\textbf{
Log2(FC) cut-off
:}

\vspace{0.5em}

    1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Treat-vs-control-DEGs-content`)**

Table \@ref(tab:Data-treat-vs-control-DEGs) (下方表格) 为表格Data treat vs control DEGs概览。

**(对应文件为 `Figure+Table/Data-treat-vs-control-DEGs.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1598行16列，以下预览的表格可能省略部分数据；含有1598个唯一`rownames；含有1300个唯一`hgnc\_symbol'。
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

Table: (\#tab:Data-treat-vs-control-DEGs)Data treat vs control DEGs

|rownames |ensemb......2 |ensemb......3 |entrez... |hgnc_s... |refseq... |chromo... |start_... |end_po... |... |
|:--------|:-------------|:-------------|:---------|:---------|:---------|:---------|:---------|:---------|:---|
|36302    |ENST00...     |ENSG00...     |23657     |SLC7A11   |NM_014331 |4         |138164097 |138242349 |... |
|139079   |ENST00...     |ENSG00...     |1728      |NQO1      |NM_000903 |16        |69706996  |69726668  |... |
|109115   |ENST00...     |ENSG00...     |3486      |IGFBP3    |          |7         |45912245  |45921874  |... |
|138968   |ENST00...     |ENSG00...     |3880      |KRT19     |NM_002276 |17        |41523617  |41528308  |... |
|111841   |ENST00...     |ENSG00...     |682       |BSG       |NM_198589 |19        |571277    |583494    |... |
|174056   |ENST00...     |ENSG00...     |3488      |IGFBP5    |NM_000599 |2         |216672105 |216695549 |... |
|139083   |ENST00...     |ENSG00...     |1728      |NQO1      |          |16        |69706996  |69726668  |... |
|161824   |ENST00...     |ENSG00...     |4176      |MCM7      |NM_005916 |7         |100092233 |100101940 |... |
|85389    |ENST00...     |ENSG00...     |9537      |TP53I11   |NM_001... |11        |44885903  |44951306  |... |
|6443     |ENST00...     |ENSG00...     |128239    |IQGAP3    |NM_178229 |HG2515... |83962     |131161    |... |
|158307   |ENST00...     |ENSG00...     |128239    |IQGAP3    |NM_178229 |1         |156525405 |156572604 |... |
|94816    |ENST00...     |ENSG00...     |3838      |KPNA2     |NM_002266 |17        |68035636  |68047364  |... |
|66013    |ENST00...     |ENSG00...     |899       |CCNF      |NM_001... |16        |2429394   |2458854   |... |
|139080   |ENST00...     |ENSG00...     |1728      |NQO1      |NM_001... |16        |69706996  |69726668  |... |
|68497    |ENST00...     |ENSG00...     |2512      |FTL       |NM_000146 |19        |48965309  |48966879  |... |
|...      |...           |...           |...       |...       |...       |...       |...       |...       |... |

### wnt 信号通路


```r
en.deg <- job_enrich(Tops$hgnc_symbol)
en.deg <- step1(en.deg)
en.deg <- step2(en.deg, "hsa04310",
  gene.level = dplyr::select(Tops, hgnc_symbol, logFC)
)
en.deg@plots$step2$p.pathviews$hsa04310

genes.wnt <- dplyr::filter(en.deg@tables$step1$res.kegg$ids, ID == "hsa04310")
genes.wnt <- dplyr::select(genes.wnt, ID, Description, geneName_list)
genes.wnt <- reframe_col(genes.wnt, "geneName_list", function(x) x[[1]])
genes.wnt
```

Figure \@ref(fig:DEG-hsa04310-visualization) (下方图) 为图DEG hsa04310 visualization概览。

**(对应文件为 `Figure+Table/DEG-hsa04310-visualization.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{pathview2024-04-24_15_53_05.50473/hsa04310.pathview.png}
\caption{DEG hsa04310 visualization}\label{fig:DEG-hsa04310-visualization}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Interactive figure
:}

\vspace{0.5em}

    \url{https://www.genome.jp/pathway/hsa04310}

\vspace{2em}


\textbf{
Enriched genes
:}

\vspace{0.5em}

    NFATC4, PPP3CA, CAMK2D, PLCB4, DAAM1, DVL2, PRICKLE1,
EP300, CHD8, CUL1, SKP1, APC, TP53, CTNNB1, PSEN1, CSNK2A1,
APCDD1, MCC

\vspace{2em}
\end{tcolorbox}
\end{center}

Table \@ref(tab:Genes-Wnt-Curcumin-affected) (下方表格) 为表格Genes Wnt Curcumin affected概览。

**(对应文件为 `Figure+Table/Genes-Wnt-Curcumin-affected.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有20行3列，以下预览的表格可能省略部分数据；含有1个唯一`ID'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Genes-Wnt-Curcumin-affected)Genes Wnt Curcumin affected

|ID       |Description           |geneName_list |
|:--------|:---------------------|:-------------|
|hsa04310 |Wnt signaling pathway |APC           |
|hsa04310 |Wnt signaling pathway |APCDD1        |
|hsa04310 |Wnt signaling pathway |CAMK2D        |
|hsa04310 |Wnt signaling pathway |CAMK2G        |
|hsa04310 |Wnt signaling pathway |CHD8          |
|hsa04310 |Wnt signaling pathway |CSNK2A1       |
|hsa04310 |Wnt signaling pathway |CSNK2B        |
|hsa04310 |Wnt signaling pathway |CTNNB1        |
|hsa04310 |Wnt signaling pathway |CUL1          |
|hsa04310 |Wnt signaling pathway |DAAM1         |
|hsa04310 |Wnt signaling pathway |DVL2          |
|hsa04310 |Wnt signaling pathway |EP300         |
|hsa04310 |Wnt signaling pathway |MCC           |
|hsa04310 |Wnt signaling pathway |NFATC4        |
|hsa04310 |Wnt signaling pathway |PLCB4         |
|...      |...                   |...           |

### 构建 PPI 网络

#### DEGs PPI


```r
sdb.deg <- job_stringdb(Tops$hgnc_symbol)
sdb.deg <- step1(sdb.deg)
sdb.deg@plots$step1$p.ppi
```

#### HNRNPH1 与 Wnt 通路

注：这里的 PPI 网络为 physical, 即 HNRNPH1 与 Wnt 蛋白之间的直接结合性。


```r
# filter the PPI network
lstPPI <- filter(sdb.deg, genes.wnt$geneName_list, "HNRNPH1",
  level.x = dplyr::select(Tops, hgnc_symbol, logFC),
  top = NULL, keep.ref = T, arrow = F, HLs = "HNRNPH1",
  label.shape = c(from = "Curcumin_Wnt", to = "HNRNPH1")
)

lstPPI$p.mcc
```

Figure \@ref(fig:PPI-HNRNPH1-and-Wnt) (下方图) 为图PPI HNRNPH1 and Wnt概览。

**(对应文件为 `Figure+Table/PPI-HNRNPH1-and-Wnt.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-HNRNPH1-and-Wnt.pdf}
\caption{PPI HNRNPH1 and Wnt}\label{fig:PPI-HNRNPH1-and-Wnt}
\end{center}

## HNRNPH1、Wnt 与斑痕的 scRNA-seq 分析

### 数据来源


```r
# Dowload data from GEO
geo.sc <- job_geo("GSE156326")
geo.sc <- step1(geo.sc)
geo.sc@params$guess
geo.sc <- step2(geo.sc)
untar("./GSE156326/GSE156326_RAW.tar", exdir = "./GSE156326")
prepare_10x("./GSE156326/", "GSM4729097_human_skin_1")
prepare_10x("./GSE156326/", "GSM4729100_human_scar_1")
```

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Data Source ID
:}

\vspace{0.5em}

    GSE156326

\vspace{2em}


\textbf{
data\_processing
:}

\vspace{0.5em}

    Raw sequencing data were demultiplexed, aligned to a
reference genome (GrCh38/mm10) and counted using Cell
Ranger (version 3.0.2; 10x Genomics).
    Raw sequencing data were demultiplexed, aligned to a
reference genome (GrCh38/mm10) and counted using Cell
Ranger (version 3.0.2; 10x Genomics).

\vspace{2em}


\textbf{
data\_processing.1
:}

\vspace{0.5em}

    Genome\_build: GrCh38/mm10
    Genome\_build: Genome\_build: GrCh38/mm10

\vspace{2em}


\textbf{
data\_processing.2
:}

\vspace{0.5em}

    Supplementary\_files\_format\_and\_content: mtx (count
matrix in sparse matrix format), barcodes.tsv (barcode
ids), features.tsv: (gene ids)
    Supplementary\_files\_format\_and\_content:
Supplementary\_files\_format\_and\_content: mtx (count matrix
in sparse matrix format), barcodes.tsv (barcode ids),
features.tsv: (gene ids)

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/SC-GSE156326-content`)**

### 细胞聚类和鉴定


```r
# sr.scar <- job_seurat("./GSE156326/GSM4729100_human_scar_1_barcodes")
# sr.scar <- step1(sr.scar)
# sr.scar@plots$step1$p.qc
# sr.scar <- step2(sr.scar, 0, 5000, 20)
# 
# sr.skin <- job_seurat("./GSE156326/GSM4729097_human_skin_1_barcodes")
# sr.skin <- step1(sr.skin)
# sr.skin@plots$step1$p.qc
# rm(sr.skin, sr.scar)

sr <- job_seuratn(c("./GSE156326/GSM4729100_human_scar_1_barcodes",
    "./GSE156326/GSM4729097_human_skin_1_barcodes"),
  c("Scar", "Skin"))

sr <- step1(sr, 0, 5000, 20)
sr <- step2(sr)
sr@plots$step2$p.pca_rank
sr <- step3(sr, 1:15, 1.2)
sr@plots$step3$p.umap
sr <- step4(sr, "")
sr <- step5(sr)
# SCSA for cell type annotation
sr <- step6(sr, "Skin")
sr@plots$step6$p.map_scsa
```

Figure \@ref(fig:UMAP-Clustering) (下方图) 为图UMAP Clustering概览。

**(对应文件为 `Figure+Table/UMAP-Clustering.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/UMAP-Clustering.pdf}
\caption{UMAP Clustering}\label{fig:UMAP-Clustering}
\end{center}

Figure \@ref(fig:SCSA-Cell-type-annotation) (下方图) 为图SCSA Cell type annotation概览。

**(对应文件为 `Figure+Table/SCSA-Cell-type-annotation.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/SCSA-Cell-type-annotation.pdf}
\caption{SCSA Cell type annotation}\label{fig:SCSA-Cell-type-annotation}
\end{center}

### 差异分析


```r
sr <- mutate(sr, group_cellType = paste0(orig.ident, "_", make.names(scsa_cell)))
contrasts.sr <- lapply(make.names(ids(sr)), function(x) paste0(c("Scar", "Skin"), "_", x))
contrasts.sr

sr <- diff(sr, "group_cellType", contrasts.sr, name = "HN_group")
sr@params$HN_group
```

Table \@ref(tab:DEGs-of-the-contrasts) (下方表格) 为表格DEGs of the contrasts概览。

**(对应文件为 `Figure+Table/DEGs-of-the-contrasts.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4863行7列，以下预览的表格可能省略部分数据；含有9个唯一`contrast'。
\end{tcolorbox}
\end{center}

Table: (\#tab:DEGs-of-the-contrasts)DEGs of the contrasts

|contrast      |p_val         |avg_log2FC    |pct.1 |pct.2 |p_val_adj     |gene       |
|:-------------|:-------------|:-------------|:-----|:-----|:-------------|:----------|
|Scar_Hemat... |3.26093311... |-0.2786380... |0.002 |1     |0.00097827... |ST6GALNAC6 |
|Scar_Hemat... |4.83497164... |2.72042542... |0.01  |0.222 |0.00145049... |CCL19      |
|Scar_Hemat... |4.97701805... |2.36267982... |0.01  |0.889 |0.00149310... |PPP1R12B   |
|Scar_Hemat... |6.54317478... |-0.7858693... |0.015 |0.111 |0.00196295... |HLA-DMB    |
|Scar_Hemat... |6.54317478... |7.81465650... |0.015 |0.778 |0.00196295... |SNX10      |
|Scar_Hemat... |1.01658537... |3.50570583... |0.012 |0.333 |0.00304975... |HHEX       |
|Scar_Hemat... |1.04560332... |-0.3003328... |0.024 |1     |0.00313680... |BCL9L      |
|Scar_Hemat... |1.04564108... |1.40598233... |0.024 |1     |0.00313692... |CHSY1      |
|Scar_Hemat... |1.10616882... |8.49062033... |0.022 |0.667 |0.00331850... |NTRK2      |
|Scar_Hemat... |1.32705918... |2.57196817... |0.012 |0.778 |0.00398117... |TRIM25     |
|Scar_Hemat... |1.34570508... |2.90265755... |0.022 |0.556 |0.00403711... |SLC40A1    |
|Scar_Hemat... |1.56816847... |8.08654102... |0.032 |0.889 |0.00470450... |ITPR1      |
|Scar_Hemat... |1.63472658... |4.54715445... |0.027 |0.222 |0.00490417... |TSPAN5     |
|Scar_Hemat... |1.72770803... |8.32439693... |0.039 |0.889 |0.00518312... |CD70       |
|Scar_Hemat... |1.72770803... |5.75361787... |0.034 |1     |0.00518312... |MTSS1      |
|...           |...           |...           |...   |...   |...           |...        |

#### HNRNPH1 的表达

HNRNPH1 在这批单细胞数据中，为非差异表达基因。


```r
p.mapHn_cell <- focus(sr, "HNRNPH1")
p.mapHn_group <- focus(sr, "HNRNPH1", "orig.ident")
wrap(p.mapHn_group$p.vln, 3, 4)

# No results
dplyr::filter(sr@params$HN_group, gene == "HNRNPH1")
```

Figure \@ref(fig:Violing-plot-of-expression-level-of-the-HNRNPH1) (下方图) 为图Violing plot of expression level of the HNRNPH1概览。

**(对应文件为 `Figure+Table/Violing-plot-of-expression-level-of-the-HNRNPH1.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Violing-plot-of-expression-level-of-the-HNRNPH1.pdf}
\caption{Violing plot of expression level of the HNRNPH1}\label{fig:Violing-plot-of-expression-level-of-the-HNRNPH1}
\end{center}

#### Wnt 通路基因的表达

- scRNA-seq, Scar vs Skin (Fibroblast, Pericyte), TP53 $\downarrow$, APCDD1 $\uparrow$
- RNA-seq, 姜黄素给药, TP53 $\uparrow$, APCDD1 $\downarrow$


```r
scDegs.wnt <- dplyr::filter(sr@params$HN_group, gene %in% genes.wnt$geneName_list)
scDegs.wnt

scCell.degWnt <- which(ids(sr, "scsa_cell", F) %in% c("Fibroblast", "Pericyte"))
scCell.degWnt

sr <- mutate(sr, cellType_group = gs(group_cellType, "^([^_]+)_(.*)", "\\2_\\1"))
p.hpWnt <- map(sr, scDegs.wnt$gene, group.by = "cellType_group", cells = scCell.degWnt)
p.hpWnt

p.focScDegWnt <- focus(getsub(sr, cells = scCell.degWnt),
  scDegs.wnt$gene, group.by = "cellType_group"
)
p.focScDegWnt$p.vln
```

Table \@ref(tab:Wnt-DEGs-of-Curcumin-affected) (下方表格) 为表格Wnt DEGs of Curcumin affected概览。

**(对应文件为 `Figure+Table/Wnt-DEGs-of-Curcumin-affected.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有8行7列，以下预览的表格可能省略部分数据；含有2个唯一`contrast'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Wnt-DEGs-of-Curcumin-affected)Wnt DEGs of Curcumin affected

|contrast      |p_val         |avg_log2FC    |pct.1 |pct.2 |p_val_adj     |gene   |
|:-------------|:-------------|:-------------|:-----|:-----|:-------------|:------|
|Scar_Fibro... |8.27560595... |3.85702595... |0.157 |0.584 |2.48268178... |NFATC4 |
|Scar_Fibro... |3.73579114... |1.64972906... |0.245 |0.317 |1.12073734... |APCDD1 |
|Scar_Fibro... |2.83791959... |1.52983006... |0.31  |0.362 |8.51375879... |CTNNB1 |
|Scar_Fibro... |2.54894125... |0.60325628... |0.112 |0.288 |7.64682377... |CAMK2D |
|Scar_Fibro... |4.69293478... |-2.8547127... |0.382 |0.133 |1.40788043... |SKP1   |
|Scar_Peric... |1.03782691... |2.97367652... |0.112 |0.863 |3.11348075... |NFATC4 |
|Scar_Peric... |5.43911467... |2.00598608... |0.216 |0.925 |1.63173440... |APCDD1 |
|Scar_Peric... |5.30098924... |-2.3467874... |0.052 |0.125 |0.00015902... |TP53   |

Figure \@ref(fig:Heatmap-show-the-Wnt-DEGs-of-Curcumin-affected) (下方图) 为图Heatmap show the Wnt DEGs of Curcumin affected概览。

**(对应文件为 `Figure+Table/Heatmap-show-the-Wnt-DEGs-of-Curcumin-affected.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Heatmap-show-the-Wnt-DEGs-of-Curcumin-affected.pdf}
\caption{Heatmap show the Wnt DEGs of Curcumin affected}\label{fig:Heatmap-show-the-Wnt-DEGs-of-Curcumin-affected}
\end{center}

Figure \@ref(fig:Violing-plot-of-Wnt-DEGs-of-Curcumin-affected) (下方图) 为图Violing plot of Wnt DEGs of Curcumin affected概览。

**(对应文件为 `Figure+Table/Violing-plot-of-Wnt-DEGs-of-Curcumin-affected.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Violing-plot-of-Wnt-DEGs-of-Curcumin-affected.pdf}
\caption{Violing plot of Wnt DEGs of Curcumin affected}\label{fig:Violing-plot-of-Wnt-DEGs-of-Curcumin-affected}
\end{center}

### 拟时分析

#### 拟时终点与 APCDD1

这里发现 Fig. \@ref(fig:Dimension-plot-of-expression-level-of-the-Wnt-Degs)
APCDD1 集中表达于一个区域，因此这里尝试将该区域选定为拟时终点。


```r
mn <- do_monocle(sr, "Fibroblast")
mn <- step1(mn, "cellType_group", pre = T)
wrap(mn@plots$step1$p.prin, 5, 4)

p.srSub_wnt <- focus(mn@params$sr_sub, scDegs.wnt$gene)
p.srSub_wnt$p.dim
```

Figure \@ref(fig:Principal-points) (下方图) 为图Principal points概览。

**(对应文件为 `Figure+Table/Principal-points.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Principal-points.pdf}
\caption{Principal points}\label{fig:Principal-points}
\end{center}

Figure \@ref(fig:Dimension-plot-of-expression-level-of-the-Wnt-Degs) (下方图) 为图Dimension plot of expression level of the Wnt Degs概览。

**(对应文件为 `Figure+Table/Dimension-plot-of-expression-level-of-the-Wnt-Degs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Dimension-plot-of-expression-level-of-the-Wnt-Degs.pdf}
\caption{Dimension plot of expression level of the Wnt Degs}\label{fig:Dimension-plot-of-expression-level-of-the-Wnt-Degs}
\end{center}

#### APCDD1 主要在 Scar 中高表达

随后发现，APCDD1 的确在拟时末期高表达，而且是主要在 Scar 组织中高表达，见
Fig. \@ref(fig:APCDD1-pseudotime-density)


```r
mn <- step2(mn, c("Y_3", "Y_6"))
mn@plots$step2$p.pseu

mn <- step3(mn, group.by = "seurat_clusters")
mn <- step4(mn, ids(mn), "APCDD1", "cellType_group")

mn@tables$step3$graph_test.sig
mn@plots$step4$genes_in_pseudotime$pseudo1
mn@plots$step4$plot_density$pseudo1
```

Figure \@ref(fig:Pseudotime) (下方图) 为图Pseudotime概览。

**(对应文件为 `Figure+Table/Pseudotime.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Pseudotime.pdf}
\caption{Pseudotime}\label{fig:Pseudotime}
\end{center}

Table \@ref(tab:graph-test-significant-results) (下方表格) 为表格graph test significant results概览。

**(对应文件为 `Figure+Table/graph-test-significant-results.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5090行6列，以下预览的表格可能省略部分数据；含有5090个唯一`gene\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item gene\_id:  GENCODE/Ensembl gene ID
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:graph-test-significant-results)Graph test significant results

|gene_id |status |p_value |morans_tes... |morans_I      |q_value |
|:-------|:------|:-------|:-------------|:-------------|:-------|
|CTHRC1  |OK     |0       |82.0068307... |0.49377906... |0       |
|APCDD1  |OK     |0       |81.8052541... |0.49183724... |0       |
|PI16    |OK     |0       |79.1167758... |0.47634067... |0       |
|IGFBP7  |OK     |0       |78.4677201... |0.47238376... |0       |
|FOS     |OK     |0       |78.0245837... |0.46974828... |0       |
|WISP2   |OK     |0       |77.1253098... |0.46433708... |0       |
|PDGFRL  |OK     |0       |74.1245797... |0.44626545... |0       |
|C1QTNF3 |OK     |0       |72.9964250... |0.43937764... |0       |
|FBLN1   |OK     |0       |69.0651449... |0.41554895... |0       |
|ELN     |OK     |0       |68.4719775... |0.41216524... |0       |
|MFAP5   |OK     |0       |68.3194338... |0.41124414... |0       |
|MMP2    |OK     |0       |68.3131206... |0.41117358... |0       |
|SEMA3B  |OK     |0       |64.3202720... |0.38704468... |0       |
|SOD2    |OK     |0       |64.0519950... |0.38551658... |0       |
|APOE    |OK     |0       |64.0171412... |0.38530148... |0       |
|...     |...    |...     |...           |...           |...     |

Figure \@ref(fig:APCDD1-pseudotime-curve) (下方图) 为图APCDD1 pseudotime curve概览。

**(对应文件为 `Figure+Table/APCDD1-pseudotime-curve.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/APCDD1-pseudotime-curve.pdf}
\caption{APCDD1 pseudotime curve}\label{fig:APCDD1-pseudotime-curve}
\end{center}

Figure \@ref(fig:APCDD1-pseudotime-density) (下方图) 为图APCDD1 pseudotime density概览。

**(对应文件为 `Figure+Table/APCDD1-pseudotime-density.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/APCDD1-pseudotime-density.pdf}
\caption{APCDD1 pseudotime density}\label{fig:APCDD1-pseudotime-density}
\end{center}

#### Fibroblast 拟时轨迹下的差异基因

- GO 富集表明，差异基因主要富集于和 Collagen 相关的通路。
- APCDD1 为排名第 2 的差异基因。
- 在两个主要的拟时分支中，APCDD1 均呈表达量上升趋势。
- APCDD1 是 Top 50 的差异基因中，唯一和 Wnt 相关且姜黄素对其有调控作用的基因
  见 Fig. \@ref(fig:Pseudotime-heatmap-of-genes)。


```r
scDegs.pseu <- head(dplyr::filter(mn@tables$step3$graph_test.sig, q_value < .000001), 500)

en.pseu <- job_enrich(scDegs.pseu$gene_id)
en.pseu <- step1(en.pseu)
en.pseu@plots$step1$p.go
```

Figure \@ref(fig:PSEU-GO-enrichment) (下方图) 为图PSEU GO enrichment概览。

**(对应文件为 `Figure+Table/PSEU-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PSEU-GO-enrichment.pdf}
\caption{PSEU GO enrichment}\label{fig:PSEU-GO-enrichment}
\end{center}


```r
genes.allWnt <- get_genes.keggPath("hsa04310")

p.hpPseu <- map(mn, head(scDegs.pseu$gene_id, 50), enrich = en.pseu,
  branches = list(c("Y_6", "Y_24"), c("Y_3", "Y_24")),
  HLs = list(Wnt = genes.allWnt, Curcumin_Wnt = genes.wnt$geneName_list,
    Curcumin_alls = Tops$hgnc_symbol)
)

p.hpPseu
```

Figure \@ref(fig:Pseudotime-heatmap-of-genes) (下方图) 为图Pseudotime heatmap of genes概览。

**(对应文件为 `Figure+Table/Pseudotime-heatmap-of-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Pseudotime-heatmap-of-genes.pdf}
\caption{Pseudotime heatmap of genes}\label{fig:Pseudotime-heatmap-of-genes}
\end{center}


#### 姜黄素有调控作用的靶点 (所有的差异基因中)


```r
p.vennTreatPseu <- new_venn(
  FB_pseu_DEGs = scDegs.pseu$gene_id,
  Treat_DEGs = Tops$hgnc_symbol
)
p.vennTreatPseu
```

Figure \@ref(fig:Intersection-of-FB-pseu-DEGs-with-Treat-DEGs) (下方图) 为图Intersection of FB pseu DEGs with Treat DEGs概览。

**(对应文件为 `Figure+Table/Intersection-of-FB-pseu-DEGs-with-Treat-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-FB-pseu-DEGs-with-Treat-DEGs.pdf}
\caption{Intersection of FB pseu DEGs with Treat DEGs}\label{fig:Intersection-of-FB-pseu-DEGs-with-Treat-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    APCDD1, ELN, CRYAB, DCN, CTSK, RGCC, CCL2, IGFBP5,
CRABP2, AEBP1, PPIB, PLD3, POSTN, CTSC, ZFP36, BSG, BIRC3,
TMEM258, FTL, ID3, FN1, NFE2L2, FKBP7, TNFAIP3, PYCR1,
TIMP1, S100A10, CES1, OLFM2, KPNA2, FTH1, TMED10, DDX5,
IL6, COL13A1, DPP7, RPL28, HTRA3, PDIA3, TNXB, C1QTNF2,
CTSB, ASAH1, GLT8D1,...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-FB-pseu-DEGs-with-Treat-DEGs-content`)**

### 细胞通讯

#### 总体通讯

因为 Fig. \@ref(fig:Pseudotime-heatmap-of-genes) 所示，末期的 APCDD1 表达量升高，
这里尝试将 Fibroblast 细胞分为 Begins 和 Ends 两组，作为两种亚型，和其它细胞
做细胞通讯分析。


```r
mn <- add_anno(mn, branches = list(c("Y_6", "Y_24"), c("Y_3", "Y_24")))
sr <- map(sr, mn)
sr <- mutate(sr,
  branch_time = paste0("B:", ifelse(pseudotime > 10, "Ends", "Begins")),
  cellType_sub = as.character(scsa_cell),
  cellType_sub = ifelse(is.na(pseudotime), cellType_sub, paste0(cellType_sub, ":", branch_time)),
  cellType_sub = as.factor(cellType_sub)
)
sr@object@meta.data$cellType_sub %>% table

cc <- asjob_cellchat(sr, "cellType_sub")
cc <- step1(cc)
cc@plots$step1$p.aggre_count
```

Figure \@ref(fig:Overall-communication-count) (下方图) 为图Overall communication count概览。

**(对应文件为 `Figure+Table/Overall-communication-count.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-communication-count.pdf}
\caption{Overall communication count}\label{fig:Overall-communication-count}
\end{center}

Figure \@ref(fig:Overall-communication-weight) (下方图) 为图Overall communication weight概览。

**(对应文件为 `Figure+Table/Overall-communication-weight.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-communication-weight.pdf}
\caption{Overall communication weight}\label{fig:Overall-communication-weight}
\end{center}

#### Fibroblast 分支与免疫细胞

这里比较了 FB:ends 和 FB:begins 与两种免疫细胞 Microphage、dendritic cells 的通讯 (pathway) 的不同之处。


```r
fun_diff <- function(data, use) {
  pair <- c("source", "target")
  pair <- pair[ pair != use ]
  lapply(split(data, data[[ use ]]),
    function(x) {
      fun <- function(pat) {
        unique(dplyr::filter(x, grpl(!!rlang::sym(pair), !!pat))$pathway_name)
      }
      ends <- fun("Ends")
      begins <- fun("Begin")
      unique(c(setdiff(ends, begins), setdiff(begins, ends)))
    })
}

chat.alltarget <- select_pathway(cc, "Begins|Ends", "^[^:]+$", "path")
diff.tar <- fun_diff(chat.alltarget, "target")

chat.allsource <- select_pathway(cc, "^[^:]+$", "Begins|Ends", "path")
diff.sour <- fun_diff(chat.allsource, "source")

diff.imm <- unique(unlist(lapply(list(diff.sour, diff.tar),
      function(x) x[ grpl(names(x), "Dendri|Macro") ])))
diff.imm
# [1] "CD99"     "COLLAGEN" "MIF"      "MK"      
```

#### 差异通讯 {#diff-chat}


```r
cc <- step2(cc, diff.imm)
cc@plots$step2$cell_comm_heatmap$COLLAGEN
cc@plots$step2$cell_comm_heatmap$ALL
```

Figure \@ref(fig:Diff-path-COLLAGEN) (下方图) 为图Diff path COLLAGEN概览。

**(对应文件为 `Figure+Table/Diff-path-COLLAGEN.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Diff-path-COLLAGEN.pdf}
\caption{Diff path COLLAGEN}\label{fig:Diff-path-COLLAGEN}
\end{center}

 
`Diff path others' 数据已全部提供。

**(对应文件为 `Figure+Table/Diff-path-others`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Diff-path-others共包含5个文件。

\begin{enumerate}\tightlist
\item 1\_ALL.pdf
\item 2\_COLLAGEN.pdf
\item 3\_MIF.pdf
\item 4\_MK.pdf
\item 5\_CD99.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

#### Others

 
`Ligand receptor roles' 数据已全部提供。

**(对应文件为 `Figure+Table/ligand-receptor-roles`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/ligand-receptor-roles共包含3个文件。

\begin{enumerate}\tightlist
\item 1\_outgoing.pdf
\item 2\_incoming.pdf
\item 3\_all.pdf
\end{enumerate}\end{tcolorbox}
\end{center}

#### 蛋白互作 (PPI)

推测，Wnt 通路的表达变化可能影响到 FB:begins 和 FB:ends 与免疫细胞的通讯差异，
因此这里试着构建 PPI 网络 (Functional, 功能网络) ，首要查看姜黄素有调控作用的 Wnt 通路基因
以及有调控作用的通讯的受体配体基因，两者之间是否存在可能的相互作用。

- Fig. \@ref(fig:PPI-Wnt-LR), CD44 主要位于 COLLAGEN pathway, Tab. \@ref(tab:LR-information)
- 联系 Fig. \@ref(fig:Diff-path-COLLAGEN) 可知，是 Macrophage 对 FB:begins 和 FB:ends 的 COLLAGEN 通讯有所不同。


```r
lp.imm <- dplyr::filter(cc@tables$step1$lp_net, pathway_name %in% diff.imm)
lp.imm <- dplyr::distinct(lp.imm[, -(1:2)], pathway_name, .keep_all = T)
genes.lp.imm <- c(lp.imm$ligand, lp.imm$receptor)
genes.lp.imm <- unlist(strsplit(genes.lp.imm, "_"))
genes.lp.imm

sdb.imm <- job_stringdb(c(genes.lp.imm, genes.allWnt))
sdb.imm <- step1(sdb.imm, 50, network_type = "full")

lstPPI.imm <- filter(sdb.imm,
  genes.wnt$geneName_list, genes.lp.imm,
  level.x = dplyr::select(Tops, hgnc_symbol, logFC),
  top = NULL, keep.ref = F, arrow = F, HLs = "CD44",
  label.shape = c(from = "Wnt", to = "Immune_LR")
)
lstPPI.imm$p.mcc
```

Figure \@ref(fig:PPI-Wnt-LR) (下方图) 为图PPI Wnt LR概览。

**(对应文件为 `Figure+Table/PPI-Wnt-LR.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PPI-Wnt-LR.pdf}
\caption{PPI Wnt LR}\label{fig:PPI-Wnt-LR}
\end{center}

Table \@ref(tab:LR-information) (下方表格) 为表格LR information概览。

**(对应文件为 `Figure+Table/LR-information.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有4行9列，以下预览的表格可能省略部分数据；含有4个唯一`ligand'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item evidence:  证据，相关文献中的描述。
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:LR-information)LR information

|ligand |receptor  |prob      |pval |intera... |intera... |pathwa... |annota... |evidence  |
|:------|:---------|:---------|:----|:---------|:---------|:---------|:---------|:---------|
|MIF    |CD74_C... |0.0088... |0    |MIF_CD... |MIF - ... |MIF       |Secret... |PMID: ... |
|MDK    |SDC1      |0.0013... |0    |MDK_SDC1  |MDK - ... |MK        |Secret... |PMID: ... |
|COL1A1 |CD44      |0.1542... |0    |COL1A1... |COL1A1... |COLLAGEN  |ECM-Re... |KEGG: ... |
|CD99   |CD99      |0.0712... |0    |CD99_CD99 |CD99 -... |CD99      |Cell-C... |KEGG: ... |

## HNRNPH1、Wnt 与姜黄素

### 分子对接结果

注：以下蛋白的 PDB 获取于 alphaFold。

- APCDD1 = "./material/APCDD1.pdb",
- PLCB4 = "./material/PLCB4.pdb",
- PRICKLE1 = "./material/PRICKLE1.pdb"

其余 PDB 文件获取于 PDB 数据库


```r
vn <- job_vina(c(Curcumin = 969516), c(genes.wnt$geneName_list, "HNRNPH1"))
# file.copy("~/Downloads/AF-Q8J025-F1-model_v4.pdb", "./material/APCDD1.pdb")
# file.copy("~/Downloads/AF-Q15147-F1-model_v4.pdb", "./material/PLCB4.pdb")
# file.copy("~/Downloads/AF-Q96MT3-F1-model_v4.pdb", "./material/PRICKLE1.pdb")

vn <- step1(vn, pdbs = c(CAMK2G = "2V7O"))
vn <- step2(vn)
vn <- step3(vn, extra_pdb.files = c(
    APCDD1 = "./material/APCDD1.pdb",
    PLCB4 = "./material/PLCB4.pdb",
    PRICKLE1 = "./material/PRICKLE1.pdb")
)
# vn <- set_remote(vn)
vn <- step4(vn)
vn <- step5(vn, cutoff.af = 0)
wrap(vn@plots$step5$p.res_vina, 7, 5)
```

APCDD1 的对接取得了优异的亲和度能量。

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

### 可视化


```r
vn <- step6(vn, top = 3)
vn@plots$step6$Top1_969516_into_APCDD1
vn <- step7(vn)
vn@plots$step7$Top1_969516_into_APCDD1
```

Figure \@ref(fig:Docking-969516-into-APCDD1) (下方图) 为图Docking 969516 into APCDD1概览。

**(对应文件为 `Figure+Table/Docking-969516-into-APCDD1.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_APCDD1/969516_into_APCDD1.png}
\caption{Docking 969516 into APCDD1}\label{fig:Docking-969516-into-APCDD1}
\end{center}

Figure \@ref(fig:Docking-969516-into-APCDD1-detail) (下方图) 为图Docking 969516 into APCDD1 detail概览。

**(对应文件为 `Figure+Table/Docking-969516-into-APCDD1-detail.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/969516_into_APCDD1/detail_969516_into_APCDD1.png}
\caption{Docking 969516 into APCDD1 detail}\label{fig:Docking-969516-into-APCDD1-detail}
\end{center}

## Session Info {#session}


```r
sessionInfo()
```

```
## R version 4.4.0 (2024-04-24)
## Platform: x86_64-pc-linux-gnu
## Running under: Pop!_OS 22.04 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.10.0 
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## time zone: Asia/Shanghai
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats4    grid      stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] Seurat_4.9.9.9067           SeuratObject_4.9.9.9091     utils.tool_0.0.0.9000       sp_2.0-0                   
##  [5] monocle3_1.3.4              SummarizedExperiment_1.30.2 GenomicRanges_1.52.0        GenomeInfoDb_1.36.1        
##  [9] IRanges_2.34.1              S4Vectors_0.38.1            MatrixGenerics_1.12.3       matrixStats_1.0.0          
## [13] tidyHeatmap_1.10.1          MCnebula2_0.0.9000          ggplot2_3.4.2               biomaRt_2.56.1             
## [17] Biobase_2.60.0              BiocGenerics_0.46.0         nvimcom_0.9-146            
## 
## loaded via a namespace (and not attached):
##   [1] DBI_1.1.3                 httr_1.4.6                registry_0.5-1            BiocParallel_1.34.2      
##   [5] prettyunits_1.1.1         yulab.utils_0.0.7         ggplotify_0.1.2           sparseMatrixStats_1.12.2 
##   [9] brio_1.1.3                spatstat.geom_3.2-4       celldex_1.10.1            pillar_1.9.0             
##  [13] Rgraphviz_2.44.0          R6_2.5.1                  boot_1.3-30               mime_0.12                
##  [17] lmom_2.9                  sysfonts_0.8.8            reticulate_1.31           uwot_0.1.16              
##  [21] gridtext_0.1.5            viridis_0.6.4             Rhdf5lib_1.22.0           polspline_1.1.23         
##  [25] ROCR_1.0-11               Hmisc_5.1-0               ggpubr_0.6.0              rprojroot_2.0.3          
##  [29] downloader_0.4            parallelly_1.36.0         GlobalOptions_0.1.2       FNN_1.1.3.2              
##  [33] caTools_1.18.2            polyclip_1.10-4           rms_6.7-0                 NMF_0.26                 
##  [37] beachmat_2.16.0           htmltools_0.5.6           fansi_1.0.4               ropls_1.32.0             
##  [41] showtext_0.9-6            e1071_1.7-13              remotes_2.4.2.1           ggrepel_0.9.3            
##  [45] qqman_0.1.8               classInt_0.4-9            car_3.1-2                 ComplexHeatmap_2.16.0    
##  [49] fgsea_1.26.0              forcats_1.0.0             scuttle_1.10.2            spatstat.utils_3.0-3     
##  [53] HDO.db_0.99.1             clusterProfiler_4.9.0.002 rpart_4.1.23              clue_0.3-64              
##  [57] scatterpie_0.2.1          fitdistrplus_1.1-11       goftest_1.2-3             tidyselect_1.2.0         
##  [61] RSQLite_2.3.1             cowplot_1.1.1             GenomeInfoDbData_1.2.10   utf8_1.2.3               
##  [65] ScaledMatrix_1.8.1        scattermore_1.2           rvest_1.0.3               spatstat.data_3.0-1      
##  [69] gridExtra_2.3             fs_1.6.3                  sctransform_0.4.0         RColorBrewer_1.1-3       
##  [73] future.apply_1.11.0       ggVennDiagram_1.2.2       graph_1.78.0              R.oo_1.25.0              
##  [77] RcppHNSW_0.4.1            uuid_1.1-0                tinytex_0.46              Rtsne_0.16               
##  [81] DelayedMatrixStats_1.22.5 lazyeval_0.2.2            scales_1.2.1              carData_3.0-5            
##  [85] munsell_0.5.0             openai_0.4.1              gsubfn_0.7                treeio_1.24.3            
##  [89] R.utils_2.12.2            KEGGgraph_1.60.0          bitops_1.0-7              R.methodsS3_1.8.2        
##  [93] labeling_0.4.2            agricolae_1.3-6           proto_1.0.0               KEGGREST_1.40.0          
##  [97] promises_1.2.1            shape_1.4.6               rhdf5filters_1.12.1       terra_1.7-39             
##  [ reached getOption("max.print") -- omitted 248 entries ]
```

