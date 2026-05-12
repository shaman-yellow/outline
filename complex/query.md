
我正在思考，我的生信分析流程是否还有优化空间。
在目前的公司，我需要提交 r.01_deg.r 这样的文件。
对应于各个分析模块。
我会在本地使用 push_script 这样的脚本，输入 deg, seurat, cellchat
这样的名称，自动按模板创建 .r 文件。然后我会在里面写 R 分析代码。

我的分析代码体系化已经很强了，对每一个分析模块，分析点，都是相同的使用函数，
通过 S4 的参数化多态来实现，例如 MR：

mr.key <- asjob_mr(fea.key, strict = FALSE)
mr.key <- step1(
  mr.key, top_n = 1L, check_new_snps = TRUE,
  templates = c(
    "smoking",
    "drinking",
    "bmi",
    "education",
    "diabetes",
    "blood_pressure",
    "lipid",
    "crp",
    "immune",
    "infection"
  )
)

mr.key <- step2(
  mr.key, "general", c("ieu-b-5088"),
  check_new_snps = TRUE
)
mr.key <- step3(mr.key, FALSE)
clear(mr.key)

mr.key <- step4(mr.key)
mr.key <- step5(mr.key)
clear(mr.key)

例如 nomogram 列线图模型：


lm.GSE134347 <- qs::qread("./rds_jobSave/lm.GSE134347.3.qs")
fea.markers <- load_feature()

rms.GSE134347 <- asjob_rms(lm.GSE134347, fea.markers)
rms.GSE134347 <- step1(rms.GSE134347)
rms.GSE134347 <- step2(rms.GSE134347)
clear(rms.GSE134347)

例如seurat：

geo.GSE167363 <- job_geo("GSE167363")
geo.GSE167363 <- step1(geo.GSE167363)
geo.GSE167363 <- step2(geo.GSE167363, get_supp = TRUE)
clear(geo.GSE167363, TRUE, FALSE)

metadata.GSE167363 <- expect(geo.GSE167363, geo_cols())
metadata.GSE167363 <- dplyr::mutate(
  metadata.GSE167363, group = ifelse(
    grpl(group, "healthy"), "healthy", "sepsis"
  )
)

if (FALSE) {
  lapply(metadata.GSE167363$sample,
    function(name) {
      prepare_10x(geo.GSE167363$dir, name)
    })
}

files <- list.files(geo.GSE167363$dir, "GSM", full.names = TRUE)

srn.GSE167363 <- job_seurat5n(
  files, strx(basename(files), "GSM[0-9]+")
)
srn.GSE167363 <- map(srn.GSE167363, metadata.GSE167363)
clear(srn.GSE167363)

srn.GSE167363 <- step1(srn.GSE167363, 200, 5000, 20000, 20)
clear(srn.GSE167363)
srn.GSE167363 <- step2(srn.GSE167363, sct = TRUE)
clear(srn.GSE167363)
srn.GSE167363 <- step3(srn.GSE167363)

srn.GSE167363 <- step4(srn.GSE167363)
srn.GSE167363 <- step5(srn.GSE167363, 5)
clear(srn.GSE167363)

以上，clear 都是用来规范命名存储的函数，会保存完整版 和 lite 版 (轻量的) 。

随后，我在本地会有一个 Rmd 文档，用来实现自动化报告输出，例如其中seurat 分析点：


## 集成单细胞数据分析

### 数据质控

`r meth(srn.GSE167363, FALSE)`
`r snap(srn.GSE167363, 1:3)`

<!-- OVERTURE_START -->
```{r eval = FALSE, echo = FALSE}
#| OVERTURE
take_positions({
  srn.GSE167363@plots$step1$p.qc_pre
  srn.GSE167363@plots$step1$p.qc_aft
  srn.GSE167363@plots$step2$p.pca_rank
  z7(srn.GSE167363@plots$step3$p.umapUint, 1.5, 1)
  z7(srn.GSE167363@plots$step3$p.umapInt, 1.5, 1)
})
```
<!-- OVERTURE_END -->

```{r}
get_file_with_format_name("./analysis_out.docx", name.hb$sc())
```

### 细胞注释

`r snap(srn.GSE167363, 1:6)`

