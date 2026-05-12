# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "04_ppi")
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

ven.candidates <- readRDS("./rds_jobSave/ven.candidates.1.rds")

sdb.candidates <- asjob_stringdb(feature(ven.candidates))
sdb.candidates <- step1(
sdb.candidates, network_type = "full", score_threshold = 400, MCC = FALSE
)
clear(sdb.candidates)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(sdb.candidates@plots$step1$p.ppi, 2.5, 2)
  notshow(sdb.candidates@tables$step1$mapped)
  notshow(sdb.candidates@params$edges)
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
    # sdb.candidates <- asjob_stringdb(feature(ven.candidates))
    setMethod(f = "asjob_stringdb", signature = c(x = "feature"), 
        definition = function (x, ...) 
        {
            .local <- function (x, extra = NULL) 
            {
                x <- resolve_feature_snapAdd_onExit("x", x)
                if (!is.null(extra)) {
                    x <- c(x, extra)
                }
                x <- job_stringdb(unlist(x))
                return(x)
            }
            .local(x, ...)
        })
    
    
    # sdb.candidates <- step1(sdb.candidates, network_type = "full", 
    #     score_threshold = 400, MCC = FALSE)
    setMethod(f = "step1", signature = c(x = "job_stringdb"), definition = function (x, 
        ...) 
    {
        .local <- function (x, tops = 30, layout = "spiral", species = 9606, 
            score_threshold = 400, network_type = "phy", input_directory = .prefix("stringdb_physical_v12.0", 
                name = "db"), version = "12.0", label = FALSE, HLs = NULL, 
            use.anno = TRUE, link_data = "detailed", file_anno = .prefix("stringdb_physical_v12.0/9606.protein.physical.links.full.v12.0.txt.gz", 
                name = "db"), filter.exp = 0, filter.text = 0, MCC = TRUE) 
        {
            step_message("Create PPI network.")
            require(ggraph)
            x$network_type <- network_type <- match.arg(network_type, 
                c("physical", "full"))
            if (!dir.exists(input_directory)) {
                dir.create(input_directory)
            }
            if (is.null(x$sdb)) {
                message("Use STRINGdb network type of '", network_type, 
                    "'")
                sdb <- new_stringdb(score_threshold = score_threshold, 
                    species = species, network_type = network_type, 
                    input_directory = input_directory, version = version, 
                    link_data = link_data)
                x$sdb <- sdb
            }
            else {
                sdb <- x$sdb
            }
            if (is.null(x$res.str)) {
                res.str <- create_interGraph(sdb, data.frame(object(x)), 
                    col = "Symbol")
                x$res.str <- res.str
            }
            else {
                res.str <- x$res.str
            }
            if (is.null(x$graph)) {
                graph <- fast_layout(x$res.str$graph, layout = layout)
                graph$name <- x$res.str$mapped$Symbol[match(graph$name, 
                    x$res.str$mapped$STRING_id)]
                x$graph <- graph
            }
            else {
                graph <- x$graph
            }
            edges <- as_tibble(igraph::as_data_frame(res.str$graph))
            edges <- dplyr::distinct(edges, from, to, .keep_all = TRUE)
            if (species == 9606) {
                message("`use.anno` not available for non hsa.")
                use.anno <- FALSE
            }
            if (use.anno) {
                message("Get PPI annotation from:\n\t", file_anno)
                anno <- ftibble(file_anno)
                edges <- tbmerge(edges[, 1:2], anno, by.x = c("from", 
                    "to"), by.y = paste0("protein", 1:2), all.x = TRUE, 
                    sort = FALSE)
                if (filter.exp || filter.text) {
                    edges <- dplyr::filter(edges, experiments >= 
                      !!filter.exp, textmining >= !!filter.text)
                }
            }
            edges <- map(edges, "from", res.str$mapped, "STRING_id", 
                "Symbol", rename = FALSE)
            edges <- map(edges, "to", res.str$mapped, "STRING_id", 
                "Symbol", rename = FALSE)
            des_edges <- list(`STRINGdb network type:` = match.arg(network_type, 
                c("physical", "full")))
            if (use.anno) {
                des_edges <- c(des_edges, list(`Filter experiments score:` = paste0("At least score ", 
                    filter.exp), `Filter textmining score:` = paste0("At least score ", 
                    filter.text)))
            }
            edges <- .set_lab(edges, sig(x), "PPI annotation")
            attr(edges, "lich") <- new_lich(des_edges)
            x$edges <- edges
            if (FALSE && network_type == "full") {
                p.ppi <- NULL
            }
            else {
                p.ppi <- plot_network.str(graph, label = label)
                h.ppi <- nrow(x$res.str$mapped)%/%10
                p.ppi <- set_lab_legend(wrap(p.ppi, h.ppi + 2, h.ppi), 
                    glue::glue("{x@sig} PPI network"), glue::glue("PPI 网络图|||每个节点表示一个蛋白 (基因)，连线表示可能存在的相互作用。"))
            }
            if (MCC) {
                message("Calculate MCC score.")
            }
            hub_genes <- cal_mcc.str(res.str, "Symbol", FALSE, MCC = MCC)
            graph_mcc <- get_subgraph.mcc(res.str$graph, hub_genes, 
                top = tops)
            x$graph_mcc <- graph_mcc <- fast_layout(graph_mcc, layout = "linear", 
                circular = TRUE)
            x$graph_mcc <- .set_lab(x$graph_mcc, sig(x), "graph MCC layout data")
            snap.mcc <- if (MCC) 
                "(带有 Cytohubba {cite_show('CytohubbaIdenChin2014')} MCC 得分)"
            else ""
            x$graph_mcc <- setLegend(x$graph_mcc, "PPI {snap.mcc}附表")
            if (!is.null(tops)) {
                feature(x) <- head(hub_genes$Symbol, n = tops)
            }
            else {
                feature(x) <- hub_genes$Symbol
            }
            p.mcc <- plot_networkFill.str(graph_mcc, label = "Symbol", 
                HLs = HLs, netType = network_type)
            p.mcc <- .set_lab(wrap(p.mcc), sig(x), paste0("Top", 
                tops, " MCC score"))
            p.mcc <- setLegend(p.mcc, "PPI {snap.mcc}网络图")
            x <- plotsAdd(x, p.ppi, p.mcc)
            x <- tablesAdd(x, hub_genes, mapped = dplyr::relocate(res.str$mapped, 
                Symbol, STRING_id))
            x$tops <- tops
            if (MCC) {
                ex <- glue::glue("以 Cytohubba {cite_show('CytohubbaIdenChin2014')} 的算法在 R 中计算 MCC (Maximal Clique Centrality) 。")
            }
            else {
                ex <- ""
            }
            nAll <- nrow(x$res.str$mapped)
            nIsolate <- nAll - length(unique(c(x$edges$from, x$edges$to)))
            x <- methodAdd(x, "STRING database 蛋白–蛋白相互作用（PPI）网络分析是一种基于已知与预测相互作用信息构建分子互作网络的方法，其主要目的是从系统层面解析基因或蛋白之间的功能关联关系。通过将候选基因映射至 STRING 数据库，构建 PPI 网络并分析其拓扑结构（如节点连接度、聚类系数等），可以识别在网络中处于核心地位的关键蛋白（hub genes）及其参与的功能模块。进一步结合功能富集分析，可揭示这些关键节点在特定生物学过程或疾病机制中的潜在作用，从而为筛选重要调控分子及后续实验验证提供依据。")
            x <- methodAdd(x, "以 R 包 `STEINGdb` ⟦pkgInfo('STRINGdb')⟧ {cite_show('TheStringDataSzklar2021')} 构建 PPI 网络。数据版本为 {version}，互作类型为 {network_type}。置信评分 (confidence score) 阈值为 {score_threshold / 1000}。{ex}随后，以 R 包 `ggraph` ⟦pkgInfo('ggraph')⟧ 可视化网络。")
            x <- snapAdd(x, "PPI 网络图 {aref(p.ppi)} 共包含 {nAll} 个蛋白 (基因)，存在 {nrow(edges)} 对相互作用，孤立蛋白数量为{nIsolate}。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(sdb.candidates)
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

