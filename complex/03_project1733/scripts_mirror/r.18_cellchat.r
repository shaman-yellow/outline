# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "18_cellchat")
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

srn.GSE150825 <- qs::qread("./rds_jobSave/srn.GSE150825.6.qs")
ssr.GSE150825 <- readRDS("./rds_jobSave/lite/ssr.GSE150825.3.rds")
srn.GSE150825 <- map(srn.GSE150825, ssr.GSE150825)

cc.GSE150825_scissor_neg <- asjob_cellchat(
  getsub(srn.GSE150825, scissor_cell == "scissor_neg")
)
cc.GSE150825_scissor_neg <- step1(cc.GSE150825_scissor_neg)
cc.GSE150825_scissor_neg <- step2(cc.GSE150825_scissor_neg)
clear(cc.GSE150825_scissor_neg)

cc.GSE150825_scissor_pos <- asjob_cellchat(
  getsub(srn.GSE150825, scissor_cell == "scissor_pos")
)
cc.GSE150825_scissor_pos <- step1(cc.GSE150825_scissor_pos)
cc.GSE150825_scissor_pos <- step2(cc.GSE150825_scissor_pos)
clear(cc.GSE150825_scissor_pos)

cc.comparison <- asjob_cellchatn(
  list(scissor_neg = cc.GSE150825_scissor_neg, scissor_pos = cc.GSE150825_scissor_pos)
)
cc.comparison <- step1(cc.comparison)
cc.comparison <- step2(
  cc.comparison, as_feature("Fibroblast", "关键细胞", nature = "cell")
)
clear(cc.comparison)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  cc.comparison@plots$step1$p.inters_counts
  cc.comparison@plots$step1$p.inters_weights
  cc.comparison@plots$step2$p.allCells_LP_comm_each_group$scissor_neg
  cc.comparison@plots$step2$p.allCells_LP_comm_each_group$scissor_pos
  cc.comparison@plots$step2$p.keyCellAsSource
  cc.comparison@plots$step2$p.keyCellAsTarget
  notshow(cc.GSE150825_scissor_neg@tables$step1$lp_net)
  notshow(cc.GSE150825_scissor_neg@tables$step1$pathway_net)
  notshow(cc.GSE150825_scissor_neg@tables$step2$t.lr_comm_bubble)
  notshow(cc.GSE150825_scissor_pos@tables$step1$lp_net)
  notshow(cc.GSE150825_scissor_pos@tables$step1$pathway_net)
  notshow(cc.GSE150825_scissor_pos@tables$step2$t.lr_comm_bubble)
  notshow(cc.comparison@params$keyCell_data$data.keyCellAsSource)
  notshow(cc.comparison@params$keyCell_data$data.keyCellAsTarget)
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
    
    
    # cc.GSE150825_scissor_neg <- asjob_cellchat(getsub(srn.GSE150825, 
    #     scissor_cell == "scissor_neg"))
    setMethod(f = "asjob_cellchat", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, group.by = x$group.by, assay = SeuratObject::DefaultAssay(object(x)), 
                sample = 0.5, force = TRUE, ...) 
            {
                step_message("Prarameter red{{`group.by`}}, red{{`assay`}}, \n      and red{{`...`}} would passed to `CellChat::createCellChat`.", 
                    show_end = NULL)
                if (x@step < 2) {
                    stop("x@step < 2. At least, preprocessed assay data should be ready.")
                }
                if (!force && (!missing(sample) || ncol(object(x)) > 
                    50000)) {
                    message(glue::glue("Too many cells, sampling for analysis."))
                    x <- asjob_seurat_sub(x, sample = sample)
                }
                if (is.null(group.by)) 
                    stop("is.null(group.by) == TRUE")
                if (is.character(object(x)@meta.data[[group.by]])) {
                    object(x)@meta.data[[group.by]] %<>% as.factor()
                }
                else {
                    object(x)@meta.data[[group.by]] %<>% droplevels()
                }
                object <- e(CellChat::createCellChat(object = object(x), 
                    group.by = group.by, assay = assay, ...))
                x <- snapAdd(.job_cellchat(object = object, params = list(group.by = group.by)), 
                    x)
                x <- methodAdd(x, "细胞通讯分析可以帮助了解细胞与细胞之间的互作关系，细胞发出信号信息通过介质（即配体）传递到另一个靶细胞并与其相应的受体相互作用，然后通过细胞信号转导产生靶细胞内一系列生理生化变化，揭示发育过程中各类细胞的相互作用。")
                x <- methodAdd(x, "以 `CellChat` R 包 ⟦pkgInfo('CellChat')⟧ {cite_show('InferenceAndAJinS2021')} 对单细胞数据进行细胞通讯分析。以 `CellChat::createCellChat` 将 `Seurat` 对象的 {assay} Assay 转化为 CellChat 对象。")
                return(x)
            }
            .local(x, ...)
        })
    
    
    # cc.GSE150825_scissor_neg <- step1(cc.GSE150825_scissor_neg)
    setMethod(f = "step1", signature = c(x = "job_cellchat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = 4, python = pg("cellchat_python"), 
            py_config = FALSE, debug = FALSE, org = c("human", "mouse"), 
            smooth = FALSE, ...) 
        {
            step_message("One step forward computation of most. ")
            org <- match.arg(org)
            if (is.remote(x)) {
                x <- run_job_remote(x, wait = 3, ..., debug = debug, 
                    {
                      options(future.globals.maxSize = 5e+10)
                      x <- step1(x, workers = "{workers}", org = "{org}", 
                        debug = "{debug}", python = "{python}", py_config = "{py_config}")
                    })
                x@plots$step1$p.commHpAll@data <- e(CellChat::netVisual_heatmap(object(x), 
                    color.heatmap = "Reds", signaling = NULL))
                return(x)
            }
            if (org == "human") {
                db <- CellChat::CellChatDB.human
                ppi <- CellChat::PPI.human
            }
            else if (org == "mouse") {
                db <- CellChat::CellChatDB.mouse
                ppi <- CellChat::PPI.mouse
            }
            if (!is.null(python)) {
                e(base::Sys.setenv(RETICULATE_PYTHON = python))
                e(reticulate::use_python(python))
                e(reticulate::py_config())
            }
            else if (py_config) {
                e(reticulate::py_config())
            }
            if (!reticulate::py_module_available(module = "umap")) {
                stop("!reticulate::py_module_available(module = \"umap\").")
            }
            x <- methodAdd(x, "参照工作流 <https://htmlpreview.github.io/?https://github.com/jinworks/CellChat/blob/master/tutorial/CellChat-vignette.html> 对单细胞数据集进行分析。")
            if (!debug) {
                p.showdb <- e(CellChat::showDatabaseCategory(db))
                p.showdb <- wrap(p.showdb, 8, 4)
                object(x)@DB <- db
                future::plan("multisession", workers = workers)
                object(x) <- e(CellChat::subsetData(object(x)))
                object(x) <- e(CellChat::identifyOverExpressedGenes(object(x)))
                object(x) <- e(CellChat::identifyOverExpressedInteractions(object(x)))
                x <- methodAdd(x, "以 CellChat::identifyOverExpressedGenes、CellChat::identifyOverExpressedInteractions，寻找高表达的信号基因之间的相互通讯。")
                if (smooth && !is.null(ppi)) {
                    if (exists("smoothData", envir = asNamespace("CellChat"))) {
                      object(x) <- e(CellChat::smoothData(object(x), 
                        adj = ppi))
                    }
                    else {
                      object(x) <- e(CellChat::projectData(object(x), 
                        ppi))
                    }
                    object(x) <- e(CellChat::computeCommunProb(object(x), 
                      raw.use = FALSE))
                }
                else {
                    object(x) <- e(CellChat::computeCommunProb(object(x)))
                }
                x <- methodAdd(x, "使用 CellChat::computeCommunProb 函数计算细胞间通讯的概率。")
                object(x) <- e(CellChat::filterCommunication(object(x), 
                    min.cells = 10))
                x <- methodAdd(x, "通过 `CellChat::filterCommunication` 函数筛选掉在特定细胞组中仅少量细胞表达的细胞间通讯（min.cells 设置阈值为10），以提高分析的准确性。")
                lp_net <- as_tibble(CellChat::subsetCommunication(object(x)))
                object(x) <- e(CellChat::computeCommunProbPathway(object(x)))
                pathway_net <- as_tibble(CellChat::subsetCommunication(object(x), 
                    slot.name = "netP"))
                object(x) <- e(CellChat::aggregateNet(object(x)))
                p.comms <- plot_communication.cellchat(object(x))
                types <- c("count", "weight", "individuals")
                p.comms <- .set_lab(p.comms, sig(x), paste("overall communication", 
                    types))
                p.comms <- setLegend(p.comms, glue::glue("为细胞通讯 {types} 统计。"))
                object(x) <- e(CellChat::netAnalysis_computeCentrality(object(x), 
                    slot.name = "netP"))
            }
            object <- object(x)
            res <- try(e({
                for (i in c("functional", "structural")) {
                    object(x) <- CellChat::computeNetSimilarity(object(x), 
                      type = i)
                    object(x) <- CellChat::netEmbedding(object(x), 
                      type = i)
                    object(x) <- CellChat::netClustering(object(x), 
                      type = i, do.parallel = FALSE)
                }
            }))
            if (inherits(res, "try-error")) {
                message("Due to error, escape from clustering; But the object was returned.")
                object(x) <- object
            }
            p.commHpAll <- CellChat::netVisual_heatmap(object(x), 
                color.heatmap = "Reds", signaling = NULL)
            p.commHpAll <- .set_lab(wrap(p.commHpAll), sig(x), "All Cell communication heatmap")
            p.commHpAll <- setLegend(p.commHpAll, "为所有细胞的通讯热图。")
            if (!debug) {
                x <- plotsAdd(x, p.showdb, p.commHpAll, p.comms)
                x <- tablesAdd(x, lp_net, pathway_net)
            }
            x <- snapAdd(x, "对 {showStrings(object(x)@meta[[x$group.by]], trunc = FALSE)} 细胞通讯分析。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # cc.GSE150825_scissor_neg <- step2(cc.GSE150825_scissor_neg)
    setMethod(f = "step2", signature = c(x = "job_cellchat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, pathways = NULL) 
        {
            step_message("This step visualize all results computed in previous step.\n      These are:\n      1. Cells yellow{{communication}} in heatmap grey{{(and L-R contribution)}};\n      2. L-R in cells yellow{{communication}} in bubble;\n      3. Gene yellow{{expression}} of signaling in violin;\n      4. Overview of yellow{{Signaling roles}} of composition in heatmap;\n      5. Weight of yellow{{signaling roles}} grey{{('outgoing' or 'incomming')}} in scatter;\n      6. L-R in yellow{{signaling roles}} of cells in heatmap.\n      ")
            if (is.null(pathways)) {
                pathways <- object(x)@netP$pathways
            }
            sapply <- pbapply::pbsapply
            if (FALSE) {
                cell_comm_heatmap <- e(sapply(pathways, simplify = FALSE, 
                    function(name) {
                      main <- try(CellChat::netVisual_heatmap(object(x), 
                        color.heatmap = "Reds", signaling = name), 
                        TRUE)
                      if (inherits(main, "try-error")) {
                        return(list(main = NULL, contri = NULL))
                      }
                      if (!is.null(name)) {
                        contri <- CellChat::extractEnrichedLR(object(x), 
                          signaling = name, geneLR.return = FALSE)
                        return(namel(main, contri))
                      }
                      else {
                        return(namel(wrap(main)))
                      }
                    }))
                cell_comm_heatmap$ALL$main <- .set_lab(cell_comm_heatmap$ALL$main, 
                    sig(x), "Cell communication heatmap")
            }
            else {
                cell_comm_heatmap <- NULL
            }
            lr_comm_bubble <- e(CellChat::netVisual_bubble(object(x), 
                remove.isolate = FALSE))
            t.lr_comm_bubble <- .get_ggplot_content(lr_comm_bubble)
            t.lr_comm_bubble <- set_lab_legend(tibble::as_tibble(t.lr_comm_bubble), 
                glue::glue("{x@sig} data within ligand receptor interactions bubble plot"), 
                glue::glue("配体-受体相互作用气泡图。"))
            x <- tablesAdd(x, t.lr_comm_bubble)
            lr_comm_bubble <- set_lab_legend(lr_comm_bubble, glue::glue("{x@sig} communication probability and significant"), 
                glue::glue("为细胞通讯概率以及显著性。"))
            gene_expr_violin <- e(sapply(pathways, simplify = FALSE, 
                function(name) {
                    p <- CellChat::plotGeneExpression(object(x), 
                      signaling = name, group.by = NULL) + theme(legend.position = "none")
                    wrap(p)
                }))
            if (FALSE) {
                role_comps_heatmap <- e(sapply(pathways, simplify = FALSE, 
                    function(name) {
                      res <- try({
                        CellChat::netAnalysis_signalingRole_network(object(x), 
                          signaling = name, width = 8, height = 2.5, 
                          font.size = 8, cluster.rows = TRUE)
                        recordPlot()
                      }, TRUE)
                      if (inherits(res, "try-error")) 
                        return(NULL)
                      else res
                    }))
            }
            else {
                role_comps_heatmap <- NULL
            }
            role_weight_scatter <- e(sapply(pathways, simplify = FALSE, 
                function(name) {
                    CellChat::netAnalysis_signalingRole_scatter(object(x), 
                      signaling = name)
                }))
            res <- try(lr_role_heatmap <- e(sapply(c("outgoing", 
                "incoming", "all"), simplify = FALSE, function(name) {
                p <- CellChat::netAnalysis_signalingRole_heatmap(object(x), 
                    pattern = name, height = 1 + length(object(x)@netP$pathways) * 
                      0.35)
                wrap(grid::grid.grabExpr(print(p)))
            })))
            if (inherits(res, "try-error")) {
                lr_role_heatmap <- NULL
                message("Due to error, escape from `CellChat::netAnalysis_signalingRole_heatmap`; ", 
                    "But the object was returned.")
            }
            lr_role_heatmap <- .set_lab(lr_role_heatmap, sig(x), 
                names(lr_role_heatmap), "ligand-receptor role")
            lr_role_heatmap <- setLegend(lr_role_heatmap, glue::glue("为细胞间的 {names(lr_role_heatmap)} 类型通路信号强度 "))
            x <- plotsAdd(x, cell_comm_heatmap, lr_comm_bubble, gene_expr_violin, 
                role_comps_heatmap, role_weight_scatter, lr_role_heatmap)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(cc.GSE150825_scissor_neg)
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
    
    
    # cc.GSE150825_scissor_pos <- asjob_cellchat(getsub(srn.GSE150825, 
    #     scissor_cell == "scissor_pos"))
    setMethod(f = "asjob_cellchat", signature = c(x = "job_seurat"), 
        definition = function (x, ...) 
        {
            .local <- function (x, group.by = x$group.by, assay = SeuratObject::DefaultAssay(object(x)), 
                sample = 0.5, force = TRUE, ...) 
            {
                step_message("Prarameter red{{`group.by`}}, red{{`assay`}}, \n      and red{{`...`}} would passed to `CellChat::createCellChat`.", 
                    show_end = NULL)
                if (x@step < 2) {
                    stop("x@step < 2. At least, preprocessed assay data should be ready.")
                }
                if (!force && (!missing(sample) || ncol(object(x)) > 
                    50000)) {
                    message(glue::glue("Too many cells, sampling for analysis."))
                    x <- asjob_seurat_sub(x, sample = sample)
                }
                if (is.null(group.by)) 
                    stop("is.null(group.by) == TRUE")
                if (is.character(object(x)@meta.data[[group.by]])) {
                    object(x)@meta.data[[group.by]] %<>% as.factor()
                }
                else {
                    object(x)@meta.data[[group.by]] %<>% droplevels()
                }
                object <- e(CellChat::createCellChat(object = object(x), 
                    group.by = group.by, assay = assay, ...))
                x <- snapAdd(.job_cellchat(object = object, params = list(group.by = group.by)), 
                    x)
                x <- methodAdd(x, "细胞通讯分析可以帮助了解细胞与细胞之间的互作关系，细胞发出信号信息通过介质（即配体）传递到另一个靶细胞并与其相应的受体相互作用，然后通过细胞信号转导产生靶细胞内一系列生理生化变化，揭示发育过程中各类细胞的相互作用。")
                x <- methodAdd(x, "以 `CellChat` R 包 ⟦pkgInfo('CellChat')⟧ {cite_show('InferenceAndAJinS2021')} 对单细胞数据进行细胞通讯分析。以 `CellChat::createCellChat` 将 `Seurat` 对象的 {assay} Assay 转化为 CellChat 对象。")
                return(x)
            }
            .local(x, ...)
        })
    
    
    # cc.GSE150825_scissor_pos <- step1(cc.GSE150825_scissor_pos)
    setMethod(f = "step1", signature = c(x = "job_cellchat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, workers = 4, python = pg("cellchat_python"), 
            py_config = FALSE, debug = FALSE, org = c("human", "mouse"), 
            smooth = FALSE, ...) 
        {
            step_message("One step forward computation of most. ")
            org <- match.arg(org)
            if (is.remote(x)) {
                x <- run_job_remote(x, wait = 3, ..., debug = debug, 
                    {
                      options(future.globals.maxSize = 5e+10)
                      x <- step1(x, workers = "{workers}", org = "{org}", 
                        debug = "{debug}", python = "{python}", py_config = "{py_config}")
                    })
                x@plots$step1$p.commHpAll@data <- e(CellChat::netVisual_heatmap(object(x), 
                    color.heatmap = "Reds", signaling = NULL))
                return(x)
            }
            if (org == "human") {
                db <- CellChat::CellChatDB.human
                ppi <- CellChat::PPI.human
            }
            else if (org == "mouse") {
                db <- CellChat::CellChatDB.mouse
                ppi <- CellChat::PPI.mouse
            }
            if (!is.null(python)) {
                e(base::Sys.setenv(RETICULATE_PYTHON = python))
                e(reticulate::use_python(python))
                e(reticulate::py_config())
            }
            else if (py_config) {
                e(reticulate::py_config())
            }
            if (!reticulate::py_module_available(module = "umap")) {
                stop("!reticulate::py_module_available(module = \"umap\").")
            }
            x <- methodAdd(x, "参照工作流 <https://htmlpreview.github.io/?https://github.com/jinworks/CellChat/blob/master/tutorial/CellChat-vignette.html> 对单细胞数据集进行分析。")
            if (!debug) {
                p.showdb <- e(CellChat::showDatabaseCategory(db))
                p.showdb <- wrap(p.showdb, 8, 4)
                object(x)@DB <- db
                future::plan("multisession", workers = workers)
                object(x) <- e(CellChat::subsetData(object(x)))
                object(x) <- e(CellChat::identifyOverExpressedGenes(object(x)))
                object(x) <- e(CellChat::identifyOverExpressedInteractions(object(x)))
                x <- methodAdd(x, "以 CellChat::identifyOverExpressedGenes、CellChat::identifyOverExpressedInteractions，寻找高表达的信号基因之间的相互通讯。")
                if (smooth && !is.null(ppi)) {
                    if (exists("smoothData", envir = asNamespace("CellChat"))) {
                      object(x) <- e(CellChat::smoothData(object(x), 
                        adj = ppi))
                    }
                    else {
                      object(x) <- e(CellChat::projectData(object(x), 
                        ppi))
                    }
                    object(x) <- e(CellChat::computeCommunProb(object(x), 
                      raw.use = FALSE))
                }
                else {
                    object(x) <- e(CellChat::computeCommunProb(object(x)))
                }
                x <- methodAdd(x, "使用 CellChat::computeCommunProb 函数计算细胞间通讯的概率。")
                object(x) <- e(CellChat::filterCommunication(object(x), 
                    min.cells = 10))
                x <- methodAdd(x, "通过 `CellChat::filterCommunication` 函数筛选掉在特定细胞组中仅少量细胞表达的细胞间通讯（min.cells 设置阈值为10），以提高分析的准确性。")
                lp_net <- as_tibble(CellChat::subsetCommunication(object(x)))
                object(x) <- e(CellChat::computeCommunProbPathway(object(x)))
                pathway_net <- as_tibble(CellChat::subsetCommunication(object(x), 
                    slot.name = "netP"))
                object(x) <- e(CellChat::aggregateNet(object(x)))
                p.comms <- plot_communication.cellchat(object(x))
                types <- c("count", "weight", "individuals")
                p.comms <- .set_lab(p.comms, sig(x), paste("overall communication", 
                    types))
                p.comms <- setLegend(p.comms, glue::glue("为细胞通讯 {types} 统计。"))
                object(x) <- e(CellChat::netAnalysis_computeCentrality(object(x), 
                    slot.name = "netP"))
            }
            object <- object(x)
            res <- try(e({
                for (i in c("functional", "structural")) {
                    object(x) <- CellChat::computeNetSimilarity(object(x), 
                      type = i)
                    object(x) <- CellChat::netEmbedding(object(x), 
                      type = i)
                    object(x) <- CellChat::netClustering(object(x), 
                      type = i, do.parallel = FALSE)
                }
            }))
            if (inherits(res, "try-error")) {
                message("Due to error, escape from clustering; But the object was returned.")
                object(x) <- object
            }
            p.commHpAll <- CellChat::netVisual_heatmap(object(x), 
                color.heatmap = "Reds", signaling = NULL)
            p.commHpAll <- .set_lab(wrap(p.commHpAll), sig(x), "All Cell communication heatmap")
            p.commHpAll <- setLegend(p.commHpAll, "为所有细胞的通讯热图。")
            if (!debug) {
                x <- plotsAdd(x, p.showdb, p.commHpAll, p.comms)
                x <- tablesAdd(x, lp_net, pathway_net)
            }
            x <- snapAdd(x, "对 {showStrings(object(x)@meta[[x$group.by]], trunc = FALSE)} 细胞通讯分析。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # cc.GSE150825_scissor_pos <- step2(cc.GSE150825_scissor_pos)
    setMethod(f = "step2", signature = c(x = "job_cellchat"), definition = function (x, 
        ...) 
    {
        .local <- function (x, pathways = NULL) 
        {
            step_message("This step visualize all results computed in previous step.\n      These are:\n      1. Cells yellow{{communication}} in heatmap grey{{(and L-R contribution)}};\n      2. L-R in cells yellow{{communication}} in bubble;\n      3. Gene yellow{{expression}} of signaling in violin;\n      4. Overview of yellow{{Signaling roles}} of composition in heatmap;\n      5. Weight of yellow{{signaling roles}} grey{{('outgoing' or 'incomming')}} in scatter;\n      6. L-R in yellow{{signaling roles}} of cells in heatmap.\n      ")
            if (is.null(pathways)) {
                pathways <- object(x)@netP$pathways
            }
            sapply <- pbapply::pbsapply
            if (FALSE) {
                cell_comm_heatmap <- e(sapply(pathways, simplify = FALSE, 
                    function(name) {
                      main <- try(CellChat::netVisual_heatmap(object(x), 
                        color.heatmap = "Reds", signaling = name), 
                        TRUE)
                      if (inherits(main, "try-error")) {
                        return(list(main = NULL, contri = NULL))
                      }
                      if (!is.null(name)) {
                        contri <- CellChat::extractEnrichedLR(object(x), 
                          signaling = name, geneLR.return = FALSE)
                        return(namel(main, contri))
                      }
                      else {
                        return(namel(wrap(main)))
                      }
                    }))
                cell_comm_heatmap$ALL$main <- .set_lab(cell_comm_heatmap$ALL$main, 
                    sig(x), "Cell communication heatmap")
            }
            else {
                cell_comm_heatmap <- NULL
            }
            lr_comm_bubble <- e(CellChat::netVisual_bubble(object(x), 
                remove.isolate = FALSE))
            t.lr_comm_bubble <- .get_ggplot_content(lr_comm_bubble)
            t.lr_comm_bubble <- set_lab_legend(tibble::as_tibble(t.lr_comm_bubble), 
                glue::glue("{x@sig} data within ligand receptor interactions bubble plot"), 
                glue::glue("配体-受体相互作用气泡图。"))
            x <- tablesAdd(x, t.lr_comm_bubble)
            lr_comm_bubble <- set_lab_legend(lr_comm_bubble, glue::glue("{x@sig} communication probability and significant"), 
                glue::glue("为细胞通讯概率以及显著性。"))
            gene_expr_violin <- e(sapply(pathways, simplify = FALSE, 
                function(name) {
                    p <- CellChat::plotGeneExpression(object(x), 
                      signaling = name, group.by = NULL) + theme(legend.position = "none")
                    wrap(p)
                }))
            if (FALSE) {
                role_comps_heatmap <- e(sapply(pathways, simplify = FALSE, 
                    function(name) {
                      res <- try({
                        CellChat::netAnalysis_signalingRole_network(object(x), 
                          signaling = name, width = 8, height = 2.5, 
                          font.size = 8, cluster.rows = TRUE)
                        recordPlot()
                      }, TRUE)
                      if (inherits(res, "try-error")) 
                        return(NULL)
                      else res
                    }))
            }
            else {
                role_comps_heatmap <- NULL
            }
            role_weight_scatter <- e(sapply(pathways, simplify = FALSE, 
                function(name) {
                    CellChat::netAnalysis_signalingRole_scatter(object(x), 
                      signaling = name)
                }))
            res <- try(lr_role_heatmap <- e(sapply(c("outgoing", 
                "incoming", "all"), simplify = FALSE, function(name) {
                p <- CellChat::netAnalysis_signalingRole_heatmap(object(x), 
                    pattern = name, height = 1 + length(object(x)@netP$pathways) * 
                      0.35)
                wrap(grid::grid.grabExpr(print(p)))
            })))
            if (inherits(res, "try-error")) {
                lr_role_heatmap <- NULL
                message("Due to error, escape from `CellChat::netAnalysis_signalingRole_heatmap`; ", 
                    "But the object was returned.")
            }
            lr_role_heatmap <- .set_lab(lr_role_heatmap, sig(x), 
                names(lr_role_heatmap), "ligand-receptor role")
            lr_role_heatmap <- setLegend(lr_role_heatmap, glue::glue("为细胞间的 {names(lr_role_heatmap)} 类型通路信号强度 "))
            x <- plotsAdd(x, cell_comm_heatmap, lr_comm_bubble, gene_expr_violin, 
                role_comps_heatmap, role_weight_scatter, lr_role_heatmap)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(cc.GSE150825_scissor_pos)
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
    
    
    # cc.comparison <- asjob_cellchatn(list(scissor_neg = cc.GSE150825_scissor_neg, 
    #     scissor_pos = cc.GSE150825_scissor_pos))
    setMethod(f = "asjob_cellchatn", signature = c(x = "list"), definition = function (x, 
        ...) 
    {
        .local <- function (x, nms = names(x)) 
        {
            if (any(!vapply(x, is, logical(1), "job_cellchat"))) {
                message("All elements of list should be 'job_cellchat'.")
            }
            if (any(vapply(x, function(x) x@step < 2, logical(1)))) {
                stop("any(vapply(x, function(x) x@step < 2, logical(1))).")
            }
            meth <- bind(meth(x[[1]])$step0, meth(x[[1]])$step1, 
                co = "\n")
            p.lr_comm_bubbles <- lapply(x, function(x) {
                x@plots$step2$lr_comm_bubble
            })
            t.lr_comm_bubble <- lapply(x, function(x) {
                x@tables$step2$t.lr_comm_bubble
            })
            group.by <- vapply(x, function(x) x$group.by, character(1))
            if (!length(group.by <- unique(group.by))) {
                stop("!length(unique(group.by)).")
            }
            args_inters <- sapply(c("count", "weight"), simplify = FALSE, 
                function(type) {
                    weight.max <- e(CellChat::getMaxWeight(lapply(x, 
                      function(x) object(x)), attribute = c("idents", 
                      type)))
                    nets <- lapply(x, function(x) object(x)@net[[type]])
                    list(nets = nets, wmax = weight.max, type = type)
                })
            object <- e(CellChat::mergeCellChat(lapply(x, function(x) object(x)), 
                add.names = nms))
            x <- .job_cellchatn(object = object)
            x$.pre_meth <- meth
            x$each_lr_comm <- namel(p.lr_comm_bubbles, t.lr_comm_bubble)
            x$args_inters <- args_inters
            x$group.by <- group.by
            return(x)
        }
        .local(x, ...)
    })
    
    
    # cc.comparison <- step1(cc.comparison)
    setMethod(f = "step1", signature = c(x = "job_cellchatn"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Plot group comparison.")
            p.inters_counts <- funPlot(.plot_interactions_across_datasets, 
                x$args_inters$count)
            p.inters_counts <- set_lab_legend(wrap(p.inters_counts, 
                14, 7), glue::glue("{x@sig} Comparison Number communication network"), 
                glue::glue("数量通讯网络|||不同细胞的连线表示潜在的通讯关系，通讯强度数量越多，连线越粗。"))
            p.inters_weights <- funPlot(.plot_interactions_across_datasets, 
                x$args_inters$weight)
            p.inters_weights <- set_lab_legend(wrap(p.inters_weights, 
                14, 7), glue::glue("{x@sig} Comparison Strength communication network"), 
                glue::glue("强度通讯网络|||不同细胞的连线表示潜在的通讯关系，通讯强度数量越多，连线越粗。"))
            x <- methodAdd(x, x$.pre_meth)
            x <- methodAdd(x, "参照 <https://htmlpreview.github.io/?https://github.com/jinworks/CellChat/blob/master/tutorial/Comparison_analysis_of_multiple_datasets.html> 对多数据集单细胞数据进行组间比较分析。")
            x <- plotsAdd(x, p.inters_counts, p.inters_weights)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # cc.comparison <- step2(cc.comparison, as_feature("Fibroblast", 
    #     "关键细胞", nature = "cell"))
    setMethod(f = "step2", signature = c(x = "job_cellchatn"), definition = function (x, 
        ...) 
    {
        .local <- function (x, cell) 
        {
            step_message("Cell as source or target interactions with other cells.")
            allCells <- levels(object(x)@meta[[x$group.by]])
            if (!is(cell, "feature_char")) {
                stop("!is(cell, \"feature_char\").")
            }
            if (length(cell) > 1) {
                stop("length(cell) > 1.")
            }
            if (!any(isThat <- grpl(allCells, cell))) {
                stop("!any(isThat <- grpl(allCells, cell)), can not found.")
            }
            keyCell <- allCells[isThat]
            otherCells <- allCells[!isThat]
            p.keyCellAsSource <- e(CellChat::netVisual_bubble(object(x), 
                comparison = c(1, 2), sources.use = keyCell, targets.use = otherCells, 
                angle.x = 45))
            data.keyCellAsSource <- .get_ggplot_content(p.keyCellAsSource)
            p.keyCellAsSource <- set_lab_legend(p.keyCellAsSource, 
                glue::glue("{x@sig} {cell} as source comparison"), 
                glue::glue("{cell} 作为通讯发送方与其他细胞之间的通讯在组间的比较|||颜色表示细胞通讯概率（Communication Probability）大小，颜色由蓝色逐渐过渡至红色，分别代表由低到高的通讯强度。点的大小表示统计学显著性水平，点越大代表显著性越高；小点表示 p > 0.05，中等点表示 0.01 < p ≤ 0.05，大点表示 p < 0.01。"))
            p.keyCellAsTarget <- e(CellChat::netVisual_bubble(object(x), 
                comparison = c(1, 2), sources.use = otherCells, targets.use = keyCell, 
                angle.x = 45))
            x <- methodAdd(x, "利用 netVisual_bubble 函数绘制气泡图对各个细胞类型中配体受体介导的相互作用。")
            data.keyCellAsTarget <- .get_ggplot_content(p.keyCellAsTarget)
            p.keyCellAsTarget <- set_lab_legend(p.keyCellAsTarget, 
                glue::glue("{x@sig} key cell as target comparison"), 
                glue::glue("{cell} 作为通讯接收方与其他细胞之间的通讯在组间的比较|||颜色表示细胞通讯概率（Communication Probability）大小，颜色由蓝色逐渐过渡至红色，分别代表由低到高的通讯强度。点的大小表示统计学显著性水平，点越大代表显著性越高；小点表示 p > 0.05，中等点表示 0.01 < p ≤ 0.05，大点表示 p < 0.01。"))
            p.allCells_LP_comm_each_group <- x$each_lr_comm$p.lr_comm_bubbles
            p.allCells_LP_comm_each_group <- set_lab_legend(p.allCells_LP_comm_each_group, 
                glue::glue("{x@sig} {names(p.allCells_LP_comm_each_group)} ligand receptor interactions bubble plot"), 
                glue::glue("Group {names(p.allCells_LP_comm_each_group)}: 不同细胞类型之间的配体-受体对相互作用气泡图。|||纵坐标为配体-受体对，横坐标为细胞-细胞相互作用方向，颜色代表交互的可能性，颜色越红代表通讯可能越高，气泡的点大小代表显著性。"))
            x <- methodAdd(x, "以 `CellChat::netVisual_bubble` 比较 {snap(cell)} 的组间差异配体与受体相互作用 (⟦mark$blue('P value &lt; 0.05')⟧)。")
            lr_comm <- x$each_lr_comm$t.lr_comm_bubble
            s.com <- glue::glue("{names(lr_comm)} 组包含 {vapply(lr_comm, nrow, integer(1))} 对唯一互作")
            x <- snapAdd(x, "各组细胞的配体、受体通讯统计{aref(p.allCells_LP_comm_each_group)}，{bind(s.com)} (P value &lt; 0.05)。")
            x$keyCell_data <- namel(data.keyCellAsSource, data.keyCellAsTarget)
            snap_compare <- .stat_cellchat_keycell_summary(x$keyCell_data, 
                p.keyCellAsSource, p.keyCellAsTarget)
            x <- snapAdd(x, "\n\n\n{snap_compare}")
            x <- plotsAdd(x, p.keyCellAsSource, p.keyCellAsTarget, 
                p.allCells_LP_comm_each_group)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(cc.comparison)
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

