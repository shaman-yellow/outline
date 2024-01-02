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
  \newenvironment{Shaded}{\begin{snugshade}}{\end{snugshade}}
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
    arc = 1mm, auto outer arc, title = {Input}]}
  {\end{tcolorbox}}
  \usepackage{titlesec}
  \titleformat{\paragraph}
  {\fontsize{10pt}{0pt}\bfseries} {\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}} {1em} {} []

---






\begin{titlepage} \newgeometry{top=7.5cm}
\ThisCenterWallPaper{1.12}{../cover_page.pdf}
\begin{center} \textbf{\Huge
胆结石RNA-seq结合肠道菌、代谢物筛选关键差异表达基因}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-02}}
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

根据客户提供的RNA-seq，结合肠道菌、代谢物筛选关键差异表达基因，基因不要是FXR及其相关信号通路（CYP7A1等），要与胆固醇代谢、胆固醇摄取、胆固醇合成、胆固醇重吸收和胆汁酸代谢相关；同时结合肠道菌群大数据库，结合菌群代谢产物。注：客户研究的疾病是胆固醇胆结石（cholesterol gallstones），如果没有使用胆结石也可。

结果：见 \@ref(results)。



# 前言 {#introduction}

客户拥有的数据类型仅为 RNA-seq，反映的是组织 mRNA 水平。当前公共数据缺少同时结合 胆结石 (gallstones, G)  疾病的 RNA-seq、肠道菌、代谢组的分析类型。因此，为了将客户的 RNA-seq 分析结果与肠道菌和代谢物建立联系，设计思路为：

- DEGs -> eQTL -> SNP -> GWAS -> Metabolites and Microbiota

