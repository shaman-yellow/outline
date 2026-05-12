# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "01_seurat")
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

geo.GSE150825 <- job_geo("GSE150825")
geo.GSE150825 <- step1(geo.GSE150825)
geo.GSE150825 <- step2(geo.GSE150825, ".", get_sup = TRUE)
clear(geo.GSE150825)

metadata.GSE150825 <- expect(geo.GSE150825, geo_cols())
metadata.GSE150825 <- dplyr::filter(
  metadata.GSE150825, grpl(title, "RNA-seq"),
  grpl(title, "^NPC")
)
metadata.GSE150825 <- dplyr::mutate(
  metadata.GSE150825, id = paste0(
    "NPC_", strx(title, "[0-9]+")
  )
)
metadata.GSE150825

if (FALSE) {
  fun_prepare <- function() {
    files <- list.files(
      geo.GSE150825$dir, "matrix|feature|barcodes", full.names = TRUE
    )
    dir <- file.path(dirname(files[1]), "NPC")
    dir.create(dir, FALSE)
    file.rename(files, s(files, "GSE[0-9]+_", "NPC/"))
    dir
  }
  dir_GSE150825 <- fun_prepare()
}

sr.GSE150825 <- job_seurat(dir_GSE150825, "GSE150825")
clear(sr.GSE150825)

sr.GSE150825 <- mutate(
  sr.GSE150825,
  id = paste0("NPC_", strx(colnames(object(sr.GSE150825)), "[0-9]+$"))
)
sr.GSE150825 <- getsub(sr.GSE150825, id %in% !!metadata.GSE150825$id)
sr.GSE150825 <- map(
  sr.GSE150825, metadata.GSE150825, "id", "id", "sample", "orig.ident"
)

srn.GSE150825 <- asjob_seurat5n(sr.GSE150825)
clear(srn.GSE150825)

srn.GSE150825 <- step1(srn.GSE150825, 200, 5000, 20000, 15)
clear(srn.GSE150825)

srn.GSE150825 <- step2(srn.GSE150825, sct = TRUE, workers = 5)
srn.GSE150825 <- step3(srn.GSE150825)
clear(srn.GSE150825)

srn.GSE150825 <- step4(srn.GSE150825)
srn.GSE150825 <- step5(srn.GSE150825, 5)
clear(srn.GSE150825)

npc_cell_markers <- list(

  B_Cell = list(
    markers = c("MS4A1", "CD79A", "CD79B", "CD19", "BANK1"),
    pmid = c("31477924", "33417831")
  ),

  Plasma_B_Cell = list(
    markers = c("SDC1", "MZB1", "XBP1", "PRDM1", "IGHG1"),
    pmid = c("31477924", "31209404")
  ),

  T_Cell = list(
    markers = c("CD3D", "CD3E", "CD3G", "CD2", "TRAC"),
    pmid = c("33417831", "31133762")
  ),

  NK_Cell = list(
    markers = c("NKG7", "GNLY", "KLRD1", "GZMB", "PRF1"),
    pmid = c("33417831", "32059779")
  ),

  Myeloid_Cell = list(
    markers = c("LYZ", "CD68", "CD14", "FCGR3A"),
    pmid = c("33417831", "31133762")
  ),

  Mast_Cell = list(
    markers = c("TPSAB1", "TPSB2", "CPA3", "KIT", "MS4A2", "HDC"),
    pmid = c("31133762", "32059779")
  ),

  Fibroblast = list(
    markers = c("COL1A1", "COL1A2", "DCN", "LUM", "FAP"),
    pmid = c("32059779", "29808064")
  ),

  Tumor_Associated = list(
    markers = c("MKI67", "TOP2A"),
    pmid = c("37880655", "34805184")
  ),

  Squamous_Epithelial_Basal = list(
      markers = c("KRT15", "S100A2", "PERP", "CLDN4"),
      pmid = c("28481227", "23217540")
  ),

  Ciliated_Epithelial = list(
    markers = c("TPPP3", "PIFO", "RSPH1", "DNAH5", "FOXJ1"),
    pmid = c("33279404")
  )

)

