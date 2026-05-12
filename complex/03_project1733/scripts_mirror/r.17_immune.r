# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "17_immune")
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

des.GSE189642 <- readRDS("./rds_jobSave/des.GSE189642.3.rds")
fea.markers <- load_feature()

iobr.GSE189642 <- asjob_iobr(des.GSE189642, source = "biomart")
iobr.GSE189642 <- step1(iobr.GSE189642, method = "xcell", tumor = TRUE)
iobr.GSE189642 <- step2(iobr.GSE189642)
iobr.GSE189642 <- step3(iobr.GSE189642, fea.markers)
clear(iobr.GSE189642)

fea.checkpoint <- as_feature(
  c(
    "TNFRSF14", "TNFRSF25", "TNFRSF4", "CD244", "LAG3", "HHLA2", "CD40",
    "TMIGD2", "IDO1", "ICOS", "IDO2", "CD44", "CTLA4", "TIGIT", "PDCD1"
  ),
  "免疫检查点基因，PMID 38774325"
)

des.checkpoint <- focus(
  copy_job(des.GSE189642), fea.checkpoint, 
  .name = "checkpoint", run_roc = FALSE, test = "wilcox.test"
)
clear(des.checkpoint, FALSE)

cp.checkpoint <- cal_corp(
  des.checkpoint, NULL, fea.markers, fea.checkpoint
)
clear(cp.checkpoint, FALSE)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  iobr.GSE189642@plots$step2$p.boxplot
  notshow(iobr.GSE189642@tables$step2$t.groupCor)
  iobr.GSE189642@plots$step2$p.cor
  notshow(iobr.GSE189642@tables$step2$t.cells_cor)
  iobr.GSE189642@plots$step3$p.GeneCellCor
  notshow(iobr.GSE189642@tables$step3$t.geneCellCor)
  notshow(iobr.GSE189642@params$allres$xcell)
  des.checkpoint@params$focusedDegs_checkpoint$p.BoxPlotOfDEGs
  z7(cp.checkpoint@params$p.cor, 1.5, 1)
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
    # iobr.GSE189642 <- asjob_iobr(des.GSE189642, source = "biomart")
    setMethod(f = "asjob_iobr", signature = c(x = "job_deseq2"), 
        definition = function (x, ...) 
        {
            .local <- function (x, idType = "Symbol", source = c("local", 
                "biomart"), levels = NULL, guess_which_level = 1L, 
                ...) 
            {
                if (x@step < 1L) {
                    stop("x@step < 1L.")
                }
                if (is.null(levels)) {
                    levels <- .get_group_from_contrast_character(names(x@tables$step2$t.results)[guess_which_level])
                }
                mtx <- SummarizedExperiment::assay(object(x))
                message("Transform the count to TPM.")
                message(glue::glue("The data dim: {bind(dim(mtx))}"))
                dir.create("tmp", FALSE)
                source <- match.arg(source)
                args <- list(countMat = mtx, idType = idType, source = source)
                message("To avoid environment pollution caused by IOBR loading, So, the IOBR is run with an Subroutine R!!!")
                fun_convert <- function(...) {
                    args <- list(...)
                    fun_run_iobr <- function(countMat, idType, source) {
                      require(IOBR)
                      IOBR::count2tpm(countMat = countMat, idType = idType, 
                        source = source)
                    }
                    callr::r(fun_run_iobr, args = args, libpath = .libPaths(), 
                      show = TRUE)
                }
                mtx <- expect_local_data("tmp", "iobr_tpm", fun_convert, 
                    args)
                message(glue::glue("The data dim: {bind(dim(mtx))}"))
                metadata <- data.frame(x$vst@colData)
                vst <- SummarizedExperiment::assay(x$vst)
                x <- job_iobr(mtx, metadata = metadata)
                x$levels <- levels
                x$vst <- vst
                return(x)
            }
            .local(x, ...)
        })
    
    
    # iobr.GSE189642 <- step1(iobr.GSE189642, method = "xcell", tumor = TRUE)
    setMethod(f = "step1", signature = c(x = "job_iobr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, method = "cibersort", run_all = FALSE, 
            workers = 1, cache = "tmp", tumor = FALSE, ..., rerun = FALSE) 
        {
            step_message("Calculating ...")
            methods <- c("cibersort", "xcell", "estimate", "timer", 
                "quantiseq", "svr", "lsei", "mcpcounter", "epic", 
                "ips", "quantiseq", "svr", "lsei")
            method <- match.arg(method, methods)
            dir.create(cache, FALSE)
            if (run_all) {
                methods <- methods
            }
            else {
                methods <- method
            }
            message("To avoid environment pollution caused by IOBR loading, So, the IOBR is run with an Subroutine R!!!")
            fun_iobr <- function(...) {
                args <- list(...)
                run_iobr <- function(eset, method, tumor) {
                    require(IOBR)
                    set.seed(12345L)
                    IOBR::deconvo_tme(eset = eset, method = method, 
                      tumor = tumor)
                }
                callr::r(run_iobr, args, libpath = .libPaths(), show = TRUE)
            }
            args <- list(tumor = tumor, eset = object(x))
            x$allres <- pbapply::pbsapply(methods, simplify = FALSE, 
                cl = workers, function(method) {
                    args$method <- method
                    try(expect_local_data(cache, "iobr", fun_iobr, 
                      args, rerun = rerun))
                })
            x$res <- x$allres[[method]]
            x <- methodAdd(x, "为系统评估诊断基因与免疫微环境之间的潜在联系，进一步开展免疫浸润及相关性分析，筛选与免疫微环境密切相关的细胞亚群，可从“基因–细胞互作”角度深化对疾病发生发展机制的理解。")
            x <- methodAdd(x, "以 R 包 `IOBR` ⟦pkgInfo('IOBR')⟧ 选择算法 {method} 对 {x$project} 数据集免疫浸润分析。")
            x$method <- method
            return(x)
        }
        .local(x, ...)
    })
    
    
    # iobr.GSE189642 <- step2(iobr.GSE189642)
    setMethod(f = "step2", signature = c(x = "job_iobr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, group.by = "group", cut.p = 0.05, 
            cut.cor = 0.3, add_noise = TRUE, keep_all = if (x$method == 
                "xcell") 
                FALSE
            else TRUE, method_cor = "spearman") 
        {
            step_message("Significant test.")
            if (!is.null(x$allres)) {
                lst <- x$allres
            }
            else {
                lst <- setNames(list(data), x$method)
            }
            x$all_filter <- lst <- lapply(lst, function(data) {
                data <- dplyr::rename_with(data, ~sub("_[^_]+$", 
                    "", .x), -ID)
                data <- map(data, "ID", x$metadata, "sample", group.by, 
                    col = "group")
                if (x$method == "cibersort") {
                    if (!is.null(cut.p)) {
                      data <- trace_filter(data, `P-value` < !!cut.p)
                      snap_filter <- snap(data)
                      snap <- glue::glue("根据 cibersort 算法得到的 P-value，{snap_filter}{try_snap(data$group)}。")
                    }
                    else {
                      snap <- NULL
                    }
                    data <- dplyr::select(data, -Correlation, -`P-value`, 
                      -RMSE)
                }
                namel(data, snap)
            })
            data <- mtx <- lst[[x$method]]$data
            if (x$method == "cibersort" && !is.null(cut.p)) {
                x <- snapAdd(x, "{lst[[ x$method ]]$snap}")
                x <- methodAdd(x, "剔除 P-value &gt; {cut.p} 的低可靠性样本。")
            }
            if (length(unique(data$group)) != 2) {
                stop("length(unique(data$group) != 2).")
            }
            data <- e(tidyr::pivot_longer(data, c(-ID, -group), names_to = "type", 
                values_to = "level"))
            p.stack <- ggplot(data, aes(x = ID, y = level, fill = type)) + 
                geom_bar(stat = "identity", width = 0.7) + facet_grid(~group, 
                scales = "free_x", space = "free") + theme_light() + 
                labs(y = "Relative Proportion", x = "Sample", fill = "Type") + 
                theme(axis.text.x = element_blank()) + scale_fill_manual(values = color_set(TRUE))
            p.stack <- wrap_scale(p.stack, length(unique(data$ID)), 
                10, pre_width = 3, pre_height = 1, size = 0.3)
            p.stack <- set_lab_legend(p.stack, glue::glue("{x@sig} Infiltration Landscape"), 
                glue::glue("免疫细胞渗透比例"))
            data <- e(dplyr::group_by(data, type))
            fun_pvalue <- function(level, group) {
                data <- data.frame(level = level, group = group)
                wilcox.test(level ~ group, data = data)$p.value
            }
            fun_measure <- function(level, group) {
                gp <- split(level, group)
                ms <- vapply(gp, function(x) fivenum(x)[3], double(1))
                names(gp)[which.max(ms)]
            }
            groupCor <- e(dplyr::summarise(data, pvalue = fun_pvalue(level, 
                group), higher = fun_measure(level, group)))
            groupCor <- add_anno(groupCor)
            groupCor <- set_lab_legend(groupCor, glue::glue("{x@sig} {x$method} wilcox test data"), 
                glue::glue("为 {x$method} 算法 wilcox test 组间比较附表。"))
            if (x$method == "xcell") {
                data <- dplyr::mutate(data, level = log2(level))
                ylab <- "log2(level)"
                exSnap <- " 对 xCell 算法得出的富集分数检验显著性，而图中的箱形图为了展示于同一尺度，做了 log2 变换"
            }
            else {
                ylab <- "level"
                exSnap <- ""
            }
            p.boxplot <- ggplot(data) + geom_jitter(aes(x = type, 
                y = level, fill = group, group = group), stroke = 0, 
                shape = 21, color = "transparent", position = position_jitterdodge(0.2)) + 
                geom_boxplot(aes(x = type, y = level, color = group), 
                    outlier.shape = NA, fill = "transparent", notchwidth = 0.7) + 
                geom_text(data = groupCor, aes(x = type, label = sig, 
                    y = max(data$level))) + labs(y = ylab) + scale_color_manual(values = color_set()) + 
                scale_fill_manual(values = color_set()) + theme_minimal() + 
                theme(legend.position = "top", axis.text.x = element_text(angle = 45, 
                    hjust = 1)) + geom_blank()
            p.boxplot <- set_lab_legend(wrap(p.boxplot, 11, 5), glue::glue("{x@sig} {x$method} Immune infiltration"), 
                glue::glue("为 {x$method} 算法的免疫微环境分析箱形图|||使用 wilcox.test{exSnap} ({.md_p_significant}) 。"))
            dataSig <- dplyr::filter(groupCor, pvalue < cut.p)
            s.com <- dataSig$type
            feature(x) <- as_feature(s.com, "IOBR 免疫浸润分析差异细胞", 
                nature = "cells")
            x <- snapAdd(x, "以 wilcox.test 组间差异分析{aref(p.boxplot)}，有显著区别 (⟦mark$blue('p &lt; {cut.p}')⟧) 的差异细胞有 {nrow(dataSig)} 类。")
            fun_snap <- function(higher) {
                ifelse(higher == x$levels[1], "升高", "下降")
            }
            snap_sig <- glue::glue("{s.com} 活性显著 {fun_snap(dataSig$higher)}")
            x <- snapAdd(x, "相比于 {x$levels[2]} 组，{x$levels[1]} 组的{bind(snap_sig)}。\n\n\n")
            mtx <- dplyr::select(mtx, -ID, -group)
            if (!keep_all) {
                mtx <- dplyr::select(mtx, dplyr::all_of(s.com))
            }
            if (add_noise) {
                mtx <- add_noise(mtx, seed = x$seed)
            }
            x$data_noise <- mtx
            res_cor.test <- psych::corr.test(mtx, method = method_cor)
            x <- methodAdd(x, "以 R 包 `psych` ⟦pkgInfo('psych')⟧ 对免疫浸润细胞之间进行关联分析 ({method_cor}) 。⟦mark$blue('将|cor| &gt; 0.3 且 p &lt; {cut.p} 的分析结果判定为具有统计学意义')⟧。")
            t.cells_cor <- add_anno(.corp(as_data_long(res_cor.test$r, 
                res_cor.test$p, "cells_x", "cells_y", "cor", "pvalue")))
            t.cells_cor <- set_lab_legend(t.cells_cor, glue::glue("{x@sig} cells correlation"), 
                glue::glue("免疫浸润细胞相关性分析附表。"))
            colors <- ifelse(colnames(res_cor.test$p) %in% s.com, 
                "red", "grey")
            fun_plot <- function(x) {
                p <- ggcor::quickcor(ggcor::as_cor_tbl(x), type = "lower", 
                    cor.test = TRUE, method = method_cor)
                .ggcor_add_general_style(p, NULL)
            }
            p.cor <- wrap_scale(fun_plot(res_cor.test), ncol(mtx), 
                ncol(mtx), pre_height = 2, size = 0.5)
            if (keep_all) {
                exSnap <- "热图的细胞名若显示为红色，则为差异细胞；"
            }
            else {
                exSnap <- "展示差异细胞之间的关联性；"
            }
            p.cor <- set_lab_legend(p.cor, glue::glue("{x@sig} Correlation immune cells"), 
                glue::glue("免疫细胞相关性分析热图|||{exSnap}热图中颜色表示相关系数的大小，颜色越深表示相关系数越高。"))
            s.cc <- dplyr::filter(t.cells_cor, cells_x %in% s.com, 
                cells_y %in% s.com, cells_x != cells_y, pvalue < 
                    cut.p, abs(cor) > cut.cor)
            if (nrow(s.cc)) {
                snap_cor <- .stat_correlation_table(s.cc, "cells_x", 
                    "cells_y")
                x <- snapAdd(x, "免疫细胞之间的相关性分析结果{aref(p.cor)}，{bind(snap_cor)}。\n\n\n")
            }
            else {
                x <- snapAdd(x, "差异免疫浸润细胞之间未发现显著关联。 ")
            }
            x <- plotsAdd(x, p.boxplot, p.stack, p.cor)
            x <- tablesAdd(x, t.groupCor = groupCor, t.cells_cor)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # iobr.GSE189642 <- step3(iobr.GSE189642, fea.markers)
    setMethod(f = "step3", signature = c(x = "job_iobr"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, recode = NULL, cut.p = 0.05, 
            cut.cor = 0.3, add_noise = TRUE, keep_all = FALSE, use_vst = FALSE, 
            method_cor = "spearman") 
        {
            step_message("Correlation for cells and genes.")
            mtx <- data.frame(dplyr::select(x$all_filter[[x$method]]$data, 
                -group))
            rownames(mtx) <- mtx$ID
            data.cell <- t(as.matrix(dplyr::select(mtx, -ID)))
            if (!keep_all) {
                data.cell <- data.cell[rownames(data.cell) %in% feature(x), 
                    ]
            }
            if (use_vst) {
                if (is.null(x$vst)) {
                    stop("is.null(x$vst).")
                }
                data.expr <- x$vst
            }
            else {
                data.expr <- object(x)
            }
            if (!is.null(recode)) {
                if (!is(recode, "list")) {
                    recode <- as.list(recode)
                }
                rownames(data.expr) <- dplyr::recode(rownames(data.expr), 
                    !!!recode, .default = rownames(data.expr))
            }
            if (is(ref, "feature")) {
                ref.snap <- snap(ref)
            }
            else {
                ref.snap <- "基因"
            }
            if (is.list(ref)) {
                ref <- unlist(ref)
            }
            data.expr <- data.expr[rownames(data.expr) %in% ref, 
                ]
            if (any(isNot <- !ref %in% rownames(data.expr))) {
                stop(glue::glue("Not cover: {bind(ref[isNot])}"))
            }
            data.expr <- data.expr[, match(colnames(data.cell), colnames(data.expr))]
            data.expr <- t(data.expr)
            data.cell <- t(data.cell)
            if (add_noise) {
                data.cell <- add_noise(data.cell)
            }
            dataCor <- psych::corr.test(data.expr, data.cell, method = method_cor)
            x <- methodAdd(x, "以 R 包 `psych` ⟦pkgInfo('psych')⟧ 对基因与免疫浸润细胞之间进行关联分析 ({method_cor}) 。将|cor| &gt; 0.3 且 p &lt; {cut.p} 的分析结果判定为具有统计学意义。")
            colors <- ifelse(colnames(dataCor$p) %in% feature(x), 
                "red", "grey")
            fun_plot <- function(x) {
                p <- ggcor::quickcor(ggcor::as_cor_tbl(x), type = "lower", 
                    cor.test = TRUE, method = method_cor)
                .ggcor_add_general_style(p)
            }
            p.GeneCellCor <- fun_plot(dataCor)
            p.GeneCellCor <- wrap_scale(p.GeneCellCor, ncol(data.cell), 
                ncol(data.expr), min_height = 3)
            if (keep_all) {
                exSnap <- "热图的细胞名若显示为红色，则为差异细胞；"
            }
            else {
                exSnap <- "展示差异细胞之间的关联性；"
            }
            p.GeneCellCor <- set_lab_legend(p.GeneCellCor, glue::glue("{x@sig} correlation of Immune cells and selected genes"), 
                glue::glue("{ref.snap}和免疫细胞相关性分析|||{exSnap}热图中颜色表示相关系数的大小，颜色越深表示相关系数越高。"))
            x <- plotsAdd(x, p.GeneCellCor)
            t.geneCellCor <- add_anno(.corp(as_data_long(dataCor$r, 
                dataCor$p, "genes", "cells", "cor", "pvalue")))
            t.geneCellCor <- set_lab_legend(t.geneCellCor, glue::glue("{x@sig} correlation between cells and genes"), 
                glue::glue("{ref.snap}与免疫细胞相关性分析"))
            s.gc <- dplyr::filter(t.geneCellCor, cells %in% feature(x), 
                pvalue < cut.p, abs(cor) > cut.cor)
            x <- tablesAdd(x, t.geneCellCor)
            if (nrow(s.gc)) {
                snap_cor <- .stat_correlation_table(s.gc, "cells", 
                    "genes")
                x <- snapAdd(x, "免疫细胞与基因之间的关联性分析表明{aref(p.GeneCellCor)}，{bind(snap_cor)}。\n\n\n")
            }
            else {
                x <- snapAdd(x, "差异免疫浸润细胞与{ref.snap}之间未发现显著关联{aref(p.GeneCellCor)}。 ")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(iobr.GSE189642)
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
    
    
    # fea.checkpoint <- as_feature(c("PDCD1", "TNFRSF4", "TNFRSF14", 
    #     "TNFRSF25", "LAG3", "CD40", "CD244", "CTLA4", "TMIGD2", "IDO2"), 
    #     "免疫检查点基因，PMID 38774325")
    setMethod(f = "as_feature", signature = c(x = "ANY", ref = "character"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, nature = names(.nature_feature()), 
            type = "disease") 
        {
            input <- nature[1]
            nature <- try(match.arg(nature), TRUE)
            if (inherits(nature, "try-error")) {
                nature <- input
            }
            else {
                nature <- .nature(nature)
            }
            type <- dplyr::recode(type, disease = "疾病", .default = type)
            if (is(x, "character")) {
                x <- .feature_char(x, type = type, nature = nature)
            }
            else if (is(x, "list")) {
                x <- .feature_list(x, type = type, nature = nature)
            }
            else {
                stop("Now, only 'character' or 'list' types of 'feature' support.")
                x <- .feature(x, type = type, nature = nature)
            }
            snap(x) <- glue::glue("{ref}")
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # des.checkpoint <- focus(copy_job(des.GSE189642), fea.checkpoint, 
    #     .name = "checkpoint", run_roc = FALSE, test = "wilcox.test")
    setMethod(f = "focus", signature = c(x = "job_deseq2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, ref.use = "guess", which = NULL, 
            run_roc = TRUE, which.roc = 1L, level.roc = .guess_compare_deseq2(x, 
                which.roc), .name = "m", use = c("adj.P.Val", "P.Value"), 
            sig = FALSE, clear = "auto", test = "wilcox.test", ...) 
        {
            use <- match.arg(use)
            fakeLmJob <- .as_job_limma.job_deseq2(x)
            if (identical(ref.use, "guess")) {
                ref.use <- .guess_symbol(fakeLmJob)
            }
            if (!is.null(which)) {
                data.which <- fakeLmJob@tables$step2$tops[[which]]
            }
            else {
                data.which <- NULL
            }
            fakeLmJob <- suppressMessages(focus(fakeLmJob, ref = ref, 
                ref.use = ref.use, .name = .name, which = which, 
                data.which = data.which, sig = sig, use = use, test = test, 
                run_roc = run_roc, ...))
            where <- paste0("focusedDegs_", .name)
            if (identical(clear, "auto")) {
                clear <- !is.null(x[[where]])
            }
            resStat <- x[[where]] <- fakeLmJob[[where]]
            snap <- fakeLmJob@snap[[paste0("step", .name)]]
            x <- snapAdd(x, snap, step = .name, add = FALSE)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(des.checkpoint, FALSE)
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
    
    
    # cp.checkpoint <- cal_corp(des.checkpoint, NULL, fea.markers, 
    #     fea.checkpoint)
    setMethod(f = "cal_corp", signature = c(x = "job_deseq2", y = "NULL"
    ), definition = function (x, y, ...) 
    {
        .local <- function (x, y, from, to, use = "symbol", group = NULL, 
            ...) 
        {
            fakeLmJob <- .as_job_limma.job_deseq2(x)
            if (is.null(use)) {
                use <- .guess_symbol(fakeLmJob)
            }
            j <- cal_corp(fakeLmJob, NULL, from, to, use = use, group = group, 
                mode = "ggcor", ...)
            return(j)
        }
        .local(x, y, ...)
    })
    
    
    # clear(cp.checkpoint, FALSE)
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

