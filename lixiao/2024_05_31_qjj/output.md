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








\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 摘要 {#abstract}


```r
dic(di("差异表达基因", "Differential Expressed Genes", "DEGs"),
  di("非酒精性脂肪肝")
)

# DEGs: Differential Expressed Genes 差异表达基因
# NFLD: Nonalcoholic fatty liver disease 非酒精性脂肪肝
```



# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Databses of `DisGeNet`, `GeneCards`, `PharmGKB` used for collating disease related targets[@TheDisgenetKnPinero2019; @TheGenecardsSStelze2016; @PharmgkbAWorBarbar2018].
- Website `HERB` <http://herb.ac.cn/> used for TCM data source[@HerbAHighThFang2021].
- R package `PubChemR` used for querying compounds information.
- Web tool of `Super-PRED` used for drug-targets relationship prediction[@SuperpredUpdaNickel2014].
- The CLI tools of `AutoDock vina` and `ADFR` software used for auto molecular docking[@AutodockVina1Eberha2021; @AutogridfrImpZhang2019; @AutodockCrankpZhang2019; @AutositeAnAuRavind2016; @AutodockfrAdvRavind2015].
- R package `ChemmineR` used for similar chemical compounds clustering[@ChemminerACoCaoY2008].
- R version 4.4.0 (2024-04-24); Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}

## 成分

- Aconitic acid
- Dianthoside
- Allo Maltol
- 6-Hydroxycoumarin
- Homovanillyl alcohol 4-O-glucoside
- Epicatechin
- Isoquercetin
- Berberine
- Quinic acid
- 2-Furoic acid
- Adoxosidic acid
- Neochlorogenic acid
- 3-O-Feruloylquinic acid
- Rutin
- Quercetin
- Isorhamnetin
- Gingerol


```r
cpds <- c("Aconitic acid", "Dianthoside", "Allo Maltol", "6-Hydroxycoumarin", "Homovanillyl alcohol 4-O-glucoside",
  "Epicatechin", "Isoquercetin", "Berberine", "Quinic acid", "2-Furoic acid", "Adoxosidic acid",
  "Neochlorogenic acid", "3-O-Feruloylquinic acid", "Rutin", "Quercetin",
  "Isorhamnetin", "Gingerol")
infoCpds <- PubChemR::get_cids(cpds)
infoCpds <- dplyr::distinct(infoCpds, Identifier, .keep_all = T)
if (!identical(nrow(infoCpds), length(cpds))) {
  message("Not Found some compounds.")
}
infoCpds <- dplyr::mutate(infoCpds, CID = as.integer(CID))
infoCpds
```


```r
pub <- job_pubchemr(nl(infoCpds$Identifier, infoCpds$CID, F))
pub <- step1(pub)
```

## 成分靶点


```r
sup <- asjob_superpred(pub)
sup <- step1(sup)
sup@tables$step1$targets
```


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Targets-predicted-by-Super-Pred) (下方表格) 为表格Targets predicted by Super Pred概览。

