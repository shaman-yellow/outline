# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "09_validate")
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

ml10.train <- readRDS("./rds_jobSave/lite/ml10.train.2.rds")
fea <- feature(ml10.train, "best", snap = "候选关键基因")

des.GSE189642 <- readRDS("./rds_jobSave/des.GSE189642.3.rds")
des.validate_GSE189642 <- focus(
  des.GSE189642, fea, 
  .name = "learn", run_roc = TRUE, test = "wilcox.test"
)
clear(des.validate_GSE189642)

ven.marker <- refine(des.validate_GSE189642)
clear(ven.marker)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(des.validate_GSE189642@params$focusedDegs_learn$p.BoxPlotOfDEGs, .7, 1.3)
  des.validate_GSE189642@params$focusedDegs_learn$p.rocs
  feature(ven.marker)
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
    # fea <- feature(ml10.train, "best", snap = "候选关键基因")
    setMethod(f = "feature", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, mode = .all_features(x), ..., snap = NULL) 
        {
            if (missing(mode)) {
                mode <- ".feature"
            }
            else {
                if (!grpl(mode, "^\\.feature")) {
                    mode <- paste0(".feature_", mode)
                }
                mode <- match.arg(mode, .all_features(x))
            }
            feas <- x[[mode]]
            if (!is(feas, "feature")) {
                feas <- as_feature(feas, x, ...)
            }
            if (!is.null(snap) && is.character(snap)) {
                snap(feas) <- snap
            }
            feas
        }
        .local(x, ...)
    })
    
    
    # des.validate_GSE189642 <- focus(des.GSE189642, fea, .name = "learn", 
    #     run_roc = TRUE, test = "wilcox.test")
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
    
    
    # clear(des.validate_GSE189642)
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
    
    
    # ven.marker <- refine(des.validate_GSE189642)
    setMethod(f = "refine", signature = c(x = "job_DEG"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = NULL, use.p = c("pvalue", 
            "padj"), ref = "key", cut.auc = 0.7) 
        {
            fun_extract <- function(x) {
                alls <- grpf(names(x@params), "^focusedDegs_")
                if (is.null(name) && length(alls) == 1L) {
                    use <- alls
                }
                else if (!is.null(name) && any(name == alls)) {
                    use <- name
                }
                else {
                    rlang::abort("What happened?")
                }
                data <- x[[use]]$summary
                if (!is.factor(data$group)) {
                    stop("!is.factor(data$group), not valid format of summary.")
                }
                data <- dplyr::mutate(data, .group_id = as.integer(group))
                if (is.null(data)) {
                    stop("is.null(data), no `focus` run?")
                }
                data
            }
            lst <- list(x)
            if (...length()) {
                lst <- c(lst, list(...))
            }
            projects <- names <- vapply(lst, function(x) x$project, 
                character(1))
            lst <- lapply(lst, fun_extract)
            lst <- setNames(lst, names)
            levels_main <- levels(lst[[1]]$group)
            summary <- data_alls <- dplyr::bind_rows(lst, .id = "dataset")
            snap_auc <- ""
            if (!is.null(data_alls$auc) && !is.null(cut.auc)) {
                summary <- dplyr::filter(data_alls, auc > cut.auc)
                snap_auc <- glue::glue("这些基因的 ROC 分析满足 AUC &gt; {cut.auc}。")
            }
            summary <- dplyr::select(summary, dataset, gene, .group_id, 
                trend)
            project_main <- x$project
            if (length(lst) > 1) {
                summary <- find_common_cross_groups(summary, "dataset")
                summary <- dplyr::filter(summary, dataset == !!project_main)
            }
            summary <- dplyr::filter(summary, .group_id == 2L)
            if (ref == "key") {
                snap <- "关键基因"
            }
            else {
                stop("...")
            }
            fea <- as_feature(summary$gene, snap)
            x <- .job_venn()
            x$.feature <- fea
            fmt <- function(x) {
                dplyr::recode(x, high = "表达量显著升高", 
                    low = "表达量显著下降")
            }
            fun_snapThat <- function(ex) {
                lst <- split(summary, ~trend)
                lst <- vapply(lst, function(x) bind(x$gene, co = ", "), 
                    FUN.VALUE = character(1))
                glue::glue("基因 {unname(lst)} {ex}表现为{fmt(names(lst))}")
            }
            use.p <- match.arg(use.p)
            if (length(lst) > 1) {
                snaps <- fun_snapThat("一致")
                x <- snapAdd(x, "综上，在各数据集 ({bind(projects)}) 中，将表达趋势一致的基因定义为{snap}。相比于 {levels_main[1]} 组，在 {levels_main[2]} 组，{bind(snaps)}({detail(use.p)} &lt; 0.05)。{snap_auc}因此，⟦mark$red('将 {bind(summary$gene)} 定义为{snap}')⟧。")
            }
            else {
                snaps <- fun_snapThat("")
                x <- snapAdd(x, "综上，在 {project_main} 数据集中，在 {levels_main[2]} 组，{bind(snaps)}({detail(use.p)} &lt; 0.05)。{snap_auc}因此，⟦mark$red('将 {bind(summary$gene)} 定义为{snap}')⟧。")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(ven.marker)
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

