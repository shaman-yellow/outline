---
title: Report of Analysis
author: 'Huang LiChuang of Wie-Biotech'
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
    toc: true
    toc_depth: 3
    latex_engine: xelatex
header-includes:
  \usepackage{caption}
  \captionsetup{font={footnotesize},width=6in}
  \renewcommand{\dblfloatpagefraction}{.9}
  \makeatletter
  \renewenvironment{figure}
  {\def\@captype{figure}}
  \makeatletter
  \definecolor{shadecolor}{RGB}{242,242,242}
  \usepackage{xeCJK}
  \usepackage{setspace}
  \setstretch{1.3} 
  \usepackage{tcolorbox}
---




\listoftables

\listoffigures

# test

Figure \@ref(fig:test)为图test概览。
**(对应文件为 `../2023_06_30_eval/figs/370_into_1cxw.png`)**
\def\@captype{figure}
\includegraphics{../2023_06_30_eval/figs/370_into_1cxw.png}
\caption{Test}\label{fig:test}

Figure \@ref(fig:report-test)为图report test概览。
**(对应文件为 `../2023_06_25_fix/figs/MCC_top10.pdf`)**
\def\@captype{figure}
\includegraphics{../2023_06_25_fix/figs/MCC_top10.pdf}
\caption{Report test}\label{fig:report-test}

Figure \@ref(fig:test-figure-out-of-line)为图test figure out of line概览。
**(对应文件为 `../2023_06_30_eval/figs/5280343_into_5th6.png`)**
\def\@captype{figure}
\includegraphics{../2023_06_30_eval/figs/5280343_into_5th6.png}
\caption{Test figure out of line}\label{fig:test-figure-out-of-line}

Figure \@ref(fig:plot-with-ggplot2)为图plot with ggplot2概览。
**(对应文件为 `figs/plot-with-ggplot2.pdf`)**
\def\@captype{figure}
\includegraphics{figs/plot-with-ggplot2.pdf}
\caption{Plot with ggplot2}\label{fig:plot-with-ggplot2}

Table \@ref(tab:mtcars)为表格mtcars概览。
test 
**(对应文件为 `tabs/mtcars.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有32行11列，以下预览的表格可能省略部分数据；表格含有25个唯一`mpg`。
show time\end{tcolorbox}
\end{center}

Table: (\#tab:mtcars)Mtcars

|mpg  |cyl |disp  |hp  |drat |wt    |qsec  |vs  |am  |gear |carb |
|:----|:---|:-----|:---|:----|:-----|:-----|:---|:---|:----|:----|
|21   |6   |160   |110 |3.9  |2.62  |16.46 |0   |1   |4    |4    |
|21   |6   |160   |110 |3.9  |2.875 |17.02 |0   |1   |4    |4    |
|22.8 |4   |108   |93  |3.85 |2.32  |18.61 |1   |1   |4    |1    |
|21.4 |6   |258   |110 |3.08 |3.215 |19.44 |1   |0   |3    |1    |
|18.7 |8   |360   |175 |3.15 |3.44  |17.02 |0   |0   |3    |2    |
|18.1 |6   |225   |105 |2.76 |3.46  |20.22 |1   |0   |3    |1    |
|14.3 |8   |360   |245 |3.21 |3.57  |15.84 |0   |0   |3    |4    |
|24.4 |4   |146.7 |62  |3.69 |3.19  |20    |1   |0   |4    |2    |
|22.8 |4   |140.8 |95  |3.92 |3.15  |22.9  |1   |0   |4    |2    |
|19.2 |6   |167.6 |123 |3.92 |3.44  |18.3  |1   |0   |4    |4    |
|17.8 |6   |167.6 |123 |3.92 |3.44  |18.9  |1   |0   |4    |4    |
|16.4 |8   |275.8 |180 |3.07 |4.07  |17.4  |0   |0   |3    |3    |
|17.3 |8   |275.8 |180 |3.07 |3.73  |17.6  |0   |0   |3    |3    |
|15.2 |8   |275.8 |180 |3.07 |3.78  |18    |0   |0   |3    |3    |
|10.4 |8   |472   |205 |2.93 |5.25  |17.98 |0   |0   |3    |4    |
|...  |... |...   |... |...  |...   |...   |... |... |...  |...  |

# 生信评估

关于转录组数据库筛选肌少症、癌症（结直肠癌）、化疗共同的通路，是否要串连三个要素（肌少症，结直肠癌，化疗）？

1. 使用公共数据库，可行：
    1. 筛选 GEO 至少两个数据集，一个肌少症，另一个结直肠癌症。后者最好包含化疗前后的两组数据。如果 GEO 数据库不存在结直肠癌化疗前后的合适数据，可能需要筛选三个数据集供处理。
    2. 消除批次效应（不同来源的数据的各种无关因素带来的影响）。
    3. 筛选共通基因，有两种方法：
        1. 一般法，多重比对，取交集。
        2. WGCNA[@WgcnaAnRPacLangfe2008] 法，对多个数据集进行一致性分析，寻找关键基因模块。
        3. 联合法，联合上述两种方法。
    4. 根据基因筛选结果，通路富集分析。
2. 使用自备数据集，可行。可以更有针对性的设计实验分组，避免批次效应，分析结果更可靠；但针对性越强，成本越高。

工作量：视数据集的多少和分析复杂程度，需要2-3天。


