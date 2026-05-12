# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "04_hdWGCNA")
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

srn.GSE150825_sciPos_FibroClean <- readRDS(
  "./rds_jobSave/srn.GSE150825_sciPos_FibroClean.5.rds"
)

hdw.GSE150825_sciPos_FibroClean <- asjob_hdwgcna(srn.GSE150825_sciPos_FibroClean)

hdw.GSE150825_sciPos_FibroClean <- step1(hdw.GSE150825_sciPos_FibroClean, auto = FALSE)

hdw.GSE150825_sciPos_FibroClean <- step2(
  hdw.GSE150825_sciPos_FibroClean, NULL, .85
)
hdw.GSE150825_sciPos_FibroClean <- step3(hdw.GSE150825_sciPos_FibroClean, 50, .3)
hdw.GSE150825_sciPos_FibroClean <- step4(hdw.GSE150825_sciPos_FibroClean)
hdw.GSE150825_sciPos_FibroClean@step <- 4L
hdw.GSE150825_sciPos_FibroClean <- step5(
  hdw.GSE150825_sciPos_FibroClean, 100
)

clear(hdw.GSE150825_sciPos_FibroClean)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  hdw.GSE150825_sciPos_FibroClean@plots$step2$p.sft
  hdw.GSE150825_sciPos_FibroClean@plots$step3$p.dg
  hdw.GSE150825_sciPos_FibroClean@plots$step4$p.cor_hMEs
  hdw.GSE150825_sciPos_FibroClean@plots$step5$p.kme
  hdw.GSE150825_sciPos_FibroClean@plots$step5$p.umap_hMEs
  notshow(hdw.GSE150825_sciPos_FibroClean$modules)
  feature(hdw.GSE150825_sciPos_FibroClean, "kme")
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
    # hdw.GSE150825_sciPos_FibroClean <- asjob_hdwgcna(srn.GSE150825_sciPos_FibroClean)
    setMethod(f = "asjob_hdwgcna", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, workers = 5, assay = SeuratObject::DefaultAssay(object(x)), 
                name = "wgcna") 
            {
                object <- object(x)
                if (FALSE) {
                    object <- e(Seurat::DietSeurat(object, assays = assay, 
                      layers = c("counts", "data", "scale.data")))
                }
                e(WGCNA::enableWGCNAThreads(workers))
                object <- e(hdWGCNA::SetupForWGCNA(object, gene_select = "fraction", 
                    fraction = 0.05, wgcna_name = name))
                SeuratObject::DefaultAssay(object) <- assay
                pr <- params(x)
                x <- .job_hdwgcna(object = object)
                x <- methodAdd(x, "**hdWGCNA** 是一种针对单细胞或高维转录组数据构建加权基因共表达网络的分析方法，其主要目的是在复杂数据中识别具有协同表达特征的基因模块，并解析其与细胞类型、状态或表型之间的关联。")
                x <- methodAdd(x, "为了系统鉴定关键细胞功能异质性的核心共表达模块及靶点基因，以 R 包 `hdWGCNA` ⟦pkgInfo('hdWGCNA')⟧对 Seurat 处理过的单细胞数据集展开加权基因共表达网络分析。")
                x@params <- append(x@params, pr)
                return(x)
            }
            .local(x, ...)
        })
    
    
    # hdw.GSE150825_sciPos_FibroClean <- step1(hdw.GSE150825_sciPos_FibroClean, 
    #     auto = FALSE)
    setMethod(f = "step1", signature = c(x = "job_hdwgcna"), definition = function (x, 
        ...) 
    {
        .local <- function (x, min_cells = 100, k = 25, max_shared = 15, 
            reduction = NULL, group.by = x$group.by, auto = FALSE, 
            ..., debug = FALSE) 
        {
            step_message("Metacells.")
            if (is.null(reduction)) {
                reduction <- names(object(x)@reductions)
                reduction <- tail(reduction[reduction != "umap"], 
                    n = 1)
                message(glue::glue("Use reduction: {reduction}"))
            }
            if (auto) {
                params <- .auto_metacell_params(object(x), group.by, 
                    ...)
                k <- params$k
                max_shared <- params$max_shared
                min_cells <- params$min_cells
                x <- methodAdd(x, "{params$snap}")
            }
            else {
                x <- methodAdd(x, "使用 ConstructMetacells 函数，设置 k = {k}, 最少细胞数量为 {min_cells}，基于 K 近邻算法将相似的细胞聚合为元细胞（metacells）。")
            }
            if (!debug) {
                object(x) <- e(hdWGCNA::MetacellsByGroups(seurat_obj = object(x), 
                    group.by = group.by, ident.group = group.by, 
                    reduction = "HarmonyIntegration", k = k, min_cells = min_cells, 
                    max_shared = max_shared, verbose = TRUE))
                object(x) <- e(hdWGCNA::NormalizeMetacells(object(x)))
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # hdw.GSE150825_sciPos_FibroClean <- step2(hdw.GSE150825_sciPos_FibroClean, 
    #     NULL, 0.85)
    setMethod(f = "step2", signature = c(x = "job_hdwgcna"), definition = function (x, 
        ...) 
    {
        .local <- function (x, celltypes = NULL, cut.r = 0.8, group.by = x$group.by, 
            debug = FALSE) 
        {
            step_message("Soft power.")
            if (is.null(celltypes)) {
                celltypes <- unique(object(x)@meta.data[[x$group.by]])
            }
            x$celltypes <- celltypes
            ncells <- nrow(dplyr::filter(object(x)@meta.data, !!rlang::sym(x$group.by) %in% 
                celltypes))
            if (!debug) {
                object(x) <- e(hdWGCNA::SetDatExpr(object(x), group_name = celltypes, 
                    group.by = group.by, assay = SeuratObject::DefaultAssay(object(x))))
                object(x) <- e(hdWGCNA::TestSoftPowers(object(x), 
                    networkType = "signed"))
            }
            x <- methodAdd(x, "以 `SetDatExpr` 选择 {bind(celltypes)} 的表达矩阵为输入数据 (共包含 {ncells} 个细胞)。")
            x$power_table <- e(hdWGCNA::GetPowerTable(object(x)))
            x$use.power <- min(dplyr::filter(x$power_table, SFT.R.sq >= 
                !!cut.r & Power > 3)$Power)
            message(glue::glue("Select power to plot: {x$use.power}"))
            p.sft <- patchwork::wrap_plots(e(hdWGCNA::PlotSoftPowers(object(x), 
                x$use.power)), ncol = 2)
            p.sft <- set_lab_legend(wrap(p.sft, 7, 6), glue::glue("{x@sig} hdWGCNA soft power"), 
                glue::glue("hdWGCNA 软阈值（soft power）筛选诊断图|||四个子图分别展示对应阈值下的无标度拓扑拟合指数（Scale-free Topology Model Fit）、平均连接度（Mean Connectivity）、中位连接度（Median Connectivity）及最大连接度（Max Connectivity）。每个点代表一个候选阈值，其数值标注在点旁；虚线用于指示经验阈值或参考标准。该图通过同时考察网络的无标度特性与连接性变化，帮助理解不同软阈值对共表达网络结构的影响，从而为后续网络构建提供依据。"))
            x <- methodAdd(x, "通过 pickSoftThreshold 函数计算不同软阈值下的无尺度网络拟合指数 R² 和平均连接度，⟦mark$blue('选择使得 R² 首次达到 {cut.r} 以上的最小 β 值 (即 β = {x$use.power}) 作为软阈值')⟧，确保网络符合无尺度拓扑结构{aref(p.sft)}。")
            x <- plotsAdd(x, p.sft)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # hdw.GSE150825_sciPos_FibroClean <- step3(hdw.GSE150825_sciPos_FibroClean, 
    #     50, 0.3)
    setMethod(f = "step3", signature = c(x = "job_hdwgcna"), definition = function (x, 
        ...) 
    {
        .local <- function (x, min.gene = 50, cut.height = 0.2, debug = FALSE) 
        {
            step_message("Network")
            message(glue::glue("Use power: {x$use.power}"))
            x$dir_cache <- create_job_cache_dir(x)
            if (!debug) {
                object(x) <- e(hdWGCNA::ConstructNetwork(object(x), 
                    x$use.power, overwrite_tom = TRUE, tom_outdir = x$dir_cache, 
                    minModuleSize = min.gene, mergeCutHeight = cut.height, 
                    tom_name = bind(x$celltypes, co = "_")))
            }
            wgcna_name <- object(x)@misc$active_wgcna
            x$modules <- hdWGCNA::GetModules(object(x), wgcna_name)
            x$nm <- length(unique(dplyr::filter(x$modules, module != 
                "grey")$module))
            p.dg <- funPlot(WGCNA::plotDendroAndColors, list(dendro = hdWGCNA::GetNetworkData(object(x), 
                wgcna_name)$dendrograms[[1]], colors = as.character(x$modules$color), 
                groupLabels = "Module colors", dendroLabels = FALSE, 
                hang = 0.03, addGuide = TRUE, guideHang = 0.05))
            p.dg <- set_lab_legend(wrap(p.dg, 7, 4), glue::glue("{x@sig} Gene co expression network module"), 
                glue::glue("hdWGCNA 基因共表达网络模块|||上方为基于基因表达相似性进行层次聚类得到的树状结构（dendrogram），每个分支代表一组表达模式相近的基因；下方的彩色条带对应动态剪切（dynamic tree cut）后识别的不同共表达模块，不同颜色表示不同模块。"))
            x <- methodAdd(x, "使用 ConstructNetwork 函数，利用 TOM 矩阵进行层次聚类，采用动态树切割算法识别初始基因模块，设定最小模块基因数为 {min.gene} 以过滤过小模块，并通过合并模块特征基因（ME）相关性高于 {cut.height} 的高度相似模块，⟦mark$red('最终获得 {x$nm} 个稳定的基因模块')⟧{aref(p.dg)}。")
            x <- plotsAdd(x, p.dg)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # hdw.GSE150825_sciPos_FibroClean <- step4(hdw.GSE150825_sciPos_FibroClean)
    setMethod(f = "step4", signature = c(x = "job_hdwgcna"), definition = function (x, 
        ...) 
    {
        .local <- function (x, sample.by = "orig.ident", debug = FALSE) 
        {
            step_message("Module eigen")
            if (!debug) {
                object(x) <- e(Seurat::ScaleData(object(x), features = Seurat::VariableFeatures(object(x))))
                object(x) <- e(hdWGCNA::ModuleEigengenes(object(x), 
                    group.by.vars = sample.by))
            }
            x <- methodAdd(x, "以 ModuleEigengenes 函数计算模块特征基因 (Module Eigengenes，MEs，如经过批次矫正，则为 hMEs)。")
            x$hMEs <- hMEs <- e(hdWGCNA::GetMEs(object(x)))
            hMEs <- dplyr::select(hMEs, -grey)
            x$cor_hMEs <- cor_hMEs <- safe_fortify_cor(hMEs)
            snap_corhMEs <- .stat_ggcor_table_list(cor_hMEs, "MEs", 
                "MEs")
            p.cor_hMEs <- .ggcor_add_general_style(ggcor::quickcor(cor_hMEs))
            p.cor_hMEs <- set_lab_legend(wrap_scale_heatmap(p.cor_hMEs, 
                x$nm, x$nm, raw = FALSE), glue::glue("{x@sig} "), 
                glue::glue("模块间相关性热图|||热图中颜色表示相关系数的大小，颜色越深表示相关系数越高。P 值以 * 标注 ({.md_p_significant})。"))
            x <- plotsAdd(x, p.cor_hMEs)
            x <- snapAdd(x, "对 hMEs 之间关联分析，如图{aref(p.cor_hMEs)}，{snap_corhMEs}")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # hdw.GSE150825_sciPos_FibroClean <- step5(hdw.GSE150825_sciPos_FibroClean, 
    #     100)
    setMethod(f = "step5", signature = c(x = "job_hdwgcna"), definition = function (x, 
        ...) 
    {
        .local <- function (x, top = NULL, global = TRUE, debug = FALSE) 
        {
            step_message("Module membership.")
            if (!debug) {
                object(x) <- e(hdWGCNA::ModuleConnectivity(object(x), 
                    group.by = x$group.by, group_name = x$celltypes))
            }
            x <- methodAdd(x, "以 `ModuleConnectivity` 计算基因与模块特征基因 (hMEs) 之间的相关性 (即，WGCNA 中的 Module Membership) 得到 kME 值。")
            modules <- e(hdWGCNA::GetModules(object(x)))
            modules <- dplyr::filter(tibble::as_tibble(modules), 
                module != "grey")
            x$modules <- dplyr::mutate(modules, module = droplevels(module))
            x$name_modules <- levels(x$modules$module)
            layout <- wrap_layout(NULL, x$nm, 2)
            p.kme <- e(hdWGCNA::PlotKMEs(object(x), ncol = layout$ncol))
            p.kme <- set_lab_legend(add(layout, p.kme), glue::glue("{x@sig} module membership ranking"), 
                glue::glue("模块特征基因相关性（module membership）排序|||每个小图对应一个共表达模块，横轴为模块内基因，纵轴为对应基因的 kME 值，反映其与模块特征基因的相关程度；右侧标注为部分代表性高 kME 基因。"))
            if (!is.null(top)) {
                data_top <- hdWGCNA::GetHubGenes(object(x), top)
                data_top <- dplyr::mutate(data_top, module = droplevels(module))
                x$.feature_kme <- as_feature(split(data_top$gene_name, 
                    data_top$module), glue::glue("Top {top} kME"))
                x <- snapAdd(x, "根据 kME 值筛选出各模块前 {top} 个基因，作为关键模块基因。")
            }
            object <- object(x)
            object@meta.data <- cbind(object@meta.data, x$hMEs)
            snap_ex <- ""
            if (global) {
                p.umap_hMEs <- e(hdWGCNA::ModuleFeaturePlot(object, 
                    features = "hMEs", order = TRUE))
            }
            else {
                celltypes <- x$celltypes
                subObj <- SeuratObject:::subset.Seurat(object, !!rlang::sym(x$group.by) %in% 
                    !!celltypes)
                p.umap_hMEs <- e(Seurat::FeaturePlot(subObj, features = x$name_modules, 
                    combine = FALSE))
                snap_ex <- glue::glue("在 {celltypes} 中的")
            }
            p.umap_hMEs <- set_lab_legend(add(layout, p.umap_hMEs), 
                glue::glue("{x@sig} hMEs in UMAP"), glue::glue("模块特征基因（module eigengene）{snap_ex} UMAP 分布图|||每个点代表一个细胞，点颜色表示该模块的特征基因 (hMEs) 数值。"))
            p.dot_hMEs <- e(Seurat::DotPlot(object, features = x$name_modules, 
                group.by = x$group.by))
            p.dot_hMEs <- p.dot_hMEs + theme(axis.text.x = element_text(angle = 45, 
                hjust = 1)) + scale_color_gradient2(high = "red", 
                mid = "grey95", low = "blue")
            p.dot_hMEs <- set_lab_legend(wrap_scale(p.dot_hMEs, length(unique(object@meta.data[[x$group.by]])), 
                x$nm, pre_width = 4.5, pre_height = 3.5, w.size = 0.2), 
                glue::glue("{x@sig} dotplot of hMEs"), glue::glue("模块特征基因（hMEs）在不同细胞类型中表达水平与表达比例|||每个圆点代表一个模块在某一细胞类型中的表达情况，点的大小表示该模块在该细胞类型中表达的细胞百分比，点的颜色表示平均表达量（Average Expression）。"))
            x <- plotsAdd(x, p.kme, p.umap_hMEs, p.dot_hMEs)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(hdw.GSE150825_sciPos_FibroClean)
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