ref.markers <- show.markers <- as_markers(npc_cell_markers)

requireNamespace("Seurat")
srn.GSE150825@step <- 5L
srn.GSE150825 <- step6(
  srn.GSE150825, "", ref.markers, show.markers
)
clear(srn.GSE150825)

save_small.huibang("seurat")
# load("rdata_smallObject/seurat.rdata")


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srn.GSE150825@plots$step1$p.qc_pre
  srn.GSE150825@plots$step1$p.qc_aft
  srn.GSE150825@plots$step2$p.pca_rank
  z7(srn.GSE150825@plots$step3$p.umapUint, 1.5, 1)
  z7(srn.GSE150825@plots$step3$p.umapInt, 1.5, 1)
})

#| OVERTURE
output_with_counting_number({
  srn.GSE150825@plots$step3$p.umapLabel
  srn.GSE150825@plots$step6$p.markers_cluster
  srn.GSE150825@tables$step6$t.validMarkers
  srn.GSE150825@plots$step6$p.markers
  srn.GSE150825@plots$step6$p.map_scsa
  z7(srn.GSE150825@plots$step6$p.props_scsa, .8, 1)
  # z7(srn.GSE150825@plots$step6$p.props_scsa_group, 1, 5)
  # srn.GSE150825@plots$step6$p.props_scsa_stat
  notshow(srn.GSE150825@tables$step5$all_markers)
  notshow(srn.GSE150825@tables$step5$all_markers_no_filter)
  notshow(srn.GSE150825@tables$step6$scsa_res_all)
  notshow(srn.GSE150825@tables$step6$t.props_scsa)
  notshow(srn.GSE150825@params$final_metadata)
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
    # geo.GSE150825 <- job_geo("GSE150825")
    job_geo <- function (id) 
    {
        .job_geo(object = strx(id, "GSE[0-9]+"))
    }
    
    
    # geo.GSE150825 <- step1(geo.GSE150825)
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
    
    
    # geo.GSE150825 <- step2(geo.GSE150825, ".", get_sup = TRUE)
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
    
    
    # clear(geo.GSE150825)
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
    
    
    # metadata.GSE150825 <- expect(geo.GSE150825, geo_cols())
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
    
    
    # sr.GSE150825 <- job_seurat(dir_GSE150825, "GSE150825")
    job_seurat <- function (target = NULL, project = basename(sub("/$", "", target)), 
        is10x = TRUE, min.cells = 3, min.features = 200, file_h5 = NULL, 
        ...) 
    {
        if (!is.null(file_h5)) {
            data <- e(Seurat::Read10X_h5(file_h5))
        }
        else {
            if (is10x) {
                data <- e(Seurat::Read10X(target))
            }
            else {
                data <- Matrix::Matrix(as.matrix(read.table(target, 
                    header = TRUE, row.names = 1)), sparse = TRUE)
            }
        }
        object <- e(Seurat::CreateSeuratObject(counts = data, project = project, 
            min.cells = min.cells, min.features = min.features, ...))
        x <- .job_seurat(object = object)
        meth(x)$step0 <- glue::glue("")
        x
    }
    
    
    # clear(sr.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
    # sr.GSE150825 <- mutate(sr.GSE150825, id = paste0("NPC_", strx(colnames(object(sr.GSE150825)), 
    #     "[0-9]+$")))
    setMethod(f = "mutate", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        object(x)@meta.data <- dplyr::mutate(object(x)@meta.data, 
            ...)
        return(x)
    })
    
    
    # sr.GSE150825 <- getsub(sr.GSE150825, id %in% !!metadata.GSE150825$id)
    setMethod(f = "getsub", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., sample = 1L, group.by = x$group.by, 
            sample_group.by = c("orig.ident", group.by)) 
        {
            if (is.null(object(x))) {
                warning("object(x) == NULL, return original job.")
                return(x)
            }
            if (sample > 0L && sample < 1L) {
                message("Sampling the cells.")
                metadata <- object(x)@meta.data
                groups <- lapply(sample_group.by, function(group) {
                    metadata[[group]]
                })
                group.by <- do.call(paste, groups)
                ncells <- split(seq_len(nrow(metadata)), group.by)
                set.seed(x$seed)
                ncells <- unlist(lapply(ncells, function(ns) {
                    sample(ns, ceiling(length(ns) * sample))
                }))
                object(x) <- e(SeuratObject:::subset.Seurat(object(x), 
                    cells = ncells))
            }
            else {
                object(x) <- e(SeuratObject:::subset.Seurat(object(x), 
                    ...))
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # sr.GSE150825 <- map(sr.GSE150825, metadata.GSE150825, "id", "id", 
    #     "sample", "orig.ident")
    setMethod(f = "map", signature = c(x = "job_seurat", ref = "df"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, by.x = "orig.ident", by.ref = "sample", 
            get = "group", col = get) 
        {
            object(x)@meta.data[[col]] <- dplyr::recode(object(x)@meta.data[[by.x]], 
                !!!setNames(ref[[get]], ref[[by.ref]]))
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # srn.GSE150825 <- asjob_seurat5n(sr.GSE150825)
    setMethod(f = "asjob_seurat5n", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, split = "orig.ident", assay = "RNA") 
            {
                object(x)[[assay]] <- split(object(x)[[assay]], f = object(x)@meta.data[[split]])
                x <- .job_seurat5n(object = object(x))
                object(x)[["percent.mt"]] <- e(Seurat::PercentageFeatureSet(object(x), 
                    pattern = "^MT-"))
                SeuratObject::Idents(object(x)) <- split
                p.qc_pre <- plot_qc.seurat(x)
                x$p.qc_pre <- p.qc_pre
                x <- methodAdd(x, "以 R 包 `Seurat` ⟦pkgInfo('Seurat')⟧ 进行单细胞数据质量控制 (QC) 和下游分析。依据 <{x@info}> 为指导对单细胞数据预处理。")
                return(x)
            }
            .local(x, ...)
        })
    
    
    # clear(srn.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step1(srn.GSE150825, 200, 5000, 20000, 15)
    setMethod(f = "step1", signature = c(x = "job_seurat5n"), definition = function (x, 
        ...) 
    {
        .local <- function (x, min.features, max.features, max.count, 
            max.percent.mt = 5) 
        {
            step_message("Quality control (QC).")
            if (!is.null(min.features)) {
                ncell <- ncol(object(x))
                ngene <- nrow(object(x))
                object(x) <- e(SeuratObject:::subset.Seurat(object(x), 
                    subset = nFeature_RNA > min.features & nFeature_RNA < 
                      max.features & percent.mt < max.percent.mt & 
                      nCount_RNA < max.count))
                p.qc_aft <- plot_qc.seurat(x)
                x$p.qc_aft <- p.qc_aft <- set_lab_legend(p.qc_aft, 
                    glue::glue("{x@sig} After Quality control"), 
                    glue::glue("数据过滤后的 QC 图|||{.seurat_qc_note}"))
                p.qc_pre <- set_lab_legend(x$p.qc_pre, glue::glue("{x@sig} before Quality control"), 
                    glue::glue("质量控制 (QC) 图 (数据过滤前) |||{.seurat_qc_note}"))
                x <- plotsAdd(x, p.qc_pre = p.qc_pre, p.qc_aft = p.qc_aft)
                x <- methodAdd(x, "前期质量控制{aref(p.qc_pre)}，一个细胞至少应有 {min.features} 个基因，并且基因数量小于 {max.features}。线粒体基因的比例小于 {max.percent.mt}%。保留总基因表达量小于 {max.count} 细胞。过滤前，所有样本共包含 {ncell} 个细胞，{ngene} 个基因。过滤后{aref(p.qc_aft)}，⟦mark$red('所有样本共包含{ncol(object(x))}个细胞，{nrow(object(x))} 个基因用于后续分析。')⟧")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(srn.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step2(srn.GSE150825, sct = TRUE, workers = 5)
    setMethod(f = "step2", signature = c(x = "job_seurat5n"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ndims = 20, sct = FALSE, jk = FALSE, 
            workers = NULL) 
        {
            step_message("Run standard anlaysis workflow or `SCTransform`.")
            if (is.remote(x)) {
                if (is.null(workers)) {
                    stop("is.null(workers).")
                }
                x <- run_job_remote(x, wait = 1, {
                    x <- step2(x, ndims = "{ndims}", sct = "{sct}", 
                      workers = "{workers}")
                })
                return(x)
            }
            if (sct) {
                if (!is.null(workers)) {
                    old_plan <- future::plan()
                    future::plan(future::multicore, workers = workers)
                    on.exit(future::plan(old_plan))
                }
                object(x) <- e(Seurat::SCTransform(object(x), method = "glmGamPoi", 
                    vars.to.regress = "percent.mt", verbose = TRUE, 
                    assay = SeuratObject::DefaultAssay(object(x))))
                message(glue::glue("Shift assays to {SeuratObject::DefaultAssay(object(x))}"))
                x <- methodAdd(x, "使用 `Seurat::SCTransform` (默认参数) 对数据集归一化 (<https://satijalab.org/seurat/articles/sctransform_vignette>) 。")
            }
            else {
                object(x) <- e(Seurat::NormalizeData(object(x)))
                object(x) <- e(Seurat::FindVariableFeatures(object(x)))
                object(x) <- e(Seurat::ScaleData(object(x)))
                x <- methodAdd(x, "执行标准 Seurat 分析工作流 (`NormalizeData`, `FindVariableFeatures`, `ScaleData`)。")
                p.varfeature <- e(Seurat::VariableFeaturePlot(object(x)))
                p.varfeature <- set_lab_legend(wrap(p.varfeature), 
                    glue::glue("{x@sig} Variable Feature Plot"), 
                    glue::glue("高变基因图|||红色代表高变基因，横坐标为基因在所有细胞中的表达水平（log10对数值），纵坐标为基因在所有细胞中的表达水平的标准差，数值越大，表示该基因在细胞中的表达水平越不稳定。生物学差异（如细胞类型、状态等差异）通常会导致某些基因在不同细胞之间表现出较大变异，因此更有可能提供关于生物学现象的信息。"))
                x <- plotsAdd(x, p.varfeature)
            }
            object(x) <- e(Seurat::RunPCA(object(x)))
            x <- methodAdd(x, "随后 PCA 聚类 (`RunPCA`)。")
            if (jk && !sct) {
                object(x) <- e(Seurat::JackStraw(object(x), dims = ndims))
                object(x) <- e(Seurat::ScoreJackStraw(object(x)))
                p.jackPlot <- Seurat::JackStrawPlot(object(x))
                p.jackPlot <- set_lab_legend(wrap(p.jackPlot), glue::glue("{x@sig} Jack Straw plot"), 
                    glue::glue("Jackstraw 置换检验 |||通过对原始数据进行多次置换，构建一个零假设分布，然后将实际观测到的主成分得分与该零假设分布进行比较。每个点表示基因在某个主成分上的投影得分与随机背景的比较，大于或等于实际观测主成分得分的比例就是 p 值。p &lt; 0.05 通常认为在该显著性水平下，实际观测到的主成分得分显著高于随机情况下的得分，说明该主成分具有统计学意义，不是由随机因素导致的。通过量化主成分的显著性强度，与均匀分布（虚线）比较，判断哪些主成分更具有统计学意义，富含低p值基因较多的主成分更有统计学意义。"))
                x <- plotsAdd(x, p.jackPlot)
                x <- methodAdd(x, "通过 Jackstraw 函数置换检验重新聚类以检验 PC 的选择结果{aref(p.jackPlot)}（P &lt; 0.05）。")
            }
            p.pca_rank <- e(Seurat::ElbowPlot(object(x), ndims))
            p.pca_rank <- set_lab_legend(wrap(pretty_elbowplot(p.pca_rank), 
                4, 4), glue::glue("{x@sig} Standard deviations of PCs"), 
                glue::glue("主成分 (PC) 的标准化方差 (Standard deviations)|||横坐标为主成分数目，纵坐标代表基于每个主成分对方差解释率的排名（每个主成分的解释方差是其特征值（eigenvalue），表示它解释了总变异的比例），图中每个点表示一个主成分的方差解释比例。"))
            x <- methodAdd(x, "使用 ElbowPlot 函数绘制肘图{aref(p.pca_rank)}，帮助确定用于下游分析的主成分以进行后续分析。")
            x <- plotsAdd(x, p.pca_rank)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step3(srn.GSE150825)
    setMethod(f = "step3", signature = c(x = "job_seurat5n"), definition = function (x, 
        ...) 
    {
        .local <- function (x, dims = 1:15, resolution = 1.2, use = c("HarmonyIntegration", 
            "CCAIntegration", "RPCAIntegration"), ...) 
        {
            step_message("Identify clusters of cells")
            use <- match.arg(use)
            if (!is.null(x$JoinLayers) && x$JoinLayers) {
                message("Job is 'job_seurat5n', but 'JoinLayers' has been performed.")
                object(x) <- e(Seurat::FindNeighbors(object(x), dims = dims, 
                    reduction = use))
                object(x) <- e(Seurat::FindClusters(object(x), resolution = resolution, 
                    ...))
                object(x) <- e(Seurat::RunUMAP(object(x), dims = dims, 
                    reduction = use, ...))
            }
            else {
                if (is.null(x$.before_IntegrateLayers)) {
                    object(x) <- e(Seurat::FindNeighbors(object(x), 
                      dims = dims, reduction = "pca"))
                    object(x) <- e(Seurat::FindClusters(object(x), 
                      resolution = resolution, cluster.name = "unintegrated_clusters"))
                    object(x) <- e(Seurat::RunUMAP(object(x), dims = dims, 
                      reduction = "pca", reduction.name = "umap_unintegrated"))
                    x$.before_IntegrateLayers <- TRUE
                }
                p.umapUint <- e(Seurat::DimPlot(object(x), reduction = "umap_unintegrated", 
                    group.by = c("orig.ident", "seurat_clusters"), 
                    cols = color_set(TRUE)))
                p.umapUint <- set_lab_legend(wrap(p.umapUint, 10, 
                    5), glue::glue("{x@sig} UMAP Unintegrated"), 
                    glue::glue("去除批次效应之前的 UMAP 聚类图|||不同颜色代表不同cluster。横纵坐标是 UMAP 降维的两个维度。UMAP能够将高维空间中的数据映射到低维空间中，并保留数据集的局部特性。"))
                x <- plotsAdd(x, p.umapUint)
                methods <- list(CCAIntegration = Seurat::CCAIntegration, 
                    HarmonyIntegration = Seurat::HarmonyIntegration, 
                    RPCAIntegration = Seurat::RPCAIntegration)
                use <- match.arg(use, names(methods))
                object <- object(x)
                res <- try(e(Seurat::IntegrateLayers(object = object, 
                    method = methods[[use]], orig.reduction = "pca", 
                    new.reduction = use, verbose = FALSE, normalization.method = if (object@active.assay == 
                      "SCT") 
                      "SCT"
                    else "LogNormalize")))
                if (!inherits(res, "try-error")) {
                    object(x) <- res
                }
                else {
                    warning("Got error while perform `Seurat::IntegrateLayers`, return the job.")
                    return(x)
                }
                object(x)[["RNA"]] <- e(SeuratObject::JoinLayers(object(x)[["RNA"]]))
                object(x)@reductions$umap_unintegrated <- NULL
                x <- callNextMethod(x, dims, resolution, reduction = use, 
                    ...)
                x <- methodAdd(x, "结果显示{aref(x@plots$step2$p.pca_rank)}，前 {max(dims)} 个 PCs 以后方差增量减缓逐渐趋于稳定，选择前 {max(dims)} 个 PCs 进行后续聚类分析。", 
                    add = FALSE)
                x <- methodAdd(x, "以 `Seurat::IntegrateLayers` 集成数据，去除批次效应 (使用 {use} 方法)。")
            }
            p.umapInt <- e(Seurat::DimPlot(object(x), group.by = c("orig.ident", 
                "seurat_clusters"), cols = color_set(TRUE)))
            p.umapInt <- set_lab_legend(wrap(p.umapInt, 10, 5), glue::glue("{x@sig} UMAP Integrated"), 
                glue::glue("去除批次效应之后的 UMAP 聚类图|||不同颜色代表不同cluster。横纵坐标是 UMAP 降维的两个维度。UMAP能够将高维空间中的数据映射到低维空间中，并保留数据集的局部特性。"))
            p.umapLabel <- e(Seurat::DimPlot(object(x), group.by = c("seurat_clusters"), 
                cols = color_set(TRUE), label = TRUE))
            p.umapLabel <- set_lab_legend(p.umapLabel, glue::glue("{x@sig} UMAP with label"), 
                glue::glue("UMAP 聚类图|||UMAP 图中带有数字注释了细胞簇属于哪个聚类，有利于分辨。不同颜色代表不同cluster。横纵坐标是 UMAP 降维的两个维度。UMAP能够将高维空间中的数据映射到低维空间中，并保留数据集的局部特性。"))
            x <- plotsAdd(x, p.umapInt, p.umapLabel)
            x <- methodAdd(x, "在 1-{max(dims)} PC 维度下，以 `Seurat::FindNeighbors` 构建 Nearest-neighbor Graph。随后在 {resolution} 分辨率下，以 `Seurat::FindClusters` 函数识别细胞群并以 `Seurat::RunUMAP` 进行 UMAP 聚类。")
            nBefore <- length(levels(object(x)@meta.data$unintegrated_clusters))
            nAfter <- length(levels(object(x)@meta.data$seurat_clusters))
            x <- methodAdd(x, "在去除批次效应前，UMAP 图{aref(p.umapUint)}中各样本保持离散。`Seurat::FindClusters` 共找到 {nBefore} 个细胞簇。")
            x <- methodAdd(x, "去除批次效应后{aref(p.umapInt)}，`Seurat::FindClusters` 找到 {nAfter} 个细胞簇，且各样本相互均匀混合，即批次效应已被良好地处理。选择去除批次效应后的数据集进行后续分析。")
            x$JoinLayers <- TRUE
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(srn.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step4(srn.GSE150825)
    setMethod(f = "step4", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, use = "", use.level = c("label.main", 
            "label.fine")) 
        {
            if (use == "scAnno") {
                stop("Deprecated. Too many bugs in that package.")
            }
            else if (use == "SingleR") {
                step_message("Use `SingleR` and `celldex` to annotate cell types.\n        By default, red{{`celldex::HumanPrimaryCellAtlasData`}} was used\n        as red{{`ref`}} dataset. This annotation would generate red{{'SingleR_cell'}}\n        column in `object(x)@meta.data`. Plots were generated in `x@plots[[ 4 ]]`;\n        tables in `x@tables[[ 4 ]]`.\n        ")
                ref <- e(celldex::HumanPrimaryCellAtlasData())
                clusters <- object(x)@meta.data$seurat_clusters
                use.level <- match.arg(use.level)
                anno_SingleR <- e(SingleR::SingleR(object(x)@assays$SCT@scale.data, 
                    ref = ref, labels = ref[[use.level]], clusters = clusters))
                score <- as.matrix(anno_SingleR$scores)
                rownames(score) <- rownames(anno_SingleR)
                p.score_SingleR <- callheatmap(new_heatdata(as_data_long(score, 
                    row_var = "Cluster", col_var = "Cell_type")))
                p.score_SingleR <- wrap(p.score_SingleR, 30, 8)
                anno_SingleR <- tibble::tibble(seurat_clusters = rownames(anno_SingleR), 
                    SingleR_cell = anno_SingleR$labels)
                object(x)@meta.data$SingleR_cell <- anno_SingleR$SingleR_cell[match(clusters, 
                    anno_SingleR$seurat_clusters)]
                p.map_SingleR <- e(Seurat::DimPlot(object(x), reduction = "umap", 
                    label = FALSE, pt.size = 0.7, group.by = "SingleR_cell", 
                    cols = color_set()))
                p.map_SingleR <- p.map_SingleR
                p.map_SingleR <- wrap(p.map_SingleR, 10, 7)
                x <- tablesAdd(x, anno_SingleR)
                x <- plotsAdd(x, p.score_SingleR, p.map_SingleR)
                x@params$group.by <- "SingleR_cell"
                x <- methodAdd(x, "以 R 包 `SingleR` ({packageVersion('SingleR')}) 注释细胞群。")
            }
            else {
                message("Do nothing.")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step5(srn.GSE150825, 5)
    setMethod(f = "step5", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = NULL, min.pct = 0.25, logfc.threshold = 0.25, 
            force = FALSE, topn = 5, assay = object(x)@active.assay, 
            test.use = "wilcox", dir_cache = "tmp") 
        {
            step_message("Find all Marders for Cell Cluster.")
            cache_markers <- file.path(create_job_cache_dir(x, dir_cache), 
                "markers.tsv")
            if (!force && file.exists(cache_markers)) {
                markers <- read_tsv(cache_markers)
            }
            else {
                if (is.remote(x)) {
                    file_markers <- file.path(x$map_local, filename_markers <- "markers.csv")
                    if (!file.exists(file_markers) || force) {
                      if (!rem_file.exists(filename_markers) || force) {
                        if (is.null(workers)) {
                          stop("is.null(workers).")
                        }
                        file_obj <- file.path(x$map_local, filename_obj <- paste0("seurat_5.rds"))
                        if (!file.exists(file_obj) || force) {
                          message(glue::glue("Save Seurat object as {file_obj}..."))
                          saveRDS(object(x), file_obj)
                        }
                        if (!rem_file.exists(filename_obj) || force) {
                          cdRun(glue::glue("scp {file_obj} {x$remote}:{x$wd}"))
                        }
                        script <- expression({
                          require(Seurat)
                          require(future)
                          args <- commandArgs(trailingOnly = TRUE)
                          file_rds <- args[1]
                          output <- args[2]
                          workers <- as.integer(args[3])
                          min.pct <- as.double(args[4])
                          logfc.threshold <- as.double(args[5])
                          object <- readRDS(file_rds)
                          if (object@active.assay == "SCT") {
                            object <- Seurat::PrepSCTFindMarkers(object)
                          }
                          options(future.globals.maxSize = Inf)
                          future::plan(future::multicore, workers = workers)
                          Seurat::Idents(object(x)) <- "seurat_clusters"
                          markers <- Seurat::FindAllMarkers(object, 
                            min.pct = min.pct, logfc.threshold = logfc.threshold, 
                            group.by = "seurat_clusters", only.pos = TRUE, 
                            test.use = test.use)
                          write.table(markers, output, sep = ",", 
                            col.names = TRUE, row.names = FALSE, 
                            quote = FALSE)
                        })
                        script <- as.character(script)
                        if (force) {
                          message(glue::glue("force == TRUE, remove remote and local file."))
                          rem_file.remove(filename_markers)
                          file.remove(file_markers)
                        }
                        rem_run(glue::glue("{pg('Rscript', is.remote(x))} -e '{script}' \\\n                {filename_obj} {filename_markers} {workers} {min.pct} {logfc.threshold}"))
                        testRem_file.exists(x, filename_markers, 
                          1, later = FALSE)
                      }
                      file_markers <- get_file_from_remote(filename_markers, 
                        x$wd, file_markers, x$remote)
                    }
                    markers <- ftibble(file_markers)
                    markers <- dplyr::mutate(markers, rownames = gene, 
                      .before = 1)
                }
                else {
                    if (object(x)@active.assay == "SCT" && is.null(x$.PrepSCTFindMarkers)) {
                      cli::cli_alert_info("Seurat::PrepSCTFindMarkers")
                      object(x) <- Seurat::PrepSCTFindMarkers(object(x))
                      x$.PrepSCTFindMarkers <- TRUE
                    }
                    if (!is.null(workers)) {
                      options(future.globals.maxSize = Inf)
                      old_plan <- future::plan()
                      future::plan(future::multicore, workers = workers)
                      on.exit(future::plan(old_plan))
                    }
                    Seurat::Idents(object(x)) <- "seurat_clusters"
                    markers <- as_tibble(e(Seurat::FindAllMarkers(object(x), 
                      min.pct = min.pct, assay = assay, logfc.threshold = logfc.threshold, 
                      only.pos = TRUE, test.use = test.use, group.by = "seurat_clusters")))
                    if (!nrow(markers)) {
                      stop("!nrow(markers), no markers got.")
                    }
                }
                write_tsv(markers, cache_markers)
            }
            all_markers_no_filter <- markers
            markers <- dplyr::filter(markers, p_val_adj < 0.05)
            markers <- set_lab_legend(markers, glue::glue("{x@sig} significant markers of cell clusters"), 
                glue::glue("为所有细胞群的 Marker (LogFC 阈值 {logfc.threshold}; 最小检出率 {min.pct}; 检验方法为 {test.use})。"))
            if (FALSE) {
                tops <- dplyr::slice_max(dplyr::group_by(markers, 
                    cluster), avg_log2FC, n = topn)
                p.toph <- e(Seurat::DoHeatmap(object(x), features = tops$gene, 
                    raster = TRUE))
                p.toph <- wrap(p.toph, 14, 12)
                x <- plotsAdd(x, p.toph)
            }
            x <- tablesAdd(x, all_markers = markers, all_markers_no_filter = all_markers_no_filter)
            x <- methodAdd(x, "以 `Seurat::FindAllMarkers` (⟦mark$blue('LogFC 阈值 {logfc.threshold}; 最小检出率 {min.pct}; 检验方法为 {test.use}')⟧) 为所有细胞群寻找 Markers。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(srn.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE150825 <- step6(srn.GSE150825, "", ref.markers, show.markers)
    setMethod(f = "step6", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, tissue, ref.markers = NULL, show.markers = ref.markers, 
            method = c("cellMarker", "gpt", "scsa"), forceCluster = NULL, 
            org = c("Human", "Mouse"), filter.p = 0.01, filter.fc = 0.5, 
            res.col = "scsa_cell", type = c("Normal cell"), exclude = NULL, 
            include = NULL, show = NULL, notShow = NULL, renameCell = NULL, 
            keep_markers = 3, filter.pct = 0.25, toClipboard = TRUE, 
            post_modify = FALSE, n = 30, variable = FALSE, hp_type = c("pretty", 
                "seurat"), rerun = FALSE, ...) 
        {
            .check_is_scsa_available()
            if (!is.character(tissue)) {
                stop("!is.character(tissue).")
            }
            args <- c(as.list(environment()), list(...))
            args$init <- FALSE
            do.call(anno, args)
        }
        .local(x, ...)
    })
    
    
    # clear(srn.GSE150825)
    setMethod(f = "clear", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = rlang::expr_text(substitute(x, 
            parent.frame(1)))) 
        {
            name <- eval(name)
            x$final_metadata <- as_tibble(object(x)@meta.data, idcol = "cell")
            callNextMethod(x, ..., name = name)
        }
        .local(x, ...)
    })
    
    
}

