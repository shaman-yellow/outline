# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "21_scTenifoldKnk")
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
srn.GSE150825_sciPos_FibroClean <- readRDS("./rds_jobSave/srn.GSE150825_sciPos_FibroClean.6.rds")

sct.GSE150825_sciPos_FibroClean <- asjob_scteni(srn.GSE150825_sciPos_FibroClean, fea.markers)
sct.GSE150825_sciPos_FibroClean <- step1(sct.GSE150825_sciPos_FibroClean)

clear(sct.GSE150825_sciPos_FibroClean)
sct.GSE150825_sciPos_FibroClean <- step2(
  sct.GSE150825_sciPos_FibroClean, cut.z = 1
)
clear(sct.GSE150825_sciPos_FibroClean)

ven.knk <- job_venn(lst = feature(sct.GSE150825_sciPos_FibroClean))
ven.knk <- step1(ven.knk)
clear(ven.knk)

en.knk <- asjob_enrich(feature(ven.knk))
en.knk <- step1(en.knk)
clear(en.knk)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  sct.GSE150825_sciPos_FibroClean@plots$step2$ps.volcano$CD9
  sct.GSE150825_sciPos_FibroClean@plots$step2$ps.volcano$CXCL12
  sct.GSE150825_sciPos_FibroClean@plots$step2$ps.volcano$NME1
  sct.GSE150825_sciPos_FibroClean@plots$step2$ps.volcano$PTPN6
  notshow(sct.GSE150825_sciPos_FibroClean@tables$step2$t.all_diff)
  z7(ven.knk@plots$step1$p.venn, 2, 2)
  z7(en.knk@plots$step1$p.kegg$ids, 1, .5)
  notshow(en.knk@tables$step1$res.kegg$ids)
  en.knk@plots$step1$p.go$ids
  notshow(en.knk@tables$step1$res.go$ids)
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
    # sct.GSE150825_sciPos_FibroClean <- asjob_scteni(srn.GSE150825_sciPos_FibroClean, 
    #     fea.markers)
    setMethod(f = "asjob_scteni", signature = c(x = "ANY"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref) 
        {
            pr <- list()
            if (is(x, "job_seurat")) {
                pr <- params(x)
                if (any(!ref %in% rownames(object(x)))) {
                    stop("any(!ref %in% rownames(object(x))).")
                }
                pr$dir_seurat <- create_job_cache_dir(x, "sctenifoldknk", 
                    path = ".")
                pr$file_seurat <- file.path(pr$dir_seurat, glue::glue("seurat_{sig(x)}.rds"))
                if (!file.exists(pr$file_seurat)) {
                    message(glue::glue("Save file: {pr$file_seurat}"))
                    saveRDS(object(x), pr$file_seurat)
                }
            }
            fea <- resolve_feature_snapAdd_onExit("x", ref)
            x <- .job_scteni(object = fea)
            x@params <- append(x@params, pr)
            x$features <- ref
            return(x)
        }
        .local(x, ...)
    })
    
    
    # sct.GSE150825_sciPos_FibroClean <- step1(sct.GSE150825_sciPos_FibroClean)
    setMethod(f = "step1", signature = c(x = "job_scteni"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Do nothing")
            x <- methodAdd(x, "**scTenifoldKnk** 是一种基于单细胞转录组数据构建基因调控网络并进行 *in silico* 虚拟敲除的计算方法，其核心目的是在无需实际基因编辑实验的情况下，评估特定基因在细胞系统中的功能重要性及其对全局转录调控网络的影响。具体而言，该方法通过对目标基因进行网络层面的“移除”，并比较敲除前后基因调控网络结构及表达模式的变化，从而识别潜在的下游调控通路及受影响的关键基因模块。该分析有助于优先筛选具有重要生物学意义的候选关键基因，为后续机制研究和实验验证提供理论依据。")
            x <- methodAdd(x, "以 R 包 `scTenifoldKnk` ⟦pkgInfo('scTenifoldKnk')⟧ 模拟敲除分析，以推测关键基因下游功能影响。构建好的基因调控网络（gene regulatory network，GRN）中进行无监督虚拟敲低，通过模拟关键基因节点的缺失来模拟其敲低状态，进而筛选出因关键基因敲低而调控关系发生显著改变的基因。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(sct.GSE150825_sciPos_FibroClean)
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
    
    
    # sct.GSE150825_sciPos_FibroClean <- step2(sct.GSE150825_sciPos_FibroClean, 
    #     cut.z = 1)
    setMethod(f = "step2", signature = c(x = "job_scteni"), definition = function (x, 
        ...) 
    {
        .local <- function (x, use.p = c("p.adj", "p.value"), cut.p = 0.05, 
            cut.z = 2, recode = NULL, dir = x$dir_seurat, lst_diff = .read_scteni_results(dir, 
                sig(x))) 
        {
            step_message("Load results file and draw volcano plot.")
            use.p <- match.arg(use.p)
            if (!is.null(recode)) {
                names(lst_diff) <- dplyr::recode(names(lst_diff), 
                    !!!recode)
                lst_diff_no_filter <- lapply(lst_diff, function(data) {
                    dplyr::mutate(data, gene = dplyr::recode(gene, 
                      !!!recode))
                })
            }
            else {
                lst_diff_no_filter <- lst_diff
            }
            lst_diff <- sapply(names(lst_diff_no_filter), simplify = FALSE, 
                function(name) {
                    data <- lst_diff_no_filter[[name]]
                    message(glue::glue("All data, nrow: {nrow(data)}"))
                    data <- dplyr::filter(data, gene != !!name, !!rlang::sym(use.p) < 
                      !!cut.p)
                    message(glue::glue("After filter by {use.p}, nrow: {nrow(data)}"))
                    if (!is.null(cut.z)) {
                      data <- dplyr::filter(data, abs(Z) > !!cut.z)
                    }
                    message(glue::glue("After filter by |Z|, nrow: {nrow(data)}"))
                    data
                })
            lst_diff <- set_lab_legend(lst_diff, glue::glue("{x@sig} data of genes affected by {names(lst_diff)} knockout"), 
                glue::glue("受 {names(lst_diff)} 敲除影响最显著的基因"))
            x <- tablesAdd(x, t.all_diff = lst_diff)
            feature(x) <- as_feature(lapply(lst_diff, function(x) x$gene), 
                "受关键基因敲除而显著影响的基因")
            ps.volcano <- sapply(names(lst_diff_no_filter), simplify = FALSE, 
                function(name) {
                    data <- lst_diff_no_filter[[name]]
                    cut.fc <- if (is.null(cut.z)) 
                      0
                    else cut.z
                    p <- plot_volcano(data, "gene", use = use.p, 
                      use.fc = "Z", fc = cut.fc, label.fc = "Z-score", 
                      f.nudge = 0.5, mode_fc = 1, HLs = head(data$gene, 
                        n = 10), show_legend = FALSE, use_break = FALSE)
                    set_lab_legend(wrap(p, 5, 6), glue::glue("{x@sig} genes affected by {name} knockout"), 
                      glue::glue("受 {name} 敲除影响最显著的基因|||横坐标为标准化Z分数，Z 的绝对值越大表示该基因受 KO 扰动越显著；纵坐标为下游基因。"))
                })
            x <- plotsAdd(x, ps.volcano)
            snap <- .stat_table_by_pvalue(dplyr::bind_rows(lst_diff, 
                .id = "ID"), n = 10, split = "ID", use.p = use.p, 
                colName = "gene", target = "基因", by = "被敲除后显著影响到", 
                needSum = FALSE)
            x <- snapAdd(x, "关键基因敲除导致调控关系发生变化，{snap}")
            if (!is.null(cut.z)) {
                snap.z <- glue::glue("& |Z| &gt; {cut.z}")
            }
            else {
                snap.z <- ""
            }
            x <- methodAdd(x, "筛选因关键基因敲低而调控关系发生显著改变的基因（阈值为{use.p} &lt; {cut.p} {snap.z}）。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(sct.GSE150825_sciPos_FibroClean)
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
    
    
    # ven.knk <- job_venn(lst = feature(sct.GSE150825_sciPos_FibroClean))
    job_venn <- function (..., mode = c("key", "candidates"), analysis = NULL, 
        lst = NULL, fun_map = function(x) x) 
    {
        if (is.null(lst)) {
            object <- list(...)
        }
        else {
            object <- lst
        }
        nature <- "基因集"
        if (all(vapply(object, is, logical(1), "feature"))) {
            snaps <- paste0("- ", vapply(object, snap, character(1), 
                enumerate = FALSE, unlist = TRUE))
            methodAdd_onExit("x", "数据集为：\n\n{bind(snaps, co = '\n')}\n\n\n\n")
            nature <- object[[1]]@nature
            message(glue::glue("Use nature as: {nature}"))
            object <- lapply(object, function(x) fun_map(unlist(x@.Data)))
            if (is.null(analysis)) {
                mode <- match.arg(mode)
                mode <- switch(mode, key = "关键", candidates = "候选")
                analysis <- glue::glue("{mode}{nature}")
            }
        }
        else {
            message(glue::glue("Some were not 'feature', be carefull! If you need automatic snap ..."))
        }
        x <- .job_venn(object = lapply(object, unlist))
        x <- methodAdd(x, "以 R 包 `ggVennDiagram` ⟦pkgInfo('ggVennDiagram')⟧ 对{nature}取交集。")
        x$nature <- nature
        x$analysis <- analysis
        return(x)
    }
    
    
    # ven.knk <- step1(ven.knk)
    setMethod(f = "step1", signature = c(x = "job_venn"), definition = function (x, 
        ...) 
    {
        step_message("Intersection.")
        p.venn <- new_venn(lst = object(x), force_upset = FALSE, 
            ...)
        p.venn <- set_lab_legend(p.venn, glue::glue("{x@sig} intersection of {bind(names(object(x)), co = ' with ')}"), 
            glue::glue("{bind(names(object(x)))} 交集维恩图|||不同颜色圆圈代表不同数据集，中间重叠部分表示同时存在多个集合中。图中 {length(p.venn$ins)} 交集为：{less(p.venn$ins, 20)}。"))
        x$.append_heading <- FALSE
        if (identical(parent.frame(1), .GlobalEnv)) {
            job_append_heading(x, heading = glue::glue("汇总: ", 
                bind(names(object(x)), co = " + ")))
        }
        if (length(p.venn$ins) < 10) {
            iter <- glue::glue(" ({bind(p.venn$ins)}) ")
        }
        else {
            iter <- ""
        }
        x <- snapAdd(x, "对{bind(names(object(x)))} 取交集，得到{length(p.venn$ins)}个交集{iter}{aref(p.venn)}。")
        x <- plotsAdd(x, p.venn)
        if (!is.null(x$analysis)) {
            feature(x) <- as_feature(p.venn$ins, x$analysis, nature = x$nature, 
                ...)
        }
        else {
            x$.feature <- as_feature(p.venn$ins, x, nature = x$nature, 
                ...)
        }
        return(x)
    })
    
    
    # clear(ven.knk)
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
    
    
    # en.knk <- asjob_enrich(feature(ven.knk))
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
    
    
    # en.knk <- step1(en.knk)
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
    
    
    # clear(en.knk)
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

