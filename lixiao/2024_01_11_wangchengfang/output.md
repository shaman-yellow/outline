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
\begin{center} \textbf{\Huge 质谱+网络药理学分析}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-02-01}}
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

- 质谱对复方内的五味药萆薢、土茯苓、泽泻、川牛膝和生米仁进行预测，得到复方药物的具体的有效药物成分XX1、XX2、XX3
- 分子对接检测XX1、XX2、XX3与FOXO信号的对接能量
- 通过GO功能富集分析和KEGG通路富集分析，对FOXO信号通路的下游靶点进行预测，进而得到所需的关于抑制炎症的下游靶点YY

结果：

- 以网络药理学的方式筛选成分：
    - 获取所有成分的靶点 (Tab. \@ref(tab:Targets-predicted-by-Super-Pred))
    - 获取炎症的靶点 (Fig. \@ref(fig:Overall-targets-number-of-datasets))
    - 炎症和疾病靶点交集 (Fig. \@ref(fig:Targets-intersect-with-targets-of-diseases))
    - 过滤，以转录因子 FOXO 可结合的靶点 (Tab. \@ref(tab:Transcription-Factor-binding-sites))
    - 将上述靶点富集分析，聚焦到 GO 显著结果：通路 `regulation of inflammatory response` (Fig. \@ref(fig:Ids-GO-enrichment))
    - 获取对应富集到该通路的靶点的基因, 以及靶向这些基因的成分
    - 对这些成分再次以 HOB 口服利用度过滤 (Fig. \@ref(fig:HOB-20-prediction))
    - 上述步骤之后的网络图见 Fig. \@ref(fig:FINAL-Network-pharmacology)
    - 最后获取含量 (峰面积) 前 5 的成分，见 \@ref(cpd)