eQTL 分析的本质是以全部的 DNA 变异位点为自变量，轮流以每种 mRNA 表达量为因变量，用大量的个体数据做样本进行线性回归，得到每一个SNP位点和每一个mRNA表达量间的关系 (<https://www.nature.com/scitable/topicpage/quantitative-trait-locus-qtl-analysis-53904/>)。

本次分析，通过寻找 mRNA 和 SNP 之间的关联，让 RNA-seq 筛选的 DEGs 联系到已有的关于代谢物或微生物的 GWAS 大数据研究 (\@ref(method) 这些数据反映了 SNP 与 代谢物或微生物之间的关联性) (即 SNP 作为桥梁) 筛选出关键 DEGs 和对应的肠道微生物和代谢物，最后再联系已有的 胆结石 (gallstones, G)  的肠道菌或代谢物的研究进行验证。

# 材料和方法 {#methods}

## 材料 {#material}

Other data obtained from published article (e.g., supplementary tables):

- Supplementary file from article refer to[@ChangesAndCorChen2021].
- Supplementary file from article refer to[@MendelianRandoLiuX2022].

## 方法 {#method}

Mainly used method:

- R package `biomaRt` used for gene annotation [@MappingIdentifDurinc2009].
- The `biomart` was used for mapping genes between organism (e.g., mgi_symbol to hgnc_symbol) [@MappingIdentifDurinc2009].
- R package `ClusterProfiler` used for gene enrichment analysis [@ClusterprofilerWuTi2021].
- The QTL data were abtained from GTEx database [@TheGtexConsorNone2020].
- R package `ClusterProfiler` used for GSEA enrichment [@ClusterprofilerWuTi2021].
- Database `gutMDisorder` used for finding associations between gut microbiota and metabolites [@GutmdisorderACheng2019].
- R package `Limma` and `edgeR` used for differential expression analysis [@LimmaPowersDiRitchi2015; @EdgerDifferenChen].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

## Liver: 

- 根据 Model vs Control 初步筛选 DEGs (Tab. \@ref(tab:Liver-raw-DEGs-Model-vs-control))
- DEGs 从 Mouce 到 Human 映射 (Tab. \@ref(tab:Liver-DEGs-mapping-from-Mice-to-Human)) 
- 对上述映射后的基因进行 KEGG 的 GSEA 富集，结果发现 'Steroid biosynthesis' 为首要富集结果 (Fig. \@ref(fig:LIVER-KEGG-enrichment-with-enriched-genes)
- 为了找到 DEGs 可能对应的 SNP，使用 eQTL 数据集，并筛选该数据集 (Fig. \@ref(fig:LIVER-database-of-eQTL-intersect-with-DEGs))  
- 上述数据建立了：DEGs -> SNP 之间的关联，随后需要建立 SNP -> metablite 或者 microbiota 的关联，因此这里使用了相关的 GWAS 数据，并做了筛选 (Tab. \@ref(tab:LIVER-filtered-eQTL-data-intersect-with-microbiota-related-DATA)、Tab. \@ref(tab:LIVER-filtered-eQTL-data-intersect-with-metabolite-related-DATA)) 。这样，SNP -> metablite 或者 microbiota 的关联就确立了。往上对应到 DEGs (Human)，它们是：ITGB3, C9orf152。
- 随后，为了发现更多的与上述筛选的 metabolite 或者 microbiota 相关的 metabolite 或者 microbiota，使用了 gutMDisorder 数据库，挖掘到的信息见 Tab. \@ref(tab:Liver-gutMDisorder-Matched-metabolites-and-their-related-microbiota)
- 为了验证上述的发现，使用了[@ChangesAndCorChen2021]的数据 (这是一批研究 胆结石 (gallstones, G)  的代谢物和肠道微生物的 mice 的数据) (Fig. \@ref(fig:PUBLISHED-ChangesAndCorChen2021-correlation-heatmap)) 。筛选后发现，Ruminococcus 的确在 胆结石 (gallstones, G)  中属于差异微生物。这样，串联上述线索，发现了关系链：
    - Microbiota:Ruminococcus -> Metabolite:Leucine -> SNP:`chr17_47247224_A_G_b38` -> DEG:ITGB3
- 这里，进一步将 ITGB3, C9orf152 与 Steroid biosynthesis 通路的其它基因做了关联分析，发现它们主要成显著的负关联 (Fig. \@ref(fig:LIVER-correlation-heatmap))。
- 这些基因在 human 或者 mice 中的基因名的对应关系见 Tab. \@ref(tab:Mapping-of-ITGB3-and-other-genes-from-hgncSymbol-to-mgiSymbol)
- 建议以 ITGB3 或上述其它基因 (Steroid biosynthesis 通路) 作为目标基因进一步分析。

注：以下，回肠 (ileum, I)  的分析与 Liver 思路一致，不同的是，Ileum 分析中，eQTL 用的是 Ileum 对应的数据。

## Ileum: 

- 根据 Model vs Control 初步筛选 DEGs (Tab. \@ref(tab:Ileum-raw-DEGs-Model-vs-control))
- DEGs 从 Mouce 到 Human 映射 (Tab. \@ref(tab:Ileum-DEGs-mapping-from-Mice-to-Human)) 
- 对上述映射后的基因进行 KEGG 的 GSEA 富集，无显著富集。
- 为了找到 DEGs 可能对应的 SNP，使用 eQTL 数据集，并筛选该数据集 (Fig. \@ref(fig:ILEUM-database-of-eQTL-intersect-with-DEGs))  
- 上述数据建立了：DEGs -> SNP 之间的关联，随后需要建立 SNP -> metablite 或者 microbiota 的关联，因此这里使用了相关的 GWAS 数据，并做了筛选 (Tab. \@ref(tab:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-DATA)) 。这样，SNP -> microbiota 的关联就确立了。往上对应到 DEGs (Human)，是：CTSW。
- 随后，为了发现更多的与上述筛选的 metabolite 或者 microbiota 相关的 metabolite 或者 microbiota，使用了 gutMDisorder 数据库。无结果。
- 为了验证上述的发现，使用了[@ChangesAndCorChen2021]的数据…… (方法同 Liver 部分) 无结果。


# 结论 {#dis}

# 附：分析流程 (Liver) {#workflow}

## 差异表达基因

### Model vs Control

Table \@ref(tab:Liver-raw-DEGs-Model-vs-control) (下方表格) 为表格Liver raw DEGs Model vs control概览。

**(对应文件为 `Figure+Table/Liver-raw-DEGs-Model-vs-control.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3908行11列，以下预览的表格可能省略部分数据；表格含有3908个唯一`ensembl\_transcript\_id'。
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

Table: (\#tab:Liver-raw-DEGs-Model-vs-control)Liver raw DEGs Model vs control

|ensemb... |mgi_sy... |entrez... |hgnc_s... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|ENSMUS... |Cyp2c70   |226105    |NA        |cytoch... |4.1662... |5.9781... |23.094... |1.2533... |3.9223... |
|ENSMUS... |Scd1      |20249     |NA        |stearo... |2.8187... |11.748... |19.213... |6.8879... |0.0001... |
|ENSMUS... |Ces2a     |102022    |          |carbox... |1.6614... |8.8361... |15.281... |5.6258... |0.0004... |
|ENSMUS... |Hsd17b6   |27400     |          |hydrox... |2.8011... |8.6106... |14.201... |1.0950... |0.0006... |
|ENSMUS... |Fmo5      |14263     |          |flavin... |1.2618... |8.1280... |13.790... |1.4285... |0.0007... |
|ENSMUS... |Hsd17b6   |27400     |          |hydrox... |3.0271... |4.8530... |13.490... |1.7415... |0.0007... |
|ENSMUS... |Enho      |69638     |NA        |energy... |-4.453... |2.2957... |-17.04... |2.0685... |0.0002... |
|ENSMUS... |Abcb11    |27413     |          |ATP-bi... |1.2515... |7.7893... |11.121... |9.7706... |0.0033... |
|ENSMUS... |Hsd17b6   |27400     |          |hydrox... |3.6061... |4.4081... |11.158... |9.4863... |0.0033... |
|ENSMUS... |Gsta4     |14860     |NA        |glutat... |1.9687... |6.1777... |10.257... |1.9887... |0.0056... |
|ENSMUS... |Gnat1     |14685     |NA        |G prot... |-2.232... |2.9799... |-10.64... |1.4365... |0.0044... |
|ENSMUS... |Nnmt      |18113     |NA        |nicoti... |-3.804... |5.1567... |-9.928... |2.6415... |0.0065... |
|ENSMUS... |Csad      |246277    |NA        |cystei... |-1.560... |7.2232... |-9.535... |3.7482... |0.0083... |
|ENSMUS... |Hsd17b6   |27400     |          |hydrox... |2.9137... |3.3218... |9.8923... |2.7263... |0.0065... |
|ENSMUS... |Mup7      |100041658 |NA        |major ... |-10.24... |7.5916... |-9.232... |4.9474... |0.0087... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |

Figure \@ref(fig:Liver-plot-DEGs-Model-vs-control) (下方图) 为图Liver plot DEGs Model vs control概览。

**(对应文件为 `Figure+Table/Liver-plot-DEGs-Model-vs-control.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Liver-plot-DEGs-Model-vs-control.pdf}
\caption{Liver plot DEGs Model vs control}\label{fig:Liver-plot-DEGs-Model-vs-control}
\end{center}



## DEGs 从 Mouce 到 Human 映射

### Biomart mapping

客户的数据为 Mouce 的数据，这里将 Mouce 的基因映射为 Human 的基因 (因为后续的数据来源主要为 Human)。 

Table \@ref(tab:Liver-DEGs-mapping-from-Mice-to-Human) (下方表格) 为表格Liver DEGs mapping from Mice to Human概览。

**(对应文件为 `Figure+Table/Liver-DEGs-mapping-from-Mice-to-Human.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2998行11列，以下预览的表格可能省略部分数据；表格含有2998个唯一`hgnc\_symbol'。
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

Table: (\#tab:Liver-DEGs-mapping-from-Mice-to-Human)Liver DEGs mapping from Mice to Human

|hgnc_s... |mgi_sy... |ensemb... |entrez... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|ENHO      |Enho      |ENSMUS... |69638     |energy... |-4.453... |2.2957... |-17.04... |2.0685... |0.0002... |
|CES2      |Ces2a     |ENSMUS... |102022    |carbox... |1.6614... |8.8361... |15.281... |5.6258... |0.0004... |
|HSD17B6   |Hsd17b6   |ENSMUS... |27400     |hydrox... |2.8011... |8.6106... |14.201... |1.0950... |0.0006... |
|FMO5      |Fmo5      |ENSMUS... |14263     |flavin... |1.2618... |8.1280... |13.790... |1.4285... |0.0007... |
|ABCB11    |Abcb11    |ENSMUS... |27413     |ATP-bi... |1.2515... |7.7893... |11.121... |9.7706... |0.0033... |
|GNAT1     |Gnat1     |ENSMUS... |14685     |G prot... |-2.232... |2.9799... |-10.64... |1.4365... |0.0044... |
|NNMT      |Nnmt      |ENSMUS... |18113     |nicoti... |-3.804... |5.1567... |-9.928... |2.6415... |0.0065... |
|CSAD      |Csad      |ENSMUS... |246277    |cystei... |-1.560... |7.2232... |-9.535... |3.7482... |0.0083... |
|ABCB1     |Abcb1a    |ENSMUS... |18671     |ATP-bi... |3.2131... |3.2740... |9.4563... |4.0267... |0.0084... |
|FGFR2     |Fgfr2     |ENSMUS... |14183     |fibrob... |2.9129... |4.2716... |9.2494... |4.8706... |0.0087... |
|DDAH1     |Ddah1     |ENSMUS... |69219     |dimeth... |1.3322... |6.8518... |9.1694... |5.2476... |0.0087... |
|ABCG5     |Abcg5     |ENSMUS... |27409     |ATP bi... |1.5044... |7.3228... |9.0073... |6.1127... |0.0089... |
|SLC1A2    |Slc1a2    |ENSMUS... |20511     |solute... |-1.900... |5.0951... |-8.951... |6.4435... |0.0089... |
|TTC39C    |Ttc39c    |ENSMUS... |72747     |tetrat... |-1.946... |6.2930... |-8.431... |1.0707... |0.0106... |
|WNK4      |Wnk4      |ENSMUS... |69847     |WNK ly... |2.3302... |2.6719... |8.3971... |1.1085... |0.0106... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |



## GSEA 富集 (Human)

### pathways

对映射完毕的 DEGs (Tab. \@ref(tab:Liver-DEGs-mapping-from-Mice-to-Human)) 进行富集分析，首要富集结果为 'Steroid biosynthesis'。

Figure \@ref(fig:LIVER-KEGG-enrichment-with-enriched-genes) (下方图) 为图LIVER KEGG enrichment with enriched genes概览。

**(对应文件为 `Figure+Table/LIVER-KEGG-enrichment-with-enriched-genes.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-KEGG-enrichment-with-enriched-genes.pdf}
\caption{LIVER KEGG enrichment with enriched genes}\label{fig:LIVER-KEGG-enrichment-with-enriched-genes}
\end{center}

Figure \@ref(fig:LIVER-GSEA-plot-of-the-pathways) (下方图) 为图LIVER GSEA plot of the pathways概览。

**(对应文件为 `Figure+Table/LIVER-GSEA-plot-of-the-pathways.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-GSEA-plot-of-the-pathways.pdf}
\caption{LIVER GSEA plot of the pathways}\label{fig:LIVER-GSEA-plot-of-the-pathways}
\end{center}



## eQTL 数据: 寻找基因表达变化 (DEGs) 和突变 (SNP) 的关联 

### eQTL 数据

使用的 eQTL 数据集 (经过注释的，来源见 \@ref(method) QTL 说明)：

Table \@ref(tab:LIVER-all-used-eQTL-data) (下方表格) 为表格LIVER all used eQTL data概览。

**(对应文件为 `Figure+Table/LIVER-all-used-eQTL-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有341233行13列，以下预览的表格可能省略部分数据；表格含有221715个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item gene\_id:  GENCODE/Ensembl gene ID
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\item tss\_distance:  distance between variant and transcription start site (TSS). Positive when variant is downstream of the TSS, negative otherwise
\item maf:  minor allele frequency observed in the set of donors for a given tissue
\item pval\_nominal:  nominal p-value associated with the most significant variant for this gene
\item slope:  regression slope
\item slope\_se:  standard error of the regression slope
\item pval\_beta:  beta-approximated permutation p-value
\item pval\_nominal\_threshold:  nominal p-value threshold for calling a variant-gene pair significant for the gene
\item ma\_samples:  number of samples carrying the minor allele
\item ma\_count:  total number of minor alleles across individuals
\item min\_pval\_nominal:  smallest nominal p-value for the gene
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:LIVER-all-used-eQTL-data)LIVER all used eQTL data

|varian... |gene_id   |tss_di... |ma_sam... |ma_count |maf       |pval_n......7 |slope     |slope_se  |pval_n......10 |... |
|:---------|:---------|:---------|:---------|:--------|:---------|:-------------|:---------|:---------|:--------------|:---|
|chr1_1... |ENSG00... |-282825   |21        |21       |0.0504808 |1.2263...     |-0.992022 |0.197055  |7.3643...      |... |
|chr1_5... |ENSG00... |-38486    |3         |3        |0.0072... |1.4398...     |1.9902    |0.445336  |4.4165...      |... |
|chr1_1... |ENSG00... |819409    |7         |7        |0.0168269 |5.0290...     |1.44172   |0.27575   |4.4165...      |... |
|chr1_1... |ENSG00... |995083    |77        |86       |0.206731  |2.6972...     |0.386875  |0.08962   |4.4165...      |... |
|chr1_9... |ENSG00... |193015    |3         |3        |0.0072... |3.7957...     |-2.4096   |0.504028  |4.9560...      |... |
|chr1_2... |ENSG00... |-510872   |10        |10       |0.0240385 |4.3979...     |-0.97553  |0.232511  |4.4931...      |... |
|chr1_9... |ENSG00... |158610    |6         |6        |0.0144231 |7.4378...     |-1.47776  |0.319499  |4.4931...      |... |
|chr1_9... |ENSG00... |170420    |26        |27       |0.0652174 |1.5197...     |0.665794  |0.149414  |4.4931...      |... |
|chr1_9... |ENSG00... |183319    |27        |28       |0.0673077 |8.0998...     |0.680912  |0.147854  |4.4931...      |... |
|chr1_7... |ENSG00... |-98104    |45        |49       |0.117788  |3.8806...     |-0.430994 |0.081567  |4.4917...      |... |
|chr1_7... |ENSG00... |-97896    |44        |48       |0.115385  |1.3477...     |-0.408977 |0.0815771 |4.4917...      |... |
|chr1_7... |ENSG00... |-97661    |53        |64       |0.153846  |2.6452...     |0.343539  |0.0794932 |4.4917...      |... |
|chr1_7... |ENSG00... |-66787    |45        |49       |0.117788  |1.1198...     |-0.405186 |0.0801673 |4.4917...      |... |
|chr1_7... |ENSG00... |-66695    |45        |48       |0.115385  |7.1610...     |-0.421834 |0.0818781 |4.4917...      |... |
|chr1_7... |ENSG00... |-28800    |44        |47       |0.112981  |4.1144...     |-0.396941 |0.0833519 |4.4917...      |... |
|...       |...       |...       |...       |...      |...       |...           |...       |...       |...            |... |



### Variant (与 DEGs 相关)

根据 DEGs 的基因名过滤 eQTL 数据：

Figure \@ref(fig:LIVER-database-of-eQTL-intersect-with-DEGs) (下方图) 为图LIVER database of eQTL intersect with DEGs概览。

**(对应文件为 `Figure+Table/LIVER-database-of-eQTL-intersect-with-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-database-of-eQTL-intersect-with-DEGs.pdf}
\caption{LIVER database of eQTL intersect with DEGs}\label{fig:LIVER-database-of-eQTL-intersect-with-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    ENHO, SLC22A3, STARD10, GNMT, TLCD2, PON1, SIK1, DDTL,
APOC4, SPRYD3, GM2A, UGT3A2, RHPN2, SULT1C2, MRPL15,
C9orf152, SLC39A4, RHOD, SAA4, SLC10A1, NUDT18, ANG, IPO7,
PROB1, GNG12, MPZL3, OST4, ASAH2B, FOLR3, CTAGE15, CD1D,
APOC2, KISS1, GOLT1A, PAQR9, DPP3, HUNK, MIF, HPR, HP,
SULT2A1, IL17RB, FADS3, DELE1, SCCPDH, CYP2A6, CYP2A13,
GNPNAT1, LINGO4, C14orf119, MRPL14, NEMP1, AP1M1, PXMP2,
PSMB3, OTUD1, MBL2, RCN1, E2F2, TMEM238, EPPK1, CMTM6,
IKBKE, ALDH16A1, C2orf42, TRABD, RTEL1, COL5A3, CTDSP1,
DIPK2A, TXN2, IMMP2L, CA5A, GRIK5, TMEM176A, ATP23, GJC3,
ZNF429, TPMT, OMD, RAP2C, CRCP, L3MBTL3, ACY3, PRMT6,
CD2BP2, IL22RA1, RNF168, BRI3, ITPRIPL1, ORM2, KPNA2,
CHMP4C, PPDPF, CCL15, OXSM, COPS7A, CYP3A7-CYP3A51P,
MBLAC2, ACOT12, SEC11C, SURF6, TRUB1, ELOVL2, MLYCD,
MARVELD3, ZBTB33, PPIL1, AMIGO1, CYC1, C11orf96, ITGB3,
GLUD2, TMEM134, DHRS3, PRRG4, LLPH, GLO1, IL1RAP, NOCT,
NTAQ1, VSIG10L, LRRC46, AMDHD1, LRRC57, SERPINA12, UFL1,
CCL27, FAM136A, RAB22A, FCGR2C, ZFPM1, TMEM218, GCNT4,
TADA1, GNG10, ANKRD9, DECR1, ZNF408, TCEA3, DSG1, INMT,
IVD, LARS2, CYP27A1, PLIN3, TMEM47, CYSTM1, FXYD1, EVI5L,
NME6, NSA2, GTF2I, LCMT2, PPP1CB, AGXT, CLDN1, PARG

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/LIVER-database-of-eQTL-intersect-with-DEGs-content`)**

Table \@ref(tab:LIVER-database-of-eQTL-intersect-with-DEGs-DATA) (下方表格) 为表格LIVER database of eQTL intersect with DEGs DATA概览。

**(对应文件为 `Figure+Table/LIVER-database-of-eQTL-intersect-with-DEGs-DATA.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有9785行13列，以下预览的表格可能省略部分数据；表格含有9455个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item gene\_id:  GENCODE/Ensembl gene ID
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\item tss\_distance:  distance between variant and transcription start site (TSS). Positive when variant is downstream of the TSS, negative otherwise
\item maf:  minor allele frequency observed in the set of donors for a given tissue
\item pval\_nominal:  nominal p-value associated with the most significant variant for this gene
\item slope:  regression slope
\item slope\_se:  standard error of the regression slope
\item pval\_beta:  beta-approximated permutation p-value
\item pval\_nominal\_threshold:  nominal p-value threshold for calling a variant-gene pair significant for the gene
\item ma\_samples:  number of samples carrying the minor allele
\item ma\_count:  total number of minor alleles across individuals
\item min\_pval\_nominal:  smallest nominal p-value for the gene
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:LIVER-database-of-eQTL-intersect-with-DEGs-DATA)LIVER database of eQTL intersect with DEGs DATA

|varian... |gene_id   |tss_di... |ma_sam... |ma_count |maf       |pval_n......7 |slope     |slope_se  |pval_n......10 |... |
|:---------|:---------|:---------|:---------|:--------|:---------|:-------------|:---------|:---------|:--------------|:---|
|chr1_1... |ENSG00... |-837790   |32        |35       |0.0841346 |1.7084...     |0.446491  |0.100836  |3.1656...      |... |
|chr1_1... |ENSG00... |-808267   |24        |25       |0.0600962 |2.8012...     |-0.470158 |0.109147  |3.1656...      |... |
|chr1_1... |ENSG00... |-270870   |11        |11       |0.0264423 |5.3189...     |0.79694   |0.169447  |3.1656...      |... |
|chr1_1... |ENSG00... |-270849   |11        |11       |0.0264423 |5.3189...     |0.79694   |0.169447  |3.1656...      |... |
|chr1_1... |ENSG00... |-193795   |13        |13       |0.03125   |4.2127...     |0.739458  |0.155452  |3.1656...      |... |
|chr1_1... |ENSG00... |-124521   |13        |13       |0.03125   |4.2127...     |0.739458  |0.155452  |3.1656...      |... |
|chr1_1... |ENSG00... |-94331    |13        |13       |0.03125   |4.2127...     |0.739458  |0.155452  |3.1656...      |... |
|chr1_2... |ENSG00... |-829148   |4         |4        |0.0096... |8.5729...     |0.771259  |0.167959  |4.9989...      |... |
|chr1_2... |ENSG00... |-828022   |4         |4        |0.0096... |8.5729...     |0.771259  |0.167959  |4.9989...      |... |
|chr1_2... |ENSG00... |40717     |62        |70       |0.168269  |4.0212...     |0.173992  |0.0412498 |4.9989...      |... |
|chr1_2... |ENSG00... |356991    |11        |11       |0.0264423 |6.9192...     |-1.03253  |0.222426  |3.5636...      |... |
|chr1_2... |ENSG00... |-135634   |14        |15       |0.0360577 |3.6543...     |-0.674426 |0.158994  |4.9389...      |... |
|chr1_2... |ENSG00... |-52692    |20        |23       |0.0552885 |3.2148...     |-0.512818 |0.119997  |4.9389...      |... |
|chr1_2... |ENSG00... |-25624    |21        |23       |0.0552885 |2.0117...     |-0.553662 |0.126165  |4.9389...      |... |
|chr1_2... |ENSG00... |-23866    |19        |21       |0.0504808 |4.0686...     |-0.550719 |0.130654  |4.9389...      |... |
|...       |...       |...       |...       |...      |...       |...           |...       |...       |...            |... |

## GWAS 数据：寻找与突变类型显著关联的肠道微生物或代谢物

### GWAS 数据 {#gwas}

以下为使用的 GWAS 数据 (代谢物或微生物与 variant 的显著关系，来源见 \@ref(material))：

 
`PUBLISHED MendelianRandoLiuX2022' 数据已全部提供。

**(对应文件为 `Figure+Table/PUBLISHED-MendelianRandoLiuX2022`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/PUBLISHED-MendelianRandoLiuX2022共包含2个文件。

\begin{enumerate}\tightlist
\item 1\_snp\_microbiota.csv
\item 2\_snp\_metabolite.csv
\end{enumerate}\end{tcolorbox}
\end{center}



以下，结合 Tab. \@ref(tab:LIVER-database-of-eQTL-intersect-with-DEGs-DATA)，根据 variant\_id 筛选上述数据。

### Microbiota {#f-mic}

Figure \@ref(fig:LIVER-filtered-eQTL-data-intersect-with-microbiota-related) (下方图) 为图LIVER filtered eQTL data intersect with microbiota related概览。

**(对应文件为 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-microbiota-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-filtered-eQTL-data-intersect-with-microbiota-related.pdf}
\caption{LIVER filtered eQTL data intersect with microbiota related}\label{fig:LIVER-filtered-eQTL-data-intersect-with-microbiota-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    chr9\_110149941\_A\_G\_b38

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-microbiota-related-content`)**

Table \@ref(tab:LIVER-filtered-eQTL-data-intersect-with-microbiota-related-DATA) (下方表格) 为表格LIVER filtered eQTL data intersect with microbiota related DATA概览。

**(对应文件为 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-microbiota-related-DATA.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行3列，以下预览的表格可能省略部分数据；表格含有1个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:LIVER-filtered-eQTL-data-intersect-with-microbiota-related-DATA)LIVER filtered eQTL data intersect with microbiota related DATA

|variant_id             |Microbiome.features   |hgnc_symbol |
|:----------------------|:---------------------|:-----------|
|chr9_110149941_A_G_b38 |s_Mobiluncus_mulieris |C9orf152    |

### Metabolite {#f-met}

Figure \@ref(fig:LIVER-filtered-eQTL-data-intersect-with-metabolite-related) (下方图) 为图LIVER filtered eQTL data intersect with metabolite related概览。

**(对应文件为 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-metabolite-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-filtered-eQTL-data-intersect-with-metabolite-related.pdf}
\caption{LIVER filtered eQTL data intersect with metabolite related}\label{fig:LIVER-filtered-eQTL-data-intersect-with-metabolite-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    chr17\_47247224\_A\_G\_b38

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-metabolite-related-content`)**

Table \@ref(tab:LIVER-filtered-eQTL-data-intersect-with-metabolite-related-DATA) (下方表格) 为表格LIVER filtered eQTL data intersect with metabolite related DATA概览。

**(对应文件为 `Figure+Table/LIVER-filtered-eQTL-data-intersect-with-metabolite-related-DATA.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行3列，以下预览的表格可能省略部分数据；表格含有1个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:LIVER-filtered-eQTL-data-intersect-with-metabolite-related-DATA)LIVER filtered eQTL data intersect with metabolite related DATA

|variant_id             |Metabolic.traits |hgnc_symbol |
|:----------------------|:----------------|:-----------|
|chr17_47247224_A_G_b38 |Leucine          |ITGB3       |

## 肠道菌和代谢物关联数据库筛选

在 \@ref(f-mic) 和 \@ref(f-met) 中，分别筛选到了一组 SNP 与 microbiota 或者 SNP 与 metabolite 之间的关联。
以下，以 gutMDisorder 数据库寻找与该 microbiota 或 metabolite 关联的其它 metabolite 或 microbiota。

### 以 Microbiota 筛选

无结果。

### 以 Metabolite 筛选 

结果如下：

Table \@ref(tab:Liver-gutMDisorder-Matched-metabolites-and-their-related-microbiota) (下方表格) 为表格Liver gutMDisorder Matched metabolites and their related microbiota概览。

**(对应文件为 `Figure+Table/Liver-gutMDisorder-Matched-metabolites-and-their-related-microbiota.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有5行4列，以下预览的表格可能省略部分数据；表格含有1个唯一`Metabolite'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Liver-gutMDisorder-Matched-metabolites-and-their-related-microbiota)Liver gutMDisorder Matched metabolites and their related microbiota

|Metabolite |Substrate |Gut.Microbiota       |Classification |
|:----------|:---------|:--------------------|:--------------|
|Leucine    |          |Ruminococcus         |genus          |
|Leucine    |          |Dorea                |genus          |
|Leucine    |          |Blautia              |genus          |
|Leucine    |          |Faecalibacterium     |genus          |
|Leucine    |          |Faecalibacterium ... |species        |



## 已有的 胆结石 (gallstones, G)  的微生物和代谢物关联研究

### ChangesAndCorChen2021 {#s1}

数据来源于[@ChangesAndCorChen2021]

Figure \@ref(fig:PUBLISHED-ChangesAndCorChen2021-correlation-heatmap) (下方图) 为图PUBLISHED ChangesAndCorChen2021 correlation heatmap概览。

**(对应文件为 `Figure+Table/PUBLISHED-ChangesAndCorChen2021-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/PUBLISHED-ChangesAndCorChen2021-correlation-heatmap.pdf}
\caption{PUBLISHED ChangesAndCorChen2021 correlation heatmap}\label{fig:PUBLISHED-ChangesAndCorChen2021-correlation-heatmap}
\end{center}

Table \@ref(tab:PUBLISHED-ChangesAndCorChen2021-significant-correlation) (下方表格) 为表格PUBLISHED ChangesAndCorChen2021 significant correlation概览。

**(对应文件为 `Figure+Table/PUBLISHED-ChangesAndCorChen2021-significant-correlation.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3104行8列，以下预览的表格可能省略部分数据；表格含有100个唯一`metabolite'。
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

Table: (\#tab:PUBLISHED-ChangesAndCorChen2021-significant-correlation)PUBLISHED ChangesAndCorChen2021 significant correlation

|metabo... |microb... |cor       |pvalue    |AdjPvalue |-log2(... |signif... |sign |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:----|
|PE(16:... |Prevot... |0.6120... |0.0049... |0.0159... |7.6581... |< 0.05    |*    |
|PE(16:... |Alloba... |-0.559... |0.0115... |0.0218... |6.4339... |< 0.05    |*    |
|PE(16:... |[Eubac... |-0.461... |0.0419... |0.0636... |4.5738... |< 0.05    |*    |
|PE(16:... |A2        |-0.514... |0.0218... |0.0428... |5.5171... |< 0.05    |*    |
|PE(16:... |Trepon... |0.5303... |0.0161... |0.0471... |5.9517... |< 0.05    |*    |
|PE(16:... |Anaero... |0.5185... |0.0191... |0.0383... |5.7051... |< 0.05    |*    |
|PE(16:... |Bifido... |-0.670... |0.0016... |0.0160... |9.2801... |< 0.05    |*    |
|PE(16:... |Entero... |-0.475... |0.0357... |0.0567... |4.8046... |< 0.05    |*    |
|PE(16:... |Turici... |-0.524... |0.0176... |0.0299... |5.8208... |< 0.05    |*    |
|PE(16:... |Tyzzer... |-0.568... |0.0100... |0.0197... |6.6310... |< 0.05    |*    |
|PE(16:... |[Eubac... |-0.478... |0.0345... |0.0931... |4.8570... |< 0.05    |*    |
|PE(16:... |GCA-90... |-0.498... |0.0252... |0.0406... |5.3097... |< 0.05    |*    |
|PE(16:... |Rumino... |-0.466... |0.0382... |0.0868... |4.7099... |< 0.05    |*    |
|PE(16:... |Tyzzer... |0.6169... |0.0037... |0.0096... |8.0559... |< 0.05    |*    |
|PE(16:... |[Rumin... |-0.472... |0.0370... |0.0699... |4.7527... |< 0.05    |*    |
|...       |...       |...       |...       |...       |...       |...       |...  |

### 验证结果

将 Tab. \@ref(tab:Liver-gutMDisorder-Matched-metabolites-and-their-related-microbiota) 中的微生物在 Tab. \@ref(tab:PUBLISHED-ChangesAndCorChen2021-significant-correlation) 中搜索验证：

Table \@ref(tab:Liver-gutMDisorder-microbiota-matched-in-PUBLISHED-ChangesAndCorChen2021) (下方表格) 为表格Liver gutMDisorder microbiota matched in PUBLISHED ChangesAndCorChen2021概览。

**(对应文件为 `Figure+Table/Liver-gutMDisorder-microbiota-matched-in-PUBLISHED-ChangesAndCorChen2021.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有104行8列，以下预览的表格可能省略部分数据；表格含有71个唯一`metabolite'。
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

Table: (\#tab:Liver-gutMDisorder-microbiota-matched-in-PUBLISHED-ChangesAndCorChen2021)Liver gutMDisorder microbiota matched in PUBLISHED ChangesAndCorChen2021

|metabo... |microb... |cor       |pvalue    |AdjPvalue |-log2(... |signif... |sign |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:----|
|PE(16:... |[Rumin... |-0.472... |0.0370... |0.0699... |4.7527... |< 0.05    |*    |
|PC(18:... |[Rumin... |0.5699... |0.0098... |0.0333... |6.6643... |< 0.05    |*    |
|PC(20:... |[Rumin... |0.7398... |0.0002... |0.0048... |11.751... |< 0.001   |**   |
|Tauroh... |[Rumin... |-0.8      |2.8326... |0.0010... |15.107... |< 0.001   |**   |
|Tauroh... |Rumino... |0.4605... |0.0410... |0.1088... |4.6077... |< 0.05    |*    |
|trans-... |[Rumin... |0.7082... |0.0006... |0.0078... |10.522... |< 0.001   |**   |
|trans-... |Rumino... |-0.509... |0.0216... |0.0980... |5.5314... |< 0.05    |*    |
|L-Norl... |[Rumin... |0.5879... |0.0074... |0.0285... |7.0754... |< 0.05    |*    |
|L-Norl... |Rumino... |-0.456... |0.0427... |0.1088... |4.5465... |< 0.05    |*    |
|m-Coum... |[Rumin... |0.6390... |0.0030... |0.0148... |8.3672... |< 0.05    |*    |
|m-Coum... |Rumino... |-0.629... |0.0029... |0.0549... |8.4227... |< 0.05    |*    |
|Galact... |[Rumin... |0.7308... |0.0003... |0.0053... |11.378... |< 0.001   |**   |
|Hypoxa... |[Rumin... |-0.538... |0.0157... |0.0406... |5.9924... |< 0.05    |*    |
|L-Carn... |[Rumin... |-0.763... |0.0001... |0.0026... |12.864... |< 0.001   |**   |
|SM C16:1  |[Rumin... |-0.562... |0.0110... |0.0335... |6.4991... |< 0.05    |*    |
|...       |...       |...       |...       |...       |...       |...       |...  |

结果发现 Ruminococcus 这一微生物得到验证，属于 胆结石 (gallstones, G)  的差异微生物。

Ruminococcus 向上对应：

Ruminococcus -> Leucine -> `chr17_47247224_A_G_b38` -> ITGB3



### ITGB3、C9orf152 与 'Steroid biosynthesis' 通路的基因的关联性

(C9orf152 来源于 Tab. \@ref(tab:LIVER-filtered-eQTL-data-intersect-with-microbiota-related-DATA))

#### 对应关系 (hgnc symbol 和 mgi symbol)

以下为这些基因的对应关系：

Table \@ref(tab:Mapping-of-ITGB3-and-other-genes-from-hgncSymbol-to-mgiSymbol) (下方表格) 为表格Mapping of ITGB3 and other genes from hgncSymbol to mgiSymbol概览。

**(对应文件为 `Figure+Table/Mapping-of-ITGB3-and-other-genes-from-hgncSymbol-to-mgiSymbol.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有13行11列，以下预览的表格可能省略部分数据；表格含有13个唯一`hgnc\_symbol'。
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

Table: (\#tab:Mapping-of-ITGB3-and-other-genes-from-hgncSymbol-to-mgiSymbol)Mapping of ITGB3 and other genes from hgncSymbol to mgiSymbol

|hgnc_s... |mgi_sy... |ensemb... |entrez... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|C9orf152  |D63003... |ENSMUS... |242484    |RIKEN ... |0.8319... |3.6286... |4.4284... |0.0014... |0.0873... |
|ITGB3     |Itgb3     |ENSMUS... |16416     |integr... |0.7621... |1.9664... |2.5048... |0.0324... |0.3350... |
|HSD17B7   |Hsd17b7   |ENSMUS... |15490     |hydrox... |-1.949... |5.7472... |-7.173... |4.0766... |0.0170... |
|MSMO1     |Msmo1     |ENSMUS... |66234     |methyl... |-4.130... |5.8215... |-6.801... |6.2586... |0.0210... |
|CYP51A1   |Cyp51     |ENSMUS... |13121     |cytoch... |-2.839... |5.6728... |-5.878... |0.0001... |0.0351... |
|LSS       |Lss       |ENSMUS... |16987     |lanost... |-1.865... |2.5679... |-5.855... |0.0002... |0.0351... |
|DHCR7     |Dhcr7     |ENSMUS... |13360     |7-dehy... |-2.171... |4.9094... |-5.653... |0.0002... |0.0398... |
|DHCR24    |Dhcr24    |ENSMUS... |74754     |24-deh... |-1.285... |9.3065... |-5.407... |0.0003... |0.0465... |
|TM7SF2    |Tm7sf2    |ENSMUS... |73166     |transm... |-1.187... |6.0181... |-5.354... |0.0003... |0.0481... |
|EBP       |Ebp       |ENSMUS... |13595     |phenyl... |-0.865... |7.0738... |-4.934... |0.0007... |0.0626... |
|NSDHL     |Nsdhl     |ENSMUS... |18194     |NAD(P)... |-2.316... |4.5013... |-4.573... |0.0011... |0.0805... |
|SC5D      |Sc5d      |ENSMUS... |235293    |sterol... |-0.953... |6.8768... |-4.064... |0.0025... |0.1117... |
|FDFT1     |Fdft1     |ENSMUS... |14137     |farnes... |-4.499... |3.0868... |-3.658... |0.0048... |0.1480... |

#### 关联分析

Figure \@ref(fig:LIVER-correlation-heatmap) (下方图) 为图LIVER correlation heatmap概览。

**(对应文件为 `Figure+Table/LIVER-correlation-heatmap.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/LIVER-correlation-heatmap.pdf}
\caption{LIVER correlation heatmap}\label{fig:LIVER-correlation-heatmap}
\end{center}

Table \@ref(tab:LIVER-significant-correlation) (下方表格) 为表格LIVER significant correlation概览。

**(对应文件为 `Figure+Table/LIVER-significant-correlation.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有16行7列，以下预览的表格可能省略部分数据；表格含有2个唯一`Screened.DEGs'。
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

Table: (\#tab:LIVER-significant-correlation)LIVER significant correlation

|Screened.DEGs |Pathway.of... |cor   |pvalue |-log2(P.va... |significant |sign |
|:-------------|:-------------|:-----|:------|:-------------|:-----------|:----|
|Itgb3         |Nsdhl         |-0.68 |0.0441 |4.50307753... |< 0.05      |*    |
|D630039A03Rik |Nsdhl         |-0.79 |0.0107 |6.54624539... |< 0.05      |*    |
|Itgb3         |Cyp51         |-0.71 |0.0309 |5.01624935... |< 0.05      |*    |
|D630039A03Rik |Cyp51         |-0.81 |0.0079 |6.98393163... |< 0.05      |*    |
|Itgb3         |Msmo1         |-0.7  |0.0375 |4.73696559... |< 0.05      |*    |
|D630039A03Rik |Msmo1         |-0.87 |0.0022 |8.82828076... |< 0.05      |*    |
|Itgb3         |Sc5d          |-0.78 |0.0138 |6.17918792... |< 0.05      |*    |
|Itgb3         |Ebp           |-0.71 |0.0333 |4.90833401... |< 0.05      |*    |
|D630039A03Rik |Ebp           |-0.72 |0.0296 |5.07825901... |< 0.05      |*    |
|Itgb3         |Tm7sf2        |-0.82 |0.0071 |7.13796526... |< 0.05      |*    |
|D630039A03Rik |Tm7sf2        |-0.67 |0.0468 |4.41734765... |< 0.05      |*    |
|Itgb3         |Hsd17b7       |-0.7  |0.0373 |4.74468055... |< 0.05      |*    |
|D630039A03Rik |Hsd17b7       |-0.86 |0.0027 |8.53282487... |< 0.05      |*    |
|D630039A03Rik |Lss           |-0.81 |0.0083 |6.91267294... |< 0.05      |*    |
|Itgb3         |Dhcr24        |-0.75 |0.0197 |5.66566056... |< 0.05      |*    |
|...           |...           |...   |...    |...           |...         |...  |



# 附：分析流程 (Ileum) {#workflow2}

## 差异表达基因

### Model vs Control

Table \@ref(tab:Ileum-raw-DEGs-Model-vs-control) (下方表格) 为表格Ileum raw DEGs Model vs control概览。

**(对应文件为 `Figure+Table/Ileum-raw-DEGs-Model-vs-control.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有3140行11列，以下预览的表格可能省略部分数据；表格含有3140个唯一`ensembl\_transcript\_id'。
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

Table: (\#tab:Ileum-raw-DEGs-Model-vs-control)Ileum raw DEGs Model vs control

|ensemb... |mgi_sy... |entrez... |hgnc_s... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|ENSMUS... |Hmgcs1    |208715    |NA        |3-hydr... |-1.476... |7.1006... |-10.01... |3.4647... |0.0446... |
|ENSMUS... |Lypd8     |70163     |          |LY6/PL... |-1.422... |6.7523... |-9.413... |5.7988... |0.0446... |
|ENSMUS... |Col1a1    |12842     |NA        |collag... |0.9944... |6.5221... |9.2532... |6.6835... |0.0446... |
|ENSMUS... |Sqle      |20775     |NA        |squale... |-1.933... |5.8928... |-9.198... |7.0178... |0.0446... |
|ENSMUS... |Defa35    |100041688 |NA        |defens... |-1.923... |4.6800... |-9.152... |7.3136... |0.0446... |
|ENSMUS... |Fdft1     |14137     |NA        |farnes... |-1.885... |4.1659... |-9.280... |6.5253... |0.0446... |
|ENSMUS... |Defa32    |100041890 |NA        |defens... |-1.251... |11.114... |-8.525... |1.3064... |0.0511... |
|ENSMUS... |Ccl6      |20305     |NA        |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|ENSMUS... |Pigr      |18703     |NA        |polyme... |-1.150... |10.832... |-8.463... |1.3856... |0.0511... |
|ENSMUS... |Acaa1b    |235674    |NA        |acetyl... |3.2729... |4.4478... |9.3290... |6.2488... |0.0446... |
|ENSMUS... |Lypd8     |70163     |          |LY6/PL... |-1.497... |10.709... |-8.271... |1.6681... |0.0520... |
|ENSMUS... |Gzma      |14938     |          |granzy... |-3.299... |4.3784... |-8.447... |1.4064... |0.0511... |
|ENSMUS... |Tcf23     |69852     |NA        |transc... |1.8100... |3.0507... |9.0283... |8.1816... |0.0446... |
|ENSMUS... |Ccl5      |20304     |NA        |chemok... |-2.603... |3.8087... |-8.365... |1.5231... |0.0511... |
|ENSMUS... |Defa34    |100041952 |NA        |defens... |-1.733... |7.3611... |-7.767... |2.7596... |0.0753... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |

Figure \@ref(fig:Ileum-plot-DEGs-Model-vs-control) (下方图) 为图Ileum plot DEGs Model vs control概览。

**(对应文件为 `Figure+Table/Ileum-plot-DEGs-Model-vs-control.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ileum-plot-DEGs-Model-vs-control.pdf}
\caption{Ileum plot DEGs Model vs control}\label{fig:Ileum-plot-DEGs-Model-vs-control}
\end{center}



## DEGs 从 Mouce 到 Human 映射

### Biomart mapping

客户的数据为 Mouce 的数据，这里将 Mouce 的基因映射为 Human 的基因 (因为后续的数据来源主要为 Human)。 

Table \@ref(tab:Ileum-DEGs-mapping-from-Mice-to-Human) (下方表格) 为表格Ileum DEGs mapping from Mice to Human概览。

**(对应文件为 `Figure+Table/Ileum-DEGs-mapping-from-Mice-to-Human.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2554行11列，以下预览的表格可能省略部分数据；表格含有2554个唯一`hgnc\_symbol'。
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

Table: (\#tab:Ileum-DEGs-mapping-from-Mice-to-Human)Ileum DEGs mapping from Mice to Human

|hgnc_s... |mgi_sy... |ensemb... |entrez... |descri... |logFC     |AveExpr   |t         |P.Value   |adj.P.Val |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|
|HMGCS1    |Hmgcs1    |ENSMUS... |208715    |3-hydr... |-1.476... |7.1006... |-10.01... |3.4647... |0.0446... |
|LYPD8     |Lypd8     |ENSMUS... |70163     |LY6/PL... |-1.422... |6.7523... |-9.413... |5.7988... |0.0446... |
|ACAA1     |Acaa1b    |ENSMUS... |235674    |acetyl... |3.2729... |4.4478... |9.3290... |6.2488... |0.0446... |
|FDFT1     |Fdft1     |ENSMUS... |14137     |farnes... |-1.885... |4.1659... |-9.280... |6.5253... |0.0446... |
|COL1A1    |Col1a1    |ENSMUS... |12842     |collag... |0.9944... |6.5221... |9.2532... |6.6835... |0.0446... |
|SQLE      |Sqle      |ENSMUS... |20775     |squale... |-1.933... |5.8928... |-9.198... |7.0178... |0.0446... |
|TCF23     |Tcf23     |ENSMUS... |69852     |transc... |1.8100... |3.0507... |9.0283... |8.1816... |0.0446... |
|CCL23     |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|CCL15     |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|CCL15-... |Ccl6      |ENSMUS... |20305     |chemok... |-1.331... |7.5855... |-8.558... |1.2650... |0.0511... |
|PIGR      |Pigr      |ENSMUS... |18703     |polyme... |-1.150... |10.832... |-8.463... |1.3856... |0.0511... |
|GZMA      |Gzma      |ENSMUS... |14938     |granzy... |-3.299... |4.3784... |-8.447... |1.4064... |0.0511... |
|CEACAM21  |Ceacam10  |ENSMUS... |26366     |CEA ce... |-3.021... |2.5056... |-7.995... |2.1919... |0.0638... |
|MSMO1     |Msmo1     |ENSMUS... |66234     |methyl... |-1.455... |5.8017... |-7.623... |3.2019... |0.0777... |
|INSIG1    |Insig1    |ENSMUS... |231070    |insuli... |-1.306... |5.1683... |-7.562... |3.4134... |0.0784... |
|...       |...       |...       |...       |...       |...       |...       |...       |...       |...       |



## GSEA 富集 (Human)

### pathways

对映射完毕的 DEGs (Tab. \@ref(tab:Ileum-DEGs-mapping-from-Mice-to-Human)) 进行富集分析。

无结果。



## eQTL 数据: 寻找基因表达变化 (DEGs) 和突变 (SNP) 的关联 

### eQTL 数据

使用的 eQTL 数据集 (经过注释的，来源见 \@ref(method) QTL 说明)：

Table \@ref(tab:ILEUM-all-used-eQTL-data) (下方表格) 为表格ILEUM all used eQTL data概览。

**(对应文件为 `Figure+Table/ILEUM-all-used-eQTL-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有362950行13列，以下预览的表格可能省略部分数据；表格含有236950个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item gene\_id:  GENCODE/Ensembl gene ID
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\item tss\_distance:  distance between variant and transcription start site (TSS). Positive when variant is downstream of the TSS, negative otherwise
\item maf:  minor allele frequency observed in the set of donors for a given tissue
\item pval\_nominal:  nominal p-value associated with the most significant variant for this gene
\item slope:  regression slope
\item slope\_se:  standard error of the regression slope
\item pval\_beta:  beta-approximated permutation p-value
\item pval\_nominal\_threshold:  nominal p-value threshold for calling a variant-gene pair significant for the gene
\item ma\_samples:  number of samples carrying the minor allele
\item ma\_count:  total number of minor alleles across individuals
\item min\_pval\_nominal:  smallest nominal p-value for the gene
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:ILEUM-all-used-eQTL-data)ILEUM all used eQTL data

|varian... |gene_id   |tss_di... |ma_sam... |ma_count |maf       |pval_n......7 |slope     |slope_se |pval_n......10 |... |
|:---------|:---------|:---------|:---------|:--------|:---------|:-------------|:---------|:--------|:--------------|:---|
|chr1_6... |ENSG00... |635545    |37        |38       |0.109195  |7.7478...     |0.714005  |0.153436 |0.0001...      |... |
|chr1_6... |ENSG00... |636475    |30        |31       |0.0890805 |1.5651...     |0.799537  |0.159046 |0.0001...      |... |
|chr1_1... |ENSG00... |-2735     |30        |31       |0.0890805 |8.5052...     |-0.732664 |0.180744 |0.0001...      |... |
|chr1_1... |ENSG00... |-1661     |30        |31       |0.0890805 |5.0459...     |-0.863981 |0.181683 |0.0001...      |... |
|chr1_1... |ENSG00... |-863      |29        |30       |0.0862069 |5.8928...     |-0.849341 |0.179995 |0.0001...      |... |
|chr1_5... |ENSG00... |366758    |26        |28       |0.0804598 |2.3127...     |-0.787625 |0.179559 |0.0001...      |... |
|chr1_1... |ENSG00... |832657    |20        |25       |0.0735294 |2.0648...     |0.682666  |0.154638 |5.3694...      |... |
|chr1_1... |ENSG00... |832698    |20        |25       |0.0744048 |1.1681...     |0.680393  |0.149393 |5.3694...      |... |
|chr1_1... |ENSG00... |832705    |21        |26       |0.0778443 |2.0142...     |0.656911  |0.148597 |5.3694...      |... |
|chr1_1... |ENSG00... |849704    |11        |12       |0.0344828 |1.3883...     |0.761038  |0.168658 |6.3166...      |... |
|chr1_1... |ENSG00... |857941    |11        |12       |0.0344828 |1.3883...     |0.761038  |0.168658 |6.3166...      |... |
|chr1_1... |ENSG00... |858470    |11        |12       |0.0344828 |1.3883...     |0.761038  |0.168658 |6.3166...      |... |
|chr1_1... |ENSG00... |499741    |4         |4        |0.0114943 |4.8015...     |1.68832   |0.319009 |5.3884...      |... |
|chr1_1... |ENSG00... |500143    |4         |4        |0.0114943 |4.8015...     |1.68832   |0.319009 |5.3884...      |... |
|chr1_7... |ENSG00... |-48605    |11        |13       |0.0373563 |1.3381...     |-0.889314 |0.196694 |5.2588...      |... |
|...       |...       |...       |...       |...      |...       |...           |...       |...      |...            |... |



### Variant (与 DEGs 相关)

根据 DEGs 的基因名过滤 eQTL 数据：

Figure \@ref(fig:ILEUM-database-of-eQTL-intersect-with-DEGs) (下方图) 为图ILEUM database of eQTL intersect with DEGs概览。

**(对应文件为 `Figure+Table/ILEUM-database-of-eQTL-intersect-with-DEGs.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ILEUM-database-of-eQTL-intersect-with-DEGs.pdf}
\caption{ILEUM database of eQTL intersect with DEGs}\label{fig:ILEUM-database-of-eQTL-intersect-with-DEGs}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    IGHV1-3, IGHV1-69, IGHV1-69-2, IGHV1-69D, CD7, VNN1,
BOK, FLVCR2, PSMB9, ABCG8, ISG15, ACOT4, PPDPF, WNT3, DCXR,
PSMB8, KIAA0753, OLFM4, ACOT1, SLC51A, PRKD3, CAT,
SMIM10L1, VMAC, NAGLU, NME6, ITLN1, FEM1A, PGP, CNN1,
CTAGE15, NOXA1, CTSW, IGKC, IGHV4-31, IGHV4-39, IGHV4-59,
IGHV4-4, IGHV4-61, UCP2, SV2A, ADH1A, ACAT2, ACTR5, WBP1,
CRACR2A, A4GNT, COA8, FABP2, TCN2, DENND11, ZKSCAN4, ILRUN,
RDH16, ISOC2, CD24, AP1M1, IGHV2-70D, IGHV2-70, SHPK,
IGLC2, IGLC3, PET100, TMEM86B, ADH4, TMED6, LRRC15, NR0B2,
GNB2, UBA52, TAF9B, PRELID1, NECTIN4, ETHE1, GADD45B,
SNAP23, F2R, TMEM238L, LILRA4, CEACAM18, TMEM220, NIPAL2,
PKDREJ, CDH19, MTCP1, IGKV1-9, IGKV1-17, IGKV1-37,
IGKV1D-37, KRT12, C9orf152, C11orf86, RCN3, ALDH16A1,
IKBKG, TMEM170B, TTC4, N4BP2L2, CDK11B, EIF1AD, C17orf75,
AMIGO1, PNLIPRP2, MS4A12, SCGB3A1, PKN3, CDA, SLFN5,
CCDC127, SLC5A4, ABRACL, HEATR9, DCTN6, TUBGCP5, LTB4R2,
HSBP1, OCEL1, SECTM1, MYO19, KAT2B, SMDT1, SVIP, HOXA7,
CA8, GTF2I, IGHV7-4-1, IGHV7-81, FAAP24, ADGRG7, UTP14C,
NPR1, UNC93A, PGAM1, C19orf53, KCTD21, IFT46, ZNF77,
CYSLTR1, FXYD7, TXNDC16, SURF1, HLA-DQB2, DIRAS1, FBXO33,
MRPL54, ALG1L2, JPH2, PPP1R15A, OVOL1, ACAD11, NUP210L,
B3GLCT, DDX3X, MANBA, GLTP, CITED4

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/ILEUM-database-of-eQTL-intersect-with-DEGs-content`)**

Table \@ref(tab:ILEUM-database-of-eQTL-intersect-with-DEGs-DATA) (下方表格) 为表格ILEUM database of eQTL intersect with DEGs DATA概览。

**(对应文件为 `Figure+Table/ILEUM-database-of-eQTL-intersect-with-DEGs-DATA.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有16252行13列，以下预览的表格可能省略部分数据；表格含有14650个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item gene\_id:  GENCODE/Ensembl gene ID
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\item tss\_distance:  distance between variant and transcription start site (TSS). Positive when variant is downstream of the TSS, negative otherwise
\item maf:  minor allele frequency observed in the set of donors for a given tissue
\item pval\_nominal:  nominal p-value associated with the most significant variant for this gene
\item slope:  regression slope
\item slope\_se:  standard error of the regression slope
\item pval\_beta:  beta-approximated permutation p-value
\item pval\_nominal\_threshold:  nominal p-value threshold for calling a variant-gene pair significant for the gene
\item ma\_samples:  number of samples carrying the minor allele
\item ma\_count:  total number of minor alleles across individuals
\item min\_pval\_nominal:  smallest nominal p-value for the gene
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:ILEUM-database-of-eQTL-intersect-with-DEGs-DATA)ILEUM database of eQTL intersect with DEGs DATA

|varian... |gene_id   |tss_di... |ma_sam... |ma_count |maf       |pval_n......7 |slope     |slope_se  |pval_n......10 |... |
|:---------|:---------|:---------|:---------|:--------|:---------|:-------------|:---------|:---------|:--------------|:---|
|chr1_9... |ENSG00... |-15826    |8         |9        |0.0258621 |8.6744...     |0.99981   |0.216114  |4.3905...      |... |
|chr1_9... |ENSG00... |-7998     |24        |26       |0.0747126 |4.2107...     |0.557187  |0.131552  |4.3905...      |... |
|chr1_9... |ENSG00... |-5352     |112       |138      |0.396552  |1.7991...     |0.309968  |0.0696764 |4.3905...      |... |
|chr1_1... |ENSG00... |13090     |112       |136      |0.390805  |2.3745...     |0.314566  |0.0718208 |4.3905...      |... |
|chr1_1... |ENSG00... |-20133    |67        |77       |0.221264  |7.3369...     |-0.279263 |0.0598447 |2.8165...      |... |
|chr1_1... |ENSG00... |-19664    |88        |113      |0.324713  |2.2660...     |-0.262255 |0.0530643 |2.8165...      |... |
|chr1_1... |ENSG00... |-19327    |66        |75       |0.215517  |5.7339...     |-0.290339 |0.0614452 |2.8165...      |... |
|chr1_1... |ENSG00... |-10376    |88        |112      |0.321839  |4.1671...     |-0.259466 |0.05405   |2.8165...      |... |
|chr1_1... |ENSG00... |-10186    |88        |112      |0.321839  |4.1671...     |-0.259466 |0.05405   |2.8165...      |... |
|chr1_1... |ENSG00... |-9166     |67        |78       |0.224138  |2.9457...     |-0.278442 |0.0570402 |2.8165...      |... |
|chr1_1... |ENSG00... |-8235     |85        |105      |0.301724  |1.1515...     |-0.249433 |0.054726  |2.8165...      |... |
|chr1_1... |ENSG00... |-7875     |85        |105      |0.301724  |1.1515...     |-0.249433 |0.054726  |2.8165...      |... |
|chr1_1... |ENSG00... |-7591     |81        |100      |0.301205  |4.9675...     |-0.265072 |0.0556976 |2.8165...      |... |
|chr1_1... |ENSG00... |-7438     |84        |103      |0.304734  |3.0221...     |-0.263054 |0.0539537 |2.8165...      |... |
|chr1_1... |ENSG00... |-7227     |85        |105      |0.301724  |1.1515...     |-0.249433 |0.054726  |2.8165...      |... |
|...       |...       |...       |...       |...      |...       |...           |...       |...       |...            |... |

## GWAS 数据：寻找与突变类型显著关联的肠道微生物或代谢物

### GWAS 数据

以下为使用的 GWAS 数据 (代谢物或微生物与 variant 的显著关系，来源见 \@ref(material))：

(同 \@ref(gwas))



以下，结合 Tab. \@ref(tab:ILEUM-database-of-eQTL-intersect-with-DEGs-DATA)，根据 variant\_id 筛选上述数据。

### Microbiota {#f-mic2}

Figure \@ref(fig:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related) (下方图) 为图ILEUM filtered eQTL data intersect with microbiota related概览。

**(对应文件为 `Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-microbiota-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-microbiota-related.pdf}
\caption{ILEUM filtered eQTL data intersect with microbiota related}\label{fig:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    chr11\_65879789\_A\_G\_b38

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-content`)**

Table \@ref(tab:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-DATA) (下方表格) 为表格ILEUM filtered eQTL data intersect with microbiota related DATA概览。

**(对应文件为 `Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-DATA.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1行3列，以下预览的表格可能省略部分数据；表格含有1个唯一`variant\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\item variant\_id:  variant ID in the format \{chr\}\_\{pos\_first\_ref\_base\}\_\{ref\_seq\}\_\{alt\_seq\}\_b38
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-DATA)ILEUM filtered eQTL data intersect with microbiota related DATA

|variant_id             |Microbiome.features     |hgnc_symbol |
|:----------------------|:-----------------------|:-----------|
|chr11_65879789_A_G_b38 |s_Collinsella_stercoris |CTSW        |

### Metabolite {#f-met2}

无结果：

Figure \@ref(fig:ILEUM-filtered-eQTL-data-intersect-with-metabolite-related) (下方图) 为图ILEUM filtered eQTL data intersect with metabolite related概览。

**(对应文件为 `Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-metabolite-related.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-metabolite-related.pdf}
\caption{ILEUM filtered eQTL data intersect with metabolite related}\label{fig:ILEUM-filtered-eQTL-data-intersect-with-metabolite-related}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/ILEUM-filtered-eQTL-data-intersect-with-metabolite-related-content`)**

## 肠道菌和代谢物关联数据库筛选

在 \@ref(f-mic2) 中，筛选到了一组 SNP 与 microbiota 之间的关联。
以下，以 gutMDisorder 数据库寻找与该 microbiota 或 metabolite 关联的其它 metabolite 或 microbiota。

### 以 Microbiota 筛选

无结果。



## 已有的 胆结石 (gallstones, G)  的微生物和代谢物关联研究

### ChangesAndCorChen2021

数据来源于[@ChangesAndCorChen2021] (同 \@ref(s1))

### 验证结果

将 Tab. \@ref(tab:ILEUM-filtered-eQTL-data-intersect-with-microbiota-related-DATA) 中的微生物在 Tab. \@ref(tab:PUBLISHED-ChangesAndCorChen2021-significant-correlation) 中搜索验证：

无结果。