<!-- OVERTURE_START -->
```{r eval = FALSE, echo = FALSE}
#| OVERTURE
take_positions({
  srn.GSE167363@tables$step6$t.validMarkers
  srn.GSE167363@plots$step3$p.umapLabel
  srn.GSE167363@plots$step6$p.markers_cluster
  srn.GSE167363@plots$step6$p.markers
  srn.GSE167363@plots$step6$p.map_scsa
  srn.GSE167363@plots$step6$p.props_scsa
  srn.GSE167363@plots$step6$p.props_scsa_group
  srn.GSE167363@plots$step6$p.props_scsa_stat
  notshow(srn.GSE167363@tables$step5$all_markers)
  notshow(srn.GSE167363@tables$step5$all_markers_no_filter)
  notshow(srn.GSE167363@tables$step6$scsa_res_all)
  notshow(srn.GSE167363@tables$step6$t.props_scsa)
  notshow(srn.GSE167363@params$final_metadata)
})
```
<!-- OVERTURE_END -->


以上，`r snap()` 部分和 `r meth()` 部分会输出 step 系列中的方法和参数说明，
而 <!-- OVERTURE_START --> 对应部分会将图片或者表格，自动展现在 docx 中，
带有标题、图例、文字说明。

可以给你看一个代表性的step函数，对应于 MR 的 (其中 methodAdd，snapAdd 就是生成对应说明文字的工具) ：


setMethod("step5", signature = c(x = "job_mr"),
  function(x, ...)
  {
    step_message("Summry.")
    args <- list(
      x = x$mr_batch_filter,
      pattern_outcome = x$pattern_outcome,
      pattern_exposure = x$pattern_exposure
    )
    # tables
    args$wrap <- FALSE
    objFmtTab <- do.call(.format_show_mr_batch, args)
    ts.alls <- x$table_with_all_columns <- .table_mr_batch(objFmtTab)
    cols_excludes <- c(
      "id.outcome", "id.exposure", "lo_ci", "up_ci",
      "or_lci95", "or_uci95",
      "SYMBOL", "pair_id"
    )
    ts.alls <- lapply(ts.alls,
      function(data) {
        data[ , !colnames(data) %in% cols_excludes ]
      })
    t.main <- set_lab_legend(
      ts.alls$main,
      glue::glue("{x@sig} MR summary"),
      glue::glue(
        "MR 因果效应汇总表|||汇总展示各暴露因素与结局之间的孟德尔随机化分析结果。method 为所采用的 MR 方法；nsnp 为纳入分析的工具变量数量；b 为效应估计值；se 为标准误；pval 为统计学检验 P 值；or 为比值比（Odds Ratio）。结果主要参考逆方差加权法（IVW）。"
      )
    )
    t.heterogeneity <- set_lab_legend(
      ts.alls$heterogeneity,
      glue::glue("{x@sig} Heterogeneity test"),
      glue::glue(
        "MR 异质性检验结果表|||用于评估各工具变量效应估计之间的一致性。method 为检验对应的 MR 方法；Q 为 Cochran's Q 统计量；Q_df 为自由度；Q_pval 为异质性检验 P 值。通常 Q_pval > 0.05 提示未见显著异质性，可认为工具变量之间总体一致性较好。"
      )
    )
    t.pleiotropy <- set_lab_legend(
      ts.alls$pleiotropy,
      glue::glue("{x@sig} Horizontal pleiotropy test"),
      glue::glue(
        "MR 水平多效性检验结果表|||基于 MR-Egger 截距检验评估工具变量是否通过暴露因素以外途径影响结局。egger_intercept 为截距估计值；se 为标准误；pval 为检验 P 值。通常 pval > 0.05 提示未发现显著方向性水平多效性，结果可靠性较高。"
      )
    )
    t.steiger <- set_lab_legend(
      dplyr::rename(ts.alls$steiger, direction = correct_causal_direction),
      glue::glue("{x@sig} Steiger directionality test"),
      glue::glue(
        "MR 因果方向检验结果表|||用于判断推定因果方向是否更支持“暴露因素影响结局”而非反向因果。snp_r2.exposure 与 snp_r2.outcome 分别表示工具变量解释暴露和结局变异的比例；direction 表示是否支持预设方向；steiger_pval 为方向性检验 P 值。direction 为 TRUE 且 steiger_pval < 0.05 时，通常认为因果方向更可信。"
      )
    )
    x <- tablesAdd(x, t.main, t.heterogeneity, t.pleiotropy, t.steiger)
    if (x$split_exposure == "SYMBOL") {
      x$.feature_exposure <- as_feature(
        split(t.main$exposure, t.main$outcome), "MR 显著因果关联"
      )
    }
    # plots
    args$wrap <- TRUE
    objFmtPlot <- do.call(.format_show_mr_batch, args)
    ps.alls <- .plot_mr_batch(objFmtPlot)
    # snap summary
    snap <- .stat_summary_mr_batch(objFmtTab)
    p.scatter <- set_lab_legend(
      ps.alls$p.scatter,
      glue::glue("{x@sig} MR scatter plot"),
      glue::glue(
        "MR 分析散点图|||横坐标表示各 SNP 对暴露因素的效应估计值，纵坐标表示对应 SNP 对结局的效应估计值。每个点代表一个工具变量。不同颜色直线表示不同 MR 方法拟合得到的总体因果效应方向与大小；斜率越大，提示效应越强。各方法拟合方向一致时，说明结果稳定性较好；若斜率差异明显，则提示模型间存在不一致性。"
      )
    )
    p.forest <- set_lab_legend(
      ps.alls$p.forest,
      glue::glue("{x@sig} MR forest plot"),
      glue::glue(
        "MR 单位点森林图|||展示每个 SNP 单独作为工具变量时对结局的效应估计及其 95% 置信区间，同时给出总体合并效应。点估计位于零效应线（或 OR=1）右侧提示正向作用，左侧提示负向作用。多数位点方向一致且总体效应稳定时，支持结果可靠；若个别位点偏离明显，则提示可能存在异常工具变量。"
      )
    )
    p.funnel <- set_lab_legend(
      ps.alls$p.funnel,
      glue::glue("{x@sig} MR funnel plot"),
      glue::glue(
        "MR 漏斗图|||横坐标表示各 SNP 的效应估计值，纵坐标表示估计精度（通常为标准误的倒数）。点位围绕总体效应线对称分布时，提示整体结果较稳定，未见明显方向性偏倚；若分布明显偏斜或单侧聚集，则提示可能存在异质性、多效性或异常位点影响。"
      )
    )
    p.leaveoneout <- set_lab_legend(
      ps.alls$p.leaveoneout,
      glue::glue("{x@sig} MR leave-one-out plot"),
      glue::glue(
        "MR 逐一剔除敏感性分析图|||依次去除单个 SNP 后重新进行 MR 分析，展示每次重新估计的总体效应及其 95% 置信区间。若各次结果接近原始总体估计，说明分析结论不依赖某一单独工具变量，稳健性较好；若去除某个位点后效应明显变化，则提示该位点可能具有较大影响。"
      )
    )
    snap_plots <- .stat_plot_summary_mr_batch(
      objFmtTab,
      p.scatter = p.scatter,
      p.forest = p.forest,
      p.funnel = p.funnel,
      p.leaveoneout = p.leaveoneout
    )
    x <- plotsAdd(x, p.scatter, p.forest, p.funnel, p.leaveoneout)
    x <- snapAdd(x, "{snap}\n\n\n{snap_plots}")
    return(x)
  })