- 分子对接结果见 Fig. \@ref(fig:Overall-combining-Affinity), Tab. \@ref(tab:Overall-combining-Affinity-rawData)
- 富集分析是以 FOXO 转录因子结合靶点的基础上富集的，可能的通路为 `regulation of inflammatory response`, 对应的靶点见 \@ref(en)



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Database `PubChem` used for querying information (e.g., InChIKey, CID) of chemical compounds; Tools of `Classyfire` used for get systematic classification of chemical compounds[@PubchemSubstanKimS2015; @ClassyfireAutDjoumb2016].
- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- Python tool of `HOB` was used for prediction of human oral bioavailability[@HobpreAccuratWeiM2022].
- Python tool `doctr` <https://github.com/mindee/doctr> used for interpreted character from images.
- R package `PubChemR` used for querying compounds information.
- Web tool of `Super-PRED` used for drug-targets relationship prediction[@SuperpredUpdaNickel2014].
- The `Transcription Factor Target Gene Database` (<https://tfbsdb.systemsbiology.net/>) was used for discovering relationship between transcription factors and genes. [@CausalMechanisPlaisi2016].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 已被鉴定的成分

Table \@ref(tab:Identified-compounds-records-in-table-CompoundDiscovery) (下方表格) 为表格Identified compounds records in table CompoundDiscovery概览。

**(对应文件为 `Figure+Table/Identified-compounds-records-in-table-CompoundDiscovery.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有129行7列，以下预览的表格可能省略部分数据；表格含有129个唯一`en.name'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item en.name:  化合物英文名
\item cn.name:  化合物中文名
\item rt.min:  保留时间 (分钟)
\item formula:  化合物分子式
\item mw:  分子质量
\item peak\_area:  峰面积
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Identified-compounds-records-in-table-CompoundDiscovery)Identified compounds records in table CompoundDiscovery

|en.name       |cn.name      |rt.min |formula   |mw        |file_area     |peak_area |
|:-------------|:------------|:------|:---------|:---------|:-------------|:---------|
|Betaine       |甜菜碱       |1.53   |C5H11NO2  |117.0791  |compound_d... |5.99e+09  |
|Astilbin      |落新妇苷     |21.96  |C21H22O11 |450.1163  |compound_d... |4.53e+09  |
|Sucrose       |蔗糖         |1.58   |C12H22O11 |342.1162  |compound_d... |2.3e+09   |
|Citric acid   |柠檬酸       |1.67   |C6H8O7    |192.027   |compound_d... |1.13e+09  |
|Pseudoprot... |伪原薯蓣皂苷 |24.66  |C51H82O21 |1030.5348 |compound_d... |8.76e+08  |
|Raffinose     |棉籽糖       |1.57   |C18H32O16 |252.0846  |compound_d... |7.83e+08  |
|Protodioscin  |原薯蓣皂苷   |24.66  |C51H84O22 |1048.5452 |compound_d... |7.11e+08  |
|Trigonelli... |盐酸胡芦巴碱 |1.61   |C7H7NO2   |137.0479  |compound_d... |6.38e+08  |
|Taxifolin     |二氢槲皮素   |22     |C15H12O7  |304.0584  |compound_d... |6.34e+08  |
|Engeletin     |黄杞苷       |22.9   |C21H22O10 |434.1214  |compound_d... |5.57e+08  |
|2-Pyrrolid... |L-脯氨酸     |1.58   |C5H9NO2   |115.0635  |compound_d... |4.06e+08  |
|Stachyose     |水苏糖       |1.6    |C24H42O21 |666.2221  |compound_d... |3.91e+08  |
|Cyasterone    |杯苋甾酮     |22.75  |C29H44O8  |566.3094  |compound_d... |3.27e+08  |
|5-Hydroxym... |5-羟甲基糠醛 |1.53   |C6H6O3    |126.0319  |compound_d... |2.07e+08  |
|Maltopentaose |麦芽五糖     |1.61   |C30H52O26 |828.2749  |compound_d... |2.07e+08  |
|...           |...          |...    |...       |...       |...           |...       |



## 化合物信息



### 分类学

Figure \@ref(fig:Classification-hierarchy) (下方图) 为图Classification hierarchy概览。

**(对应文件为 `Figure+Table/Classification-hierarchy.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Classification-hierarchy.pdf}
\caption{Classification hierarchy}\label{fig:Classification-hierarchy}
\end{center}

Figure \@ref(fig:Compounds-classify) (下方图) 为图Compounds classify概览。

**(对应文件为 `Figure+Table/Compounds-classify.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Compounds-classify.pdf}
\caption{Compounds classify}\label{fig:Compounds-classify}
\end{center}



### 化合物靶点

Table \@ref(tab:Targets-predicted-by-Super-Pred) (下方表格) 为表格Targets predicted by Super Pred概览。

**(对应文件为 `Figure+Table/Targets-predicted-by-Super-Pred.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有13670行9列，以下预览的表格可能省略部分数据；表格含有129个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Targets-predicted-by-Super-Pred)Targets predicted by Super Pred

|.id       |Target... |ChEMBL-ID |UniPro... |PDB Vi... |TTD ID    |Probab... |Model ... |symbols  |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:--------|
|C1[C@H... |Tyrosy... |CHEMBL... |Q9NUW8    |6N0D      |Not Av... |99.57%    |71.22%    |TDP1     |
|C1[C@H... |DNA-(a... |CHEMBL... |P27695    |6BOW      |T13348    |97.3%     |91.11%    |APEX1    |
|C1[C@H... |Cathep... |CHEMBL... |P07339    |4OD9      |T67102    |92.9%     |98.95%    |CTSD     |
|C1[C@H... |LSD1/C... |CHEMBL... |O60341    |5L3D      |Not Av... |91.71%    |97.09%    |KDM1A    |
|C1[C@H... |Endopl... |CHEMBL... |Q99714    |2O23      |Not Av... |89.3%     |70.16%    |HSD17B10 |
|C1[C@H... |Transc... |CHEMBL... |O15164    |4YBM      |Not Av... |89.13%    |95.56%    |TRIM24   |
|C1[C@H... |DNA to... |CHEMBL... |P11388    |6ZY5      |T17048    |88.76%    |89%       |TOP2A    |
|C1[C@H... |Glycin... |CHEMBL... |P23415    |4X5T      |T50269    |87.03%    |90.71%    |GLRA1    |
|C1[C@H... |Estrog... |CHEMBL242 |Q92731    |1QKM      |T80896    |86.62%    |98.35%    |ESR2     |
|C1[C@H... |Nuclea... |CHEMBL... |P19838    |1SVC      |Not Av... |85.02%    |96.09%    |NFKB1    |
|C1[C@H... |Riboso... |CHEMBL... |Q15418    |2Z7Q      |Not Av... |84.42%    |85.11%    |RPS6KA1  |
|C1[C@H... |IgG re... |CHEMBL... |P55899    |6FGB      |Not Av... |84.41%    |90.93%    |FCGRT    |
|C1[C@H... |Egl ni... |CHEMBL... |Q9GZT9    |4BQY      |Not Av... |83.24%    |93.4%     |EGLN1    |
|C1[C@H... |Arachi... |CHEMBL... |P18054    |3D3L      |Not Av... |81.74%    |75.57%    |ALOX12   |
|C1[C@H... |Casein... |CHEMBL... |P67870    |6TLS      |T51565    |81.25%    |99.23%    |CSNK2B   |
|...       |...       |...       |...       |...       |...       |...       |...       |...      |



## 网络药理学

### 靶点网络 (+化合物含量) 

Figure \@ref(fig:Network-pharmacology) (下方图) 为图Network pharmacology概览。

**(对应文件为 `Figure+Table/Network-pharmacology.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology.pdf}
\caption{Network pharmacology}\label{fig:Network-pharmacology}
\end{center}



### 炎症

Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}



