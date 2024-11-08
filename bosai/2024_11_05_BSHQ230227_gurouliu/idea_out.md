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
\ThisCenterWallPaper{1.12}{~/outline/bosai//cover_page.pdf}
\begin{center} \textbf{\huge 测试} \vspace{4em}
\begin{textblock}{10}(3.2,9.25) \huge
\textbf{\textcolor{black}{2024-11-06}}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 研究背景 {#abstract}



## 相关研究

骨肉瘤病理生理机制涉及与骨形成相关的几种可能的疾病遗传驱动因素，导致恶性进展和转移 (2022, Nature reviews. Disease primers, **IF:76.9**, Q1)[@OsteosarcomaBeird2022]。

## 相关概念

因果基因 (2009, Statistics Surveys, **IF:11**, Q1)[@CausalInferencPearl2009]。

TWAS (2016, Nature Genetics, **IF:31.7**, Q1)[@IntegrativeAppGusev2016]

PWAS (2020, Genome Biology, **IF:10.1**, Q1)[@PwasProteomeBrande2020]

## 思路 {#introduction}

骨肉瘤+因果基因筛选 (联合 PWAS 和 TWAS)  (可能筛选到线粒体失调相关)

涉及方法：
- PWAS: GWAS + FUSION (2016, Nature Genetics, **IF:31.7**, Q1)[@IntegrativeAppGusev2016] <http://gusevlab.org/projects/fusion/>
- TWAS: GWAS + S-PrediXcan (2018, Nature Communications, **IF:14.7**, Q1)[@ExploringThePBarbei2018] <https://github.com/hakyimlab/MetaXcan>
  + FOCUS (2020, Human genetics, **IF:3.8**, Q2)[@APowerfulFineWuCh2020] <https://github.com/ChongWu-Biostat/FOGS>

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}
\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{~/Pictures/causal_genes_selection.jpg}
\caption{Example workflow}\label{fig:example-workflow}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 可行性 {#methods}

# 创新性 {#results}

# 参考文献和数据集 {#workflow}

Identifying causal genes for migraine by integrating the proteome and transcriptome 
(2023, The journal of headache and pain, **IF:7.3**, Q1)[@IdentifyingCauLiSh2023]