我觉得你提的优化，在我看来没什么价值。你说命名规范化，好像没有必要吧？
MR 分析和单细胞分析，差别太大了，此外，还有其他各样的分析，例如分子对接……
这怎么可能一套命名呢？存储在 params 或者 tables 或者 plots 中，自由命名才是最合理的。

我还可以让你看看我的自动化根据数据类型选择合适的报告展现方法的体系 (还只是一小部分) ：


setMethod("autor", signature = c(x = "ANY", name = "missing"),
  function(x, ..., shownote = TRUE)
  {
    if (is.null(knitr::pandoc_to())) {
      message("Not in knitr circumstance, show object only.")
      if (!is.null(lab(x))) {
        message(glue::glue("lab(x): {lab(x)}\nautor_label: {as_chunk_label(lab(x))}"))
        message("Legend:\n", paste0(strwrap(split_text_by_width(Legend(x), 70), , 4), collapse = "\n"))
      }
      return(show(x))
    } else {
      autor_label_env <- knitr::opts_chunk$get("autor_label_env")
      autor_legend_env <- getOption("autor_legend_env")
      if (is.null(autor_label_env)) {
        autor_label_env <- lapply(knitr::knit_code$get(), function(x) list())
        ## this environment is set for check duplicated of 'autor_label'
        autor_label_env <- as.environment(autor_label_env)
        knitr::opts_chunk$set(autor_label_env = autor_label_env)
      }
    }
    if (is(x, "rms") || is(x, "validate")) {
      if (needTex()) {
        options(prType = "latex")
      } else {
        options(prType = "plain")
      }
      set_showtext()
      return(x)
    }
    name <- chunk_label <- knitr::opts_current$get("label")
    if (grpl(name, "^unnamed-chunk") && !is.null(lab(x))) {
      name <- lab(x)
      # if (is.null(name)) {
        # code <- rlang::expr_text(substitute(x))
        # stop(glue::glue('Chunk should set label, or object with "lab" (set by `lab({code}) <- `)'))
      # }
      ## save into the environment
      autor_label_env[[ chunk_label ]] <- name
      ## check duplicated
      all_autor_labels <- unlist(lapply(autor_label_env, function(x) x))
      if (any(duplicated(c(all_autor_labels, names(autor_label_env))))) {
        stop("'autor_label' should not duplicated with each other or chunk labels.")
      }
    }
    if (!is.null(Legend <- Legend(x))) {
      autor_legend_env[[ name ]] <- Legend
    }
    knitr::opts_current$set(autor_label = name)
    autor(x, name, ...)
    if (shownote && !is(x, "df")  && !is.null(note <- Legend(x, "note"))) {
      abstract(note, name, NULL)
    }
    invisible()
  })

