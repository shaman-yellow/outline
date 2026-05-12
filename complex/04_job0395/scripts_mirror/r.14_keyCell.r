# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "14_keyCell")
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

srn.GSE167363 <- qs::qread("./rds_jobSave/srn.GSE167363.1.qs")
metaCells <- readRDS("./rds_jobSave/lite/srn.GSE167363.6.rds")

srn.GSE167363_T <- asjob_seurat_sub(
  srn.GSE167363, metaCells, "T_Cell"
)
clear(srn.GSE167363_T)
rm(srn.GSE167363)

srn.GSE167363_T <- step1(srn.GSE167363_T)
requireNamespace("Seurat")
srn.GSE167363_T <- step2(srn.GSE167363_T, sct = TRUE)
srn.GSE167363_T <- step3(srn.GSE167363_T, 1:15, 0.2)
clear(srn.GSE167363_T)

srn.GSE167363_T <- step4(srn.GSE167363_T)

srn.GSE167363_T <- step5(
  srn.GSE167363_T, 5, force = TRUE, min.pct = .1
)
clear(srn.GSE167363_T)

tcell_db <- list(

  Naive_CD4_T = list(
    markers = c(
      "IL7R",
      "LTB",
      "MALAT1",
      "LTB",
      "MALAT1",
      "CCR7",
      "LTB",
      "TCF7",
      "LEF1",
      "MALAT1"
    ),
    pmid = c(
      "31792411",
      "29476063"
    )
  ),

  Memory_CD4_T = list(
    markers = c(
      "IL7R",
      "LTB",
      "LTB",
      "MALAT1",
      "IL32",
      "LTB",
      "S100A4",
      "LTB",
      "TCF7"
    ),
    pmid = c(
      "31792411",
      "29476063"
    )
  ),

  Activated_CD4_T = list(
    markers = c(
      "IL32",
      "CD69",
      "TNFRSF4",
      "TNFRSF18",
      "ICOS",
      "HLA-DRA",
      "HLA-DRB1"
    ),
    pmid = c(
      "31792411",
      "29942093"
    )
  ),

  Cytotoxic_CD8_T = list(
    markers = c(
      "NKG7",
      "CST7",
      "PRF1",
      "GNLY",
      "GZMB",
      "CTSW",
      "KLRD1",
      "FGFBP2"
    ),
    pmid = c(
      "29476063",
      "31792411"
    )
  ),

  Effector_CD8_T = list(
    markers = c(
      "CCL5",
      "NKG7",
      "GZMK",
      "CXCR3",
      "IFNG",
      "CTSW",
      "CST7"
    ),
    pmid = c(
      "31792411",
      "29942093"
    )
  ),

  Exhausted_CD8_T = list(
    markers = c(
      "PDCD1",
      "LAG3",
      "HAVCR2",
      "CTLA4",
      "TIGIT",
      "TOX"
    ),
    pmid = c(
      "31792411",
      "29942093"
    )
  ),

  Regulatory_T = list(
    markers = c(
      "FOXP3",
      "IL2RA",
      "TIGIT",
      "CTLA4",
      "LTB",
      "ICOS"
    ),
    pmid = c(
      "29476063",
      "29942093"
    )
  ),

  IFN_Stimulated_T = list(
    markers = c(
      "IFIT1",
      "IFIT2",
      "IFIT3",
      "ISG15",
      "OAS1",
      "MX1",
      "HERC5"
    ),
    pmid = c(
      "31792411",
      "31110316"
    )
  ),

  Proliferating_T = list(
    markers = c(
      "MKI67",
      "TYMS",
      "PCLAF",
      "TOP2A",
      "TK1",
      "CDK1"
    ),
    pmid = c(
      "31792411",
      "29942093"
    )
  )

)

ref.markers <- as_markers(tcell_db)

