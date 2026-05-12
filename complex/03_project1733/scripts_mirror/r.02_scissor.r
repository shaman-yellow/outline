# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "02_scissor")
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

geo.GSE189642 <- job_geo("GSE189642")
geo.GSE189642 <- step1(geo.GSE189642)
geo.GSE189642 <- step2(geo.GSE189642)
clear(geo.GSE189642)

metadata.GSE189642 <- expect(geo.GSE189642, geo_cols(group = "group.ch1"))
metadata.GSE189642 <- dplyr::mutate(
  metadata.GSE189642, group = paste0("IBL_", group)
)

des.GSE189642 <- asjob_deseq2(geo.GSE189642, metadata.GSE189642)
des.GSE189642 <- step1(des.GSE189642)
des.GSE189642 <- step2(des.GSE189642, IBL_High - IBL_Low, use = "pvalue")
des.GSE189642 <- step3(des.GSE189642)
clear(des.GSE189642)

srn.GSE150825 <- qs::qread("./rds_jobSave/srn.GSE150825.6.qs")

ssr.GSE150825 <- do_scissor(srn.GSE150825, des.GSE189642)
rm(srn.GSE150825)

ssr.GSE150825 <- step1(ssr.GSE150825, "small")
ssr.GSE150825 <- step2(ssr.GSE150825, c(5e-3, 5e-4), k = 8, workers = 8)
ssr.GSE150825 <- step3(ssr.GSE150825)

ssr.GSE150825 <- map(ssr.GSE150825, srn.GSE150825)
clear(ssr.GSE150825)

srn.GSE150825 <- qs::qread("./rds_jobSave/srn.GSE150825.6.qs")
srn.GSE150825 <- map(srn.GSE150825, ssr.GSE150825)

# ==========================================================================

mdb.serotonin <- job_msigdb("all")
mdb.serotonin <- step1(mdb.serotonin, "Serotonin")
clear(mdb.serotonin)

gn.serotonin <- readRDS("./rds_jobSave/gn.serotonin.1.rds")
clear(gn.serotonin)

fea.serotonin <- feature(mdb.serotonin) + feature(gn.serotonin)
clear_feature(fea.serotonin, "serotonin.rds")

# ==========================================================================

au.GSE150825 <- asjob_aucell(
  srn.GSE150825, fea.serotonin, "Serotonin"
)
au.GSE150825 <- step1(au.GSE150825, 5L)
au.GSE150825 <- map(au.GSE150825, srn.GSE150825)
clear(au.GSE150825)

ven.key_cell <- job_venn(
  `High Scissor+ ratio from All` = quantile(ssr.GSE150825, cut = .8),
  # `High Scissor+ ratio from Select` = quantile(ssr.GSE150825, type = "ratio_pos_vs_select_by_", cut = .7),
  # `IBL-related Top ratio` = quantile(au.GSE150825_hallmark, "MYC_TARGETS_V1", cut = .7, gather = "inter"),
  `High Serotonin activity` = quantile(au.GSE150825, cut = .8)
)
ven.key_cell <- step1(ven.key_cell)
clear(ven.key_cell)
feature(ven.key_cell)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  ssr.GSE150825@plots$step2$p.alpha
  ssr.GSE150825@params$map_seurat$p.map
  ssr.GSE150825@params$map_seurat$p.props
  ssr.GSE150825@params$map_seurat$p.props_group
  ssr.GSE150825@params$map_seurat$p.props_stat
  notshow(ssr.GSE150825@params$stat_alphas_all)
})

#| OVERTURE
output_with_counting_number({
  feature(mdb.serotonin)
  feature(gn.serotonin)
})

#| OVERTURE
output_with_counting_number({
  au.GSE150825@plots$step1$p.aucell_mean
  au.GSE150825@params$map_seurat$p.map
})