setMethod("autor", signature = c(x = "feature_char", name = "missing"),
  function(x, ...){
    data <- setNames(tibble::tibble(as.character(x)), .nature(x@nature, TRUE))
    autor(data, ..., notshow = TRUE, shownote = FALSE)
  })

setMethod("autor", signature = c(x = "feature_list", name = "missing"),
  function(x, ...){
    if (length(x) == 1 && is(x[[1]], "feature_list")) {
      name <- names(x)
      x <- setNames(x[[1]], paste0(name, "|||", names(x[[1]])))
    }
    lst <- setNames(x@.Data, names(x))
    data <- setNames(stack(lst), c(.nature(x@nature, TRUE), "Type"))[, 2:1]
    autor(tibble::as_tibble(data), ..., notshow = TRUE, shownote = FALSE)
  })

setMethod("autor", signature = c(x = "notshow", name = "missing"),
  function(x, ...){
    autor(x@data, ..., notshow = TRUE, shownote = FALSE)
  })

setMethod("autor", signature = c(x = "list", name = "character"),
  function(x, name, ...){
    file <- autosv(x, name, ...)
    autor(file, name)
  })

setMethod("autor", signature = c(x = "can_not_be_draw", name = "character"),
  function(x, name, ...){
    file <- autosv(x, name, ...)
    if (getOption("autor_legend_as_caption", TRUE)) {
      autor(fig(file), name, caption = Legend(x), ...)
    } else {
      autor(fig(file), name, ...)
    }
    if (!is.null(lich <- attr(x, "lich"))) {
      abstract(lich, name)
      file <- autosv(lich, name <- paste0(name, "-content"))
      locate_file(name, "See: ")
    }
  })

setClassUnion("can_be_draw", c("gg.obj", "heatdata", "grob.obj"))
## autor for ggplot
setMethod("autor", signature = c(x = "can_be_draw", name = "character"),
  function(x, name, ...){
    file <- autosv(x, name, ...)
    if (getOption("autor_legend_as_caption", TRUE)) {
      autor(fig(file), name, caption = Legend(x), ...)
    } else {
      autor(fig(file), name, ...)
    }
  })

suppressMessages(setMethod("autor", signature = c(x = "layout_tbl_graph"),
  function(x, ...){
    autor(dplyr::as_tibble(x), ...)
  }))

setMethod("autor", signature = c(x = "df", name = "character"),
  function(x, name, ..., asis = getOption("autor_asis", TRUE)){
    if (needTex()) {
      cat("\\begin{center}\\vspace{1.5cm}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\\end{center}")
    }
    if (any(vapply(x, class, character(1)) == "list")) {
      x <- dplyr::mutate(x,
        dplyr::across(dplyr::where(is.list),
          function(x) {
            vapply(x, paste0, collapse = " | ", FUN.VALUE = character(1))
          }))
    }
    x <- dplyr::select_if(x,
      function(x) is.character(x) | is.numeric(x) | is.logical(x) | is.factor(x))
    file <- autosv(x, name, ...)
    if (getOption("autor_legend_as_caption", TRUE)) {
      include(x, name, caption = Legend(x),
        footer = Legend(x, "note"), ...)
    } else {
      include(x, name, ...)
    }
    if (asis) {
      abstract(x, name = name, ...)
      if (!is.null(lich <- attr(x, "lich"))) {
        abstract(lich, name = name)
      }
    }
    if (needTex()) {
      cat("\n\n\\begin{center}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{89}\\vspace{1.5cm}\\end{center}")
    }
  })