requireNamespace("Seurat")
srn.GSE167363_T <- step6(
  srn.GSE167363_T, "", ref.markers, ref.markers, filter.fc = .3, 
  filter.p = .05, forceCluster = c(Other_Cell = 5L)
)
# scsa_check(srn.GSE167363_T, "", 0:6)
clear(srn.GSE167363_T)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srn.GSE167363_T@plots$step3$p.umapUint
  srn.GSE167363_T@plots$step3$p.umapInt
  srn.GSE167363_T@tables$step6$t.validMarkers
  srn.GSE167363_T@plots$step3$p.umapLabel
  z7(srn.GSE167363_T@plots$step6$p.markers_cluster, 1, 1.1)
  z7(srn.GSE167363_T@plots$step6$p.markers, 1, 1.4)
  wrap(srn.GSE167363_T@plots$step6$p.props_scsa, 7, 5)
  wrap(srn.GSE167363_T@plots$step6$p.props_scsa_stat, 5, 5)
  wrap(srn.GSE167363_T@plots$step6$p.map_scsa, 5, 3)
  notshow(srn.GSE167363_T@tables$step5$all_markers)
  notshow(srn.GSE167363_T@tables$step5$all_markers_no_filter)
  notshow(srn.GSE167363_T@tables$step6$scsa_res_all)
  notshow(srn.GSE167363_T@tables$step6$t.props_scsa)
  notshow(srn.GSE167363_T@params$final_metadata)
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
    # srn.GSE167363_T <- asjob_seurat_sub(srn.GSE167363, metaCells, 
    #     "T_Cell")
    setMethod(f = "asjob_seurat_sub", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, ref, group, group.by = "scsa_cell", 
                cellName = "cell", get_after = "seurat_clusters", 
                refine = NULL, cut.refine = 0) 
            {
                if (missing(ref)) {
                    ref <- as_tibble(object(x)@meta.data, idcol = cellName)
                }
                if (is(ref, "job_seurat")) {
                    if (is.null(object(ref))) {
                      message(glue::glue("is.null(object(ref)), try get metadata from `ref$final_metadata`"))
                      metadata <- ref$final_metadata
                    }
                    else {
                      metadata <- as_tibble(object(ref)@meta.data, 
                        idcol = cellName)
                    }
                }
                else {
                    metadata <- ref
                }
                if (!is(metadata, "data.frame")) {
                    stop("!is(metadata, \"data.frame\").")
                }
                if (x@step != 1) {
                    stop("x@step != 1.")
                }
                .check_columns(metadata, c(cellName, group.by), "metadata")
                if (!all(colnames(object(x)) %in% metadata[[cellName]])) {
                    stop("!all(colnames(object(x)) %in% metadata[[cellName]]).")
                }
                if (!any(metadata[[group.by]] %in% group)) {
                    stop("!any(metadata[[ group.by ]] %in% group).")
                }
                exclude <- NULL
                if (TRUE) {
                    metaEx <- dplyr::filter(metadata, !!rlang::sym(group.by) %in% 
                      !!group)
                    freq <- table(metaEx$orig.ident)
                    if (any(freq < 2)) {
                      exclude <- names(freq)[freq < 2]
                      methodAdd_onExit("x", " (去除了对应细胞 ({bind(group)}) 数量过少 (&lt; 2) 的样本，防止 Seurat 运行错误，这些样本为: {bind(exclude)}) ")
                      message(glue::glue("Pre exclude sample: {bind(exclude)}"))
                      message("Prevent only one target cell from remaining in the sample, causing dgcMatrix drop to become numeric and resulting in errors.")
                      metadata <- dplyr::filter(metadata, !orig.ident %in% 
                        exclude)
                      object(x) <- object(x)[, !object(x)@meta.data$orig.ident %in% 
                        exclude]
                    }
                }
                if (!is.null(get_after)) {
                    metadata <- dplyr::select(metadata, !!rlang::sym(cellName), 
                      !!rlang::sym(group.by), !!rlang::sym(get_after):last_col())
                }
                else {
                    metadata <- dplyr::select(metadata, !!rlang::sym(cellName), 
                      !!rlang::sym(group.by))
                }
                orderSub <- match(colnames(object(x)), metadata[[cellName]])
                object(x)@meta.data <- cbind(object(x)@meta.data, 
                    metadata[orderSub, !colnames(metadata) %in% colnames(object(x)@meta.data)])
                x <- getsub(x, !!rlang::sym(group.by) %in% !!group)
                methodAdd_onExit("x", "提取 {bind(group)} 对其二次降维聚类 (重新对其按照完整工作流整合不同样本) 以分析其亚群。")
                isDropped <- vapply(object(x)@assays$RNA@layers, 
                    FUN.VALUE = logical(1), function(x) {
                      is.numeric(x)
                    })
                if (any(isDropped)) {
                    sampleNames <- s(names(object(x)@assays$RNA@layers), 
                      "^counts\\.", "")
                    stop(glue::glue("Please remove the Dropped assay layers: {bind(sampleNames[isDropped])}"))
                }
                if (!is.null(refine)) {
                    if (!is(refine, "refine")) {
                      stop("!is(refine, \"refine\"), the refine is not valid?")
                    }
                    if (length(unlist(refine$cells)) != ncol(object(x))) {
                      stop("length(unlist(refine$cells)) != ncol(object(x)), not match cells number?")
                    }
                    message(glue::glue("Before refine cells, dim: {bind(dim(object(x)))}"))
                    ncell_pre <- ncol(object(x))
                    cells_keep <- unlist(dplyr::filter(tibble::as_tibble(refine), 
                      purity > cut.refine)$cells)
                    object(x) <- e(SeuratObject:::subset.Seurat(object(x), 
                      cells = cells_keep))
                    message(glue::glue("After refine cells, dim: {bind(dim(object(x)))}"))
                    ncell_aft <- ncol(object(x))
                    methodAdd_onExit("x", "{snap(refine)}在对细胞提纯之前，子集细胞总数量为 {ncell_pre}，在提纯之后，细胞总数量为 {ncell_aft}。")
                }
                validObject(object(x))
                x <- .job_seurat_sub(object = object(x))
                x$group.by <- group.by
                return(x)
            }
            .local(x, ...)
        })
    
    
    # clear(srn.GSE167363_T)
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
    
    
    # srn.GSE167363_T <- step1(srn.GSE167363_T)
    setMethod(f = "step1", signature = c(x = "job_seurat_sub"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Render as job_seurat5n.")
            x <- .job_seurat5n(x)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE167363_T <- step2(srn.GSE167363_T, sct = TRUE)
    setMethod(f = "step2", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, min.features, max.features, max.percent.mt = 5, 
            nfeatures = 2000, use = "nFeature_RNA", sct = FALSE, 
            ndims = 20) 
        {
            step_message("This contains several execution: Subset the data...\n      NOTE: inspect the plots and red{{Determined dims}} for downstream analysis. ")
            if (missing(min.features) | missing(max.features)) {
                stop("missing(min.features) | missing(max.features)")
            }
            object(x) <- e(SeuratObject:::subset.Seurat(object(x), 
                subset = !!rlang::sym(use) > min.features & !!rlang::sym(use) < 
                    max.features & percent.mt < max.percent.mt))
            x <- methodAdd(x, "一个细胞至少应有 {min.features} 个基因，并且基因数量小于 {max.features}。线粒体基因的比例小于 {max.percent.mt}%。根据上述条件，获得用于下游分析的高质量细胞 (低质量的细胞或空液滴通常含有很少的基因; 细胞双联体或多联体可能表现出异常高的基因计数; 低质量/死亡细胞通常表现出广泛的线粒体污染) (请参考 <https://satijalab.org/seurat/articles/pbmc3k_tutorial.html#qc-and-selecting-cells-for-further-analysis>)。")
            x <- snapAdd(x, "前期质量控制，一个细胞至少应有 {min.features} 个基因，并且基因数量小于 {max.features}。线粒体基因的比例小于 {max.percent.mt}%。过滤后，数据集共包含 {dim(x@object)[1]} 个基因，{dim(x@object)[2]} 个细胞。")
            p.qc_aft <- plot_qc.seurat(x)
            p.qc_aft <- .set_lab(p.qc_aft, sig(x), "After Quality control")
            p.qc_aft <- setLegend(p.qc_aft, "为数据过滤后的 QC 图。")
            x$p.qc_aft <- p.qc_aft
            if (sct) {
                object(x) <- e(Seurat::SCTransform(object(x), method = "glmGamPoi", 
                    vars.to.regress = "percent.mt", verbose = TRUE, 
                    assay = SeuratObject::DefaultAssay(object(x))))
            }
            else {
                object(x) <- e(Seurat::NormalizeData(object(x)))
                object(x) <- e(Seurat::FindVariableFeatures(object(x)))
                object(x) <- e(Seurat::ScaleData(object(x)))
            }
            object(x) <- e(Seurat::RunPCA(object(x), features = SeuratObject::VariableFeatures(object(x)), 
                reduction.name = "pca"))
            p.pca_rank <- e(Seurat::ElbowPlot(object(x), ndims))
            p.pca_rank <- set_lab_legend(wrap(pretty_elbowplot(p.pca_rank), 
                4, 4), glue::glue("{x@sig} Standard deviations of PCs"), 
                glue::glue("为主成分 (PC) 的 Standard deviations|||"))
            x <- plotsAdd(x, p.pca_rank)
            x <- methodAdd(x, "执行标准 Seurat 分析工作流 (`NormalizeData`, `FindVariableFeatures`, `ScaleData`, `RunPCA`)。以 `ElbowPlot` 判断后续分析的 PC 维度。")
            x <- snapAdd(x, "数据归一化，PCA 聚类 (Seurat 标准工作流)。")
            message("Dim: ", paste0(dim(object(x)), collapse = ", "))
            return(x)
        }
        .local(x, ...)
    })
    
    
    # srn.GSE167363_T <- step3(srn.GSE167363_T, 1:15, 0.2)
    setMethod(f = "step3", signature = c(x = "job_seurat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, dims = 1:15, resolution = 1.2, features = NULL, 
            reset = FALSE, reduction = if (is.null(features)) 
                "pca"
            else "features_pca", force = FALSE) 
        {
            step_message("This contains several execution: Cluster the cells, UMAP...")
            if (reset) {
                object(x) <- e(Seurat::FindVariableFeatures(object(x)))
                object(x) <- e(Seurat::ScaleData(object(x)))
                object(x) <- e(Seurat::RunPCA(object(x), features = SeuratObject::VariableFeatures(object(x)), 
                    reduction.name = "pca"))
            }
            if (!is.null(features)) {
                message(glue::glue("Run PCA in specified features."))
                object(x) <- e(Seurat::RunPCA(object(x), features = unique(features), 
                    reduction.name = reduction))
            }
            object(x) <- e(Seurat::FindNeighbors(object(x), dims = dims, 
                reduction = reduction))
            object(x) <- e(Seurat::FindClusters(object(x), resolution = resolution))
            object(x) <- e(Seurat::RunUMAP(object(x), dims = dims, 
                reduction = reduction))
            p.umap <- e(Seurat::DimPlot(object(x), cols = color_set(TRUE)))
            p.umap <- set_lab_legend(wrap(p.umap, 6, 5), glue::glue("{x@sig} UMAP Clustering"), 
                glue::glue("UMAP 聚类图|||不同颜色代表不同cluster。横纵坐标是 UMAP 降维的两个维度。UMAP能够将高维空间中的数据映射到低维空间中，并保留数据集的局部特性。"))
            x <- plotsAdd(x, p.umap)
            x <- methodAdd(x, "在 1-{max(dims)} PC 维度下，以 Seurat::FindNeighbors 构建 Nearest-neighbor Graph。随后在 {resolution} 分辨率下，以 Seurat::FindClusters 函数识别细胞群并以 Seurat::RunUMAP 进行 UMAP 聚类。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(srn.GSE167363_T)
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
    
    
    # srn.GSE167363_T <- step4(srn.GSE167363_T)
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
    
    
    # srn.GSE167363_T <- step5(srn.GSE167363_T, 5, force = TRUE, min.pct = 0.1)
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
    
    
    # clear(srn.GSE167363_T)
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
    
    
    # ref.markers <- as_markers(tcell_db)
    as_markers <- function (cell_markers, snap = NULL, df = NULL, ref = "pmid") 
    {
        if (!is.null(df)) {
            colnames(df) <- c("cell", "markers")
            cell_markers <- df
        }
        else {
            type <- vapply(cell_markers, class, character(1))
            if (all(type == "character")) {
                cell_markers <- as_df.lst(cell_markers, "cell", "markers")
            }
            else if (all(type == "list")) {
                lst <- lapply(cell_markers, function(x) {
                    setNames(tibble::tibble(markers = x[["markers"]], 
                      ref = bind(x[[ref]])), c("markers", ref))
                })
                cell_markers <- dplyr::bind_rows(lst, .id = "cell")
                refs <- bind(unique(unlist(strsplit(cell_markers[[ref]], 
                    ", "))))
                snap(cell_markers) <- glue::glue("{toupper(ref)}: {refs}")
            }
        }
        if (!is.null(snap)) {
            snap(cell_markers) <- snap
        }
        cell_markers
    }
    
    
    # srn.GSE167363_T <- step6(srn.GSE167363_T, "", ref.markers, ref.markers, 
    #     filter.fc = 0.3, filter.p = 0.05, forceCluster = c(Other_Cell = 5L))
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
    
    
    # clear(srn.GSE167363_T)
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

