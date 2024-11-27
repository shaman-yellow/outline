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






\begin{titlepage} \newgeometry{top=7.5cm}
\ThisCenterWallPaper{1.12}{~/outline/bosai//cover_page_idea.pdf}
\begin{center} \textbf{\huge 对 GBM 的 mRNAsi
的分析筛选 PS 基因} \vspace{4em}
\begin{textblock}{10}(3.2,9.25) \huge
\textbf{\textcolor{black}{2024-11-19}}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 研究背景 {#abstract}



多形性胶质母细胞瘤 (GBM) 是成人中最常见的恶性原发性脑肿瘤，尽管过去十年在理解这种肿瘤的分子发病机制和生物学方面取得了重要进展，但 GBM 患者的预后仍然很差 (2024, **IF:4.9**, Q2, International journal of molecular sciences)[@Glioblastoma_A_Lan_Z_2024]。

细胞在空间和时间上协调大量生化反应，这取决于细胞内空间细分为功能区室。有力的证据表明，相分离 (Phase Separation, PS) 诱导无膜区室的形成，以严格调控的方式分隔细胞内物质，并参与各种生物过程。鉴于癌症与细胞内生理过程失调以及癌症相关凝聚物中相分离的发生密切相关，相分离在肿瘤发生中起着重要作用 ((2022, **IF:6.9**, Q1, Oncogene)[@Phase_separatio_Gu_Xi_2022])

mRNAsi是一种癌症干性评分，用于衡量肿瘤细胞与干细胞的相似程度，可以量化肿瘤组织中的肿瘤干细胞 (cancer stem cells, CSC)。mRNAsi的值介于0和1之间，越接近1，肿瘤细胞分化程度越低，CSC的特征越强 (2018, **IF:45.5**, Q1, Cell)[@Machine_Learnin_Malta_2018]。多个 mRNAsi 相关基因已被证明广泛参与肿瘤的发生并作为患者的预后标志 (2020, **IF:2.8**, Q2, Genes)[@mRNAsi_Index_M_Zhang_2020] (2019, **IF:5**, Q1, Molecular oncology)[@Integrative_ana_Lian_2019] (……)。

## 思路 {#introduction}

- TCGA GBM 数据获取
- 差异基因筛选和相分离功能基因检索
- mRNAsi计算，分组
    - 免疫细胞浸润分析
    - 药物敏感性预测
    - mRNAsi差异分析及和临床特征关系
    - 单因素Cox回归
    - 多因素Cox回归构建预后模型及验证
    - 疾病分子亚型识别

基于 GBM 的 mRNAsi 的分析，筛选相 PS 相关基因，可能促进 GBM 干性的客观诊断工具的开发，并产生预测 GBM 患者生存率或针对 GBM 干细胞的策略疗效的新型生物标志物。


# 可行性 {#methods}

## 以 `"glioblastoma" AND "Phase separation"` 搜索文献。

已有 GBM 与相分离相关报道。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-18 16-26-10.png}
\caption{Search 1}\label{fig:search-1}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 创新性 {#results}

## 以 `"glioblastoma" AND "Phase separation" AND "mRNAsi"` 搜索文献。

未发现相关报道。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-18 16-27-03.png}
\caption{Search 2}\label{fig:search-2}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

## 以 `"glioblastoma" AND "Phase separation" AND "Immune infiltration"` 搜索文献。

未发现相关报道。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/Screenshots/Screenshot from 2024-11-18 16-31-35.png}
\caption{Search 3}\label{fig:search-3}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 参考文献和数据集 {#workflow}

- mRNAsi <https://pmc.ncbi.nlm.nih.gov/articles/PMC5902191/>
<https://bioinformaticsfmrp.github.io/PanCanStem_Web/>
- calculate mRNAsi <https://zhuanlan.zhihu.com/p/398410279>
- Instance <https://pmc.ncbi.nlm.nih.gov/articles/PMC9207218/>

- OCLR <https://pmc.ncbi.nlm.nih.gov/articles/PMC4856035/>
<https://cran.r-project.org/web/packages/gelnet/index.html>

- LLPSDB: <http://bio-comp.org.cn/llpsdb/home.html>
- PhaSepDB: <http://db.phasep.pro/>
- DrLLPS: <http://llps.biocuckoo.cn/>

