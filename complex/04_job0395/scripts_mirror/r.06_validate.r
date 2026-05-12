# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "06_validate")
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

lm.GSE134347 <- readRDS("./rds_jobSave/lm.GSE134347.3.rds")
ven.learn <- readRDS("./rds_jobSave/ven.learn.1.rds")
lm.validate_train <- focus(
  lm.GSE134347, feature(ven.learn), 
  .name = "learn", run_roc = TRUE, test = "wilcox.test"
)
clear(lm.validate_train, FALSE, TRUE)

geo.GSE131761 <- job_geo("GSE131761")
geo.GSE131761 <- step1(geo.GSE131761)
clear(geo.GSE131761, TRUE, FALSE)

metadata.GSE131761 <- expect(
  geo.GSE131761, geo_cols(group = "diagnosis.ch1")
)
metadata.GSE131761 <- dplyr::filter(
  metadata.GSE131761, group != "non_septic_shock"
)
metadata.GSE131761 <- dplyr::mutate(
  metadata.GSE131761, group = ifelse(
    group == "septic_shock", "sepsis", "healthy"
  )
)

lm.validate_GSE131761 <- asjob_limma(geo.GSE131761, metadata.GSE131761)
lm.validate_GSE131761 <- step1(lm.validate_GSE131761)
lm.validate_GSE131761 <- focus(
  lm.validate_GSE131761, feature(ven.learn),
  .name = "learn", test = "wilcox.test",
  levels = c("sepsis", "healthy")
)
clear(lm.validate_GSE131761, FALSE, TRUE)