## autor for figures of file
setMethod("autor", signature = c(x = "fig", name = "character"),
  function(x, name, ..., asis = getOption("autor_asis", TRUE)){
    if (needTex()) {
      cat("\\begin{center}\\vspace{1.5cm}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\\end{center}")
    }
    file <- autosv(x, name, ...)
    if (!any(...names() == "caption") && getOption("autor_legend_as_caption", TRUE)) {
      include(x, name, caption = Legend(x), ...)
    } else {
      include(x, name, ...)
    }
    if (asis) {
      abstract(x, name = name, ...)
    }
    if (!is.null(lich <- attr(x, "lich"))) {
      if (asis) {
        abstract(lich, name = name)
      }
    }
    if (needTex()) {
      cat("\n\n\\begin{center}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{88}\\vspace{1.5cm}\\end{center}")
    }
  })

setMethod("autor", signature = c(x = "files", name = "character"),
  function(x, name, ..., asis = getOption("autor_asis", FALSE)){
    file <- autosv(x, name, ...)
    if (needTex()) {
      cat("\n\n\\begin{center}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\\vspace{1.5cm}\\end{center}")
    }
    if (asis) {
      abstract(x, name, ...)
    }
    if (needTex()) {
      cat("\n\n\\begin{center}\\pgfornament[anchor=center,ydelta=0pt,width=9cm]{85}\\vspace{1.5cm}\\end{center}")
    }
  })

setMethod("autor", signature = c(x = "lich", name = "character"),
  function(x, name, ...){
    abstract(x, name, ...)
    file <- autosv(x, name <- paste0(name, "-content"))
    locate_file(name, "见")
  })

setMethod("autor", signature = c(x = "character", name = "character"),
  function(x, name, ...){
    if (length(x) > 1)
      stop("length(x) == 1")
    if (!file.exists(x))
      stop("file.exists(x) == FALSE")
    if (dir.exists(x)) {
      return(autor(files(x), name, ...))
    }
    fig.type <- c(".jpg", ".png", ".pdf")
    file.type <- stringr::str_extract(x, "\\.[a-zA-Z]+$")
    if (!is.na(file.type)) {
      if (any(file.type == fig.type))
        return(autor(fig(x), name, ...))
    }
    autor(files(x), name, ...)
  })

# ==========================================================================
# show object in report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setGeneric("include", 
  function(x, name, ...) standardGeneric("include"))

## include for fig
setMethod("include", signature = c(x = "fig"),
  function(x, name, caption = NULL, notshow = FALSE, ...){
    if (notshow) {
      return(invisible())
    }
    if (knitr::is_latex_output()) {
      cat("\n\\def\\@captype{figure}\n")
      cat("\\begin{center}\n",
        "\\includegraphics[width = 0.9\\linewidth]{", as.character(x), "}\n",
        "\\caption{", knitr::opts_current$get("fig.cap"),
        "}\\label{fig:", name, "}\n",
        "\\end{center}\n", sep = "")
    } else {
      inclu.fig(
        as.character(x), saveDir = "report_picture", name = name,
        caption = caption
      )
    }
  })

setMethod("include", signature = c(x = "df"),
  function(x, name, caption = NULL, footer = NULL, notshow = FALSE, ...){
    if (notshow) {
      return(invisible())
    }
    x <- tibble::as_tibble(x)
    if (is.null(caption)) {
      caption <- as_caption(name)
    }
    if (knitr::is_latex_output()) {
      x <- trunc_table(x)
      print(knitr::kable(x, "markdown", caption = caption))
    } else if (knitr::pandoc_to("docx")) {
      x <- trunc_table(x)
      knitr::opts_current$set(tab.id = name)
      writeLines(
        flextable:::knit_print.flextable(
          pretty_flex(x, caption, footer = footer,
            font.size = ifelse(ncol(x) > 10, 8, 10.5))
        )
      )
    } else {
      x <- trunc_table(x)
      print(knitr::kable(x, "markdown", caption = caption))
    }
  })


请整体评估一下我的分析体系的价值。

