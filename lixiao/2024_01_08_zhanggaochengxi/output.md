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
红豆杉和养阴解毒汤的共同活性成分和作用靶点（m6A、铁死亡相关)}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-01-22}}
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



注：关于南方红豆杉的成分数据，使用的是 Taxus mairei (<https://plantaedb.com/taxa/phylum/gymnosperms/order/cupressales/family/taxaceae/genus/taxus/species/taxus-mairei>) 记录。更多关于红豆杉的记录可见 <https://plantaedb.com/search?src=Taxus>。

## 需求

co-targets > ATF3 > pathway (m6A) > ferroptosis
根据研究基础，养阴解毒汤能够促进IGFIBP2表达，抑制METTL3表达，如果红豆杉和养阴解毒汤都靶向 m6A 甲基化修饰相关的作用靶点XXX。推测：红豆杉和养阴解毒汤通过XXX/YYY途径调控基因m6A甲基化修饰，促进肺癌细胞铁死亡，从而抑制肺癌的发展。（机制尽可能的结合ATF3）

## 结果

注：红豆杉的靶点未发现 ATF3，因此红豆杉和养阴解毒的共同靶点未包括 ATF3。

- 分别分析了 养阴解毒汤 (YYJD) 和 红豆杉 (HDS) 的成分和靶点。
    - YYDS：由于 YYDS 的南方红豆杉成分，多数中药数据库 (HERB、TCMSP 等) 没有该条目，这里使用了 PlantaeDb 中的成分记录 (Tab. \@ref(tab:Taxus-mairei-compounds-from-plantaeDb)) 。
    - YYDS：由于 PlantaeDb 中的成分没有靶点信息，因此这里用 Super-Pred 预测了这些化合物的靶点 (先以 HOB 预测20%口服利药度，过滤了一部分成分) (Tab. \@ref(tab:Taxus-mairei-compounds-targets-predicted-by-Super-Pred)) 。
    - YYDS：最终的成分靶点数据整合了来自于 HERB 的其它中药的成分靶点数据 (这里，也用 Super-Pred 补充了它们的靶点)，和来自于 PlantaeDb 的南方红豆杉的成分靶点。最终图和表见 Fig. \@ref(fig:MERGE-network-pharmacology-visualization), Tab. \@ref(tab:MERGE-Herbs-compounds-and-targets)
    - HDS：分析思路同 YYDS，结合了 HERB 数据库的记录和 Super-Pred 的预测。Fig. \@ref(fig:HDS-network-pharmacology-visualization), Tab. \@ref(tab:HDS-Herbs-compounds-and-targets)
- YYDS 和 HDS 的共同靶点见 Fig. \@ref(fig:Intersected-targets-of-YYJD-and-HDS)
- 铁死亡相关的基因集来自于 `FerrDb V2`。Tab. \@ref(tab:Ferroptosis-regulators)
- 肺癌和 m6A 相关的基因集都来自于 GeneCards (Tab. \@ref(tab:Lung-cancer-GeneCards-used-data), Tab. \@ref(tab:M6A-GeneCards-used-data))。
- 最终结果采取交集方式：共同靶点 + 驱动铁死亡的调控基因 + 肺癌靶点 + m6A 相关，见 Fig. \@ref(fig:m6A-related-of-alls) 和 Fig. \@ref(fig:All-intersection)。筛选出的基因为：PRKAA1

# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- R package `ClusterProfiler` used for gene enrichment analysis[@ClusterprofilerWuTi2021].
- Website `HERB` <http://herb.ac.cn/> used for data source[@HerbAHighThFang2021].
- Python tool of `HOB` was used for prediction of human oral bioavailability[@HobpreAccuratWeiM2022].
- The API of `m6A-Atlas` used for obtaining m6A related data from the website[@M6aAtlasV20Liang2024].
- The Database `PlantaeDB` <https://plantaedb.com/> used for collating data of herbal ingredients.
- Web tool of `Super-PRED` used for drug-targets prediction[@SuperpredUpdaNickel2014].
- R package `STEINGdb` used for PPI network construction[@TheStringDataSzklar2021; @CytohubbaIdenChin2014].
- The Human Gene Database `GeneCards` used for disease related genes prediction[@TheGenecardsSStelze2016].
- R package `UniProt.ws` used for querying Gene or Protein information.
- Database of `FerrDb V2` used for obtaining ferroptosis regulators[@FerrdbV2UpdaZhou2023].
- Database of `MSigDB` (c2, curated gene sets) was used for signiture screening.
- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

<https://plantaedb.com/>
<https://bidd.group/NPASS/index.php>
<https://plantaedb.com/>

## 网络药理学分析

### 养阴解毒汤

#### 南方红豆杉 Taxus-mairei

Table \@ref(tab:Taxus-mairei-compounds-from-plantaeDb) (下方表格) 为表格Taxus mairei compounds from plantaeDb概览。

**(对应文件为 `Figure+Table/Taxus-mairei-compounds-from-plantaeDb.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有302行8列，以下预览的表格可能省略部分数据；表格含有1个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Taxus-mairei-compounds-from-plantaeDb)Taxus mairei compounds from plantaeDb

|.id       |classes   |Name      |PubChe... |Canoni... |MW     |Found in |Proof     |
|:---------|:---------|:---------|:---------|:---------|:------|:--------|:---------|
|Taxus ... |> Alka... |CID 30956 |30956     |CC1CC=... |507.60 |unknown  |https:... |
|Taxus ... |> Alka... |cytoch... |5458428   |CC1CC=... |507.60 |unknown  |https:... |
|Taxus ... |> Benz... |3,4-Di... |72        |C1=CC(... |154.12 |unknown  |https:... |
|Taxus ... |> Benz... |(3S)-8... |486250    |CC1CC2... |222.19 |unknown  |https:... |
|Taxus ... |> Benz... |8-Hydr... |5242129   |CC1CC2... |222.19 |unknown  |https:... |
|Taxus ... |> Benz... |Methyl... |7456      |COC(=O... |152.15 |unknown  |https:... |
|Taxus ... |> Benz... |Honokiol  |72303     |C=CCC1... |266.30 |unknown  |https:... |
|Taxus ... |> Benz... |3-(4-H... |82452     |C1=CC(... |152.19 |unknown  |https:... |
|Taxus ... |> Benz... |2-Prop... |9984      |COC1=C... |178.18 |unknown  |https:... |
|Taxus ... |> Benz... |4-[[(5... |163079914 |CC1(OC... |402.50 |unknown  |https:... |
|Taxus ... |> Benz... |4-[[6-... |141864758 |CC1(OC... |402.50 |unknown  |https:... |
|Taxus ... |> Benz... |4-Hydr... |5280536   |COC1=C... |178.18 |unknown  |https:... |
|Taxus ... |> Benz... |Dihydr... |16822     |COC1=C... |182.22 |unknown  |https:... |
|Taxus ... |> Benz... |Isovan... |12127     |COC1=C... |152.15 |unknown  |https:... |
|Taxus ... |> Lign... |4-[(5a... |137796452 |CC1(OC... |386.40 |unknown  |https:... |
|...       |...       |...       |...       |...       |...    |...      |...       |

Figure \@ref(fig:Taxus-mairei-compounds-HOB-20-prediction) (下方图) 为图Taxus mairei compounds HOB 20 prediction概览。

**(对应文件为 `Figure+Table/Taxus-mairei-compounds-HOB-20-prediction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Taxus-mairei-compounds-HOB-20-prediction.pdf}
\caption{Taxus mairei compounds HOB 20 prediction}\label{fig:Taxus-mairei-compounds-HOB-20-prediction}
\end{center}

Table \@ref(tab:Taxus-mairei-compounds-targets-predicted-by-Super-Pred) (下方表格) 为表格Taxus mairei compounds targets predicted by Super Pred概览。

**(对应文件为 `Figure+Table/Taxus-mairei-compounds-targets-predicted-by-Super-Pred.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有13879行9列，以下预览的表格可能省略部分数据；表格含有126个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Taxus-mairei-compounds-targets-predicted-by-Super-Pred)Taxus mairei compounds targets predicted by Super Pred

|.id       |Target... |ChEMBL-ID |UniPro... |PDB Vi... |TTD ID    |Probab... |Model ... |symbols |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:-------|
|CC[C@H... |Nuclea... |CHEMBL... |P19838    |1SVC      |Not Av... |97.23%    |96.09%    |NFKB1   |
|CC[C@H... |Cathep... |CHEMBL... |P07339    |4OD9      |T67102    |96.37%    |98.95%    |CTSD    |
|CC[C@H... |Adenos... |CHEMBL226 |P30542    |5N2S      |T92072    |94.33%    |95.93%    |ADORA1  |
|CC[C@H... |Cannab... |CHEMBL253 |P34972    |6KPF      |Not Av... |93.89%    |97.25%    |CNR2    |
|CC[C@H... |Dual s... |CHEMBL... |Q9HAZ1    |6FYV      |Not Av... |92.7%     |94.45%    |CLK4    |
|CC[C@H... |Cycloo... |CHEMBL221 |P23219    |6Y3C      |Not Av... |91.59%    |90.17%    |PTGS1   |
|CC[C@H... |Minera... |CHEMBL... |P08235    |4PF3      |Not Av... |90.65%    |100%      |NR3C2   |
|CC[C@H... |Glutam... |CHEMBL... |Q05586    |5EWM      |Not Av... |90.47%    |95.89%    |GRIN1   |
|CC[C@H... |G-prot... |CHEMBL... |Q9Y2T6    |Not Av... |T87670    |90.05%    |78.15%    |GPR55   |
|CC[C@H... |Formyl... |CHEMBL... |P21462    |Not Av... |T87831    |89.44%    |93.56%    |FPR1    |
|CC[C@H... |Glycin... |CHEMBL... |P23415    |4X5T      |T50269    |89.42%    |90.71%    |GLRA1   |
|CC[C@H... |LSD1/C... |CHEMBL... |O60341    |5L3D      |Not Av... |88.56%    |97.09%    |KDM1A   |
|CC[C@H... |DNA-(a... |CHEMBL... |P27695    |6BOW      |T13348    |87.72%    |91.11%    |APEX1   |
|CC[C@H... |NT-3 g... |CHEMBL... |Q16288    |6KZD      |Not Av... |83.36%    |95.89%    |NTRK3   |
|CC[C@H... |Androg... |CHEMBL... |P10275    |3V49      |T11211    |83.21%    |96.43%    |AR      |
|...       |...       |...       |...       |...       |...       |...       |...       |...     |





#### 其它中药 MIX

以下靶点数据来源于 HERB 数据库：

Table \@ref(tab:MIX-Herbs-compounds-and-targets-from-HERB) (下方表格) 为表格MIX Herbs compounds and targets from HERB概览。

**(对应文件为 `Figure+Table/MIX-Herbs-compounds-and-targets-from-HERB.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有20801行9列，以下预览的表格可能省略部分数据；表格含有835个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MIX-Herbs-compounds-and-targets-from-HERB)MIX Herbs compounds and targets from HERB

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target... |Databa... |Paper.id |... |
|:-------------|:---------|:-------------|:-------------|:---------|:---------|:---------|:--------|:---|
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ATIC      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |FPGS      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |GART      |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD1    |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD2    |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ALDH1L1   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD1L   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTFMT     |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |ALDH1L2   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10,12-...     |NA            |HBTAR0... |MTHFD2L   |NA        |NA       |... |
|HBIN00...     |SHI HU    |10β,13...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |BEI SH... |10-epi...     |NA            |NA        |NA        |NA        |NA       |... |
|HBIN00...     |DANG SHEN |11alph...     |11α-me...     |NA        |NA        |NA        |NA       |... |
|HBIN00...     |DANG SHEN |11-Hyd...     |Spiro(...     |HBTAR0... |CDK2      |NA        |NA       |... |
|HBIN00...     |DANG SHEN |11-Hyd...     |Spiro(...     |HBTAR0... |ESR1      |NA        |NA       |... |
|...           |...       |...           |...           |...       |...       |...       |...      |... |

Figure \@ref(fig:MIX-HOB-20-prediction) (下方图) 为图MIX HOB 20 prediction概览。

**(对应文件为 `Figure+Table/MIX-HOB-20-prediction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MIX-HOB-20-prediction.pdf}
\caption{MIX HOB 20 prediction}\label{fig:MIX-HOB-20-prediction}
\end{center}

补充了预测的靶点数据：

Table \@ref(tab:MIX-compounds-targets-predicted-by-Super-Pred) (下方表格) 为表格MIX compounds targets predicted by Super Pred概览。

**(对应文件为 `Figure+Table/MIX-compounds-targets-predicted-by-Super-Pred.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有42305行9列，以下预览的表格可能省略部分数据；表格含有387个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MIX-compounds-targets-predicted-by-Super-Pred)MIX compounds targets predicted by Super Pred

|.id       |Target... |ChEMBL-ID |UniPro... |PDB Vi... |TTD ID    |Probab... |Model ... |symbols  |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:--------|
|C1=CC(... |Transc... |CHEMBL... |O15164    |4YBM      |Not Av... |94.7%     |95.56%    |TRIM24   |
|C1=CC(... |Endopl... |CHEMBL... |Q99714    |2O23      |Not Av... |93.9%     |70.16%    |HSD17B10 |
|C1=CC(... |Monoam... |CHEMBL... |P21397    |2Z5Y      |Not Av... |90.07%    |91.49%    |MAOA     |
|C1=CC(... |Transt... |CHEMBL... |P02766    |6SUG      |T86462    |88.39%    |90.71%    |TTR      |
|C1=CC(... |DNA-(a... |CHEMBL... |P27695    |6BOW      |T13348    |87.23%    |91.11%    |APEX1    |
|C1=CC(... |Serine... |CHEMBL... |O75460    |6W39      |Not Av... |81.09%    |98.11%    |ERN1     |
|C1=CC(... |Dual s... |CHEMBL... |Q9HAZ1    |6FYV      |Not Av... |80.64%    |94.45%    |CLK4     |
|C1=CC(... |Pregna... |CHEMBL... |O75469    |6TFI      |T82702    |79.78%    |94.73%    |NR1I2    |
|C1=CC(... |Estrog... |CHEMBL242 |Q92731    |1QKM      |T80896    |79.45%    |98.35%    |ESR2     |
|C1=CC(... |Kruppe... |CHEMBL... |Q13887    |Not Av... |Not Av... |79.32%    |86.33%    |KLF5     |
|C1=CC(... |Protea... |CHEMBL... |P20618    |6KWY      |Not Av... |77.67%    |90%       |PSMB1    |
|C1=CC(... |Cytoch... |CHEMBL... |P11509    |2FDV      |T06455    |76.23%    |71.78%    |CYP2A6   |
|C1=CC(... |C-X-C ... |CHEMBL... |P61073    |3ODU      |T96079    |76.12%    |93.1%     |CXCR4    |
|C1=CC(... |Tyrosy... |CHEMBL... |Q9NUW8    |6N0D      |Not Av... |75.1%     |71.22%    |TDP1     |
|C1=CC(... |Cathep... |CHEMBL... |P07339    |4OD9      |T67102    |75.01%    |98.95%    |CTSD     |
|...       |...       |...       |...       |...       |...       |...       |...       |...      |



#### 合并 MERGE

Figure \@ref(fig:MERGE-Intersection-of-herbs-all-targets) (下方图) 为图MERGE Intersection of herbs all targets概览。

**(对应文件为 `Figure+Table/MERGE-Intersection-of-herbs-all-targets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MERGE-Intersection-of-herbs-all-targets.pdf}
\caption{MERGE Intersection of herbs all targets}\label{fig:MERGE-Intersection-of-herbs-all-targets}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    ACHE, GRIA2, PRSS1, PTGS2, NOS2, DPP4, GABRA1, CHRM2,
CNR2, CTSD, NFKB1, APEX1, TDP1, TRIM24, FPR1, BLM, GRIN1,
KDM1A, NR3C2, NR1I2, ADAM10, DPP8, NTRK3, FCGRT, KLF5,
TOP2A, S1PR5, CYP3A4, PIK3R1, DRD1, SLC6A5, CSNK2B, CDK5,
FPR2, CACNA1B, HSD17B10, GPR55, PLA2G2A, GPBAR1, DPP9,
TLR4, ACACA, CHRM...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/MERGE-Intersection-of-herbs-all-targets-content`)**

Figure \@ref(fig:MERGE-Intersection-of-herbs-compounds) (下方图) 为图MERGE Intersection of herbs compounds概览。

**(对应文件为 `Figure+Table/MERGE-Intersection-of-herbs-compounds.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MERGE-Intersection-of-herbs-compounds.pdf}
\caption{MERGE Intersection of herbs compounds}\label{fig:MERGE-Intersection-of-herbs-compounds}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}



\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/MERGE-Intersection-of-herbs-compounds-content`)**

Figure \@ref(fig:MERGE-network-pharmacology-visualization) (下方图) 为图MERGE network pharmacology visualization概览。

**(对应文件为 `Figure+Table/MERGE-network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/MERGE-network-pharmacology-visualization.pdf}
\caption{MERGE network pharmacology visualization}\label{fig:MERGE-network-pharmacology-visualization}
\end{center}

药方所有的成分、靶点数据：

Table \@ref(tab:MERGE-Herbs-compounds-and-targets) (下方表格) 为表格MERGE Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/MERGE-Herbs-compounds-and-targets.tsv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有70759行10列，以下预览的表格可能省略部分数据；表格含有961个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:MERGE-Herbs-compounds-and-targets)MERGE Herbs compounds and targets

|Ingred......1 |Herb_p... |Ingred......3 |Ingred......4 |Target.id |Target......6 |Databa... |Paper.id |... |
|:-------------|:---------|:-------------|:-------------|:---------|:-------------|:---------|:--------|:---|
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |APEX1         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |NFKB1         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |KDM1A         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |HTR2C         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |HIF1A         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |TRIM24        |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |BLM           |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |SLC6A5        |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |GPR55         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |CTSD          |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |KLF5          |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |PRCP          |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |C5AR1         |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |THRA          |NA        |NA       |... |
|10022393      |Taxus ... |(7R)-7...     |NA            |NA        |PSMB1         |NA        |NA       |... |
|...           |...       |...           |...           |...       |...           |...       |...      |... |



### 红豆杉

以下是收集自 HERB 数据库的成分、靶点数据：

Table \@ref(tab:HDS-Herbs-compounds-and-targets-from-HERB) (下方表格) 为表格HDS Herbs compounds and targets from HERB概览。

**(对应文件为 `Figure+Table/HDS-Herbs-compounds-and-targets-from-HERB.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有128行7列，以下预览的表格可能省略部分数据；表格含有105个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:HDS-Herbs-compounds-and-targets-from-HERB)HDS Herbs compounds and targets from HERB

|Ingredient.id |Herb_pinyi... |Ingredient......3 |Ingredient......4 |Target.id |Target.name |Database.s... |... |
|:-------------|:-------------|:-----------------|:-----------------|:---------|:-----------|:-------------|:---|
|HBIN000081    |HONG DOU SHAN |10-deacety...     |NA                |NA        |NA          |NA            |... |
|HBIN000084    |HONG DOU SHAN |10-deacety...     |NA                |NA        |NA          |NA            |... |
|HBIN001104    |HONG DOU SHAN |1,3,7,8-te...     |1,3,7,8-te...     |NA        |NA          |NA            |... |
|HBIN001125    |HONG DOU SHAN |13-acetyl-...     |NA                |NA        |NA          |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |NA          |NA            |... |
|HBIN001379    |HONG DOU SHAN |14β-benzoy...     |NA                |NA        |NA          |NA            |... |
|HBIN001380    |HONG DOU SHAN |14β-benzoy...     |NA                |NA        |NA          |NA            |... |
|HBIN001381    |HONG DOU SHAN |14β-benzoy...     |NA                |NA        |NA          |NA            |... |
|HBIN001385    |HONG DOU SHAN |14β-hydrox...     |NA                |NA        |NA          |NA            |... |
|HBIN002352    |HONG DOU SHAN |1β,2β,9α-t...     |1beta,2bet...     |NA        |NA          |NA            |... |
|HBIN002387    |HONG DOU SHAN |1beta-dehy...     |1β-dehydro...     |NA        |NA          |NA            |... |
|HBIN002399    |HONG DOU SHAN |1β-hydroxy...     |NA                |NA        |NA          |NA            |... |
|HBIN002663    |HONG DOU SHAN |1-hydroxyt...     |NA                |NA        |NA          |NA            |... |
|HBIN005241    |HONG DOU SHAN |2alpha,5al...     |NA                |NA        |NA          |NA            |... |
|HBIN005242    |HONG DOU SHAN |2α,5α,10β-...     |2alpha,5al...     |NA        |NA          |NA            |... |
|...           |...           |...               |...               |...       |...         |...           |... |

Figure \@ref(fig:HDS-HOB-20-prediction) (下方图) 为图HDS HOB 20 prediction概览。

**(对应文件为 `Figure+Table/HDS-HOB-20-prediction.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HDS-HOB-20-prediction.pdf}
\caption{HDS HOB 20 prediction}\label{fig:HDS-HOB-20-prediction}
\end{center}

以 Super-Pred 预测更多的靶点：

Table \@ref(tab:HDS-compounds-targets-predicted-by-Super-Pred) (下方表格) 为表格HDS compounds targets predicted by Super Pred概览。

**(对应文件为 `Figure+Table/HDS-compounds-targets-predicted-by-Super-Pred.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2050行9列，以下预览的表格可能省略部分数据；表格含有18个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:HDS-compounds-targets-predicted-by-Super-Pred)HDS compounds targets predicted by Super Pred

|.id       |Target... |ChEMBL-ID |UniPro... |PDB Vi... |TTD ID    |Probab... |Model ... |symbols |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:-------|
|CC1=CC... |Bloom ... |CHEMBL... |P54132    |4O3M      |Not Av... |98.7%     |70.06%    |BLM     |
|CC1=CC... |Tyrosy... |CHEMBL... |Q9NUW8    |6N0D      |Not Av... |97.89%    |71.22%    |TDP1    |
|CC1=CC... |Nuclea... |CHEMBL... |P19838    |1SVC      |Not Av... |97.37%    |96.09%    |NFKB1   |
|CC1=CC... |DNA-(a... |CHEMBL... |P27695    |6BOW      |T13348    |93.58%    |91.11%    |APEX1   |
|CC1=CC... |Cannab... |CHEMBL253 |P34972    |6KPF      |Not Av... |91.48%    |97.25%    |CNR2    |
|CC1=CC... |Cathep... |CHEMBL... |P07339    |4OD9      |T67102    |91.07%    |98.95%    |CTSD    |
|CC1=CC... |Protei... |CHEMBL... |Q05655    |1YRK      |T44861    |88.96%    |97.79%    |PRKCD   |
|CC1=CC... |Dual s... |CHEMBL... |Q9HAZ1    |6FYV      |Not Av... |88.61%    |94.45%    |CLK4    |
|CC1=CC... |Kruppe... |CHEMBL... |Q13887    |Not Av... |Not Av... |85.83%    |86.33%    |KLF5    |
|CC1=CC... |Glutam... |CHEMBL... |P42262    |2WJW      |T42392    |82.94%    |86.92%    |GRIA2   |
|CC1=CC... |Transc... |CHEMBL... |O15164    |4YBM      |Not Av... |82.59%    |95.56%    |TRIM24  |
|CC1=CC... |DNA to... |CHEMBL... |P11388    |6ZY5      |T17048    |82.58%    |89%       |TOP2A   |
|CC1=CC... |Cytoch... |CHEMBL340 |P08684    |5VCC      |T37848    |82.47%    |91.19%    |CYP3A4  |
|CC1=CC... |Minera... |CHEMBL... |P08235    |4PF3      |Not Av... |82.02%    |100%      |NR3C2   |
|CC1=CC... |Muscar... |CHEMBL... |P08912    |6OL9      |T79961    |81.06%    |94.62%    |CHRM5   |
|...       |...       |...       |...       |...       |...       |...       |...       |...     |

合并了预测的靶点后的数据：

Figure \@ref(fig:HDS-network-pharmacology-visualization) (下方图) 为图HDS network pharmacology visualization概览。

**(对应文件为 `Figure+Table/HDS-network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/HDS-network-pharmacology-visualization.pdf}
\caption{HDS network pharmacology visualization}\label{fig:HDS-network-pharmacology-visualization}
\end{center}

Table \@ref(tab:HDS-Herbs-compounds-and-targets) (下方表格) 为表格HDS Herbs compounds and targets概览。

**(对应文件为 `Figure+Table/HDS-Herbs-compounds-and-targets.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有2139行7列，以下预览的表格可能省略部分数据；表格含有105个唯一`Ingredient.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:HDS-Herbs-compounds-and-targets)HDS Herbs compounds and targets

|Ingredient.id |Herb_pinyi... |Ingredient......3 |Ingredient......4 |Target.id |Target.name |Database.s... |... |
|:-------------|:-------------|:-----------------|:-----------------|:---------|:-----------|:-------------|:---|
|HBIN000081    |HONG DOU SHAN |10-deacety...     |NA                |NA        |NA          |NA            |... |
|HBIN000084    |HONG DOU SHAN |10-deacety...     |NA                |NA        |NA          |NA            |... |
|HBIN001104    |HONG DOU SHAN |1,3,7,8-te...     |1,3,7,8-te...     |NA        |NA          |NA            |... |
|HBIN001125    |HONG DOU SHAN |13-acetyl-...     |NA                |NA        |NA          |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |NFKB1       |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |KLF5        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |TDP1        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |RORB        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |PTGS1       |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |NPC1        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |CTSD        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |CHRM5       |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |MAOA        |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |TRIM24      |NA            |... |
|HBIN001159    |HONG DOU SHAN |13-deaceto...     |NA                |NA        |APEX1       |NA            |... |
|...           |...           |...               |...               |...       |...         |...           |... |





### 养阴解毒汤和红豆杉共同靶点 coSig

Figure \@ref(fig:Intersected-targets-of-YYJD-and-HDS) (下方图) 为图Intersected targets of YYJD and HDS概览。

**(对应文件为 `Figure+Table/Intersected-targets-of-YYJD-and-HDS.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersected-targets-of-YYJD-and-HDS.pdf}
\caption{Intersected targets of YYJD and HDS}\label{fig:Intersected-targets-of-YYJD-and-HDS}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    APEX1, NFKB1, KDM1A, HTR2C, HIF1A, TRIM24, BLM, SLC6A5,
GPR55, CTSD, KLF5, PRCP, C5AR1, THRA, PSMB1, HSD17B10,
TOP2A, GUSB, NTRK3, NFE2L2, GRIA2, HDAC8, SLC2A1, NR1I2,
CACNA1B, ALOX12, PRKCZ, CYP3A4, DUSP3, KIF11, CLK4, GRIN1,
KCNA5, ADAM10, SCD, PDE3A, CCR1, HDAC9, DPP8, TTR, SLC9A1,
GLS, S1PR5,...

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersected-targets-of-YYJD-and-HDS-content`)**



## 铁死亡

### `FerrDb V2` 基因集

 
`Ferroptosis regulators' 数据已全部提供。

**(对应文件为 `Figure+Table/Ferroptosis-regulators`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹Figure+Table/Ferroptosis-regulators共包含4个文件。

\begin{enumerate}\tightlist
\item 1\_marker.csv
\item 2\_driver.csv
\item 3\_suppressor.csv
\item 4\_unclassifier.csv
\end{enumerate}\end{tcolorbox}
\end{center}



### Ferroptosis Driver 与 coSig 交集

Figure \@ref(fig:The-common-Targets-related-to-ferroptosis-driver) (下方图) 为图The common Targets related to ferroptosis driver概览。

**(对应文件为 `Figure+Table/The-common-Targets-related-to-ferroptosis-driver.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/The-common-Targets-related-to-ferroptosis-driver.pdf}
\caption{The common Targets related to ferroptosis driver}\label{fig:The-common-Targets-related-to-ferroptosis-driver}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    HIF1A, ALOX12, NOX1, MDM4, TLR4, KEAP1, ABCC1, IDO1,
PRKAA1, MAP3K11, KDM5C, KDM5A, MAPK1, PIK3CA, STING1,
MAP3K14, TBK1, ALOX5, PPARG, PRKCA, CTSB, DPP4, GSK3B,
MAPK14, SIRT1, FLT3

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/The-common-Targets-related-to-ferroptosis-driver-content`)**



## 肺癌

### 肺癌相关基因集

GeneCards Score &gt; 3

Table \@ref(tab:Lung-cancer-GeneCards-used-data) (下方表格) 为表格Lung cancer GeneCards used data概览。

**(对应文件为 `Figure+Table/Lung-cancer-GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有945行7列，以下预览的表格可能省略部分数据；表格含有945个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Lung-cancer-GeneCards-used-data)Lung cancer GeneCards used data

|Symbol   |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:--------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|KRAS     |KRAS Proto... |Protein Co... |P01116     |61    |GC12M028437 |74.63 |
|BRAF     |B-Raf Prot... |Protein Co... |P15056     |62    |GC07M140762 |73.07 |
|EGFR-AS1 |EGFR Antis... |RNA Gene      |           |23    |GC07M055179 |64.72 |
|PIK3CA   |Phosphatid... |Protein Co... |P42336     |61    |GC03P179148 |63.70 |
|ALK      |ALK Recept... |Protein Co... |Q9UM73     |59    |GC02M029190 |61.05 |
|ERBB2    |Erb-B2 Rec... |Protein Co... |P04626     |63    |GC17P039687 |61.00 |
|CDKN2A   |Cyclin Dep... |Protein Co... |Q8N726     |60    |GC09M021967 |58.81 |
|CTNNB1   |Catenin Be... |Protein Co... |P35222     |62    |GC03P041194 |58.62 |
|MYC      |MYC Proto-... |Protein Co... |P01106     |61    |GC08P127735 |52.43 |
|LUCAT1   |Lung Cance... |RNA Gene      |           |23    |GC05M091054 |52.39 |
|AKT1     |AKT Serine... |Protein Co... |P31749     |62    |GC14M104769 |52.22 |
|HRAS     |HRas Proto... |Protein Co... |P01112     |61    |GC11M010201 |51.36 |
|PTEN     |Phosphatas... |Protein Co... |P60484     |60    |GC10P106636 |50.58 |
|ERCC6    |ERCC Excis... |Protein Co... |Q03468     |55    |GC10M049454 |50.54 |
|STK11    |Serine/Thr... |Protein Co... |Q15831     |59    |GC19P001177 |50.19 |
|...      |...           |...           |...        |...   |...         |...   |

### coSig-ferroptosis 与 肺癌交集

Figure \@ref(fig:Intersection-of-coSigFe-genes-with-Lung-cancer-signatures) (下方图) 为图Intersection of coSigFe genes with Lung cancer signatures概览。

**(对应文件为 `Figure+Table/Intersection-of-coSigFe-genes-with-Lung-cancer-signatures.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Intersection-of-coSigFe-genes-with-Lung-cancer-signatures.pdf}
\caption{Intersection of coSigFe genes with Lung cancer signatures}\label{fig:Intersection-of-coSigFe-genes-with-Lung-cancer-signatures}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    IDO1, PRKAA1, PIK3CA, ALOX5

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Intersection-of-coSigFe-genes-with-Lung-cancer-signatures-content`)**





## m6A 相关

### N6-Methyladenosine 基因集

GeneCards Score &gt; 1

Table \@ref(tab:M6A-GeneCards-used-data) (下方表格) 为表格M6A GeneCards used data概览。

**(对应文件为 `Figure+Table/M6A-GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有1460行7列，以下预览的表格可能省略部分数据；表格含有1460个唯一`Symbol'。
\end{tcolorbox}
\end{center}

Table: (\#tab:M6A-GeneCards-used-data)M6A GeneCards used data

|Symbol  |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:-------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|YTHDF2  |YTH N6-Met... |Protein Co... |Q9Y5A9     |45    |GC01P034802 |46.37 |
|YTHDF1  |YTH N6-Met... |Protein Co... |Q9BYJ9     |44    |GC20M063195 |41.09 |
|YTHDF3  |YTH N6-Met... |Protein Co... |Q7Z739     |43    |GC08P063168 |40.02 |
|YTHDC1  |YTH N6-Met... |Protein Co... |Q96MU7     |46    |GC04M068310 |37.59 |
|YTHDC2  |YTH N6-Met... |Protein Co... |Q9H6S0     |44    |GC05P113513 |37.19 |
|METTL3  |Methyltran... |Protein Co... |Q86U44     |50    |GC14M021498 |22.54 |
|METTL14 |Methyltran... |Protein Co... |Q9HCE5     |46    |GC04P118685 |13.41 |
|VIRMA   |Vir Like M... |Protein Co... |Q69YN4     |41    |GC08M094496 |11.79 |
|XIST    |X Inactive... |RNA Gene      |           |30    |GC0XM073820 |11.78 |
|METTL16 |Methyltran... |Protein Co... |Q86W50     |41    |GC17M002405 |10.84 |
|ZC3H13  |Zinc Finge... |Protein Co... |Q5T200     |39    |GC13M045954 |10.16 |
|ALKBH5  |AlkB Homol... |Protein Co... |Q6P6C2     |43    |GC17P018183 |9.99  |
|FTO     |FTO Alpha-... |Protein Co... |Q9C0B1     |55    |GC16P067676 |9.67  |
|IGF2BP2 |Insulin Li... |Protein Co... |Q9Y6M1     |53    |GC03M185643 |9.60  |
|WTAP    |WT1 Associ... |Protein Co... |Q15007     |45    |GC06P159725 |9.31  |
|...     |...           |...           |...        |...   |...         |...   |

### coSig-ferroptosis-cancer 与 m6A 相关

Figure \@ref(fig:m6A-related-of-alls) (下方图) 为图m6A related of alls概览。

**(对应文件为 `Figure+Table/m6A-related-of-alls.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/m6A-related-of-alls.pdf}
\caption{M6A related of alls}\label{fig:m6A-related-of-alls}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
Intersection
:}

\vspace{0.5em}

    PRKAA1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/m6A-related-of-alls-content`)**



## 汇总

Figure \@ref(fig:All-intersection) (下方图) 为图All intersection概览。

**(对应文件为 `Figure+Table/All-intersection.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/All-intersection.pdf}
\caption{All intersection}\label{fig:All-intersection}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    PRKAA1

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/All-intersection-content`)**