### 靶点网络 (+化合物含量) + 炎症

Figure \@ref(fig:Network-pharmacology-with-disease) (下方图) 为图Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease.pdf}
\caption{Network pharmacology with disease}\label{fig:Network-pharmacology-with-disease}
\end{center}

Figure \@ref(fig:Targets-intersect-with-targets-of-diseases) (下方图) 为图Targets intersect with targets of diseases概览。

**(对应文件为 `Figure+Table/Targets-intersect-with-targets-of-diseases.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Targets-intersect-with-targets-of-diseases.pdf}
\caption{Targets intersect with targets of diseases}\label{fig:Targets-intersect-with-targets-of-diseases}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    ACE, PTGS2, MIF, PPARG, TLR4, MMP9, PARP1, NOS2, MMP2,
PPARA, F2R, IDO1, STAT3, RORC, CHRNB2, TRPA1, NR1H4, PTPN1,
ABCB1, KLK1, CDK5, CCR5, TACR1, ALOX5, PDE5A, ADORA1,
PIK3CG, MTOR, OPRM1, PROC, NFKB1, PLAU, NOS3, SERPINE1,
CNR2, NFE2L2, MAPK14, APP, CFTR, NR3C2, CD38, C5AR1, TGM2,
HIF1A, FPR2, ...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**



### 相关靶点与转录因子 FOXO 相关

数据库`Transcription Factor Target Gene Database` 检索：

Table \@ref(tab:Transcription-Factor-binding-sites) (下方表格) 为表格Transcription Factor binding sites概览。

**(对应文件为 `Figure+Table/Transcription-Factor-binding-sites.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有30090行10列，以下预览的表格可能省略部分数据；表格含有104个唯一`target'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item Start:  起始点
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Transcription-Factor-binding-sites)Transcription Factor binding sites

|target |TF_symbol |Motif     |Source |Strand |Start    |Stop     |PValue  |MatchS... |Overla... |
|:------|:---------|:---------|:------|:------|:--------|:--------|:-------|:---------|:---------|
|ACE    |CTCF      |CTCF_M... |JASPAR |-      |61556433 |61556451 |0.0E+00 |GGACCA... |19        |
|ACE    |FOXJ2     |FOXJ2_... |SELEX  |-      |61551959 |61551971 |4.0E-06 |GTAAAA... |13        |
|ACE    |MESP1     |MESP1_... |SELEX  |-      |61554628 |61554637 |9.0E-06 |AGCACC... |10        |
|ACE    |FOXJ2     |FOXJ2_... |SELEX  |-      |61551854 |61551861 |5.0E-06 |ATAAACAA  |8         |
|ACE    |TBX1      |TBX1_T... |SELEX  |-      |61552066 |61552085 |1.0E-06 |TTCACA... |20        |
|ACE    |HOXD9     |Hoxd9_... |SELEX  |-      |61551499 |61551508 |4.0E-06 |ACAATT... |10        |
|ACE    |BARX1     |BARX1_... |SELEX  |-      |61552008 |61552024 |4.0E-06 |TCATTA... |17        |
|ACE    |target    |SRY_HM... |SELEX  |+      |61551570 |61551584 |5.0E-06 |TTCTAT... |15        |
|ACE    |KLF16     |KLF16_... |SELEX  |-      |61554376 |61554386 |7.0E-06 |GACACA... |11        |
|ACE    |KLF16     |KLF16_... |SELEX  |-      |61554725 |61554735 |1.0E-05 |GCCCCG... |11        |
|ACE    |FOXG1     |FOXG1_... |SELEX  |+      |61551524 |61551540 |6.0E-06 |AAAAAC... |17        |
|ACE    |FOXG1     |FOXG1_... |SELEX  |-      |61551902 |61551918 |2.0E-06 |ATAAAT... |17        |
|ACE    |MEF2D     |MEF2D_... |SELEX  |+      |61551941 |61551952 |1.0E-06 |CCTAAA... |12        |
|ACE    |FOXC2     |FOXC2_... |SELEX  |-      |61551853 |61551864 |3.0E-06 |TGTATA... |12        |
|ACE    |PDX1      |PDX1_h... |SELEX  |-      |61551528 |61551545 |7.0E-06 |ACAATT... |18        |
|...    |...       |...       |...    |...    |...      |...      |...     |...       |...       |



### 富集分析 {#en}

Figure \@ref(fig:Ids-KEGG-enrichment) (下方图) 为图Ids KEGG enrichment概览。

**(对应文件为 `Figure+Table/Ids-KEGG-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ids-KEGG-enrichment.pdf}
\caption{Ids KEGG enrichment}\label{fig:Ids-KEGG-enrichment}
\end{center}

