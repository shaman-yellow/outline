# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "22_mr")
if (!dir.exists(output)) {
  dir.create(output, recursive = TRUE)
}
setwd(ORIGINAL_DIR)

.libPaths(c('/data/nas2/software/miniconda3/envs/public_R/lib/R/library/', '/data/nas1/huanglichuang_OD/conda/envs/extra_pkgs/lib/R/library/'))

myPkg <- "./union/union.utils"
if (!dir.exists(myPkg)) {
  stop('Can not found package: ', myPkg)
}
devtools::load_all(myPkg)
load_unions()
setup.huibang()

# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

fea.markers <- load_feature()
fea.markers

mr.markers <- asjob_mr(fea.markers)
mr.markers <- step1(
  mr.markers, templates = c("drinking", "smoking", "BMI", "education")
)
mr.markers <- step2(mr.markers, "mbg", type = "ALL")
mr.markers <- step3(mr.markers)
clear(mr.markers)
mr.markers <- step4(mr.markers)
mr.markers <- step5(mr.markers)
clear(mr.markers)



# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  mr.markers@plots$step5$p.forest
  mr.markers@plots$step5$p.scatter
  mr.markers@plots$step5$p.funnel
  mr.markers@plots$step5$p.leaveoneout
  mr.markers@tables$step5$t.main
  mr.markers@tables$step5$t.heterogeneity
  mr.markers@tables$step5$t.pleiotropy
  mr.markers@tables$step5$t.steiger
  notshow(mr.markers@params$fTest$data_f)
  notshow(mr.markers@params$table_with_all_columns)
})




# ==========================================================================
# FIELD: checkout
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# NOTE: 下方代码是以上分析代码中解析出来的，目前只解析一层，没有递归解析
# 递归的话代码会变得非常多，而且会很乱。目前应该够了，method 内部大多都是普通 function
# 查看起来比较方便，可以在加载了我的 R 包后直接输入后查看本体。
# 
# 下方的代码，我在定义的上方写明了在上方哪个分析代码用到了这个本体，
# 希望对您有所帮助


