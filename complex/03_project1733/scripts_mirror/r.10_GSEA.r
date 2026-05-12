# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "10_GSEA")
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
fea.markers

corgsea.marker <- asjob_corgsea(des.GSE189642, fea.markers)
corgsea.marker <- step1(corgsea.marker)
corgsea.marker <- step2(corgsea.marker)
clear(corgsea.marker)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(corgsea.marker@plots$step2$p.codes$CD9, 10, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$CD9)
  wrap(corgsea.marker@plots$step2$p.codes$CXCL12, 10, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$CXCL12)
  wrap(corgsea.marker@plots$step2$p.codes$PTPN6, 10, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$PTPN6)
  wrap(corgsea.marker@plots$step2$p.codes$NME1, 10, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$NME1)
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
    # corgsea.marker <- asjob_corgsea(des.GSE189642, fea.markers)
    setMethod(f = "asjob_corgsea", signature = c(x = "job_deseq2"), 
        definition = function (x, ...) 
        {
            .local <- function (x, ref, method = "spearman") 
            {
                if (x@step < 1L) {
                    stop("x@step < 1L.")
                }
                if (any(!ref %in% rownames(object(x)))) {
                    stop("any(!ref %in% rownames(object(x))).")
                }
                data <- SummarizedExperiment::assay(x$vst)
                x <- job_corgsea(data, ref, method = method)
                return(x)
            }
            .local(x, ...)
        })
    
    
    # corgsea.marker <- step1(corgsea.marker)
    setMethod(f = "step1", signature = c(x = "job_corgsea"), definition = function (x, 
        ...) 
    {
        .local <- function (x, db, cutoff = 0.05, pattern = NULL, 
            pvalue = FALSE, cutoff.nes = 1, db_anno = NULL, rerun = FALSE, 
            mode = c(`curated gene sets` = "C2", `hallmark gene sets` = "H", 
                `positional gene sets` = "C1", `regulatory target gene sets` = "C3", 
                `computational gene sets` = "C4", `ontology gene sets` = "C5", 
                `oncogenic signature gene sets` = "C6"), mode_sub = "CP") 
        {
            step_message("Custom database for GSEA enrichment.")
            if (missing(db)) {
                mode <- match.arg(mode)
                x <- .set_msig_db(x, mode, mode_sub)
                db <- x$msig_db
            }
            if (is.null(db_anno)) {
                db_anno <- x$db_anno
            }
            cli::cli_h1("clusterProfiler::GSEA")
            dir.create("tmp", FALSE)
            all.gsea <- pbapply::pbsapply(names(object(x)), simplify = FALSE, 
                function(name) {
                    glist <- object(x)[[name]]
                    args <- list(geneList = glist, TERM2GENE = db, 
                      pvalueCutoff = cutoff)
                    res.gsea <- expect_local_data("tmp", "gsea", 
                      clusterProfiler::GSEA, args, rerun = rerun)
                    table_gsea <- dplyr::as_tibble(res.gsea@result)
                    table_gsea <- dplyr::filter(table_gsea, abs(NES) > 
                      cutoff.nes)
                    table_gsea <- dplyr::mutate(table_gsea, geneName_list = strsplit(core_enrichment, 
                      "/"), Count = lengths(geneName_list), GeneRatio = round(as.double(stringr::str_extract(leading_edge, 
                      "[0-9]+"))/100, 2))
                    table_gsea <- set_lab_legend(table_gsea, glue::glue("GSEA pathway list of {name} data"), 
                      glue::glue("为基因 {name} 的 GSEA 按 {mode} ({names(mode)}) 数据集富集附表。"))
                    if (!is.null(db_anno) && all(c("gs_id", "gs_description") %in% 
                      colnames(db_anno))) {
                      table_gsea <- map(table_gsea, "ID", db_anno, 
                        "gs_id", "gs_description", col = "Description")
                      table_gsea <- dplyr::mutate(table_gsea, Description = stringr::str_wrap(Description, 
                        80))
                      p.gsea <- plot_kegg(table_gsea)
                      p.gsea <- .set_lab(p.gsea, sig(x), glue::glue("Gene {name} GSEA pathway list of {mode}"))
                      p.gsea <- setLegend(p.gsea, "基因 {name} 的 GSEA 按 {mode} ({names(mode)}) 数据集富集图。")
                    }
                    else {
                      p.gsea <- NULL
                    }
                    return(namel(table_gsea, p.gsea, res.gsea))
                })
            p.gsea <- lapply(all.gsea, function(x) x$p.gsea)
            table_gsea <- lapply(all.gsea, function(x) x$table_gsea)
            if (length(all.gsea) < 6) {
                snaps <- vapply(table_gsea, FUN.VALUE = character(1), 
                    function(data) {
                      .stat_table_by_pvalue(data, n = 10, use.p = "p.adjust", 
                        enumeration = FALSE)
                    })
                snaps <- glue::glue("{names(table_gsea)} 富集到 {snaps}")
                x <- snapAdd(x, "基因 {bind(snaps, co = '')}")
            }
            res.gsea <- lapply(all.gsea, function(x) x$res.gsea)
            x <- methodAdd(x, "使用 {mode} 数据集, 以 R 包 `clusterProfiler` ⟦pkgInfo('clusterProfiler')⟧ 对基因列表富集分析。富集设定阈值 ⟦mark$blue('adjust P value (FDR) &lt; {cutoff}，|NES| &gt; {cutoff.nes}')⟧。")
            x@params$res.gsea <- res.gsea
            x@params$db.gsea <- db
            x$db_anno <- db_anno
            x <- tablesAdd(x, table_gsea)
            x <- plotsAdd(x, p.gsea)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # corgsea.marker <- step2(corgsea.marker)
    setMethod(f = "step2", signature = c(x = "job_corgsea"), definition = function (x, 
        ...) 
    {
        .local <- function (x, top = 10, intersect = TRUE) 
        {
            step_message("Select and Visualization")
            x$.feature <- list()
            p.codes <- sapply(names(x$res.gsea), simplify = FALSE, 
                function(name) {
                    data <- x@tables$step1$table_gsea[[name]]
                    dataTop <- head(data, n = top)
                    idTop <- dataTop$ID
                    x$.feature[[name]] <<- dataTop$Description
                    p.code <- vis(x, map = idTop, res.gsea = x$res.gsea[[name]], 
                      table_gsea = data, .name = name)
                    p.code
                })
            alls <- names(x$res.gsea)
            x <- snapAdd(x, "选取 {bind(alls)} 的 Top {top} 富集通路{aref(p.codes)}。")
            x <- plotsAdd(x, p.codes)
            ins <- lapply(x@tables$step1$table_gsea, function(data) {
                head(data$ID, n = top)
            })
            ins <- ins(lst = ins)
            if (length(ins)) {
                insName <- dplyr::filter(x@tables$step1$table_gsea[[1]], 
                    ID %in% !!ins)$Description
                x <- snapAdd(x, "对 {bind(alls)} 的 Top {top} 通路取交集，得到 {length(ins)} 个通路：{bind(insName)}。")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(corgsea.marker)
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

