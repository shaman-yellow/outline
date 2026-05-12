# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "20_SCENIC")
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

srn.GSE150825 <- qs::qread("rds_jobSave/srn.GSE150825.6.qs", nthreads = 5)
requireNamespace("Seurat")
ssr.GSE150825 <- readRDS("./rds_jobSave/lite/ssr.GSE150825.3.rds")
srn.GSE150825 <- map(srn.GSE150825, ssr.GSE150825)

sce.GSE150825 <- asjob_scenic(srn.GSE150825)
sce.GSE150825 <- step1(sce.GSE150825, 32)
sce.GSE150825 <- step2(sce.GSE150825, 3)
sce.GSE150825 <- step3(sce.GSE150825)
clear(sce.GSE150825)

sce.GSE150825 <- map(
  sce.GSE150825, srn.GSE150825, "scissor_pos", "scissor_cell"
)
clear(sce.GSE150825)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  sce.GSE150825@params$map_seurat$p.hp_top
  notshow(sce.GSE150825@params$map_seurat$data)
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
    
    
    # sce.GSE150825 <- asjob_scenic(srn.GSE150825)
    setMethod(f = "asjob_scenic", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, sketch = TRUE, ncells = 10000, 
                filter = TRUE, org = c("human"), dir_db = pg("db_scenic"), 
                overwrite = FALSE) 
            {
                dir_cache <- create_job_cache_dir(x, "scene")
                args <- list(sketch = sketch, ncells = ncells, filter = filter, 
                    org = org)
                hash <- digest::digest(args, "xxhash64", serializeVersion = 3)
                file_expr <- file.path(dir_cache, glue::glue("expr_{hash}.loom"))
                methodAdd_onExit("x", "为在复杂细胞群体中识别关键转录因子及其调控网络，为后续功能解析提供依据，本研究采用 pySCENIC (0.12.1, PMID: 32561888) 进行转录调控分析。")
                methodAdd_onExit("x", "该方法以基因表达矩阵为输入，首先基于共表达关系（如 GRNBoost2）推断转录因子与靶基因之间的调控网络，其次结合 motif 注释对网络进行剪枝以保留高置信调控关系，最后通过 AUCell 在单细胞水平量化各调控模块（regulon）的活性，从而识别关键转录因子及其调控特征。")
                if (sketch) {
                    if (ncol(object(x)) > ncells * 1.5) {
                      ncells_pre <- ncol(object(x))
                      message(glue::glue("Use `Seurat::SketchData` to sampling cells."))
                      Seurat::DefaultAssay(object(x)) <- "RNA"
                      if (!length(Seurat::VariableFeatures(object(x)))) {
                        object(x) <- e(Seurat::NormalizeData(object(x)))
                        object(x) <- e(Seurat::FindVariableFeatures(object(x)))
                      }
                      object(x) <- e(Seurat::SketchData(object(x), 
                        ncells = ncells, seed = x$seed))
                      counts <- SeuratObject::GetAssayData(object(x), 
                        assay = "sketch", layer = "counts")
                      methodAdd_onExit("x", "在为 GRNBoost2 提供构建调控网络的表达数据之前，为保证计算效率的同时尽可能保留数据的整体结构信息，本研究采用了基于 “sketch” 的代表性抽样策略 (`Seurat::SketchData`，使用的算法为 LeverageScore)。⟦mark$blue('在抽样前，数据集包含 {ncells_pre} 个细胞，抽样后，子集包含 { ncells } 个细胞')⟧。")
                    }
                }
                else {
                    counts <- SeuratObject::GetAssayData(object(x), 
                      assay = "RNA", layer = "counts")
                }
                if (filter) {
                    ngenes_pre <- nrow(counts)
                    keep_genes <- Matrix::rowSums(counts > 0) > (0.01 * 
                      ncol(counts))
                    counts <- counts[keep_genes, ]
                    methodAdd_onExit("x", "对基因进行预过滤以降低数据稀疏性并减少计算负担，具体而言，⟦mark$blue('仅保留在至少 1% 细胞中被检测到（表达值大于 0）的基因。在过滤前，数据集包含 {ngenes_pre} 个基因，过滤后，数据集包含 {sum(keep_genes)} 个基因')⟧。")
                }
                fun_save <- function(data, file) {
                    if (file.exists(file) && overwrite) {
                      file.remove(file)
                    }
                    if (!file.exists(file)) {
                      loom <- SCopeLoomR::build_loom(file, data)
                      loom$close_all()
                    }
                }
                fun_save(counts, file_expr)
                used_genes <- rownames(counts)
                file_expr_all <- file_expr
                if (sketch) {
                    file_expr_all <- file.path(dir_cache, glue::glue("expr_all_{hash}.loom"))
                    counts_alls <- SeuratObject::GetAssayData(object(x), 
                      assay = "RNA", layer = "counts")
                    counts_alls <- counts_alls[rownames(counts_alls) %in% 
                      used_genes, ]
                    message(glue::glue("Set sketch. Save all cells for AUCells running."))
                    fun_save(counts_alls, file_expr_all)
                }
                pr <- params(x)
                x <- .job_scenic()
                x$used_genes <- used_genes
                x$dir_cache <- dir_cache
                x$hash <- hash
                x$file_expr <- file_expr
                x$file_expr_all <- file_expr_all
                x$sketch <- sketch
                x@params <- append(x@params, pr)
                if (org == "human") {
                    pattern <- "hg38"
                    pattern_mutate <- "hgnc"
                }
                x$org <- org
                if (!dir.exists(dir_db)) {
                    dir.create(dir_db, FALSE)
                }
                fun_get <- function(pattern, fun_download) {
                    fun_list <- function() list.files(dir_db, pattern, 
                      recursive = TRUE, full.names = TRUE)
                    files <- fun_list()
                    if (org == "human" && !length(files) && sureThat("No any {pattern} files, download it?")) {
                      fun_download()
                      files <- fun_list()
                    }
                    files
                }
                x$file_feathers <- fun_get(glue::glue("{pattern}.*\\.rankings.feather$"), 
                    .download_feather_files)
                x$file_motifs <- fun_get(glue::glue("{pattern_mutate}.*\\.tbl$"), 
                    .download_motif2tf_files)
                x$file_tf <- fun_get(glue::glue("{pattern}\\.txt$"), 
                    .download_tf_files)
                lapply(c("file_tf", "file_feathers", "file_motifs"), 
                    function(name) {
                      if (!length(x[[name]])) {
                        stop(glue::glue("Not found any file for {name}?"))
                      }
                    })
                return(x)
            }
            .local(x, ...)
        })
    
    
    # sce.GSE150825 <- step1(sce.GSE150825, 32)
    setMethod(f = "step1", signature = c(x = "job_scenic"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = 16) 
        {
            step_message("Run pyscenic grn")
            x$file_log <- "task.log"
            x$file_adj <- file.path(x$dir_cache, glue::glue("adj_{x$hash}.tsv"))
            cmd <- glue::glue("{pg('pyscenic')} grn {x$file_expr} {x$file_tf} -o {x$file_adj} --num_workers {workers} --seed {x$seed}")
            .expect_file_with_cmd_run(cmd, NULL, x$file_adj, x$file_log, 
                check = FALSE)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # sce.GSE150825 <- step2(sce.GSE150825, 3)
    setMethod(f = "step2", signature = c(x = "job_scenic"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = 3L) 
        {
            step_message("Run pyscenic ctx")
            x$file_reg <- file.path(x$dir_cache, glue::glue("reg_{x$hash}.tsv"))
            cmd <- .glue_cmd("{pg('pyscenic')} ctx {x$file_adj} {bind(x$file_feathers, co = ' ')} ", 
                "--annotations_fname {x$file_motifs} --expression_mtx_fname {x$file_expr} ", 
                "--output {x$file_reg} --mask_dropouts --num_workers {workers}")
            .expect_file_with_cmd_run(cmd, x$file_adj, x$file_reg, 
                x$file_log)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # sce.GSE150825 <- step3(sce.GSE150825)
    setMethod(f = "step3", signature = c(x = "job_scenic"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = 3L) 
        {
            step_message("Run pyscenic aucell")
            x$file_aucell <- file.path(x$dir_cache, glue::glue("aucell_{x$hash}.loom"))
            if (!is.null(x$sketch) && x$sketch) {
                x <- methodAdd(x, "在 GRNBoost2，cisTarget 的算法部分，使用了上述子集细胞进行运算。而在 AUCell 部分，我们将使用全部细胞来计算 AUCell 活性评分，从而得到所有细胞的 AUCell 活性。")
            }
            cmd <- .glue_cmd("{pg('pyscenic')} aucell {x$file_expr_all} {x$file_reg} ", 
                "--output {x$file_aucell} --num_workers {workers} --seed {x$seed} ")
            .expect_file_with_cmd_run(cmd, x$file_reg, x$file_aucell, 
                x$file_log)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(sce.GSE150825)
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
    
    
    # sce.GSE150825 <- map(sce.GSE150825, srn.GSE150825, "scissor_pos", 
    #     "scissor_cell")
    setMethod(f = "map", signature = c(x = "job_scenic", ref = "job_seurat"
    ), definition = function (x, ref, ...) 
    {
        .local <- function (x, ref, name = NULL, name.by = NULL, 
            ntop = 3, group.by = ref$group.by, .name = "seurat") 
        {
            step_message("Mapping results into seurat (heatmap)")
            init(snap(x)) <- TRUE
            init(meth(x)) <- TRUE
            name_save <- glue::glue("map_{.name}")
            lst_results <- list()
            if (!is.null(name)) {
                if (is.null(name.by)) {
                    stop("is.null(name.by), no default.")
                }
                message(glue::glue("Get sub-object of cells {bind(name)}, within: {name.by}"))
                ref <- getsub(ref, !!rlang::sym(name.by) %in% name)
                x <- snapAdd(x, "聚焦于 {bind(name)} 的 regulon 活性。", 
                    step = .name)
            }
            object <- .get_seurat_with_regulon(x, ref)
            SeuratObject::Idents(object) <- group.by
            object <- e(Seurat::ScaleData(object))
            p.hp <- e(Seurat::DoHeatmap(object, rownames(object), 
                group.by = x$group.by))
            data <- tibble::as_tibble(.get_ggplot_content(p.hp[[1]]))
            data <- dplyr::filter(data, !is.na(Expression))
            lst_results$data <- data
            data <- dplyr::mutate(data, Cell = paste0(Identity, "_", 
                Cell))
            args <- list(.data = data, .row = quote(Feature), .column = quote(Cell), 
                .value = quote(Expression), group_by = quote(Identity), 
                split_by = quote(Identity), cluster_columns = TRUE, 
                show_column_names = FALSE, cluster_rows = TRUE, show_row_names = FALSE, 
                palette_value = c("#053061FF", "White", "#67001FFF"))
            p.hp <- wrap_scale_heatmap(funPlot(heatmap_with_group, 
                args), data$Cell, data$Feature, pre_width = 3, w.size = 0.002, 
                h.size = 0.005, min_width = 12, min_height = 8)
            p.hp <- set_lab_legend(p.hp, glue::glue("{x@sig} AUCell all regulon heatmap"), 
                glue::glue("不同细胞亚群的所有 regulon 活性谱热图|||横坐标表示单细胞，按照细胞亚群进行排序；顶部颜色注释条表示对应的细胞分组（Identity）。纵坐标表示 regulon。颜色梯度表示 regulon 活性水平（Expression），其中暖色表示相对高活性，冷色表示相对低活性。"))
            lst_results$p.hp <- p.hp
            if (!is.null(ntop)) {
                features <- .get_representative_regulon(data, ntop)
                args$.data <- dplyr::filter(data, Feature %in% !!features)
                args$show_row_names <- TRUE
                p.hp_top <- wrap(funPlot(heatmap_with_group, args), 
                    12, 8)
                p.hp_top <- set_lab_legend(p.hp_top, glue::glue("{x@sig} AUCell top regulon heatmap"), 
                    glue::glue("不同细胞亚群的 Top regulon 活性谱热图|||横坐标表示单细胞，按照细胞亚群进行排序；顶部颜色注释条表示对应的细胞分组（Identity）。纵坐标表示筛选获得的代表性 regulon。颜色梯度表示 regulon 活性水平（Expression），其中暖色表示相对高活性，冷色表示相对低活性。"))
                lst_results$p.hp_top <- p.hp_top
                x <- snapAdd(x, "为解析不同细胞亚群间潜在转录调控网络的异质性，首先在各细胞群（Identity）内计算每个 regulon 的平均活性水平（Expression），以表征对应转录因子调控程序在该亚群中的整体活化状态。随后，分别筛选各细胞群中活性最高的前 {ntop} 个 regulon 与活性最低的前 {ntop} 个 regulon，前者代表该亚群特异性增强或持续激活的关键调控网络，后者则提示相对沉默或受抑制的调控程序。最终，将所有细胞亚群筛选得到的 regulon 合并并去重，形成具有生物学代表性的候选调控集合，用于热图展示及亚群功能状态比较{aref(p.hp_top)}，从而识别驱动细胞命运转变、功能分化及微环境适应的核心转录调控模式。", 
                    step = .name)
            }
            x[[name_save]] <- lst_results
            return(x)
        }
        .local(x, ref, ...)
    })
    
    
    # clear(sce.GSE150825)
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

