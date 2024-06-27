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
\ThisCenterWallPaper{1.12}{~/outline/lixiao//cover_page.pdf}
\begin{center} \textbf{\Huge 图片查重程序}
\vspace{4em} \begin{textblock}{10}(3,5.9) \huge
\textbf{\textcolor{white}{2024-06-27}}
\end{textblock} \begin{textblock}{10}(3,7.3)
\Large \textcolor{black}{LiChuang Huang}
\end{textblock} \begin{textblock}{10}(3,11.3)
\Large \textcolor{black}{@立效研究院}
\end{textblock} \end{center} \end{titlepage}
\restoregeometry

\pagenumbering{roman}



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{84}\end{center}\tableofcontents



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{88}\end{center}\listoffigures



\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=8cm]{89}\end{center}\listoftables

\newpage

\pagenumbering{arabic}

# 摘要 {#abstract}

Findsimilar 可递归搜索文件夹下所有图片 (没有明确的数量上限, 但最少 10 张图片)，根据设定的阈值 (threshold 参数)，寻找相似图片，
最后将结果以网页报告的形式输出。

步骤 1：选择搜索目录 (需要搜索的路径)。
步骤 2：选择输出目录 (生成的报告文件和其他分析数据存放)。
步骤 3：点击 “Run”。
步骤 4：点击 “Similarity Gallery”，在网页浏览器中显示报告。

注意：
支持的格式：.png, .jpg, .jpeg, .gif, .giff, .tif, .tiff, .heic, .heif, .bmp, .webp, .jfif

注：以下面板示例为 Linux 系统的界面，Windows 下略有不同。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:Panel) (下方图) 为图Panel概览。

**(对应文件为 `Figure+Table/Panel.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{/home/echo/Pictures/Screenshots/Screenshot from 2024-06-27 16-14-44.png}
\caption{Panel}\label{fig:Panel}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

# 安装

## Python 3.9.0

请下载并安装 Python 3.9.0:

<https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe>

## findsimilar

### (Option 1) 运行 bat 文件安装 (未测试)

请确认已安装完成 Python, 然后打开文件夹


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`All files' 数据已全部提供。

**(对应文件为 `./use_for_install/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./use\_for\_install/共包含3个文件。

\begin{enumerate}\tightlist
\item findsimilar
\item get\_shortcut.bat
\item install.bat
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

1. 双击 `install.bat`, 等待安装完成。
2. 双击 `get_shortcut.bat`, 这会在桌面生成 `findsimilar.bat`。
3. 完成。





### (Option 2) 通过命令安装

按 `Win + R`, 输入 `cmd`, 确认打开 `cmd` 界面，输入以下安装。

\begin{tcolorbox}[colback = gray!10, colframe = red!50, width = 16cm, arc = 1mm, auto outer arc, title = {cmd input}]
\begin{verbatim}

# 请确认 cmd 已经切换到 findsimilar 安装包的路径
pip install findsimilar -i https://pypi.tuna.tsinghua.edu.cn/simple

\end{verbatim}
\end{tcolorbox}

\begin{tcolorbox}[colback = gray!10, colframe = red!50, width = 16cm, arc = 1mm, auto outer arc, title = {cmd input}]
\begin{verbatim}

echo $(which findsimilar) > "%USERPROFILE%\Desktop\findsimilar.bat"

\end{verbatim}
\end{tcolorbox}

# 使用示例

可以使用如下文件夹作为测试。


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center} 
`Test files' 数据已全部提供。

**(对应文件为 `./test/`)**
\begin{center}\begin{tcolorbox}[colback=gray!10, colframe=gray!50, width=0.9\linewidth, arc=1mm, boxrule=0.5pt]注：文件夹./test/共包含10个文件。

\begin{enumerate}\tightlist
\item Control-1.tif
\item Control.tif
\item DAPIPKH67.tif
\item Figure 4 revise.tif
\item Figure 5 revise.tif
\item ...
\end{enumerate}\end{tcolorbox}
\end{center}

\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\vspace{1.5cm}\end{center}

新建一个空的文件夹作为输出目录。

\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-11) (下方图) 为图unnamed chunk 11概览。

**(对应文件为 `Figure+Table/unnamed-chunk-11.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{/home/echo/Pictures/Screenshots/Screenshot from 2024-06-27 16-43-27.png}
\caption{Unnamed chunk 11}\label{fig:unnamed-chunk-11}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

如上运行完成后，点击 "Similarity Gallery" ，得到 HTML 报告。


\begin{center}\vspace{1.5cm}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\end{center}Figure \@ref(fig:unnamed-chunk-12) (下方图) 为图unnamed chunk 12概览。

**(对应文件为 `Figure+Table/unnamed-chunk-12.png`)**

\def\@captype{figure}
\begin{center}
\includegraphics[width = 0.9\linewidth]{/home/echo/Pictures/Screenshots/Screenshot from 2024-06-27 16-48-30.png}
\caption{Unnamed chunk 12}\label{fig:unnamed-chunk-12}
\end{center}


\begin{center}\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\vspace{1.5cm}\end{center}