if (FALSE) {
    # mr.markers <- asjob_mr(fea.markers)
    setMethod(f = "asjob_mr", signature = c(x = "feature"), definition = function (x, 
        ...) 
    {
        .local <- function (x, mode = "eqtlgen", ...) 
        {
            mode <- match.arg(mode)
            if (mode == "eqtlgen") {
                data_exposure <- .get_exposure_opengwas_eqtlgen(fea <- x, 
                    ...)
                x <- job_mr(data_exposure, "SYMBOL")
                x <- methodAdd(x, "本研究以 {snap(fea)} 的表达量为暴露因素；")
            }
            x$.snap_exposure <- snap(data_exposure) %||% ""
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mr.markers <- step1(mr.markers, templates = c("drinking", "smoking", 
    #     "BMI", "education"))
    setMethod(f = "step1", signature = c(x = "job_mr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, templates = NULL, patterns = NULL, 
            cut.p = 1e-05, top_n = 3L, ..., show_source = TRUE) 
        {
            step_message("Remove confounder effect.")
            if (!is.null(x$data_exposure_raw)) {
                message(glue::glue("Detected exists of `x$data_exposure_raw`, use it as `data_exposure`"))
                data_exposure <- x$data_exposure_raw
            }
            else {
                message(glue::glue("For first run, `x$data_exposure` will be backup in `x$data_exposure_raw`."))
                if (is.null(x$data_exposure)) {
                    stop("is.null(x$data_exposure).")
                }
                data_exposure <- x$data_exposure_raw <- x$data_exposure
            }
            source_confounder <- .hunt_representative_dataset_opengwas(patterns = patterns, 
                templates = templates, top_n = top_n, catalog = x$catalog)
            x$source_confounder <- dplyr::relocate(source_confounder, 
                search_group, id, sample_size, nsnp)
            if (show_source) {
                message(glue::glue("Confounder datasets refer to (`x$source_confounder`): "))
                print(x$source_confounder, n = 10L, width = 80L)
            }
            detail <- bind(c(patterns, templates))
            snap_confounder <- glue::glue("为排除混杂因素 ({detail}) 相关的 SNP，{snap(x$source_confounder)}")
            data_exposure <- .remove_other_snps_opengwas(data_exposure, 
                x$source_confounder$id, p_threshold = cut.p, type = "confounder", 
                ..., ask_query = TRUE)
            snap_remove <- glue::glue("{snap(data_exposure)}")
            x$.snap_confounder <- paste0(snap_confounder, snap_remove)
            snap(data_exposure) <- NULL
            x$data_exposure <- data_exposure
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mr.markers <- step2(mr.markers, "mbg", type = "ALL")
    setMethod(f = "step2", signature = c(x = "job_mr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, mode = "mbg", ...) 
        {
            step_message("Get outcome data.")
            if (mode == "mbg") {
                data_outcome <- .get_outcome_opengwas_mbg(x$data_exposure$SNP, 
                    ...)
                x <- methodAdd(x, "以微生物丰度 (MiBioGen 数据) 为结局，探究两者之间的因果关联。")
                x$data_outcome <- data_outcome
                x$split_outcome <- "outcome"
                x$pattern_outcome <- "(?<=\\()[^()]+(?=\\))"
                x$.snap_outcome <- glue::glue("结局因素获取自 MiBioGen 数据库。{snap(data_outcome)}")
            }
            else {
                stop("Not yet ready.")
                .get_outcome_opengwas(...)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mr.markers <- step3(mr.markers)
    setMethod(f = "step3", signature = c(x = "job_mr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, cut.p = 1e-05, ...) 
        {
            step_message("Remove outcome snaps.")
            data_exposure <- x$data_exposure
            data_exposure <- .remove_other_snps_opengwas(data_exposure, 
                x$data_outcome$id.outcome %||% x$data_outcome$id, 
                p_threshold = cut.p, type = "outcomeFactor", ..., 
                ask_query = TRUE)
            snap_remove <- glue::glue("排除与结局因素相关的 SNP。{snap(data_exposure)}")
            snap(data_exposure) <- NULL
            x <- methodAdd(x, "{x$.snap_exposure}\n\n")
            x <- methodAdd(x, "{x$.snap_confounder}\n\n")
            x <- methodAdd(x, "{x$.snap_outcome}\n\n")
            x <- methodAdd(x, "{snap_remove}\n\n")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(mr.markers)
    setMethod(f = "clear", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = rlang::expr_text(substitute(x, parent.frame(1))), 
            path_jobSave = getOption("path_jobSave", "."), path_lite = file.path(path_jobSave, 
                "lite"), expr_lite = NULL, allow_qs = TRUE, nthreads = 5) 
        {
            dir.create(path_jobSave, FALSE)
            filename <- paste0(name, ".", x@step, suffix, ".rds")
            if (save) {
                file <- file.path(path_jobSave, filename)
                if (allow_qs && object.size(x) > 5e+08) {
                    fileQs <- paste0(tools::file_path_sans_ext(file), 
                      ".qs")
                    message(glue::glue("Too large object ('{obj.size(x)}' > 478.6 Mb), use `qs::qsave`"))
                    message("Save qs: ", fileQs)
                    qs::qsave(x, fileQs, nthreads = nthreads)
                }
                else {
                    message("Save RDS: ", file)
                    saveRDS(x, file)
                }
            }
            object(x) <- NULL
            dir.create(path_lite, FALSE)
            if (!is.null(expr_lite)) {
                if (!is.expression(expr_lite)) {
                    stop("!is.expression(expr_lite).")
                }
                eval(expr_lite)
            }
            if (lite) {
                file <- file.path(path_lite, filename)
                message("Save RDS: ", file)
                saveRDS(x, file)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mr.markers <- step4(mr.markers)
    setMethod(f = "step4", signature = c(x = "job_mr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, min_nsnp = 3L, ..., rerun = FALSE, 
            workers = 10L) 
        {
            step_message("Run MR analysis and filter results.")
            x$mr_batch <- .run_mr_batch(x$data_exposure, x$data_outcome, 
                split_exposure = x$split_exposure, split_outcome = x$split_outcome, 
                min_nsnp = min_nsnp, meth = TRUE, ncore = workers, 
                rerun = rerun)
            x$mr_batch_filter <- .filter_mr_batch(x$mr_batch, ...)
            x <- methodAdd(x, "{x$mr_batch$snap_run}\n\n\n{x$mr_batch_filter$snap_filter}")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mr.markers <- step5(mr.markers)
    setMethod(f = "step5", signature = c(x = "job_mr"), definition = function (x, 
        ...) 
    {
        step_message("Summry.")
        args <- list(x = x$mr_batch_filter, pattern_outcome = x$pattern_outcome, 
            pattern_exposure = x$pattern_exposure)
        args$wrap <- FALSE
        objFmtTab <- do.call(.format_show_mr_batch, args)
        ts.alls <- x$table_with_all_columns <- .table_mr_batch(objFmtTab)
        cols_excludes <- c("id.outcome", "id.exposure", "lo_ci", 
            "up_ci", "or_lci95", "or_uci95", "SYMBOL", "pair_id")
        ts.alls <- lapply(ts.alls, function(data) {
            data[, !colnames(data) %in% cols_excludes]
        })
        t.main <- set_lab_legend(ts.alls$main, glue::glue("{x@sig} MR summary"), 
            glue::glue("MR 因果效应汇总表|||汇总展示各暴露因素与结局之间的孟德尔随机化分析结果。method 为所采用的 MR 方法；nsnp 为纳入分析的工具变量数量；b 为效应估计值；se 为标准误；pval 为统计学检验 P 值；or 为比值比（Odds Ratio）。结果主要参考逆方差加权法（IVW）。"))
        t.heterogeneity <- set_lab_legend(ts.alls$heterogeneity, 
            glue::glue("{x@sig} Heterogeneity test"), glue::glue("MR 异质性检验结果表|||用于评估各工具变量效应估计之间的一致性。method 为检验对应的 MR 方法；Q 为 Cochran's Q 统计量；Q_df 为自由度；Q_pval 为异质性检验 P 值。通常 Q_pval > 0.05 提示未见显著异质性，可认为工具变量之间总体一致性较好。"))
        t.pleiotropy <- set_lab_legend(ts.alls$pleiotropy, glue::glue("{x@sig} Horizontal pleiotropy test"), 
            glue::glue("MR 水平多效性检验结果表|||基于 MR-Egger 截距检验评估工具变量是否通过暴露因素以外途径影响结局。egger_intercept 为截距估计值；se 为标准误；pval 为检验 P 值。通常 pval > 0.05 提示未发现显著方向性水平多效性，结果可靠性较高。"))
        t.steiger <- set_lab_legend(dplyr::rename(ts.alls$steiger, 
            direction = correct_causal_direction), glue::glue("{x@sig} Steiger directionality test"), 
            glue::glue("MR 因果方向检验结果表|||用于判断推定因果方向是否更支持“暴露因素影响结局”而非反向因果。snp_r2.exposure 与 snp_r2.outcome 分别表示工具变量解释暴露和结局变异的比例；direction 表示是否支持预设方向；steiger_pval 为方向性检验 P 值。direction 为 TRUE 且 steiger_pval < 0.05 时，通常认为因果方向更可信。"))
        x <- tablesAdd(x, t.main, t.heterogeneity, t.pleiotropy, 
            t.steiger)
        args$wrap <- TRUE
        objFmtPlot <- do.call(.format_show_mr_batch, args)
        ps.alls <- .plot_mr_batch(objFmtPlot)
        snap <- .stat_summary_mr_batch(objFmtTab)
        p.scatter <- set_lab_legend(ps.alls$p.scatter, glue::glue("{x@sig} MR scatter plot"), 
            glue::glue("MR 分析散点图|||横坐标表示各 SNP 对暴露因素的效应估计值，纵坐标表示对应 SNP 对结局的效应估计值。每个点代表一个工具变量。不同颜色直线表示不同 MR 方法拟合得到的总体因果效应方向与大小；斜率越大，提示效应越强。各方法拟合方向一致时，说明结果稳定性较好；若斜率差异明显，则提示模型间存在不一致性。"))
        p.forest <- set_lab_legend(ps.alls$p.forest, glue::glue("{x@sig} MR forest plot"), 
            glue::glue("MR 单位点森林图|||展示每个 SNP 单独作为工具变量时对结局的效应估计及其 95% 置信区间，同时给出总体合并效应。点估计位于零效应线（或 OR=1）右侧提示正向作用，左侧提示负向作用。多数位点方向一致且总体效应稳定时，支持结果可靠；若个别位点偏离明显，则提示可能存在异常工具变量。"))
        p.funnel <- set_lab_legend(ps.alls$p.funnel, glue::glue("{x@sig} MR funnel plot"), 
            glue::glue("MR 漏斗图|||横坐标表示各 SNP 的效应估计值，纵坐标表示估计精度（通常为标准误的倒数）。点位围绕总体效应线对称分布时，提示整体结果较稳定，未见明显方向性偏倚；若分布明显偏斜或单侧聚集，则提示可能存在异质性、多效性或异常位点影响。"))
        p.leaveoneout <- set_lab_legend(ps.alls$p.leaveoneout, glue::glue("{x@sig} MR leave-one-out plot"), 
            glue::glue("MR 逐一剔除敏感性分析图|||依次去除单个 SNP 后重新进行 MR 分析，展示每次重新估计的总体效应及其 95% 置信区间。若各次结果接近原始总体估计，说明分析结论不依赖某一单独工具变量，稳健性较好；若去除某个位点后效应明显变化，则提示该位点可能具有较大影响。"))
        snap_plots <- .stat_plot_summary_mr_batch(objFmtTab, p.scatter = p.scatter, 
            p.forest = p.forest, p.funnel = p.funnel, p.leaveoneout = p.leaveoneout)
        x <- plotsAdd(x, p.scatter, p.forest, p.funnel, p.leaveoneout)
        x <- snapAdd(x, "{snap}\n\n\n{snap_plots}")
        return(x)
    })
    
    
    # clear(mr.markers)
    setMethod(f = "clear", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = rlang::expr_text(substitute(x, parent.frame(1))), 
            path_jobSave = getOption("path_jobSave", "."), path_lite = file.path(path_jobSave, 
                "lite"), expr_lite = NULL, allow_qs = TRUE, nthreads = 5) 
        {
            dir.create(path_jobSave, FALSE)
            filename <- paste0(name, ".", x@step, suffix, ".rds")
            if (save) {
                file <- file.path(path_jobSave, filename)
                if (allow_qs && object.size(x) > 5e+08) {
                    fileQs <- paste0(tools::file_path_sans_ext(file), 
                      ".qs")
                    message(glue::glue("Too large object ('{obj.size(x)}' > 478.6 Mb), use `qs::qsave`"))
                    message("Save qs: ", fileQs)
                    qs::qsave(x, fileQs, nthreads = nthreads)
                }
                else {
                    message("Save RDS: ", file)
                    saveRDS(x, file)
                }
            }
            object(x) <- NULL
            dir.create(path_lite, FALSE)
            if (!is.null(expr_lite)) {
                if (!is.expression(expr_lite)) {
                    stop("!is.expression(expr_lite).")
                }
                eval(expr_lite)
            }
            if (lite) {
                file <- file.path(path_lite, filename)
                message("Save RDS: ", file)
                saveRDS(x, file)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
}

