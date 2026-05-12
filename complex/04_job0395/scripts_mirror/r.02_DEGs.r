# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "02_DEGs")
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

geo.GSE134347 <- job_geo("GSE134347")
geo.GSE134347 <- step1(geo.GSE134347)
clear(geo.GSE134347, lite = FALSE)

metadata.GSE134347 <- expect(geo.GSE134347, geo_cols())
metadata.GSE134347 <- dplyr::filter(metadata.GSE134347, group != "noninfectious")

lm.GSE134347 <- asjob_limma(geo.GSE134347, metadata.GSE134347)
lm.GSE134347 <- step1(lm.GSE134347)
lm.GSE134347 <- step2(
  lm.GSE134347, sepsis - healthy,
  use = "P", cut.fc = .5
)
lm.GSE134347 <- step3(lm.GSE134347)
clear(lm.GSE134347)

swi.cpd <- readRDS("./rds_jobSave/swi.cpd.2.rds")
sup.cpd <- readRDS("./rds_jobSave/sup.cpd.2.rds")

ven.candidates <- job_venn(
  `DEGs (sepsis vs healthy)` = feature(lm.GSE134347),
  `Endogenous small-molecule compound targets` = feature(swi.cpd, "target") + feature(sup.cpd, "target"),
  mode = "candidates"
)
ven.candidates <- step1(ven.candidates)
clear(ven.candidates)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  lm.GSE134347@plots$step3$topDegs$`sepsis vs healthy`$p.hp
  lm.GSE134347@plots$step3$topDegs$`sepsis vs healthy`$p.volcano
  notshow(lm.GSE134347@tables$step2$tops$`sepsis vs healthy`)
  feature(lm.GSE134347)
})

