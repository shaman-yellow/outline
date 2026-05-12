# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "03_enrich")
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

ven.candidates <- readRDS("./rds_jobSave/ven.candidates.1.rds")

en.candidates <- asjob_enrich(feature(ven.candidates))
en.candidates <- step1(en.candidates)
clear(en.candidates)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(en.candidates@plots$step1$p.kegg$ids, 1, .7)
  en.candidates@plots$step1$p.go$ids
  notshow(en.candidates@tables$step1$res.kegg$ids)
  notshow(en.candidates@tables$step1$res.go$ids)
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
    # en.candidates <- asjob_enrich(feature(ven.candidates))
    setMethod(f = "asjob_enrich", signature = c(x = "feature"), definition = function (x, 
        ...) 
    {
        .local <- function (x, unlist = TRUE, ...) 
        {
            names <- names(x)
            x <- resolve_feature_snapAdd_onExit("x", x)
            if (unlist) {
                x <- job_enrich(unlist(x), ...)
            }
            else {
                names(x) <- names
                x <- job_enrich(x, ...)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # en.candidates <- step1(en.candidates)
    setMethod(f = "step1", signature = c(x = "job_enrich"), definition = function (x, 
        ...) 
    {
        .local <- function (x, organism = c("hsa", "mmu", "rno"), 
            orgDb = switch(organism, hsa = "org.Hs.eg.db", mmu = "org.Mm.eg.db", 
                rno = "org.Rn.eg.db"), cl = 4, maxShow.kegg = 20, 
            exclude_disease = TRUE, maxShow.go = 10, use = c("p.adjust", 
                "pvalue")) 
        {
            step_message("Use clusterProfiler for enrichment.")
            cli::cli_alert_info("clusterProfiler::enrichKEGG")
            organism <- match.arg(organism)
            orgDb <- match.arg(orgDb)
            use <- match.arg(use)
            res.kegg <- expect_local_data("tmp", "kegg", multi_enrichKEGG, 
                list(lst.entrez_id = object(x), organism = organism))
            if (exclude_disease) {
                methodAdd_onExit("x", "对于 KEGG 富集分析，富集后根据 Category 去除 Human Diseases 条目，随后根据阈值统计结果。")
                res.kegg <- lapply(res.kegg, function(x) {
                    dplyr::filter(x, category != "Human Diseases")
                })
            }
            p.kegg <- vis_enrich.kegg(res.kegg, maxShow = maxShow.kegg, 
                use = use)
            use.p <- attr(p.kegg, "use.p")
            p.kegg <- set_lab_legend(p.kegg, glue::glue("{x@sig} {names(p.kegg)} KEGG enrichment"), 
                glue::glue("{.enNames(p.kegg)} KEGG 富集分析气泡图|||横坐标为 GeneRatio (目标基因在基因集中的比例与目标基因的总数的比值)；纵坐标代表富集到通路的名称；点的大小代表富集到的属于该通路的基因的数量；颜色代表-log10({use.p})，值越大代表富集到的通路越显著。"))
            fun <- function(sets) {
                lapply(sets, function(set) {
                    from_ids <- x@params$annotation$entrezgene_id
                    to_names <- x@params$annotation[[x$from]]
                    to_names[match(set, from_ids)]
                })
            }
            res.kegg <- lapply(res.kegg, mutate, geneName_list = fun(geneID_list))
            res.kegg <- set_lab_legend(res.kegg, glue::glue("{x@sig} {names(res.kegg)} KEGG enrichment data"), 
                glue::glue("为 {.enNames(res.kegg)} KEGG 富集分析统计表。"))
            cli::cli_alert_info("clusterProfiler::enrichGO")
            res.go <- expect_local_data("tmp", "go", multi_enrichGO, 
                list(lst.entrez_id = object(x), orgDb = orgDb, cl = cl), 
                ignore = "cl")
            p.go <- vis_enrich.go(res.go, maxShow = maxShow.go, use = use.p)
            p.go <- set_lab_legend(p.go, glue::glue("{x@sig} {names(p.go)} GO enrichment"), 
                glue::glue("为 {.enNames(p.go)} GO 富集分析气泡图|||横坐标为 GeneRatio (目标基因在基因集中的比例与目标基因的总数的比值)；纵坐标代表富集到通路的名称；点的大小代表富集到的属于该通路的基因的数量；颜色代表-log10({use.p})，值越大代表富集到的通路越显著。GO 富集囊括了三个子集 Cellular Component (CC), the Molecular Function (MF) and the Biological Process (BP)。"))
            res.go <- lapply(res.go, function(data) {
                if (all(vapply(data, is.data.frame, logical(1)))) {
                    data <- as_tibble(data.table::rbindlist(data, 
                      idcol = TRUE))
                    data <- dplyr::mutate(data, geneName_list = fun(geneID_list))
                    dplyr::relocate(data, ont = .id)
                }
            })
            res.go <- set_lab_legend(res.go, glue::glue("{x@sig} {names(res.go)} GO enrichment data"), 
                glue::glue(" {.enNames(res.go)} GO 富集分析统计表。"))
            if (length(res.kegg) == 1) {
                x <- snapAdd(x, "KEGG 一共富集到 {.stat_table_by_pvalue(res.kegg[[1]], 10, use.p = use.p, enumeration = FALSE)}")
                x <- snapAdd(x, "GO 一共富集到 {.stat_table_by_pvalue(res.go[[1]], 5, 'ont', use.p = use.p, enumeration = FALSE)}")
            }
            x <- tablesAdd(x, res.kegg, res.go)
            x <- plotsAdd(x, p.kegg, p.go)
            x@params$check_go <- check_enrichGO(res.go)
            x$organism <- organism
            x <- methodAdd(x, "以 R 包 `clusterProfiler` ⟦pkgInfo('clusterProfiler')⟧进行 KEGG 和 GO 富集分析。以 {use.p} 表示显著水平。富集筛选条件为 {use.p} &lt; 0.05。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(en.candidates)
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

