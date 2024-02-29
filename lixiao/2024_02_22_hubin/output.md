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
\begin{center} \textbf{\Huge 建立风险模型和作图}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-02-29}}
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

绘制风险模型，原始数据在压缩包里，图片中文字用中文表示 ，用原始数据做出类似的图1-图3（原文见附件1）

- 急性单纯性阑尾炎组与急性化脓性阑尾炎组
- 急性单纯性阑尾炎组与急性坏疽性阑尾炎伴穿孔组

## 结果

对应结果分别见 \@ref(supp), \@ref(gang)

注：阑尾管径按照需求，以 ROC 二分类后，再用于 Logistic 回归和建模




# 前言 {#introduction}

# 材料和方法 {#methods}

## 材料



## 方法

Mainly used method:

- Other R packages (eg., `dplyr` and `ggplot2`) used for statistic analysis or data visualization.

# 分析结果 {#results}

# 结论 {#dis}

# 附：分析流程 {#workflow}



## 预处理表格

Table \@ref(tab:raw-data) (下方表格) 为表格raw data概览。

**(对应文件为 `Figure+Table/raw-data.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有201行5列，以下预览的表格可能省略部分数据；表格含有98个唯一`阑尾管径'。
\end{tcolorbox}
\end{center}

Table: (\#tab:raw-data)Raw data

|阑尾管径 |管腔内积液 |阑尾周围炎性渗出 |临近肠道反应 |病理结果         |
|:--------|:----------|:----------------|:------------|:----------------|
|7.5      |有         |无               |无           |急性单纯性阑尾炎 |
|7.6      |有         |有               |无           |急性单纯性阑尾炎 |
|9.9      |有         |无               |有           |急性单纯性阑尾炎 |
|9.3      |有         |无               |无           |急性单纯性阑尾炎 |
|11.1     |有         |无               |无           |急性单纯性阑尾炎 |
|8.9      |有         |无               |无           |急性单纯性阑尾炎 |
|6.8      |无         |无               |无           |急性单纯性阑尾炎 |
|9.7      |有         |无               |无           |急性单纯性阑尾炎 |
|10.5     |有         |无               |无           |急性单纯性阑尾炎 |
|9.8      |有         |无               |无           |急性单纯性阑尾炎 |
|11.8     |有         |有               |无           |急性单纯性阑尾炎 |
|11.5     |有         |无               |无           |急性单纯性阑尾炎 |
|9.1      |有         |无               |无           |急性单纯性阑尾炎 |
|14.5     |有         |无               |无           |急性单纯性阑尾炎 |
|10.5     |有         |无               |无           |急性单纯性阑尾炎 |
|...      |...        |...              |...          |...              |



## 急性单纯性阑尾炎组与急性化脓性阑尾炎组 {#supp}



### 阑尾管径 cutoff

Figure \@ref(fig:supp-cutoff) (下方图) 为图supp cutoff概览。

**(对应文件为 `Figure+Table/supp-cutoff.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/supp-cutoff.pdf}
\caption{Supp cutoff}\label{fig:supp-cutoff}
\end{center}



### 数据预处理

Table \@ref(tab:data-simple-vs-suppuration) (下方表格) 为表格data simple vs suppuration概览。

**(对应文件为 `Figure+Table/data-simple-vs-suppuration.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有133行5列，以下预览的表格可能省略部分数据；表格含有2个唯一`阑尾管径'。
\end{tcolorbox}
\end{center}

Table: (\#tab:data-simple-vs-suppuration)Data simple vs suppuration

|阑尾管径    |管腔内积液 |阑尾周围炎性渗出 |临近肠道反应 |病理结果         |
|:-----------|:----------|:----------------|:------------|:----------------|
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |有               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |有           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|> 10.55 mm  |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |无         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|> 10.55 mm  |有         |有               |无           |急性单纯性阑尾炎 |
|> 10.55 mm  |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|> 10.55 mm  |有         |无               |无           |急性单纯性阑尾炎 |
|<= 10.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|...         |...        |...              |...          |...              |



### 结果


\noindent \textbf{Logistic Regression Model}

\begin{verbatim}
rms::lrm(formula = formula, data = data, x = T, y = T)
\end{verbatim}

{\fontfamily{phv}\selectfont \begin{center}\begin{tabular}{|c|c|c|c|}\hline
&Model Likelihood&Discrimination&Rank Discrim.\\
&Ratio Test&Indexes&Indexes\\\hline
Obs~\hfill 133&LR $\chi^{2}$~\hfill 103.29&$R^{2}$~\hfill 0.751&$C$~\hfill 0.953\\
~~急性单纯性阑尾炎~\hfill 44&d.f.~\hfill 4&$R^{2}_{4,133}$~\hfill 0.526&$D_{xy}$~\hfill 0.906\\
~~急性化脓性阑尾炎~\hfill 89&Pr$(>\chi^{2})$~\hfill \textless 0.0001&$R^{2}_{4,88.3}$~\hfill 0.675&$\gamma$~\hfill 0.949\\
$\max|\frac{\partial\log L}{\partial \beta}|$~\hfill $2\!\times\!10^{-8}$&&Brier~\hfill 0.071&$\tau_{a}$~\hfill 0.404\\
\hline
\end{tabular}
\end{center}}

\setlongtables\begin{longtable}{lrrrr}\hline
\multicolumn{1}{l}{}&\multicolumn{1}{c}{$\hat{\beta}$}&\multicolumn{1}{c}{S.E.}&\multicolumn{1}{c}{Wald $Z$}&\multicolumn{1}{c}{Pr$(>|Z|)$}\tabularnewline
\hline
\endhead
\hline
\endfoot
Intercept&~ 0.0411~&~1.3870~& 0.03&0.9764\tabularnewline
阑尾管径=$\textgreater $ 10.55 mm&~ 2.0478~&~0.7522~& 2.72&0.0065\tabularnewline
管腔内积液=有&~-2.7917~&~1.5123~&-1.85&0.0649\tabularnewline
阑尾周围炎性渗出=有&~ 3.9788~&~0.7061~& 5.63&\textless 0.0001\tabularnewline
临近肠道反应=有&~ 2.0577~&~0.8238~& 2.50&0.0125\tabularnewline
\hline
\end{longtable}
\addtocounter{table}{-1}

Figure \@ref(fig:supp-Nomogram-plot) (下方图) 为图supp Nomogram plot概览。

**(对应文件为 `Figure+Table/supp-Nomogram-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/supp-Nomogram-plot.pdf}
\caption{Supp Nomogram plot}\label{fig:supp-Nomogram-plot}
\end{center}

Figure \@ref(fig:supp-Bootstrap-calibration) (下方图) 为图supp Bootstrap calibration概览。

**(对应文件为 `Figure+Table/supp-Bootstrap-calibration.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/supp-Bootstrap-calibration.pdf}
\caption{Supp Bootstrap calibration}\label{fig:supp-Bootstrap-calibration}
\end{center}

Figure \@ref(fig:supp-ROC) (下方图) 为图supp ROC概览。

**(对应文件为 `Figure+Table/supp-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/supp-ROC.pdf}
\caption{Supp ROC}\label{fig:supp-ROC}
\end{center}



## 急性单纯性阑尾炎组与急性坏疽性阑尾炎伴穿孔组 {#gang}



### 阑尾管径 cutoff

Figure \@ref(fig:gang-cutoff) (下方图) 为图gang cutoff概览。

**(对应文件为 `Figure+Table/gang-cutoff.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/gang-cutoff.pdf}
\caption{Gang cutoff}\label{fig:gang-cutoff}
\end{center}



### 数据预处理

Table \@ref(tab:data-simple-vs-ganguration) (下方表格) 为表格data simple vs ganguration概览。

**(对应文件为 `Figure+Table/data-simple-vs-ganguration.csv`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：表格共有71行5列，以下预览的表格可能省略部分数据；表格含有2个唯一`阑尾管径'。
\end{tcolorbox}
\end{center}

Table: (\#tab:data-simple-vs-ganguration)Data simple vs ganguration

|阑尾管径    |管腔内积液 |阑尾周围炎性渗出 |临近肠道反应 |病理结果         |
|:-----------|:----------|:----------------|:------------|:----------------|
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |有               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |有           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |无         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|> 11.55 mm  |有         |有               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|> 11.55 mm  |有         |无               |无           |急性单纯性阑尾炎 |
|<= 11.55 mm |有         |无               |无           |急性单纯性阑尾炎 |
|...         |...        |...              |...          |...              |



### 结果


\noindent \textbf{Logistic Regression Model}

\begin{verbatim}
rms::lrm(formula = formula, data = data, x = T, y = T)
\end{verbatim}

{\fontfamily{phv}\selectfont \begin{center}\begin{tabular}{|c|c|c|c|}\hline
&Model Likelihood&Discrimination&Rank Discrim.\\
&Ratio Test&Indexes&Indexes\\\hline
Obs~\hfill 71&LR $\chi^{2}$~\hfill 86.00&$R^{2}$~\hfill 0.955&$C$~\hfill 0.996\\
~~急性单纯性阑尾炎~\hfill 44&d.f.~\hfill 4&$R^{2}_{4,71}$~\hfill 0.685&$D_{xy}$~\hfill 0.992\\
~~急性坏疽性阑尾炎伴穿孔~\hfill 27&Pr$(>\chi^{2})$~\hfill \textless 0.0001&$R^{2}_{4,50.2}$~\hfill 0.805&$\gamma$~\hfill 0.997\\
$\max|\frac{\partial\log L}{\partial \beta}|$~\hfill 0.001&&Brier~\hfill 0.020&$\tau_{a}$~\hfill 0.474\\
\hline
\end{tabular}
\end{center}}

\setlongtables\begin{longtable}{lrrrr}\hline
\multicolumn{1}{l}{}&\multicolumn{1}{c}{$\hat{\beta}$}&\multicolumn{1}{c}{S.E.}&\multicolumn{1}{c}{Wald $Z$}&\multicolumn{1}{c}{Pr$(>|Z|)$}\tabularnewline
\hline
\endhead
\hline
\endfoot
Intercept&~-14.6312~&~1216.0084~&-0.01&0.9904\tabularnewline
阑尾管径=$\textgreater $ 11.55 mm&~  0.4055~&~   1.6833~& 0.24&0.8096\tabularnewline
管腔内积液=有&~ -5.1411~&~1216.0070~& 0.00&0.9966\tabularnewline
阑尾周围炎性渗出=有&~ 18.6737~&~  48.2789~& 0.39&0.6989\tabularnewline
临近肠道反应=有&~ 10.8189~&~  32.2735~& 0.34&0.7375\tabularnewline
\hline
\end{longtable}
\addtocounter{table}{-1}

Figure \@ref(fig:gang-Nomogram-plot) (下方图) 为图gang Nomogram plot概览。

**(对应文件为 `Figure+Table/gang-Nomogram-plot.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/gang-Nomogram-plot.pdf}
\caption{Gang Nomogram plot}\label{fig:gang-Nomogram-plot}
\end{center}

Figure \@ref(fig:gang-Bootstrap-calibration) (下方图) 为图gang Bootstrap calibration概览。

**(对应文件为 `Figure+Table/gang-Bootstrap-calibration.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/gang-Bootstrap-calibration.pdf}
\caption{Gang Bootstrap calibration}\label{fig:gang-Bootstrap-calibration}
\end{center}

Figure \@ref(fig:gang-ROC) (下方图) 为图gang ROC概览。

**(对应文件为 `Figure+Table/gang-ROC.pdf`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{Figure+Table/gang-ROC.pdf}
\caption{Gang ROC}\label{fig:gang-ROC}
\end{center}