#| OVERTURE
output_with_counting_number({
  ven.candidates@plots$step1$p.venn
  feature(ven.candidates)
  feature(ven.candidates, "sets")
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
    # geo.GSE134347 <- job_geo("GSE134347")
    job_geo <- function (id) 
    {
        .job_geo(object = strx(id, "GSE[0-9]+"))
    }
    
    
    # geo.GSE134347 <- step1(geo.GSE134347)
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
    
    
    # clear(geo.GSE134347, lite = FALSE)
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
    
    
    # metadata.GSE134347 <- expect(geo.GSE134347, geo_cols())
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
    
    
    # lm.GSE134347 <- asjob_limma(geo.GSE134347, metadata.GSE134347)
    setMethod(f = "asjob_limma", signature = c(x = "job_geo"), definition = function (x, 
        ...) 
    {
        .local <- function (x, metadata, rna = NULL, use = 1L, normed = "guess", 
            use.col = NULL, use_as_id = TRUE, split = "\\s*///\\s*|,\\s*", 
            filter_split_symbol = c("---")) 
        {
            if (is.null(rna)) {
                rna <- x$rna
            }
            project <- object(x)
            if (rna) {
                counts <- as_tibble(data.frame(x@params$about[[use]]@assays@data$counts, 
                    check.names = FALSE))
                genes <- as_tibble(data.frame(x@params$about[[use]]@elementMetadata, 
                    check.names = FALSE))
                genes <- dplyr::mutate(genes, rownames = as.character(GeneID), 
                    .before = 1)
                if (missing(use.col)) {
                    use.col <- "Symbol"
                }
                else {
                    if (!is.character(genes[[use.col]])) {
                      stop("`use.col` should character (symbol).")
                    }
                }
            }
            else {
                counts <- as_tibble(x@params$about[[use]]@assayData$exprs)
                genes <- as_tibble(x@params$about[[use]]@featureData@data)
            }
            if (any(colnames(genes) == "gene_assignment")) {
                genes <- dplyr::mutate(genes, GENE_SYMBOL = strx(gene_assignment, 
                    "(?<=// )[^/ ]+(?= //)"), .before = 2)
                if (!is.null(filter_split_symbol)) {
                    isInvalid <- genes$GENE_SYMBOL %in% filter_split_symbol
                    if (any(isInvalid)) {
                      message(glue::glue("Filter symbol of {bind(filter_split_symbol)}: {sum(isInvalid)}"))
                      genes <- genes[!isInvalid, ]
                      counts <- counts[!isInvalid, ]
                    }
                }
            }
            else if (any(colnames(genes) == "SPOT_ID.1")) {
                genes <- dplyr::mutate(genes, GENE_SYMBOL = gs(SPOT_ID.1, 
                    "[^/]+// RefSeq // [^(]+\\(([^)]+)\\).*", "\\1"), 
                    .before = 2)
            }
            if (is.null(use.col)) {
                if (any(colnames(genes) == "rownames")) {
                    if (any(isThat <- grpl(colnames(genes), "Gene Symbol"))) {
                      oname <- colnames(genes)[isThat][1]
                    }
                    else {
                      oname <- .guess_symbol(colnames(genes))
                    }
                    message(glue::glue("Rename '{oname}' as: symbol:\n{showStrings(genes[[oname]])}"))
                    genes <- dplyr::relocate(genes, rownames, symbol = !!rlang::sym(oname))
                    use.col <- "symbol"
                }
                else {
                    guess <- grpf(colnames(genes), "^gene", ignore.case = TRUE)
                    if (length(guess)) {
                      message("All available:\n\t", paste0(guess, 
                        collapse = ", "))
                      message("Use the firist.")
                      guess <- guess[[1]]
                    }
                    else {
                      which <- menuThat(colnames(genes), "Use which as gene ID?")
                      guess <- colnames(genes)[which]
                    }
                    keep <- !is.na(genes[[guess]]) & genes[[guess]] != 
                      ""
                    genes <- dplyr::mutate(genes, rownames = !!rlang::sym(guess))
                    genes <- dplyr::relocate(genes, rownames)
                    message("Col.names of the data.frame:\n\t", stringr::str_trunc(paste0(colnames(counts), 
                      collapse = ", "), 40))
                    counts <- dplyr::mutate(counts, rownames = !!genes[[guess]])
                    counts <- dplyr::relocate(counts, rownames)
                    genes <- genes[keep, ]
                    counts <- counts[keep, ]
                    use.col <- guess
                }
            }
            else {
                genes <- dplyr::relocate(genes, rownames, symbol = !!rlang::sym(use.col))
            }
            message(glue::glue("Gene annotation:\n{showStrings(colnames(genes), trunc = FALSE)}"))
            if (!rna && identical(normed, "guess")) {
                message("Guess whether data has been normed.")
                if (all(range(counts[, -1], na.rm = TRUE) >= 0)) {
                    message("all(range(counts[, -1]) > 0), the data has not been normed.")
                    normed <- FALSE
                }
                else {
                    message("all(range(counts[, -1]) > 0) == FALSE, the data has been normed.")
                    normed <- TRUE
                }
            }
            else {
                normed <- FALSE
            }
            if (!is.null(x$ncbiNotGot)) {
                message(glue::glue("Filter out NCBI generated data (Missing samples): {bind(x$ncbiNotGot)}"))
                metadata <- dplyr::filter(metadata, !rownames %in% 
                    x$ncbiNotGot)
            }
            if (use_as_id) {
                message(crayon::red(glue::glue("Use `{use.col}` as ID columns.")))
                if (any(grpl(genes[[use.col]], split))) {
                    message(glue::glue("Detected that the ID column contains multiple ID names separated by: {split}"))
                    message("Use the first.")
                    genes[[".annotation_raw"]] <- genes[[use.col]]
                    genes[[use.col]] <- vapply(strsplit(genes[[use.col]], 
                      split), FUN.VALUE = character(1), function(x) x[1])
                }
                counts[[1]] <- genes[[use.col]]
                genes <- dplyr::relocate(genes, !!rlang::sym(use.col))
                keep <- !is.na(genes[[use.col]]) & genes[[use.col]] != 
                    ""
                genes <- genes[keep, ]
                counts <- counts[keep, ]
            }
            if (normed) {
                lst <- prepare_expr_data(metadata, counts, genes)
                counts <- dplyr::select(lst$counts, -1)
                counts <- data.frame(counts)
                rownames(counts) <- lst$genes$rownames
                x <- job_limma_normed(counts, lst$metadata)
                x$genes <- lst$genes
                x$rna <- rna
                x$project <- project
            }
            else {
                cli::cli_alert_info("Use function: `prepare_expr_data`")
                res <- try(job_limma(new_dge(metadata, counts, genes)))
                if (inherits(res, "try-error")) {
                    Terror <<- namel(metadata, counts, genes)
                    stop("Error. Check `Terror`.")
                }
                else {
                    res$rna <- rna
                    res$project <- project
                }
                x <- res
            }
            x <- methodAdd(x, "整理 GEO 数据集 ({project}) 以备 `limma` 差异分析 ({prepare_expr_data()})。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # lm.GSE134347 <- step1(lm.GSE134347)
    setMethod(f = "step1", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, group = .get_meta(x, "group"), batch = .get_meta(x, 
            "batch"), pairs = .get_meta(x, "pairs"), formula = .guess_formula(), 
            design = mx(as.formula(formula), data = tibble::tibble(group = group, 
                batch = batch, pairs = pairs)), min.count = 10, no.rna_filter = if (x$normed) 
                TRUE
            else FALSE, no.rna_norm = no.rna_filter, no.array_norm = "guess", 
            norm_vis = FALSE, pca = FALSE, data_type = c("count", 
                "cpm", "tpm"), dir_cache = .prefix("tcga_normalized", 
                "db")) 
        {
            saveAsCache <- FALSE
            if (grpl(x$project, "^tcga", TRUE)) {
                hash <- digest::digest(list(object(x), group, batch, 
                    pairs, formula, design, min.count, no.rna_norm, 
                    no.array_norm, no.rna_filter, norm_vis, data_type))
                dir.create(dir_cache, FALSE)
                file_cache <- add_filename_suffix(file.path(dir_cache, 
                    "tcga.rds"), hash)
                if (file.exists(file_cache)) {
                    message(glue::glue("Use file_cache: {file_cache}"))
                    sig <- x@sig
                    x <- readRDS(file_cache)
                    x@sig <- sig
                    return(x)
                }
                else {
                    saveAsCache <- TRUE
                }
            }
            step_message("Preprocess expression data.")
            if (!x$normed && x$rna) {
                x <- methodAdd(x, "以 R 包 `edgeR` ({packageVersion('edgeR')}) {cite_show('EdgerDifferenChen')} 对数据预处理。")
                x <- snapAdd(x, "以 `edgeR` 将{x$project} RNA-seq 数据标准化。")
            }
            message(glue::glue("Use formula: {formula}"))
            data_type <- match.arg(data_type)
            plots <- list()
            s.com <- try_snap(group)
            if (nchar(s.com) < 50) {
                x <- snapAdd(x, "样本分组：{s.com}。", FALSE)
            }
            if (x$rna || x$isTcga) {
                message("Data from RNA-seq.")
                if (!no.rna_filter && data_type == "count") {
                    object(x) <- filter_low.dge(object(x), group, 
                      min.count = min.count)
                    x <- methodAdd(x, "以 `edgeR::filterByExpr` 过滤 count 数量小于 {min.count} 的基因。", 
                      TRUE)
                    p.filter <- wrap(attr(object(x), "p"), 8, 3)
                    p.filter <- .set_lab(p.filter, sig(x), "Filter low counts")
                    plots <- c(plots, namel(p.filter))
                }
                else {
                    message("Skip from filtering.")
                }
                if (!no.rna_norm) {
                    object(x) <- norm_genes.dge(object(x), design, 
                      vis = norm_vis, data_type = data_type)
                    if (data_type == "count") {
                      x <- methodAdd(x, "以 `edgeR::calcNormFactors`，`limma::voom` 转化 {data_type} 数据为 log2 counts-per-million (logCPM)。")
                    }
                    else if (data_type == "tpm") {
                      x$tpm_use_trend <- TRUE
                    }
                    if (norm_vis && data_type == "count") {
                      if (length(x@object$targets$sample) < 50) {
                        p.norm <- wrap(attr(object(x), "p"), 6, max(c(length(x@object$targets$sample) * 
                          0.6, 10)))
                      }
                      else {
                        p.norm <- wrap(attr(object(x), "p"))
                      }
                      p.norm <- .set_lab(p.norm, sig(x), "Normalization")
                      x@params$p.norm_data <- p.norm@data$data
                    }
                    else {
                      p.norm <- NULL
                    }
                    plots <- c(plots, namel(p.norm))
                    x@params$normed_data <- object(x)
                }
                else {
                    if (x$rna && is(object(x), "df")) {
                      x$normed_data <- list(genes = if (is.null(x$genes)) data.frame(rownames = rownames(object(x))) else x$genes, 
                        targets = x$metadata, E = object(x))
                    }
                    else {
                      x$normed_data <- object(x)
                    }
                }
            }
            else {
                message("Data from Microarray.")
                if (!x$normed && no.array_norm == "guess") {
                    message("Guess whether data need normalization")
                    range <- range(object(x)$counts)
                    if (all(range > 0) && range[2] > 100) {
                      message("May be raw expression dataset.")
                      no.array_norm <- FALSE
                    }
                    else if (range[1] == 0 && range[2] > 100) {
                      message("Min expression equal to 0, add prior value: 1.")
                      object(x)$counts <- object(x)$counts + 1
                      no.array_norm <- FALSE
                    }
                    else {
                      no.array_norm <- TRUE
                    }
                }
                if (!x$normed && !no.array_norm) {
                    x <- methodAdd(x, "使用 `log2(x + 1)` 和 `limma::normalizeBetweenArrays` 对数据标准化。")
                    object(x)$counts <- e(limma::normalizeBetweenArrays(log2(object(x)$counts + 
                      1)))
                }
                if (x$normed) {
                    x$normed_data <- new_from_package("EList", "limma", 
                      list(genes = x$genes, targets = x$metadata, 
                        E = object(x)))
                }
                else {
                    x$normed_data <- new_from_package("EList", "limma", 
                      list(genes = object(x)$genes, targets = object(x)$samples, 
                        E = object(x)$counts))
                }
                validObject(x$normed_data)
            }
            if (pca) {
                pca <- pca_data.long(as_data_long(object(x)))
                p.pca <- plot_andata(pca)
                plots <- c(plots, namel(p.pca))
            }
            if (length(plots)) {
                x@plots[[1]] <- plots
            }
            if (!length(group)) {
                stop("!length(group), no any data?")
            }
            x@params$group <- group
            x@params$design <- design
            snap <- ""
            if (!is.null(batch)) {
                snap <- paste0("(Batch: ", try_snap(batch), ")")
            }
            x <- methodAdd(x, "以公式 {formula} 创建设计矩阵 (design matrix) {snap}。")
            x$.metadata <- .set_lab(x$.metadata, sig(x), "metadata of used sample")
            x$metadata <- .set_lab(x$metadata, sig(x), "metadata of used sample")
            if (saveAsCache) {
                saveRDS(x, file_cache)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # lm.GSE134347 <- step2(lm.GSE134347, sepsis - healthy, use = "P", 
    #     cut.fc = 0.5)
    setMethod(f = "step2", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., contrasts = NULL, block = NULL, 
            use = c("adj.P.Val", "P.Value"), use.cut = 0.05, cut.fc = 1, 
            label = .guess_symbol(x), batch = FALSE, HLs = NULL) 
        {
            step_message("Difference test.")
            use <- match.arg(use)
            if (is.null(contrasts)) {
                if (!...length()) {
                    contr <- NULL
                }
                else {
                    contr <- limma::makeContrasts(..., levels = x@params$design)
                }
            }
            else {
                contr <- limma::makeContrasts(contrasts = contrasts, 
                    levels = x@params$design)
            }
            s.contr <- bind(.fmt_contr_names(colnames(contr)))
            x <- methodAdd(x, "以 R 包 `limma` ⟦pkgInfo('limma')⟧ {cite_show('LimmaLinearMSmyth2005')} 差异分析。")
            if (x$rna) {
                x <- methodAdd(x, "分析方法参考 <https://bioconductor.org/packages/release/workflows/vignettes/RNAseq123/inst/doc/limmaWorkflow.html>。")
            }
            x <- methodAdd(x, "差异分析组别：{s.contr} (前者比后者，LogFC 大于 0 时，前者表达量高于后者)。")
            if (batch) {
                message("Note: `limma::removeBatchEffect` would convert the object class.")
                object(x) <- e(limma::removeBatchEffect(object(x), 
                    batch = object(x)$targets$batch, design = x@params$design, 
                    group = x$targets$group))
            }
            if (!is.null(x$tpm_use_trend) && x$tpm_use_trend) {
                message("As data_type == 'tpm', limma::eBayes will use params: trend = TRUE.")
                trend <- TRUE
            }
            else {
                trend <- FALSE
            }
            if (x$normed) {
                if (is(x$normed_data, "EList")) {
                    object(x) <- x$normed_data
                }
                else {
                    object(x) <- new_from_package("EList", "limma", 
                      x$normed_data)
                }
            }
            object(x) <- diff_test(object(x), x@params$design, contr, 
                block, trend = trend)
            x <- methodAdd(x, "使用 `limma::lmFit`, `limma::contrasts.fit`, `limma::eBayes` 拟合线形模型。")
            if (!is.null(contr)) {
                topsSig <- extract_tops(object(x), use = use, use.cut = use.cut, 
                    cut.fc = cut.fc)
                x <- methodAdd(x, "以 `limma::topTable` 提取所有结果，并过滤得到 ⟦mark$blue('{use} 小于 {use.cut}，|Log2(FC)| 大于 {cut.fc} 的差异基因')⟧。")
                names(topsSig) <- .fmt_contr_names(names(topsSig))
                topsSig <- lapply(topsSig, dplyr::relocate, !!rlang::sym(label), 
                    logFC, !!rlang::sym(use))
                topsSig <- lapply(topsSig, dplyr::arrange, dplyr::desc(abs(logFC)))
                res <- .collate_snap_and_features_by_logfc(topsSig, 
                    "logFC", get = label)
                x <- snapAdd(x, "显著基因统计：\n⟦mark$red('{res$snap}')⟧\n")
                topsSig <- set_lab_legend(topsSig, glue::glue("{x@sig} {names(topsSig)} limma DEGs data"), 
                    glue::glue("{names(topsSig)} 差异分析统计表格。"))
                feature(x) <- as_feature(res$sets, glue::glue("DEGs ({x$project}, {bind(names(res$sets))})"))
                x <- tablesAdd(x, tops = topsSig)
                if (length(topsSig) >= 2) {
                    lst <- lapply(topsSig, function(x) x[[label]])
                    p.contrast_cols <- new_col(lst = lst)
                    p.contrast_cols <- .set_lab(p.contrast_cols, 
                      sig(x), "All Difference Feature of contrasts")
                    x <- plotsAdd(x, p.contrast_cols)
                }
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # lm.GSE134347 <- step3(lm.GSE134347)
    setMethod(f = "step3", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, group = "group", top = 10) 
        {
            step_message("Draw plots.")
            use.fc <- "logFC"
            use <- match.arg(x$.args$step2$use[1], c("adj.P.Val", 
                "P.Value"))
            fc <- x$.args$step2$cut.fc
            cut.p <- x$.args$step2$use.cut
            data_expr <- x$normed_data$E
            metadata <- x$normed_data$targets
            top_tables <- lapply(x@tables$step2$tops, function(x) {
                attr(x, "all")
            })
            idcol <- x$.args$step2$label
            if (is.null(idcol)) {
                stop("is.null(idcol), can not get `label` from step2 args.")
            }
            x <- .plot_DEG_and_add_snap(x, data_expr, metadata, top_tables, 
                use = use, use.fc = use.fc, fc = fc, cut.p = cut.p, 
                top = top, group = group, features = feature(x), 
                idcol = idcol)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(lm.GSE134347)
    setMethod(f = "clear", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = substitute(x, parent.frame(1))) 
        {
            eval(name)
            callNextMethod(x, save = save, lite = lite, suffix = suffix, 
                name = name)
            object(x) <- NULL
            x@params$normed_data <- NULL
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ven.candidates <- job_venn(`DEGs (sepsis vs healthy)` = feature(lm.GSE134347), 
    #     `Acupuncture Target` = feature(swi.cpd, "target") + feature(sup.cpd, 
    #         "target"), mode = "candidates")
    job_venn <- function (..., mode = c("key", "candidates", "ck"), analysis = NULL, 
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
                if (missing(mode)) {
                    warning(crayon::red("`mode` is missing, use default: 'key'"))
                }
                mode <- match.arg(mode)
                mode <- switch(mode, key = "关键", candidates = "候选", 
                    ck = "候选关键")
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
    
    
    # ven.candidates <- step1(ven.candidates)
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
    
    
    # clear(ven.candidates)
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