ven.key <- refine(lm.validate_train, lm.validate_GSE131761)
feature(ven.key)
clear(ven.key)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
lm.validate_train@params$focusedDegs_learn$p.BoxPlotOfDEGs
z7(lm.validate_train@params$focusedDegs_learn$p.rocs, 1, 1.3)
lm.validate_GSE131761@plots$step2$p.BoxPlotOfDEGs_learn
z7(lm.validate_GSE131761@params$focusedDegs_learn$p.rocs, 1, 1.3)
feature(ven.key)
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
    # lm.validate_train <- focus(lm.GSE134347, feature(ven.learn), 
    #     .name = "learn", run_roc = TRUE, test = "wilcox.test")
    setMethod(f = "focus", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, ref.use = .guess_symbol(x), which = NULL, 
            use = c("adj.P.Val", "P.Value"), .name = NULL, sig = FALSE, 
            test = "wilcox.test", data.which = if (!is.null(which)) 
                attr(x@tables$step2$tops[[which]], "all")
            else NULL, run_roc = TRUE, levels = .guess_compare_limma(x, 
                1L), ...) 
        {
            if (missing(levels)) {
                levels <- eval(levels)
            }
            use <- match.arg(use)
            if (is(ref, "feature")) {
                x <- snapAdd(x, "在 {x$project} 数据集中，聚焦于{snap(ref)}的差异表达。", 
                    add = FALSE, step = if (is.null(.name)) 
                      "m"
                    else .name)
                ref <- resolve_feature(ref)
            }
            else {
                x <- snapAdd(x, "在 {x$project} 数据集中，聚焦于{less(ref)}的差异表达。", 
                    add = FALSE, step = if (is.null(.name)) 
                      "m"
                    else .name)
            }
            if (identical(ref.use, "guess")) {
                ref.use <- .guess_symbol(x)
            }
            if (!is.null(data.which)) {
                data <- dplyr::filter(data.which, !!rlang::sym(ref.use) %in% 
                    ref)
                data <- dplyr::relocate(data, !!rlang::sym(ref.use), 
                    logFC, adj.P.Val, P.Value)
                if (sig) {
                    data <- dplyr::filter(data, !!rlang::sym(use) < 
                      0.05)
                    ref <- ref[ref %in% data[[ref.use]]]
                    if (!length(ref)) {
                      stop("!length(ref), no significant.")
                    }
                }
                data <- set_lab_legend(tibble::as_tibble(data), paste(sig(x), 
                    "Statistic of Focused genes", .name), "为聚焦分析的基因的统计附表。")
            }
            else {
                data <- NULL
            }
            x <- map(x, ref, ref.use, use = use, which = which, data.which = data.which, 
                name = .name, test = test, ...)
            if (!is.null(.name)) {
                lst <- namel(p.BoxPlotOfDEGs = x@plots$step2[[paste0("p.BoxPlotOfDEGs_", 
                    .name)]], data = data)
            }
            else {
                lst <- namel(p.BoxPlotOfDEGs = x@plots$step2$p.BoxPlotOfDEGs, 
                    data = data)
            }
            pvalue <- lst$p.BoxPlotOfDEGs$pvalue
            summary <- lapply(lst$p.BoxPlotOfDEGs$compare, stack)
            summary <- dplyr::bind_rows(summary, .id = "gene")
            summary <- dplyr::select(summary, gene, group = values, 
                trend = ind)
            summary <- dplyr::mutate(summary, group = factor(group, 
                levels = rev(levels)))
            snap <- glue::glue("{names(pvalue)} (P = {pvalue})")
            x <- snapAdd(x, "以 {detail(test)} 对 {bind(names(pvalue))} 统计检验组间差异 (阈值 P &lt; 0.05) 。", 
                step = .name)
            x <- snapAdd(x, .stat_compare_by_pvalue(lst$p.BoxPlotOfDEGs, 
                levels, ""), step = .name)
            if (run_roc) {
                elist <- x$normed_data
                lst$roc <- roc <- sapply(ref, simplify = FALSE, function(gene) {
                    .evaluate_by_ROC(elist$E, elist$targets, gene, 
                      control = levels[2], sig = sig(x))
                })
                allAuc <- lapply(roc, function(x) as.double(x$roc$auc))
                summary <- dplyr::mutate(summary, auc = dplyr::recode(gene, 
                    !!!allAuc))
                if (length(ref) > 1) {
                    lst$p.rocs <- plot_roc(lapply(roc, function(x) x$roc))
                    lst$p.rocs <- set_lab_legend(lst$p.rocs, glue::glue("{x@sig} ROC of genes {bind(ref, co = ' and ')}"), 
                      glue::glue("ROC 曲线|||{detail('note_roc')}"))
                }
                snaps <- bind(vapply(roc, function(x) x$snap[1], 
                    character(1)), co = "\n")
                x <- snapAdd(x, "\n{snaps}", step = .name)
            }
            lst$summary <- summary
            if (!is.null(.name)) {
                x[[paste0("focusedDegs_", .name)]] <- lst
            }
            else {
                x$focusedDegs <- lst
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(lm.validate_train, FALSE, TRUE)
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
    
    
    # geo.GSE131761 <- job_geo("GSE131761")
    job_geo <- function (id) 
    {
        .job_geo(object = strx(id, "GSE[0-9]+"))
    }
    
    
    # geo.GSE131761 <- step1(geo.GSE131761)
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
    
    
    # clear(geo.GSE131761, TRUE, FALSE)
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
    
    
    # metadata.GSE131761 <- expect(geo.GSE131761, geo_cols(group = "diagnosis.ch1"))
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
    
    
    # lm.validate_GSE131761 <- asjob_limma(geo.GSE131761, metadata.GSE131761)
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
    
    
    # lm.validate_GSE131761 <- step1(lm.validate_GSE131761)
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
    
    
    # lm.validate_GSE131761 <- focus(lm.validate_GSE131761, feature(ven.learn), 
    #     .name = "learn", test = "wilcox.test", levels = c("sepsis", 
    #         "healthy"))
    setMethod(f = "focus", signature = c(x = "job_limma"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, ref.use = .guess_symbol(x), which = NULL, 
            use = c("adj.P.Val", "P.Value"), .name = NULL, sig = FALSE, 
            test = "wilcox.test", data.which = if (!is.null(which)) 
                attr(x@tables$step2$tops[[which]], "all")
            else NULL, run_roc = TRUE, levels = .guess_compare_limma(x, 
                1L), ...) 
        {
            if (missing(levels)) {
                levels <- eval(levels)
            }
            use <- match.arg(use)
            if (is(ref, "feature")) {
                x <- snapAdd(x, "在 {x$project} 数据集中，聚焦于{snap(ref)}的差异表达。", 
                    add = FALSE, step = if (is.null(.name)) 
                      "m"
                    else .name)
                ref <- resolve_feature(ref)
            }
            else {
                x <- snapAdd(x, "在 {x$project} 数据集中，聚焦于{less(ref)}的差异表达。", 
                    add = FALSE, step = if (is.null(.name)) 
                      "m"
                    else .name)
            }
            if (identical(ref.use, "guess")) {
                ref.use <- .guess_symbol(x)
            }
            if (!is.null(data.which)) {
                data <- dplyr::filter(data.which, !!rlang::sym(ref.use) %in% 
                    ref)
                data <- dplyr::relocate(data, !!rlang::sym(ref.use), 
                    logFC, adj.P.Val, P.Value)
                if (sig) {
                    data <- dplyr::filter(data, !!rlang::sym(use) < 
                      0.05)
                    ref <- ref[ref %in% data[[ref.use]]]
                    if (!length(ref)) {
                      stop("!length(ref), no significant.")
                    }
                }
                data <- set_lab_legend(tibble::as_tibble(data), paste(sig(x), 
                    "Statistic of Focused genes", .name), "为聚焦分析的基因的统计附表。")
            }
            else {
                data <- NULL
            }
            x <- map(x, ref, ref.use, use = use, which = which, data.which = data.which, 
                name = .name, test = test, ...)
            if (!is.null(.name)) {
                lst <- namel(p.BoxPlotOfDEGs = x@plots$step2[[paste0("p.BoxPlotOfDEGs_", 
                    .name)]], data = data)
            }
            else {
                lst <- namel(p.BoxPlotOfDEGs = x@plots$step2$p.BoxPlotOfDEGs, 
                    data = data)
            }
            pvalue <- lst$p.BoxPlotOfDEGs$pvalue
            summary <- lapply(lst$p.BoxPlotOfDEGs$compare, stack)
            summary <- dplyr::bind_rows(summary, .id = "gene")
            summary <- dplyr::select(summary, gene, group = values, 
                trend = ind)
            summary <- dplyr::mutate(summary, group = factor(group, 
                levels = rev(levels)))
            snap <- glue::glue("{names(pvalue)} (P = {pvalue})")
            x <- snapAdd(x, "以 {detail(test)} 对 {bind(names(pvalue))} 统计检验组间差异 (阈值 P &lt; 0.05) 。", 
                step = .name)
            x <- snapAdd(x, .stat_compare_by_pvalue(lst$p.BoxPlotOfDEGs, 
                levels, ""), step = .name)
            if (run_roc) {
                elist <- x$normed_data
                lst$roc <- roc <- sapply(ref, simplify = FALSE, function(gene) {
                    .evaluate_by_ROC(elist$E, elist$targets, gene, 
                      control = levels[2], sig = sig(x))
                })
                allAuc <- lapply(roc, function(x) as.double(x$roc$auc))
                summary <- dplyr::mutate(summary, auc = dplyr::recode(gene, 
                    !!!allAuc))
                if (length(ref) > 1) {
                    lst$p.rocs <- plot_roc(lapply(roc, function(x) x$roc))
                    lst$p.rocs <- set_lab_legend(lst$p.rocs, glue::glue("{x@sig} ROC of genes {bind(ref, co = ' and ')}"), 
                      glue::glue("ROC 曲线|||{detail('note_roc')}"))
                }
                snaps <- bind(vapply(roc, function(x) x$snap[1], 
                    character(1)), co = "\n")
                x <- snapAdd(x, "\n{snaps}", step = .name)
            }
            lst$summary <- summary
            if (!is.null(.name)) {
                x[[paste0("focusedDegs_", .name)]] <- lst
            }
            else {
                x$focusedDegs <- lst
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(lm.validate_GSE131761, FALSE, TRUE)
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
    
    
    # ven.key <- refine(lm.validate_train, lm.validate_GSE131761)
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
    
    
    # feature(ven.key)
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
    
    
    # clear(ven.key)
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

