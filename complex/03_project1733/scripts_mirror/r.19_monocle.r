# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "19_monocle")
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

srn.GSE150825_sciPos_FibroClean <- readRDS("./rds_jobSave/srn.GSE150825_sciPos_FibroClean.6.rds")

mn.GSE150825_sciPos_FibroClean <- asjob_monocle2(
  srn.GSE150825_sciPos_FibroClean, NULL
)

mn.GSE150825_sciPos_FibroClean <- step1(mn.GSE150825_sciPos_FibroClean)
mn.GSE150825_sciPos_FibroClean <- step2(
  mn.GSE150825_sciPos_FibroClean, mode = "var"
)
mn.GSE150825_sciPos_FibroClean <- step3(
  mn.GSE150825_sciPos_FibroClean, extra = NULL
)

fea.markers <- load_feature()

mn.GSE150825_sciPos_FibroClean@step <- 3L
mn.GSE150825_sciPos_FibroClean <- step4(
  mn.GSE150825_sciPos_FibroClean, fea.markers,
  # recode = c("HIST1H1E" = "H1-4"),
  relative_expr = FALSE
)
mn.GSE150825_sciPos_FibroClean <- step5(mn.GSE150825_sciPos_FibroClean)
clear(mn.GSE150825_sciPos_FibroClean)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(mn.GSE150825_sciPos_FibroClean@plots$step3$p.traj, .7, .7)
  mn.GSE150825_sciPos_FibroClean@plots$step4$p.geneInPseudo$scsa_cell
  # des.validate_GSE189642@params$focusedDegs_learn$p.BoxPlotOfDEGs
  mn.GSE150825_sciPos_FibroClean@plots$step5$p.hp
  notshow(mn.GSE150825_sciPos_FibroClean@params$diff_test_pseudotime)
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
    # mn.GSE150825_sciPos_FibroClean <- asjob_monocle2(srn.GSE150825_sciPos_FibroClean, 
    #     NULL)
    setMethod(f = "asjob_monocle2", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, compare = .guess_levels_from_job_seurat(x), 
                compare.by = "group", group.by = x$group.by, nfeatures = 1000) 
            {
                if (!requireNamespace("monocle", quietly = TRUE)) {
                    stop("!requireNamespace(\"monocle\").")
                }
                metadata <- object(x)@meta.data
                if (SeuratObject::DefaultAssay(object(x)) == "SCT") {
                    message(glue::glue("Default Assay is SCT, to found variables, use data in assay 'RNA'"))
                    object <- object(x)
                    SeuratObject::DefaultAssay(object) <- "RNA"
                    object <- e(Seurat::NormalizeData(object))
                    object <- e(Seurat::FindVariableFeatures(object))
                    VariableFeatures <- e(Seurat::VariableFeatures(object))
                }
                else {
                    object(x) <- e(Seurat::FindVariableFeatures(object(x), 
                      nfeatures = nfeatures))
                    VariableFeatures <- e(Seurat::VariableFeatures(object(x)))
                }
                if (!length(VariableFeatures)) {
                    stop("!length(VariableFeatures).")
                }
                diff_genes <- NULL
                if (!is.null(compare)) {
                    if (length(compare) != 2) {
                      stop("length(compare) != 2.")
                    }
                    Seurat::Idents(object(x)) <- compare.by
                    diff_genes <- e(Seurat::FindMarkers(object(x), 
                      compare[1], compare[2]))
                    snap(diff_genes) <- glue::glue("使用 Seurat::FindMarkers 默认参数进行组间比较 {bind(compare, co = ' vs ')}")
                }
                cells <- unique(metadata[[group.by]])
                snapAdd_onExit("x", "将 {bind(cells)} 进行拟时间轴轨迹分析。")
                counts <- object(x)@assays$RNA$counts
                phenoData <- new("AnnotatedDataFrame", data = metadata)
                phenoData$Size_Factor <- rep(NA_real_, ncol(counts))
                featureData = new("AnnotatedDataFrame", data = data.frame(gene_short_name = row.names(counts), 
                    row.names = row.names(counts)))
                cli::cli_alert_info("new('CellDataSet', ...)")
                object <- new("CellDataSet", assayData = Biobase::assayDataNew("environment", 
                    exprs = counts), phenoData = phenoData, featureData = featureData, 
                    lowerDetectionLimit = 0.01, expressionFamily = VGAM::negbinomial.size(), 
                    dispFitInfo = new.env(hash = TRUE))
                validObject(object)
                x <- .job_monocle2(object = object)
                x$VariableFeatures <- VariableFeatures
                x$group.by <- group.by
                x$diff_genes <- diff_genes
                x <- methodAdd(x, "基于 **Monocle2** 的单细胞转录组拟时序分析，本研究旨在利用其核心的反转图嵌入（Reversed Graph Embedding）算法，构建细胞分化或发育过程的动态轨迹，以解析细胞在连续生物学过程中的状态转换与谱系分支决策。通过识别随拟时间变化的关键基因，揭示驱动细胞命运决定的潜在分子调控机制。")
                return(x)
            }
            .local(x, ...)
        })
    
    
    # mn.GSE150825_sciPos_FibroClean <- step1(mn.GSE150825_sciPos_FibroClean)
    setMethod(f = "step1", signature = c(x = "job_monocle2"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Detect features.")
            object(x) <- e(BiocGenerics::estimateSizeFactors(object(x)))
            object(x) <- e(BiocGenerics::estimateDispersions(object(x)))
            object(x) <- e(monocle::detectGenes(object(x), min_expr = 1))
            x <- methodAdd(x, "以 R 包 `monocle` ⟦pkgInfo('monocle')⟧ 对所选细胞进行细胞拟时序轨迹分析。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mn.GSE150825_sciPos_FibroClean <- step2(mn.GSE150825_sciPos_FibroClean, 
    #     mode = "var")
    setMethod(f = "step2", signature = c(x = "job_monocle2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, mode = c("diff", "var"), top = 300, 
            try_sig = TRUE, cut.fc = 0.5, use.p = c("p_val"), group = "group") 
        {
            step_message("DDRTree.")
            require(DDRTree)
            if (!missing(mode) && length(mode) > 1) {
                order.by <- mode
            }
            else {
                mode <- match.arg(mode)
                if (mode == "var") {
                    order.by <- x$VariableFeatures
                    x <- methodAdd(x, "以 `Seurat::FindVariableFeatures` 选取 {length(order.by)} 个高变基因，以这些高变基因使用 `monocle::setOrderingFilter` 对细胞轨迹排序。")
                }
                else {
                    message(glue::glue("Use Top {top} DEGs as ordering principle."))
                    if (!is.null(x$diff_genes)) {
                      data <- x$diff_genes
                      snap_ex <- ""
                      if (try_sig) {
                        dataSig <- dplyr::filter(data, abs(avg_log2FC) > 
                          0.5, !!rlang::sym(use.p) < 0.05)
                        if (nrow(dataSig) < top) {
                          top <- nrow(dataSig)
                          message(glue::glue("Too less significant genes ({top})..."))
                        }
                        snap_ex <- glue::glue("(⟦mark$blue('{detail(use.p)} &lt; 0.05, |avg_log2FC| &gt; cut.fc')⟧)")
                        data <- dataSig
                      }
                      order.by <- head(rownames(data), n = top)
                      if (any(!order.by %in% rownames(object(x)))) {
                        stop("any(!order.by %in% rownames(object(x))).")
                      }
                      x <- methodAdd(x, "参考已发表文献{cite_show('An_atlas_of_epi_Han_G_2024')}(PMID: 38418883)，根据差异表达基因排序选取 Top {top} ({snap(x$diff_genes)}){snap_ex}，进而以 `monocle::setOrderingFilter` 对细胞轨迹排序。")
                    }
                    else {
                      stop("!is.null(x$diff_genes).")
                    }
                }
            }
            object(x) <- e(monocle::setOrderingFilter(object(x), 
                ordering_genes = order.by))
            object(x) <- e(monocle::reduceDimension(object(x), reduction_method = "DDRTree"))
            object(x) <- e(monocle::orderCells(object(x)))
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mn.GSE150825_sciPos_FibroClean <- step3(mn.GSE150825_sciPos_FibroClean, 
    #     extra = NULL)
    setMethod(f = "step3", signature = c(x = "job_monocle2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, use = c("Pseudotime", "State", x$group.by), 
            extra = "group", root = NULL) 
        {
            step_message("Plot cell Trajectory")
            use <- c(use, extra)
            if (!is.character(use)) {
                stop("!is.character(use).")
            }
            if (!is.null(root)) {
                object(x) <- e(monocle::orderCells(object(x), root_state = root))
            }
            cli::cli_alert_info("monocle::plot_cell_trajectory")
            lst <- pbapply::pbsapply(use, simplify = FALSE, function(type) {
                p <- monocle::plot_cell_trajectory(object(x), color_by = type)
                if (type == x$group.by) {
                    p + guides(color = guide_legend(nrow = 2))
                }
                else p
            })
            message(glue::glue("Finished plot cell trajectory."))
            p.traj <- smart_wrap(lst, 5, max_ratio = 2)
            snaps <- c(Pseudotime = "细胞发育时间的细胞轨迹图，不同颜色代表分化的早晚；", 
                State = "细胞分化的各个发育状态的细胞轨迹图，不同颜色代表细胞处于不同发育状态；", 
                cell = "不同细胞类型的细胞轨迹图，不同颜色代表细胞属于不同细胞类型；", 
                group = "不同分组的细胞轨迹图，不同颜色代表细胞属于不同样本分组。")
            snaps <- snaps[seq_along(use)]
            snaps <- setNames(snaps, c("Pseudotime", "State", x$group.by, 
                extra))
            snaps <- bind(snaps[match(use, names(snaps))], co = "")
            p.traj <- set_lab_legend(p.traj, glue::glue("{x@sig} cell trajectories"), 
                glue::glue("细胞拟时轨迹图。|||横纵坐标分别为拟时序的两个纬度，图中每个圆点代表一个细胞，黑色的圆圈内的数字代表轨迹分析中确定不同细胞状态的节点。从左到右，从上到下，各子图分别为：{snaps}"))
            x$use <- use
            x <- plotsAdd(x, p.traj)
            x <- methodAdd(x, "使用 `monocle::plot_cell_trajectory` 函数绘制细胞的拟时轨迹图。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mn.GSE150825_sciPos_FibroClean <- step4(mn.GSE150825_sciPos_FibroClean, 
    #     fea.markers, relative_expr = FALSE)
    setMethod(f = "step4", signature = c(x = "job_monocle2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, use = x$use, recode = NULL, ...) 
        {
            step_message("Plot genes in pseudotime.")
            set.seed(x$seed)
            if (!is(ref, "feature")) {
                stop("!is(ref, \"feature\").")
            }
            regenes <- genes <- unique(resolve_feature(ref))
            if (!is.null(recode)) {
                regenes <- dplyr::recode(genes, !!!setNames(names(recode), 
                    unname(recode)))
                fun_recode <- function(data) {
                    dplyr::mutate(data, feature_label = dplyr::recode(feature_label, 
                      !!!recode))
                }
                fun_recode_layer <- function(layers) {
                    for (i in seq_along(layers)) {
                      data <- layers[[i]]$data
                      if (!is.null(data) && !is.null(data$feature_label)) {
                        layers[[i]]$data <- dplyr::mutate(layers[[i]]$data, 
                          feature_label = dplyr::recode(feature_label, 
                            !!!recode))
                      }
                    }
                    return(layers)
                }
            }
            if (length(regenes) > 10) {
                stop("length(regenes) > 10, too many input.")
            }
            if (any(notGot <- !regenes %in% rownames(object(x)))) {
                stop(glue::glue("Not got: {bind(regenes[notGot])}"))
            }
            object <- object(x)[regenes, ]
            cli::cli_alert_info("monocle::plot_genes_in_pseudotime")
            plot_pseudotime <- function(object, color_by, ...) {
                suppressMessages(require(monocle))
                monocle::plot_genes_in_pseudotime(object, color_by = color_by, 
                    ...)
            }
            p.geneInPseudo <- pbapply::pbsapply(use, function(type) {
                args <- list(object = object, color_by = type, ...)
                p <- callr::r(plot_pseudotime, args, libpath = .libPaths(), 
                    show = TRUE)
                if (!is.null(recode)) {
                    p <- .set_ggplot_content(p, fun_recode)
                    p <- .set_ggplot_content(p, fun_recode_layer, 
                      "layers")
                }
                wrap(p, 5, 1.5 * length(regenes))
            }, simplify = FALSE)
            p.geneInPseudo <- set_lab_legend(p.geneInPseudo, glue::glue("{x@sig} genes in trajectorie of {use}"), 
                glue::glue("基因在细胞轨迹图中的表达量变化|||横坐标为细胞的伪时间排序，纵轴表示基因的表达量，每一个点代表一个细胞，颜色代表图例所示的类型 ({use}) 。"))
            x <- plotsAdd(x, p.geneInPseudo)
            x <- methodAdd(x, "使用 `monocle::plot_genes_in_pseudotime` 绘制 {snap(ref)} 在关键细胞中的伪时序表达水平变化。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # mn.GSE150825_sciPos_FibroClean <- step5(mn.GSE150825_sciPos_FibroClean)
    setMethod(f = "step5", signature = c(x = "job_monocle2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, maxShow = 50, workers = 1, rerun = FALSE) 
        {
            step_message("differentialGeneTest (Pseudotime)")
            run_diff <- function(cds, cores) {
                require(monocle)
                require(VGAM)
                monocle::differentialGeneTest(cds = cds, cores = cores)
            }
            fun_cache <- function(...) {
                genes <- x$VariableFeatures
                callr::r(run_diff, list(cds = object(x)[genes, ], 
                    cores = workers), libpath = .libPaths(), show = FALSE)
            }
            args <- x$.args[names(x$.args) %in% paste0("step", 1:4)]
            diff_test_pseudotime <- expect_local_data("tmp", "monocle_diff", 
                fun_cache, list(args), rerun = rerun)
            x <- methodAdd(x, "以 `monocle::differentialGeneTest` 根据 Pseudotime 鉴定高变基因中 (n = {length(x$VariableFeatures)}) 随拟时间动态变化且相关的基因。")
            diff_test_pseudotime <- tibble::as_tibble(diff_test_pseudotime)
            x$diff_test_pseudotime <- diff_test_pseudotime <- dplyr::arrange(diff_test_pseudotime, 
                qval)
            data <- dplyr::filter(diff_test_pseudotime, qval < 0.05)
            genes <- head(data$gene_short_name, n = maxShow)
            fun_heatmap <- function(cds) {
                require(monocle)
                monocle::plot_pseudotime_heatmap(cds, num_clusters = 4, 
                    show_rownames = TRUE, return_heatmap = TRUE)
            }
            p.hp <- callr::r(fun_heatmap, list(cds = object(x)[genes, 
                ]), libpath = .libPaths(), show = TRUE)
            p.hp <- set_lab_legend(wrap(p.hp$gtable, 5, 8), glue::glue("{x@sig} pseudotime significant genes in heatmap"), 
                glue::glue("Monocle 拟时分析热图|||图中每一行代表一个基因，每一列代表一个拟时序点，颜色表示基因表达水平（例如从蓝色低表达到红色高表达），通过聚类将具有相似表达变化模式的基因归入同一个 Cluster。"))
            x <- snapAdd(x, "根据 Pseudotime 一共鉴定到 {nrow(data)} (⟦mark$blue('qval &lt; 0.05')⟧) 个随时间轴变化的基因，并以热图展示{aref(p.hp)} (Top {length(genes)})。")
            x <- plotsAdd(x, p.hp)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(mn.GSE150825_sciPos_FibroClean)
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