**(对应文件为 `Figure+Table/Targets-predicted-by-Super-Pred.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有827行9列，以下预览的表格可能省略部分数据；含有17个唯一`.id'。
\end{tcolorbox}
\end{center}

Table: (\#tab:Targets-predicted-by-Super-Pred)Targets predicted by Super Pred

|.id       |Target... |ChEMBL-ID |UniPro... |PDB Vi... |TTD ID    |Probab... |Model ... |symbols |
|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:---------|:-------|
|C1=CC(... |Tyrosy... |CHEMBL... |Q9NUW8    |6N0D      |Not Av... |99.49%    |71.22%    |TDP1    |
|C1=CC(... |DNA-(a... |CHEMBL... |P27695    |6BOW      |T13348    |99.11%    |91.11%    |APEX1   |
|C1=CC(... |Monoam... |CHEMBL... |P21397    |2Z5Y      |Not Av... |97.49%    |91.49%    |MAOA    |
|C1=CC(... |DNA to... |CHEMBL... |P11388    |6ZY5      |T17048    |95.68%    |89%       |TOP2A   |
|C1=CC(... |Arachi... |CHEMBL... |P18054    |3D3L      |Not Av... |95.66%    |75.57%    |ALOX12  |
|C1=CC(... |Transt... |CHEMBL... |P02766    |6SUG      |T86462    |93.11%    |90.71%    |TTR     |
|C1=CC(... |Thyroi... |CHEMBL... |P10827    |3ILZ      |T79591    |93.02%    |99.15%    |THRA    |
|C1=CC(... |Cathep... |CHEMBL... |P07339    |4OD9      |T67102    |92.28%    |98.95%    |CTSD    |
|C1=CC(... |Riboso... |CHEMBL... |P51812    |4D9T      |Not Av... |90.31%    |95.64%    |RPS6KA3 |
|C1=CC(... |Kruppe... |CHEMBL... |Q13887    |Not Av... |Not Av... |88.96%    |86.33%    |KLF5    |
|C1=CC(... |Pregna... |CHEMBL... |O75469    |6TFI      |T82702    |87.7%     |94.73%    |NR1I2   |
|C1=CC(... |Dual s... |CHEMBL... |P51452    |3F81      |Not Av... |87.51%    |94%       |DUSP3   |
|C1=CC(... |Transc... |CHEMBL... |O15164    |4YBM      |Not Av... |86.89%    |95.56%    |TRIM24  |
|C1=CC(... |Dual s... |CHEMBL... |Q9HAZ1    |6FYV      |Not Av... |85.69%    |94.45%    |CLK4    |
|C1=CC(... |Serine... |CHEMBL... |O75460    |6W39      |Not Av... |84.58%    |98.11%    |ERN1    |
|...       |...       |...       |...       |...       |...       |...       |...       |...     |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

## 成分靶点网络


```r
hb <- do_herb(pub, sup)
hb@plots$step3$p.pharm
```


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Network-pharmacology-visualization) (下方图) 为图Network pharmacology visualization概览。

**(对应文件为 `Figure+Table/Network-pharmacology-visualization.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-visualization.pdf}
\caption{Network pharmacology visualization}\label{fig:Network-pharmacology-visualization}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 疾病靶点


```r
gm <- job_gmix("Nonalcoholic fatty liver disease", "nonalcoholic")
gm <- step1(gm)
gm <- step2(gm, NULL, 1, 3, restrict = T)
gm@tables$step2$t.genecard
gm@plots$step2$p.cols
```

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:GeneCards-used-data) (下方表格) 为表格GeneCards used data概览。

**(对应文件为 `Figure+Table/GeneCards-used-data.xlsx`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有289行7列，以下预览的表格可能省略部分数据；含有289个唯一`Symbol'。
\end{tcolorbox}
\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
The GeneCards data was obtained by querying
:}

\vspace{0.5em}

    Nonalcoholic fatty liver disease

\vspace{2em}


\textbf{
Restrict (with quotes)
:}

\vspace{0.5em}

    TRUE

\vspace{2em}


\textbf{
Filtering by Score:
:}

\vspace{0.5em}

    Score > 3

\vspace{2em}
\end{tcolorbox}
\end{center}

Table: (\#tab:GeneCards-used-data)GeneCards used data

|Symbol |Description   |Category      |UniProt_ID |GIFtS |GC_id       |Score |
|:------|:-------------|:-------------|:----------|:-----|:-----------|:-----|
|PNPLA3 |Patatin Li... |Protein Co... |Q9NST1     |51    |GC22P043923 |36.37 |
|ADIPOQ |Adiponecti... |Protein Co... |Q15848     |55    |GC03P186842 |23.53 |
|INS    |Insulin       |Protein Co... |P01308     |56    |GC11M002159 |22.46 |
|LEP    |Leptin        |Protein Co... |P41159     |55    |GC07P128241 |18.65 |
|TNF    |Tumor Necr... |Protein Co... |P01375     |61    |GC06P134820 |17.83 |
|PPARA  |Peroxisome... |Protein Co... |Q07869     |53    |GC22P046150 |17.77 |
|MIR122 |MicroRNA 122  |RNA Gene (... |           |29    |GC18P058451 |17.58 |
|GPT    |Glutamic--... |Protein Co... |P24298     |51    |GC08P144502 |16.73 |
|CYP2E1 |Cytochrome... |Protein Co... |P05181     |55    |GC10P133520 |16.28 |
|APOB   |Apolipopro... |Protein Co... |P04114     |55    |GC02M020956 |16.1  |
|SREBF1 |Sterol Reg... |Protein Co... |P36956     |58    |GC17M017810 |15.94 |
|LIVAR  |Liver Cell... |RNA Gene (... |           |16    |GC18M070336 |15.32 |
|MIR27A |MicroRNA 27a  |RNA Gene (... |           |30    |GC19M092209 |14.96 |
|MIR34A |MicroRNA 34a  |RNA Gene (... |           |29    |GC01M014460 |14.76 |
|NR1H4  |Nuclear Re... |Protein Co... |Q96RI1     |56    |GC12P100473 |14.17 |
|...    |...           |...           |...        |...   |...         |...   |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Overall-targets-number-of-datasets) (下方图) 为图Overall targets number of datasets概览。

**(对应文件为 `Figure+Table/Overall-targets-number-of-datasets.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-targets-number-of-datasets.pdf}
\caption{Overall targets number of datasets}\label{fig:Overall-targets-number-of-datasets}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 成分-疾病-靶点


```r
hb <- map(hb, gm@params$lst.genes, name = "dis", less.label = F)
hb@params$p.pharm2dis
hb@params$p.venn2dis
```

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Network-pharmacology-with-disease) (下方图) 为图Network pharmacology with disease概览。

**(对应文件为 `Figure+Table/Network-pharmacology-with-disease.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Network-pharmacology-with-disease.pdf}
\caption{Network pharmacology with disease}\label{fig:Network-pharmacology-with-disease}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Targets-intersect-with-targets-of-diseases) (下方图) 为图Targets intersect with targets of diseases概览。

**(对应文件为 `Figure+Table/Targets-intersect-with-targets-of-diseases.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Targets-intersect-with-targets-of-diseases.pdf}
\caption{Targets intersect with targets of diseases}\label{fig:Targets-intersect-with-targets-of-diseases}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]
\textbf{
All\_intersection
:}

\vspace{0.5em}

    TLR4, NFE2L2, CASP8, ACACA, SERPINE1, ERN1, NR1I2,
RXRA, MAP3K11, SCD, ACACB, CYP3A4, CNR1, CETP, CHUK, HIF1A,
MIF, STING1, HSP90AA1, GSTP1, CYP2A6

\vspace{2em}
\end{tcolorbox}
\end{center}
**(上述信息框内容已保存至 `Figure+Table/Targets-intersect-with-targets-of-diseases-content`)**

## 分子对接


```r
dockLayout <- dplyr::select(hb@params$p.pharm2dis$.data, -1)
dockLayout <- map(dockLayout, "Ingredient.name", infoCpds, "Identifier", "CID", col = "CID")
dockLayout

vn <- job_vina(.layout = dockLayout)
vn <- step1(vn)
vn <- step2(vn)
vn <- step3(vn)
vn <- set_remote(vn)
vn <- step4(vn)
vn <- step5(vn)
wrap(vn@plots$step5$p.res_vina, 7, 9.5)
vn@tables$step5$res_dock
vn <- step6(vn, top = 3)
vn@plots$step6$Top1_643757_into_1tqn
vn@plots$step6$Top2_99477_into_2dn8
vn@plots$step6$Top3_5316639_into_4cgv
vn <- step7(vn)
vn@plots$step7$Top1_643757_into_1tqn
vn@plots$step7$Top2_99477_into_2dn8
vn@plots$step7$Top3_5316639_into_4cgv
```

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Overall-combining-Affinity) (下方图) 为图Overall combining Affinity概览。

**(对应文件为 `Figure+Table/Overall-combining-Affinity.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/Overall-combining-Affinity.pdf}
\caption{Overall combining Affinity}\label{fig:Overall-combining-Affinity}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\end{center}Table \@ref(tab:Affinity-data) (下方表格) 为表格Affinity data概览。

**(对应文件为 `Figure+Table/Affinity-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有36行8列，以下预览的表格可能省略部分数据；含有9个唯一`PubChem\_id；含有13个唯一`hgnc\_symbol'。
\end{tcolorbox}
\end{center}
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]\begin{enumerate}\tightlist
\item hgnc\_symbol:  基因名 (Human)
\end{enumerate}\end{tcolorbox}
\end{center}

Table: (\#tab:Affinity-data)Affinity data

|PubChe... |PDB_ID |Affinity |dir       |file      |Combn     |hgnc_s... |Ingred... |
|:---------|:------|:--------|:---------|:---------|:---------|:---------|:---------|
|643757    |1tqn   |-5.949   |vina_s... |vina_s... |643757... |CYP3A4    |Aconit... |
|99477     |2dn8   |-4.804   |vina_s... |vina_s... |99477_... |ACACB     |6-Hydr... |
|5316639   |4cgv   |-4.559   |vina_s... |vina_s... |531663... |HSP90AA1  |Dianth... |
|5280805   |2dn8   |-3.473   |vina_s... |vina_s... |528080... |ACACB     |Rutin     |
|6919      |1tqn   |-3.464   |vina_s... |vina_s... |6919_i... |CYP3A4    |2-Furo... |
|69521     |2dn8   |-3.435   |vina_s... |vina_s... |69521_... |ACACB     |Allo M... |
|643757    |4h6j   |-3.338   |vina_s... |vina_s... |643757... |HIF1A     |Aconit... |
|5280343   |5brr   |-3.087   |vina_s... |vina_s... |528034... |SERPINE1  |Quercetin |
|72276     |1tqn   |-2.828   |vina_s... |vina_s... |72276_... |CYP3A4    |Epicat... |
|6919      |5brr   |-2.814   |vina_s... |vina_s... |6919_i... |SERPINE1  |2-Furo... |
|72276     |5brr   |-2.762   |vina_s... |vina_s... |72276_... |SERPINE1  |Epicat... |
|5280805   |5brr   |-2.624   |vina_s... |vina_s... |528080... |SERPINE1  |Rutin     |
|69521     |1tqn   |-2.508   |vina_s... |vina_s... |69521_... |CYP3A4    |Allo M... |
|168436832 |4cgv   |-2.398   |vina_s... |vina_s... |168436... |HSP90AA1  |Homova... |
|5316639   |4h6j   |-1.74    |vina_s... |vina_s... |531663... |HIF1A     |Dianth... |
|...       |...    |...      |...       |...       |...       |...       |...       |


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\vspace{1.5cm}\end{center}

### 对接可视化

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-643757-into-1tqn) (下方图) 为图Docking 643757 into 1tqn概览。

**(对应文件为 `Figure+Table/Docking-643757-into-1tqn.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/643757_into_1tqn/643757_into_1tqn.png}
\caption{Docking 643757 into 1tqn}\label{fig:Docking-643757-into-1tqn}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-99477-into-2dn8) (下方图) 为图Docking 99477 into 2dn8概览。

**(对应文件为 `Figure+Table/Docking-99477-into-2dn8.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/99477_into_2dn8/99477_into_2dn8.png}
\caption{Docking 99477 into 2dn8}\label{fig:Docking-99477-into-2dn8}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-5316639-into-4cgv) (下方图) 为图Docking 5316639 into 4cgv概览。

**(对应文件为 `Figure+Table/Docking-5316639-into-4cgv.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/5316639_into_4cgv/5316639_into_4cgv.png}
\caption{Docking 5316639 into 4cgv}\label{fig:Docking-5316639-into-4cgv}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

### 对接细节可视化

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-643757-into-1tqn-detail) (下方图) 为图Docking 643757 into 1tqn detail概览。

**(对应文件为 `Figure+Table/Docking-643757-into-1tqn-detail.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/643757_into_1tqn/detail_643757_into_1tqn.png}
\caption{Docking 643757 into 1tqn detail}\label{fig:Docking-643757-into-1tqn-detail}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-99477-into-2dn8-detail) (下方图) 为图Docking 99477 into 2dn8 detail概览。

**(对应文件为 `Figure+Table/Docking-99477-into-2dn8-detail.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/99477_into_2dn8/detail_99477_into_2dn8.png}
\caption{Docking 99477 into 2dn8 detail}\label{fig:Docking-99477-into-2dn8-detail}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Docking-5316639-into-4cgv-detail) (下方图) 为图Docking 5316639 into 4cgv detail概览。

**(对应文件为 `Figure+Table/Docking-5316639-into-4cgv-detail.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{vina_space/5316639_into_4cgv/detail_5316639_into_4cgv.png}
\caption{Docking 5316639 into 4cgv detail}\label{fig:Docking-5316639-into-4cgv-detail}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