#| OVERTURE
output_with_counting_number({
  z7(ven.key_cell@plots$step1$p.venn, 2.5, 1.5)
  feature(ven.key_cell)
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
    # geo.GSE189642 <- job_geo("GSE189642")
    job_geo <- function (id) 
    {
        .job_geo(object = strx(id, "GSE[0-9]+"))
    }
    
    
    # geo.GSE189642 <- step1(geo.GSE189642)
    setMethod(f = "step1", signature = c(x = "job_geo"), definition = function (x, 
        ...) 
    {
        .local <- function (x, getGPL = TRUE, dir_cache = .prefix("GEO", 
            "db"), force = FALSE) 
        {
            step_message("Get GEO metadata and information.")
            if (!is.null(dir_cache)) {
                dir.create(dir_cache, FALSE)
                file_cache <- file.path(dir_cache, paste0(object(x), 
                    "_", getGPL, ".rds"))
                if (file.exists(file_cache) && !force) {
                    message(glue::glue("file.exists(file_cache): {file_cache}"))
                    about <- readRDS(file_cache)
                }
                else {
                    message(glue::glue("Download {object(x)}..."))
                    about <- e(GEOquery::getGEO(object(x), getGPL = getGPL))
                    saveRDS(about, file_cache)
                }
            }
            else {
                about <- e(GEOquery::getGEO(object(x), getGPL = getGPL))
            }
            metas <- get_metadata.geo(about)
            prods <- get_prod.geo(metas)
            prods <- .lich(c(list(`Data Source ID` = object(x)), 
                prods))
            prods <- .set_lab(prods, sig(x), object(x))
            x@params$about <- about
            x@params$metas <- metas
            x@params$prods <- prods
            guess <- metas$res[[1]]
            guess <- dplyr::rename_all(guess, make.names)
            guess <- dplyr::select(guess, 1:2, dplyr::ends_with(".ch1"))
            guess <- .set_lab(guess, sig(x), object(x), "metadata")
            x@params$guess <- guess
            x@params$test <- list(genes = try(as_tibble(about[[1]]@featureData@data), 
                TRUE), counts = try(as_tibble(about[[1]]@assayData$exprs), 
                TRUE), anno = about[[1]]@annotation, anno.db = try(.get_biocPackage.gpl(about[[1]]@annotation), 
                TRUE))
            x <- methodAdd(x, "以 R 包 `GEOquery` ⟦pkgInfo('GEOquery')⟧ 获取 {object(x)} 数据集。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # geo.GSE189642 <- step2(geo.GSE189642)
    setMethod(f = "step2", signature = c(x = "job_geo"), definition = function (x, 
        ...) 
    {
        .local <- function (x, filter_regex = NULL, baseDir = .prefix("GEO", 
            "db"), rna = TRUE, get_supp = FALSE, hasFile = FALSE) 
        {
            step_message("Download geo datasets or yellow{{RNA seq data}}.")
            if (rna && !get_supp) {
                if (dim(x$about[[1]])[1] > 0) {
                    message("Is this a Microarray dataset?")
                    return()
                }
                if (TRUE) {
                    if (TRUE) {
                      quantifications <- getRNASeqQuantResults_custom(object(x))
                    }
                    else {
                      quantifications <- e(GEOquery:::getRNASeqQuantResults(object(x)))
                    }
                    se <- e(SummarizedExperiment::SummarizedExperiment(assays = list(counts = quantifications$quants), 
                      rowData = quantifications$annotation))
                    supp <- ""
                    if (any(isThat <- !x$guess$rownames %in% colnames(se))) {
                      x$ncbiNotGot <- notGot <- x$guess$rownames[isThat]
                      message(glue::glue("any(!x$guess$rownames %in% colnames(se)): Not got: {bind(notGot)}"))
                      supp <- glue::glue("缺失样本: {bind(notGot)} ('NCBI-generated data' 缺失样本计数数据的原因包括运行未通过 50% 的对齐率或由于技术原因处理失败)")
                    }
                    x <- methodAdd(x, "以 `GEOquery:::getRNASeqQuantResults` 获取 RNA count 数据\n          (NCBI-generated data, 参考 <https://www.ncbi.nlm.nih.gov/geo/info/rnaseqcounts.html>)\n          {supp} 以及基因注释。")
                    x$about[[1]] <- se
                }
                else {
                    x$about[[1]] <- e(GEOquery::getRNASeqData(object(x)))
                    message("Replace data in `x$about[[1]]`.")
                    x <- methodAdd(x, "以 `GEOquery::getRNASeqData` 获取 RNA count 数据 (NCBI-generated data) 以及基因注释。")
                }
                x$rna <- TRUE
            }
            else {
                if (!dir.exists(baseDir)) {
                    dir.create(baseDir)
                }
                dir <- file.path(baseDir, object(x))
                continue <- 1L
                if (dir.exists(dir)) {
                    if (interactive()) {
                      continue <- sureThat(glue::glue("File exists ({dir}), continue?"))
                    }
                    else {
                      continue <- FALSE
                    }
                }
                if (continue) {
                    if (!hasFile) {
                      res <- try(e(GEOquery::getGEOSuppFiles(object(x), 
                        filter_regex = filter_regex, baseDir = baseDir)))
                      if (inherits(res, "try-error")) {
                        message(glue::glue("Download Failed. Please manualy download the file to:\n{baseDir}/{object(x)}"))
                        stop("...")
                      }
                    }
                    x$dir <- dir
                    files <- list.files(dir, "\\.tar", full.names = TRUE)
                    if (length(files)) {
                      lapply(files, function(file) {
                        utils::untar(file, exdir = normalizePath(dir))
                      })
                    }
                }
                files <- list.files(dir, ".", full.names = TRUE)
                files <- files[!grpl(files, "\\.tar$")]
                x$dir_files <- files
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(geo.GSE189642)
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
    
    
    # metadata.GSE189642 <- expect(geo.GSE189642, geo_cols(group = "group.ch1"))
    setMethod(f = "expect", signature = c(x = "job_geo", ref = "ANY"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, force = ref@default, id = x@object, 
            ret = c("meta", "job")) 
        {
            ret <- match.arg(ret)
            if (missing(ref)) {
                ref <- geo_cols()
            }
            x$guess <- expect(x$guess, ref, force = force, id = id)
            if (ret == "job") {
                return(x)
            }
            else if (ret == "meta") {
                return(x$guess)
            }
        }
        .local(x, ref, ...)
    })
    
    
    # des.GSE189642 <- asjob_deseq2(geo.GSE189642, metadata.GSE189642)
    setMethod(f = "asjob_deseq2", signature = c(x = "job_geo"), definition = function (x, 
        ...) 
    {
        .local <- function (x, metadata, use.col = NULL, use_as_id = TRUE, 
            use = 1L, ...) 
        {
            if (!x$rna) {
                stop("!x$rna, not RNA-seq data!")
            }
            counts <- as_tibble(data.frame(x$about[[use]]@assays@data$counts, 
                check.names = FALSE))
            genes <- as_tibble(data.frame(x$about[[use]]@elementMetadata, 
                check.names = FALSE))
            genes <- dplyr::mutate(genes, rownames = as.character(GeneID), 
                .before = 1)
            if (missing(use.col)) {
                use.col <- .guess_symbol(colnames(genes))
                message(glue::glue("Guess `use.col` (gene symbol) is: {use.col}."))
            }
            else {
                if (!is.character(genes[[use.col]])) {
                    stop("`use.col` should character (symbol).")
                }
            }
            genes <- dplyr::relocate(genes, rownames, symbol = !!rlang::sym(use.col))
            use.col <- "symbol"
            if (!is.null(x$ncbiNotGot)) {
                message(glue::glue("Filter out NCBI generated data (Missing samples): {bind(x$ncbiNotGot)}"))
                metadata <- dplyr::filter(metadata, !rownames %in% 
                    x$ncbiNotGot)
            }
            if (use_as_id) {
                message(crayon::red(glue::glue("Use `{use.col}` as ID columns.")))
                counts[[1]] <- genes[[use.col]]
                genes <- dplyr::relocate(genes, !!rlang::sym(use.col))
                keep <- !is.na(genes[[use.col]]) & genes[[use.col]] != 
                    ""
                genes <- genes[keep, ]
                counts <- counts[keep, ]
            }
            project <- x$project
            x <- job_deseq2(counts, metadata, genes, project, ...)
            x <- methodAdd(x, "整理 GEO 数据集 ({project}) 以备 `DESeq2` 差异分析。", 
                after = FALSE)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # des.GSE189642 <- step1(des.GSE189642)
    setMethod(f = "step1", signature = c(x = "job_deseq2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, show_qc = FALSE) 
        {
            step_message("Quality control (QC).")
            object(x) <- e(DESeq2::DESeq(object(x)))
            x$vst <- e(DESeq2::vst(object(x), blind = FALSE))
            p.pca <- DESeq2::plotPCA(x$vst, intgroup = "group")
            p.pca <- set_lab_legend(wrap(p.pca, 7, 6), glue::glue("{x@sig} PCA of VST data"), 
                glue::glue("样本 PCA 聚类图"))
            cook_data <- log10(object(x)@assays@data[["cooks"]])
            colnames(cook_data) <- colnames(object(x))
            p.boxplot <- as_grob(expression(boxplot(cook_data)))
            p.boxplot <- set_lab_legend(p.boxplot, glue::glue("{x@sig} boxplot of cook distance"), 
                glue::glue("样本 cook 距离箱线图。"))
            x <- plotsAdd(x, p.pca, p.boxplot)
            x <- methodAdd(x, "使用 DESeq 函数进行标准化和差异分析。")
            if (show_qc) {
                x <- methodAdd(x, "DESeq 函数会针对每个基因和每个样本计算一个称为 Cook 距离的异常值诊断测试。绘制 Cook 距离的箱线图{aref(p.boxplot)}，以查看是否存在某个样本始终高于其他样本。为进一步质控数据，另一方面，对数据集以 vst 函数处理，随后绘制 PCA 图检查样本是否存在批次效应或离群样本{aref(p.pca)}。")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # des.GSE189642 <- step2(des.GSE189642, IBL_High - IBL_Low, use = "pvalue")
    setMethod(f = "step2", signature = c(x = "job_deseq2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., cut.p = 0.05, cut.fc = 0.5, use = c("padj", 
            "pvalue"), order.by = "log2FoldChange") 
        {
            step_message("stat.")
            use <- match.arg(use)
            if (!...length()) {
                stop("!...length().")
            }
            contrast <- limma::makeContrasts(..., levels = object(x)@design)
            cli::cli_alert_info("DESeq2::results")
            t.results <- apply(contrast, 2, simplify = FALSE, FUN = function(numVec) {
                data <- as_tibble(data.frame(DESeq2::results(object(x), 
                    contrast = numVec)), idcol = x$idcol)
                dplyr::arrange(data, dplyr::desc(abs(!!rlang::sym(order.by))))
            })
            names(t.results) <- .fmt_contr_names(colnames(contrast))
            t.sigResults <- lapply(t.results, function(data) {
                dplyr::filter(data, !!rlang::sym(use) < cut.p, abs(log2FoldChange) > 
                    cut.fc)
            })
            t.sigResults <- set_lab_legend(t.sigResults, glue::glue("{x@sig} {names(t.sigResults)} Contrast significant result table"), 
                glue::glue("差异分析 {names(t.results)} 的显著基因的结果表格"))
            t.results <- set_lab_legend(t.results, glue::glue("{x@sig} {names(t.results)} Contrast all result table"), 
                glue::glue("差异分析 {names(t.results)} 的全部基因的结果表格"))
            res <- .collate_snap_and_features_by_logfc(t.sigResults, 
                "log2FoldChange", get = x$idcol)
            x <- methodAdd(x, "对 DESeq 函数处理过后的数据获取差异基因。⟦mark$blue('筛选差异表达基因（DEGs）的标准为 {use} &lt; {cut.p} 且 |log2(FoldChange)| &gt; {cut.fc}')⟧。")
            x <- snapAdd(x, "显著基因统计：\n⟦mark$red('{res$snap}')⟧\n")
            x$.feature <- as_feature(res$sets, glue::glue("DEGs ({x$project}, {bind(names(res$sets))})"))
            x <- tablesAdd(x, t.results, t.sigResults)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # des.GSE189642 <- step3(des.GSE189642)
    setMethod(f = "step3", signature = c(x = "job_deseq2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, top = 10, group = "group", use = x$.args$step2$use[1]) 
        {
            step_message("Draw plots.")
            use.fc <- "log2FoldChange"
            fc <- x$.args$step2$cut.fc
            cut.p <- x$.args$step2$cut.p
            data_expr <- SummarizedExperiment::assay(x$vst)
            metadata <- SummarizedExperiment::colData(x$vst)
            top_tables <- x@tables$step2$t.results
            idcol <- x$idcol
            x <- .plot_DEG_and_add_snap(x, data_expr, metadata, top_tables, 
                use = use, use.fc = use.fc, fc = fc, cut.p = cut.p, 
                top = top, group = group, features = feature(x), 
                idcol = idcol)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(des.GSE189642)
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
    
    
    # ssr.GSE150825 <- do_scissor(srn.GSE150825, des.GSE189642)
    setMethod(f = "do_scissor", signature = c(x = "job_seurat", ref = "job_deseq2"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, group = "group", family = "binomial", 
            label = group, assay = SeuratObject::DefaultAssay(object(x))) 
        {
            if (x@step < 3L) {
                stop("x@step < 3L.")
            }
            if (ref@step < 1L) {
                stop("ref@step < 1L.")
            }
            levels <- NULL
            if (family == "binomial") {
                levels <- rev(.guess_compare_deseq2(ref))
                meta_bulk <- as.integer(factor(object(ref)@colData[[group]], 
                    levels = levels)) - 1L
                methodAdd_onExit("x", "选择 Scissor 回归类型为 {family}，即构建二分类变量回归模型，计算每个细胞与表型的回归系数。将负回归系数的细胞描述为 “Scissor-”，在本研究中，与{label}为 {levels[1]} 的组高度相关；将正回归系数的细胞描述为 “Scissor+”，与{label}为 {levels[2]} 的组高度相关。回归系数为零的细胞为背景细胞。")
            }
            else {
                stop("family != \"binomial\", not yet ready.")
            }
            expr_bulk <- ref$vst@assays@data[[1L]]
            object <- object(x)
            assayObj <- object[[assay]]
            if (is(assayObj, "Assay5") || is(assayObj, "SCTAssay")) {
                message(glue::glue("Detected 'Assay5' or 'SCTAssay', convert to 'Assay'."))
                assayObj <- as(assayObj, "Assay")
                object[["RNA"]] <- assayObj
            }
            if (assay != "RNA") {
                nameSnn <- glue::glue("{assay}_snn")
                object@graphs[["RNA_snn"]] <- object@graphs[[nameSnn]]
                SeuratObject::DefaultAssay(object) <- "RNA"
                object[[assay]] <- NULL
            }
            object <- Seurat::DietSeurat(object, graphs = "RNA_snn")
            object[["RNA"]]$scale.data <- NULL
            object[["RNA"]]$counts <- NULL
            pr <- params(x)
            project_x <- x$project
            if (is.null(project_x)) {
                project_x <- .guess_geo_project(x)
            }
            project_ref <- .guess_geo_project(ref)
            x <- .job_scissor(object = list(bulk_dataset = expr_bulk, 
                sc_dataset = object, phenotype = meta_bulk))
            x <- methodAdd(x, "Scissor 是一种用于整合单细胞转录组数据与群体水平表型信息（如临床性状或 bulk 转录组数据）的分析方法，其主要目的是在单细胞分辨率下识别与特定表型显著相关的细胞亚群。该方法通过构建单细胞与 bulk 样本之间的表达相关性，并结合回归模型（如惩罚回归）筛选出与目标表型正相关或负相关的细胞群体（分别称为 Scissor+ 和 Scissor− 细胞）。在此基础上，可进一步对相关细胞群进行差异分析与功能注释。\n\n")
            x <- methodAdd(x, "选择 {project_x} 作为单细胞表达矩阵来源，以 {project_ref} 为 bulk 表达矩阵输入，且以 {project_ref} 的表型数据{label}作为目标表型，使用 R 包 `Scissor` ⟦pkgInfo('Scissor')⟧ 实现表型关联单细胞亚群分析。")
            x@params <- append(x@params, pr)
            x$family <- family
            x$tag <- levels
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # ssr.GSE150825 <- step1(ssr.GSE150825, "small")
    setMethod(f = "step1", signature = c(x = "job_scissor"), definition = function (x, 
        ...) 
    {
        .local <- function (x, mode = c("normal", "small", "middle"), 
            workers = 4L, file_save = file.path(create_job_cache_dir(x), 
                "scissor_inputs.qs"), rerun = FALSE, ...) 
        {
            step_message("Run Scissor...")
            mode <- match.arg(mode)
            if (mode == "small") {
                alphas <- c(0.005, 5e-04, 1e-04, 5e-05)
            }
            else if (mode == "middle") {
                alphas <- c(0.003, 0.001, 7e-04, 9e-04)
            }
            else if (mode == "normal") {
                alphas <- c(0.005, 0.05, 0.1, 0.2)
            }
            res <- .optimize_scissor_with_speed_up_and_score_alpha(x, 
                alphas, x$family, rerun = rerun, workers = workers, 
                ...)
            x$stat_alphas_rough <- res$stat_alphas
            x$res_scissor_rough <- res$res_scissor
            x$alphas_rough <- alphas
            x$file_save <- file_save
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ssr.GSE150825 <- step2(ssr.GSE150825, c(0.005, 5e-04), k = 8, 
    #     workers = 8)
    setMethod(f = "step2", signature = c(x = "job_scissor"), definition = function (x, 
        ...) 
    {
        .local <- function (x, alpha_range, k = 8L, alphas = NULL, 
            workers = x$.args$step1$workers, rerun = FALSE, ...) 
        {
            step_message("Optimize")
            if (is.null(alphas)) {
                alphas <- .refine_alphas_by_index(range(alpha_range), 
                    c(1L, 2L), k = k)
            }
            res <- .optimize_scissor_with_speed_up_and_score_alpha(x, 
                alphas, x$family, rerun = rerun, workers = workers, 
                ...)
            x$stat_alphas_hierar <- res$stat_alphas
            x$res_scissor_hierar <- res$res_scissor
            x$alphas_hierar <- alphas
            alls <- dplyr::bind_rows(x$stat_alphas_rough, x$stat_alphas_hierar)
            alls <- dplyr::select(alls, -dplyr::starts_with("score"))
            x$stat_alphas_all <- .score_alpha_from_scissor(alls)
            t.stat_alphas_all <- set_lab_legend(x$stat_alphas_all, 
                glue::glue("{x@sig} data scissor alpha selection"), 
                glue::glue("Scissor alpha 选择统计表。"))
            x <- tablesAdd(x, t.stat_alphas_all)
            snap_alpha <- readLines(file.path(.expath, "description", 
                "scissor_alpha.md"))
            p.alpha <- .plot_scissor_alphas_selection(x$stat_alphas_all)
            p.alpha <- set_lab_legend(wrap(p.alpha, 8, 5), glue::glue("{x@sig} scissor alpha selection"), 
                glue::glue("Scissor alpha 参数的选择|||{.note_legend_scissor_alpha}"))
            x <- plotsAdd(x, p.alpha)
            x <- methodAdd(x, "{bind(snap_alpha, co = '\n')}")
            x <- methodAdd(x, "实际应用中，分析将首先从初步拟定的 α 区间开始，随后对细胞选择数波动较大，且趋向于选择较少细胞数的 α 区间以对数尺度增加梯度，最终得到所有 α 值对应的细胞选择数以及各细胞类型对应的 Scissor+ 或 Scissor- 数量，再计算综合得分。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ssr.GSE150825 <- step3(ssr.GSE150825)
    setMethod(f = "step3", signature = c(x = "job_scissor"), definition = function (x, 
        ...) 
    {
        .local <- function (x, focus = NULL, alpha = NULL, cell_num = NULL, 
            n = 10L, nfold = 10L, qs_nthreads = 5L) 
        {
            step_message("Significant test.")
            if (is.null(alpha) || is.null(cell_num)) {
                which <- which.max(x$stat_alphas_all$score)
                use <- as.list(x$stat_alphas_all[which, ])
                alpha <- use$alpha
                score <- use$score
                cell_num <- use$ncell_select
                .fmt <- function(x) signif(x, 2)
                x <- snapAdd(x, "如图{aref(x@plots$step2$p.alpha)}，选择具有最高综合得分 (Score ={round(score, 2)}) 的 α 值 (α = {signif(alpha, 3)}, -log(α) = {round(-log(alpha), 2)}) 对表型关联分析最终定性。在该 α 值下，⟦mark$red('Scissor 细胞选择数为 {cell_num}，占所有细胞数比例为 {.fmt(use$ratio_select_vs_all)}，Scissor+ 细胞所占 Scissor 细胞选择数的比例为 {.fmt(use$ratio_pos_vs_select)}')⟧。")
                if (!is.null(focus)) {
                    snap_focus <- vapply(focus, FUN.VALUE = character(1), 
                      function(name) {
                        ratio_pos <- use[[glue::glue("ratio_pos_vs_select_by_{name})")]]
                        if (is.null(ratio_pos)) {
                          stop("is.null(ratio_pos), can not extract of celltype: ", 
                            name)
                        }
                        ratio_neg <- use[[glue::glue("ratio_neg_vs_select_by_{name})")]]
                        glue::glue("{name} 有 {.fmt(ratio_pos)} 的比例被选择为 Scissor+ 细胞，有 {.fmt(ratio_neg)} 的比例被选择为 Scissor- 细胞")
                      })
                    x <- snapAdd(x, "其中，⟦mark$red('{bind(snap_focus, co = '；')}')⟧。")
                }
            }
            fun_test <- function(...) {
                args <- .qload_multi(x$file_save, nthreads = qs_nthreads)
                .replace_fun_diag_for_scissor(x$family)
                e(Scissor::reliability.test(args$X, args$Y, args$network, 
                    alpha = alpha, family = x$family, cell_num = cell_num, 
                    n = n, nfold = nfold))
            }
            x$res_test <- expect_local_data("tmp", "scissor_reliability", 
                fun_test, list(colnames(object(x)$bulk_dataset), 
                    colnames(object(x)$sc_dataset), object(x)$phenotype, 
                    alpha, n, nfold))
            nameAlpha <- glue::glue("alpha_{alpha}")
            x$use.scissor <- x$res_scissor_hierar[[nameAlpha]] %||% 
                x$res_scissor_rough[[nameAlpha]]
            x$use.alpha <- alpha
            meta_scissor <- tibble::tibble(cell = c(x$use.scissor$Scissor_pos, 
                x$use.scissor$Scissor_neg), scissor_cell = rep(c("scissor_pos", 
                "scissor_neg"), c(length(x$use.scissor$Scissor_pos), 
                length(x$use.scissor$Scissor_neg))))
            x$metadata <- map(x$metadata, "cell", meta_scissor, "cell", 
                "scissor_cell", col = "scissor_cell")
            x$metadata <- dplyr::mutate(x$metadata, scissor_cell = ifelse(is.na(scissor_cell), 
                "scissor_null", scissor_cell), scissor_cell = factor(scissor_cell, 
                levels = c("scissor_neg", "scissor_pos", "scissor_null")))
            snap_p <- if (x$res_test$p < 0.05) 
                "结果显著 (⟦mark$blue('p < 0.05')⟧)，表明表型与单细胞亚群的关联是可靠的"
            else ""
            x <- snapAdd(x, "以 `Scissor::reliability.test` 对所选 α 对应的细胞选择数进行显著性检验，设置 nfold (number of cross-validation fold) 为 {nfold}，n (Permutation times) 为 {n}。显著性统计结果，Test statistic = {fmt(x$res_test$statistic)}, p = {fmt(x$res_test$p)} {snap_p}。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ssr.GSE150825 <- map(ssr.GSE150825, srn.GSE150825)
    setMethod(f = "map", signature = c(x = "job_scissor", ref = "job_seurat"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, .name = "seurat") 
        {
            if (is.null(x$metadata$scissor_cell)) {
                stop("is.null(x$metadata$scissor_cell).")
            }
            if (ref@step < 3L) {
                stop("ref@step < 3L.")
            }
            metadata <- data.frame(dplyr::select(x$metadata, scissor_cell), 
                row.names = x$metadata$cell)
            object(ref) <- SeuratObject::AddMetaData(object(ref), 
                metadata)
            col_celltype <- x$group.by
            group <- "scissor_cell"
            layout <- z7(wrap_layout(NULL, 2L), 1.3, 1)
            ps.map <- e(Seurat::DimPlot(object(ref), pt.size = if (dim(object(ref))[2] > 
                30000) 
                0.3
            else 0.5, group.by = c(group, ref$group.by), cols = color_set(), 
                combine = FALSE))
            ps.map[[1]] <- ps.map[[1]] + scale_color_manual(values = pal(x))
            p.map <- add(layout, ps.map, TRUE)
            p.map <- set_lab_legend(p.map, glue::glue("{x@sig} Scissor Cell UMAP mapping"), 
                glue::glue("Scissor cell 的 UMAP 图|||左图为 Scissor 细胞 UMAP 图，右图对照为细胞类型。"))
            p.props <- plot_cells_proportion(object(ref)@meta.data, 
                "orig.ident", col_celltype, group = group)
            p.props <- set_lab_legend(p.props, glue::glue("{sig(x)} Scissor Cell Proportions in each sample"), 
                glue::glue("Scissor 细胞群在各个样本中的占比|||不同颜色代表不同细胞类型，纵坐标为不同样本，横坐标为细胞类型所占百分比。"))
            x <- snapAdd(x, "将 Scissor 重新映射到 UMAP 图中{aref(p.map)}。这些细胞在不同样本中的分布如图所示{aref(p.props)}。", 
                step = .name)
            p.props_group <- plot_cells_proportion(object(ref)@meta.data, 
                group, col_celltype, "Group", group = NULL)
            p.props_group <- set_lab_legend(p.props_group, glue::glue("{sig(x)} Scissor Cell Proportions in each group"), 
                glue::glue("Scissor 细胞群在各个组别中的占比|||不同颜色代表不同细胞类型，纵坐标为不同样本，横坐标为细胞类型所占百分比。"))
            layout <- wrap_layout(NULL, length(ids(ref)), 1.7)
            p.props_stat <- .map_boxplot2(dplyr::filter(p.props$.data, 
                group != "scissor_null"), TRUE, "group", "Ratio", 
                ylab = "Ratio", ids = "Cells", ncol = layout$ncol)
            p.props_stat <- set_lab_legend(add(layout, wrap(p.props_stat)), 
                glue::glue("{sig(x)} Scissor Cell Proportion intergroup comparison"), 
                glue::glue("Scissor 细胞群占比的组间差异分析|||差异分析 Scissor+ 与 Scissor- 细胞比例。横坐标为为不同细胞簇类型，纵坐标为细胞类型所占比例，纵坐标越高表示该细胞类型所占比例越大。不同颜色代表不同分组。"))
            snap_stat <- .stat_compare_by_pvalue(p.props_stat, c("scissor_pos", 
                "scissor_neg"), name = "", mode = "ratio")
            x <- snapAdd(x, "针对不同样本的不同 Scissor 细胞类型，对细胞占比做差异分析。{snap_stat}", 
                step = .name)
            name <- glue::glue("map_{.name}")
            x[[name]] <- namel(p.map, p.props, p.props_group, p.props_stat)
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # clear(ssr.GSE150825)
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
    
    
    # srn.GSE150825 <- map(srn.GSE150825, ssr.GSE150825)
    setMethod(f = "map", signature = c(x = "job_seurat", ref = "job_scissor"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref) 
        {
            if (is.null(ref$metadata$scissor_cell)) {
                stop("is.null(ref$metadata$scissor_cell).")
            }
            metadata <- data.frame(dplyr::select(ref$metadata, scissor_cell), 
                row.names = ref$metadata$cell)
            object(x) <- SeuratObject::AddMetaData(object(x), metadata)
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # mdb.serotonin <- job_msigdb("all")
    job_msigdb <- function (mode) 
    {
        x <- .job_msigdb()
        x$mode <- mode
        x <- methodAdd(x, "MSigDB 整合了多种来源的基因集资源，包括 Hallmark、KEGG、Reactome、GO 及免疫相关特征基因集等，可根据研究目的筛选相应基因集并构建候选集合。所得基因集可进一步应用于 GSEA、GSVA、ssGSEA、AUCell 及通路富集分析，从而揭示样本间分子功能差异及潜在调控机制。")
        return(x)
    }
    
    
    # mdb.serotonin <- step1(mdb.serotonin, "Serotonin")
    setMethod(f = "step1", signature = c(x = "job_msigdb"), definition = function (x, 
        ...) 
    {
        .local <- function (x, pattern = NULL, name = pattern, join = TRUE, 
            mode = x$mode, sub = NULL, species = "Homo sapiens") 
        {
            step_message("Got data.")
            x <- .set_msig_db(x, mode, sub, species)
            sets <- as_feature(lapply(split(x$db_anno$gene_symbol, 
                x$db_anno$gs_name), unique), glue::glue("MSigDB {name} 基因集"))
            if (!is.null(pattern)) {
                sets <- sets[grp(names(sets), pattern, TRUE)]
                methodAdd_onExit("x", "在基因集中获取与 {pattern} 相关的基因子集。")
                snap <- stat_features(sets, glue::glue("MSigDB {name}"), 
                    join, assign = "sets")
                methodAdd_onExit("x", "{snap}")
            }
            x$.feature <- sets
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(mdb.serotonin)
    setMethod(f = "clear", signature = c(x = "job_msigdb"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = FALSE, lite = TRUE, suffix = NULL, 
            name = substitute(x, parent.frame(1))) 
        {
            eval(name)
            if (save) {
                callNextMethod(x, save = save, lite = FALSE, suffix = suffix, 
                    name = name)
            }
            x$db_anno <- NULL
            x$msig_db <- NULL
            if (lite) {
                callNextMethod(x, save = FALSE, lite = TRUE, suffix = suffix, 
                    name = name)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(gn.serotonin)
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
    
    
    # au.GSE150825 <- asjob_aucell(srn.GSE150825, fea.serotonin, "Serotonin")
    setMethod(f = "asjob_aucell", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, sets, name = names(sets)[1], join = TRUE, 
                sets_feature = NULL, assay = SeuratObject::DefaultAssay(object(x)), 
                ...) 
            {
                mtx <- Seurat::GetAssayData(object(x), assay = assay, 
                    layer = "data")
                if (is.null(mtx) || is.null(rownames(mtx))) {
                    stop("is.null(mtx) || is.null(rownames(mtx)).")
                }
                if (!is(sets, "feature")) {
                    stop("!is(sets, \"feature\").")
                }
                if (missing(name)) {
                    message(glue::glue("Missing `name`, will use: {name}"))
                }
                snap <- stat_features(sets, name, join, "sets")
                methodAdd_onExit("x", "{snap}以该基因集作为 AUCell 输入。")
                pr <- params(x)
                if (is.null(pr$metadata)) {
                    stop("is.null(pr$metadata).")
                }
                x <- job_aucell(mtx, sets, ...)
                x@params <- append(x@params, pr)
                x$.feature_genesSets <- sets
                x$name <- name
                return(x)
            }
            .local(x, ...)
        })
    
    
    # au.GSE150825 <- step1(au.GSE150825, 5L)
    setMethod(f = "step1", signature = c(x = "job_aucell"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = NULL, group.by = x$group.by, 
            rerun = FALSE, fun_name = function(x) s(x, "^HALLMARK_", 
                "")) 
        {
            step_message("Running...")
            if (is.remote(x)) {
                x <- run_job_remote(x, wait = 3L, {
                    x <- step1(x, workers = "{workers}")
                })
                return(x)
            }
            fun_show <- function(string) stringr::str_wrap(gs(string, 
                "_", " "), 20)
            fun_aucell <- function(...) {
                if (!is.null(workers)) {
                    workers <- e(BiocParallel::MulticoreParam(workers))
                }
                e(AUCell::AUCell_run(object(x), x$sets, BPPARAM = workers))
            }
            res_aucell <- expect_local_data("tmp", "AUcell", fun_aucell, 
                list(colnames(object(x)), sig(x), names(x$sets), 
                    x$gids), rerun = rerun)
            x$res_aucell <- e(AUCell::getAUC(res_aucell))
            if (!is.null(fun_name)) {
                rownames(x$res_aucell) <- fun_name(rownames(x$res_aucell))
            }
            x <- methodAdd(x, "采用 AUCell 算法对预定义功能基因集在单细胞水平进行活性评分，并提取各细胞对应的 AUC（Area Under the Curve）值。")
            if (!is.null(group.by)) {
                metadata <- x$metadata
                fun_mean <- function(...) {
                    auc <- .get_auc_from_job_aucell(x)
                    data <- cbind(metadata[, group.by, drop = FALSE], 
                      as.data.frame(auc))
                    data <- as.data.table(data)
                    data <- data.table:::`[.data.table`(data, , lapply(.SD, 
                      mean), by = group.by, .SDcols = setdiff(names(data), 
                      group.by))
                    tibble::as_tibble(data)
                }
                data <- expect_local_data("tmp", "aucell_mean", fun_mean, 
                    list(rownames(x$res_aucell), metadata$cell, group.by, 
                      x$gids), rerun = rerun)
                x <- methodAdd(x, "基于细胞注释信息对同一细胞群内所有细胞的 AUC 值取平均，以评估不同细胞类型的整体功能状态。")
                x$res_aucell_mean <- data
                if (ncol(data) < 21L) {
                    layout <- wrap_layout(NULL, ncol(data) - 1L, 
                      3)
                    data <- tidyr::pivot_longer(data, -!!rlang::sym(group.by), 
                      names_to = "Function", values_to = "Activity")
                    if (!is.null(fun_show)) {
                      data <- dplyr::mutate(data, Function = fun_show(Function))
                    }
                    p.aucell_mean <- ggplot(data, aes(x = reorder(!!rlang::sym(group.by), 
                      Activity), y = Activity)) + geom_col() + facet_wrap(~Function, 
                      ncol = layout$ncol) + labs(x = "Cell types", 
                      y = "Activity") + coord_flip() + theme_minimal()
                    p.aucell_mean <- set_lab_legend(add(layout, p.aucell_mean), 
                      glue::glue("{x@sig} Mean AUCell Activity"), 
                      glue::glue("各细胞类型评价 AUCell 功能活性|||每个分面代表一个独立的功能通路或生物学过程（Function），横坐标表示不同细胞群体（按平均活性值排序），纵坐标表示该群体的平均 AUCell 活性评分（Activity）。"))
                    x <- snapAdd(x, "对于每个功能基因集，计算对应细胞群体的平均活性分数，并以分面柱状图形式展示{aref(p.aucell_mean)}。")
                    x <- plotsAdd(x, p.aucell_mean)
                }
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # au.GSE150825 <- map(au.GSE150825, srn.GSE150825)
    setMethod(f = "map", signature = c(x = "job_aucell", ref = "job_seurat"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, use.trait = NULL, use.function = NULL, 
            group.by = ref$group.by, pal = NULL, .name = "seurat") 
        {
            fun_show <- function(string) stringr::str_wrap(gs(string, 
                "_", " "), 20)
            fun_rename_title <- function(lst) {
                lst$title <- fun_show(lst$title)
                lst
            }
            if (x@step == 1L) {
                if (is.null(use.function)) {
                    auc <- .get_auc_from_job_aucell(x)
                    use.function <- colnames(auc)
                }
                meta <- dplyr::select(x$metadata, cell)
                meta <- cbind(meta, auc)
                meta <- data.frame(meta[, -1L, drop = FALSE], row.names = meta$cell)
                object(ref) <- SeuratObject::AddMetaData(object(ref), 
                    meta)
                layout <- wrap_layout(NULL, length(use.function))
                ps.map <- e(Seurat::FeaturePlot(object(ref), features = use.function, 
                    combine = FALSE))
                if (!is(ps.map, "list")) {
                    ps.map <- list(ps.map)
                }
                ps.map <- lapply(ps.map, function(x) {
                    x + theme(plot.title = element_text(face = "plain", 
                      size = 10))
                })
                if (!is.null(fun_show)) {
                    ps.map <- lapply(ps.map, .set_ggplot_content, 
                      fun = fun_rename_title, slot = "labels")
                }
                p.map <- add(layout, ps.map, TRUE)
                p.map <- set_lab_legend(p.map, glue::glue("{x@sig} AUCell Activity UMAP mapping"), 
                    glue::glue("AUCell 功能活性 UMAP 图||| {bind(use.function)} 的 AUCell 功能活性 UMAP 图。"))
                x[[glue::glue("map_{.name}")]] <- namel(p.map, metadata = meta)
            }
            else if (x@step > 1L) {
                meta <- x$metadata[, !duplicated(colnames(x$metadata))]
                meta <- dplyr::select(meta, cell, AUCell_Function)
                col_r_trait <- NULL
                col_trait <- NULL
                if (!is.null(use.trait)) {
                    if (is.null(x$cor_trait_aucell)) {
                      stop("is.null(x$cor_trait_aucell), but !is.null(use.trait)")
                    }
                    data_cor <- dplyr::filter(x$cor_trait_aucell, 
                      .row.names %in% use.trait)
                    lst_cor <- split(data_cor, ~.row.names)
                    col_r_trait <- glue::glue("r_{use.trait}")
                    for (i in seq_along(lst_cor)) {
                      meta <- map(meta, "AUCell_Function", lst_cor[[i]], 
                        ".col.names", "r", col = col_r_trait[i])
                    }
                    allAvai <- c(colnames(meta(ref)), colnames(meta))
                    col_trait <- use.trait[use.trait %in% allAvai]
                    if (any(isNot <- !use.trait %in% col_trait)) {
                      warning("Can not got trait from `ref`: ", bind(use.trait[isNot]))
                    }
                }
                meta <- data.frame(meta[, -1L, drop = FALSE], row.names = meta$cell)
                object(ref) <- SeuratObject::AddMetaData(object(ref), 
                    meta)
                group <- c("AUCell_Function", group.by, col_trait)
                ps.map <- e(Seurat::DimPlot(object(ref), pt.size = if (dim(object(ref))[2] > 
                    30000) 
                    0.3
                else 0.5, group.by = group, cols = color_set(), combine = FALSE))
                if (!is.null(pal) && !is.null(use.trait)) {
                    whichTrait <- which(group %in% use.trait)
                    for (i in whichTrait) {
                      ps.map[[i]] <- ps.map[[i]] + scale_color_manual(values = pal)
                    }
                }
                if (!is.null(col_r_trait)) {
                    ps2.map <- e(Seurat::FeaturePlot(object(ref), 
                      features = col_r_trait, combine = FALSE))
                    if (!is(ps2.map, "list")) {
                      ps2.map <- list(ps2.map)
                    }
                    for (i in seq_along(col_r_trait)) {
                      ps2.map[[i]] <- ps2.map[[i]] + .scale_for_cor_palette("color")
                    }
                    group <- c(group, col_r_trait)
                    ps.map <- c(ps.map, ps2.map)
                }
                legend_ex <- ""
                if (!is.null(use.trait)) {
                    legend_ex <- glue::glue("其中，{bind(col_r_trait)} 对应为 AUCell_Function 与 {bind(use.trait)} 的关联分析的相关系数。")
                }
                layout <- z7(wrap_layout(NULL, length(group), ncol = 2), 
                    1.7, 1)
                p.map <- add(layout, ps.map, TRUE)
                p.map <- set_lab_legend(p.map, glue::glue("{x@sig} Cell Function UMAP mapping"), 
                    glue::glue("AUCell 功能活性 UMAP 图|||依次对应为 {bind(group)} 的 UMAP 图。{legend_ex}"))
                x[[glue::glue("map_{.name}")]] <- namel(p.map, metadata = meta)
            }
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # clear(au.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_aucell"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = substitute(x, parent.frame(1))) 
        {
            eval(name)
            if (save) {
                callNextMethod(x, save = save, lite = FALSE, suffix = suffix, 
                    name = name)
            }
            object(x) <- NULL
            x$res_aucell <- NULL
            if (lite) {
                callNextMethod(x, save = FALSE, lite = TRUE, suffix = suffix, 
                    name = name)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ven.key_cell <- job_venn(`High Scissor+ ratio from All` = quantile(ssr.GSE150825, 
    #     cut = 0.8), `High Serotonin activity` = quantile(au.GSE150825, 
    #     cut = 0.8))
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
    
    
    # ven.key_cell <- step1(ven.key_cell)
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
    
    
    # clear(ven.key_cell)
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
    
    
    # feature(ven.key_cell)
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
    
    
}

