# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "15_reactome")
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

srn.GSE167363_T <- qs::qread("./rds_jobSave/srn.GSE167363_T.6.qs")

tcell <- c("Cytotoxic_CD8_T", "Memory_CD4_T", "Naive_CD4_T")
rt.GSE167363_T <- asjob_reactome(srn.GSE167363_T, tcell)
rt.GSE167363_T <- step1(rt.GSE167363_T)

rt.GSE167363_T <- step2(rt.GSE167363_T, mode = "pathway")
rt.GSE167363_T <- step3(rt.GSE167363_T)
clear(rt.GSE167363_T)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  rt.GSE167363_T@plots$step3$p.hps$pathways
  notshow(rt.GSE167363_T@tables$step2$t.wilcox$pathways)
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
    # rt.GSE167363_T <- asjob_reactome(srn.GSE167363_T, tcell)
    setMethod(f = "asjob_reactome", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, ref = NULL, compare.by = "group", 
                sample.by = "orig.ident", cellType = x$group.by, 
                ids = c(compare.by, sample.by, cellType)) 
            {
                object <- object(x)
                if (is.null(ref)) {
                    fea <- as_feature(levels(Seurat::Idents(object)), 
                      "关键细胞", "cell")
                    ref <- snap(fea)
                }
                snapAdd_onExit("x", "将{bind(ref)}进行通路富集分析。")
                if (is.null(object@meta.data[[compare.by]])) {
                    stop("is.null(object@meta.data[[compare.by]]).")
                }
                if (any(colnames(object@meta.data) == "ids")) {
                    stop("any(colnames(object@meta.data) == \"ids\").")
                }
                object@meta.data <- tidyr::unite(object@meta.data, 
                    "ids", dplyr::all_of(ids), sep = "___", remove = FALSE)
                metadata <- as_tibble(object@meta.data, idcol = "cell")
                e(Seurat::Idents(object) <- "ids")
                message(glue::glue("Clusters for enrichment: {less(levels(Seurat::Idents(object)), 10)}"))
                message("Replace aggregation with a sparse matrix algorithm")
                cli::cli_alert_info(".reactome_prepare")
                object <- .reactome_prepare(object, verbose = TRUE)
                x <- .job_reactome(object = object)
                x$metadata <- metadata
                x$compare.by <- compare.by
                x$sample.by <- sample.by
                x$cellType <- cellType
                x$ids <- ids
                x$from <- "Seurat"
                return(x)
            }
            .local(x, ...)
        })
    
    
    # rt.GSE167363_T <- step1(rt.GSE167363_T)
    setMethod(f = "step1", signature = c(x = "job_reactome"), definition = function (x, 
        ...) 
    {
        .local <- function (x, fallback = TRUE, verify = TRUE) 
        {
            step_message("Send to reactome server.")
            cli::cli_alert_info("ReactomeGSA::perform_reactome_analysis")
            if (fallback) {
                options(reactome_gsa.url = "http://gsa.reactome.org")
            }
            if (!verify) {
                Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true")
                httr::set_config(httr::config(ssl_verifypeer = FALSE, 
                    ssl_verifyhost = FALSE))
            }
            object(x) <- ReactomeGSA::perform_reactome_analysis(object(x), 
                verbose = TRUE)
            x <- methodAdd(x, "反应组基因集分析（Reactome Gene Set Analysis，ReactomeGSA）是 Reactome 知识库旗下的多组学通路分析工具，可通过 Camera、PADOG 等方法将单细胞数据转化为通路水平信息，通过计算细胞集群平均表达量实现通路富集分析，识别细胞功能特征，解析细胞异质性。")
            x <- methodAdd(x, "使用 R 包 `ReactomeGSA` ⟦pkgInfo('ReactomeGSA')⟧ 基于基因表达量对 Reactome 通路进行“活性评分”。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # rt.GSE167363_T <- step2(rt.GSE167363_T, mode = "pathway")
    setMethod(f = "step2", signature = c(x = "job_reactome"), definition = function (x, 
        ...) 
    {
        .local <- function (x, use = c("p.value", "p.adjust"), show = 10, 
            rerun = FALSE, mode = c("all", "pathway")) 
        {
            step_message("Gather for test.")
            compare.by <- x$compare.by
            use <- match.arg(use)
            mode <- match.arg(mode)
            if (!is.null(x$from) && x$from == "Seurat") {
                if (length(unique(x$metadata[[compare.by]])) != 2) {
                    stop("length(unique(x$metadata[[gather.by]])) != 2, only comparison of two group allowed.")
                }
                paths <- ReactomeGSA::get_result(object(x), "pathways", 
                    "Seurat")
                genes <- ReactomeGSA::get_result(object(x), "fold_changes", 
                    "Seurat")
                fun_test <- function(x, y) {
                    pbapply::pbvapply(seq_along(x), function(n) {
                      wilcox.test(x[[n]], y[[n]])$p.value
                    }, double(1))
                }
                lst <- setNames(list(paths, genes), c("pathways", 
                    "genes"))
                lapply_test <- function(lst) {
                    lapply(lst, function(data) {
                      whichIdCols <- which(vapply(data, is.character, 
                        logical(1)))
                      if (!all(whichIdCols %in% 1:2)) {
                        stop("!all(whichIdCols %in% 1:3).")
                      }
                      idCols <- colnames(data)[whichIdCols]
                      if (!all(idCols %in% c("Pathway", "Name", "Identifier"))) {
                        stop("!all(idCols %in% c(\"Pathway\", \"Name\", \"Identifier\")).")
                      }
                      data <- dplyr::select(data, -dplyr::contains("Pathway"))
                      data <- dplyr::rename(data, Name = 1)
                      data <- tidyr::pivot_longer(data, dplyr::where(is.double), 
                        names_to = "type", values_to = "value")
                      data <- tidyr::separate(data, type, into = x$ids, 
                        sep = "___")
                      data <- dplyr::select(data, -!!rlang::sym(x$sample.by))
                      data <- tidyr::pivot_wider(data, names_from = !!rlang::sym(compare.by), 
                        values_from = value)
                      groups <- unique(x$metadata[[compare.by]])
                      cli::cli_alert_info("wilcox.test")
                      data <- dplyr::mutate(data, p.value = fun_test(!!rlang::sym(groups[1]), 
                        !!rlang::sym(groups[2])))
                      data <- dplyr::group_by(data, !!rlang::sym(x$cellType))
                      data <- dplyr::mutate(data, p.adjust = p.adjust(p.value, 
                        method = "BH"))
                      data <- dplyr::ungroup(data)
                      dplyr::arrange(data, p.value)
                    })
                }
                t.wilcox <- expect_local_data("tmp", "reactome_wilcox", 
                    lapply_test, list(lst = lst), rerun = rerun)
                snap <- .stat_table_by_pvalue(t.wilcox$pathways, 
                    n = show, use.p = use, colName = "Name")
                x <- snapAdd(x, "通过对 ReactomeGSA 活性评分差异分析富集通路 ({detail(use)} &lt; 0.05)，一共富集到{snap}\n\n")
                if (mode == "all") {
                    snap <- .stat_table_by_pvalue(t.wilcox$genes, 
                      n = show, use.p = use, colName = "Name", target = "基因")
                    x <- snapAdd(x, "通过对 ReactomeGSA 活性评分差异分析富集基因 (⟦mark$blue('{detail(use)} &lt; 0.05')⟧)，一共富集到{snap}")
                    snap_ex <- "通路和基因"
                }
                else {
                    snap_ex <- "通路"
                }
                x <- tablesAdd(x, t.wilcox)
                x <- methodAdd(x, "以 wilcox.test 检验评估每个{snap_ex}在组间的表达差异显著性，并以 {detail(use)} 对其排序。")
                x$mode <- mode
                x$snap_ex <- snap_ex
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # rt.GSE167363_T <- step3(rt.GSE167363_T)
    setMethod(f = "step3", signature = c(x = "job_reactome"), definition = function (x, 
        ...) 
    {
        .local <- function (x, top = x$.args$step2$show) 
        {
            step_message("")
            lst <- x@tables$step2$t.wilcox
            p.hps <- sapply(names(lst), simplify = FALSE, function(type) {
                data <- lst[[type]]
                .set_heatmap_with_test_list(data, top, x$cellType)
            })
            cn <- dplyr::recode(names(p.hps), genes = "基因", pathways = "通路")
            p.hps <- set_lab_legend(p.hps, glue::glue("{x@sig} Top {names(p.hps)} ReactomeGSA heatmap"), 
                glue::glue("ReactomeGSA 富集结果中各细胞类型按显著性排列靠前的{cn}|||横轴分布的是不同细胞类型，对应于各自组别；纵向为富集通路的名称。"))
            x <- snapAdd(x, "如图，富集的{x$snap_ex}在不同组之间的活性评分以热图展示。")
            x <- plotsAdd(x, p.hps)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(rt.GSE167363_T)
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