Figure \@ref(fig:Ids-GO-enrichment) (下方图) 为图Ids GO enrichment概览。

**(对应文件为 `Figure+Table/Ids-GO-enrichment.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Ids-GO-enrichment.pdf}
\caption{Ids GO enrichment}\label{fig:Ids-GO-enrichment}
\end{center}

GO 中，`regulation of inflammatory response` 通路的基因：

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
GO
:}

\vspace{0.5em}

    ACE, ADORA1, ALOX5, APP, CCR2, CNR1, CNR2, CYP19A1,
IDO1, MAPK14, MMP8, MMP9, NFKB1, NR1H3, PIK3CG, PLA2G2A,
PRKCD, PROC, PTGS2, SERPINE1, TLR4

\vspace{2em}
\end{tcolorbox}
\end{center}



### 口服利用度筛选

Figure \@ref(fig:HOB-20-prediction) (下方图) 为图HOB 20 prediction概览。

**(对应文件为 `Figure+Table/HOB-20-prediction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HOB-20-prediction.pdf}
\caption{HOB 20 prediction}\label{fig:HOB-20-prediction}
\end{center}



### 最终筛选过的网络药理图

Figure \@ref(fig:FINAL-Network-pharmacology) (下方图) 为图FINAL Network pharmacology概览。

**(对应文件为 `Figure+Table/FINAL-Network-pharmacology.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/FINAL-Network-pharmacology.pdf}
\caption{FINAL Network pharmacology}\label{fig:FINAL-Network-pharmacology}
\end{center}



## 分子对接

### 对接的成分 {#cpd}

选择了含量排名前 5 的成分对接 (从 Fig. \@ref(fig:Network-pharmacology-with-disease))。

\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Compounds
:}

\vspace{0.5em}

    Trigonelline HCl, 2-Pyrrolidinecarboxylic acid,
5-Hydroxymethylfurfural, Epiberberine, Nobiletin

\vspace{2em}
\end{tcolorbox}
\end{center}



### 对接结果

Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}

Table \@ref(tab:Overall-combining-Affinity-rawData) (下方表格) 为表格Overall combining Affinity rawData概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity-rawData.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有15行8列，以下预览的表格可能省略部分数据；表格含有5个唯一`PubChem\_id'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Overall-combining-Affinity-rawData)Overall combining Affinity rawData

|PubChe... |PDB_ID |Affinity |dir       |file      |Combn     |hgnc_s... |Ingred... |
|:---------|:------|:--------|:---------|:---------|:---------|:---------|:---------|
|160876    |2uzk   |-4.9     |vina_s... |vina_s... |160876... |FOXO3     |Epiber... |
|145742    |2uzk   |-4.502   |vina_s... |vina_s... |145742... |FOXO3     |2-Pyrr... |
|237332    |2uzk   |-4.177   |vina_s... |vina_s... |237332... |FOXO3     |5-Hydr... |
|72344     |2uzk   |-4.173   |vina_s... |vina_s... |72344_... |FOXO3     |Nobiletin |
|134606    |2uzk   |-1.563   |vina_s... |vina_s... |134606... |FOXO3     |Trigon... |
|145742    |6qvw   |-0.687   |vina_s... |vina_s... |145742... |FOXO1     |2-Pyrr... |
|160876    |6qvw   |-0.508   |vina_s... |vina_s... |160876... |FOXO1     |Epiber... |
|134606    |6qvw   |-0.506   |vina_s... |vina_s... |134606... |FOXO1     |Trigon... |
|237332    |6qvw   |-0.413   |vina_s... |vina_s... |237332... |FOXO1     |5-Hydr... |
|134606    |3l2c   |-0.203   |vina_s... |vina_s... |134606... |FOXO4     |Trigon... |
|145742    |3l2c   |0.559    |vina_s... |vina_s... |145742... |FOXO4     |2-Pyrr... |
|160876    |3l2c   |0.691    |vina_s... |vina_s... |160876... |FOXO4     |Epiber... |
|72344     |6qvw   |0.874    |vina_s... |vina_s... |72344_... |FOXO1     |Nobiletin |
|237332    |3l2c   |0.889    |vina_s... |vina_s... |237332... |FOXO4     |5-Hydr... |
|72344     |3l2c   |2.084    |vina_s... |vina_s... |72344_... |FOXO4     |Nobiletin |



