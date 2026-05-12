# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "11_geneAnalysis")
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

des.GSE189642 <- readRDS("./rds_jobSave/des.GSE189642.3.rds")
fea.markers <- load_feature()

cp.markers <- cal_corp(des.GSE189642, NULL, fea.markers, fea.markers)
clear(cp.markers)

lc.markers <- asjob_locate(fea.markers)
lc.markers <- step1(lc.markers)
lc.markers <- step2(lc.markers)
clear(lc.markers)

gm.markers <- readRDS("./rds_jobSave/gm.markers.3.rds")
clear(gm.markers)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  cp.markers@params$p.cor
  notshow(cp.markers@params$res)
})

#| OVERTURE
output_with_counting_number({
  lc.markers@plots$step1$p.locateChr
  notshow(lc.markers@params$gene_data)
  lc.markers@plots$step2$p.locateScore
  notshow(lc.markers@params$locateData)
})

#| OVERTURE
output_with_counting_number({
  gm.markers@plots$step3$p.network
  notshow(gm.markers@params$res_alls$functions)
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
    # cp.markers <- cal_corp(des.GSE189642, NULL, fea.markers, fea.markers)
    setMethod(f = "cal_corp", signature = c(x = "job_deseq2", y = "NULL"
    ), definition = function (x, y, ...) 
    {
        .local <- function (x, y, from, to, use = "symbol", group = NULL, 
            ...) 
        {
            fakeLmJob <- .as_job_limma.job_deseq2(x)
            if (is.null(use)) {
                use <- .guess_symbol(fakeLmJob)
            }
            j <- cal_corp(fakeLmJob, NULL, from, to, use = use, group = group, 
                mode = "ggcor", ...)
            return(j)
        }
        .local(x, y, ...)
    })
    
    
    # clear(cp.markers)
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
    
    
    # lc.markers <- asjob_locate(fea.markers)
    setMethod(f = "asjob_locate", signature = c(x = "feature"), definition = function (x, 
        ...) 
    {
        fea <- resolve_feature_snapAdd_onExit("x", x)
        x <- .job_locate(object = fea)
        dir.create("tmp", FALSE)
        x$gene_data <- expect_local_data("tmp", "biomart", get_gene_positions, 
            list(genes = fea), ...)
        return(x)
    })
    
    
    # lc.markers <- step1(lc.markers)
    setMethod(f = "step1", signature = c(x = "job_locate"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Quality control (QC).")
            p.locateChr <- funPlot(plot_genes_in_RCircos, list(gene_data = x$gene_data))
            p.locateChr <- set_lab_legend(p.locateChr, glue::glue("{x@sig} Chromosome localization"), 
                glue::glue("基因于染色体定位|||外圈数字表示染色体（1-22表示1-22条人类染色体，XY对应性染色体）"))
            snap <- glue::glue("基因 {x$gene_data$Gene} 位于 {s(x$gene_data$Chromosome, 'chr', '')} 染色体上")
            x <- snapAdd(x, "如图所示{aref(p.locateChr)}，{bind(snap)}。")
            x <- methodAdd(x, "染色体定位分析可有效揭示基因在染色体上的分布特征。以 R 包 `RCircos` ⟦pkgInfo('RCircos')⟧ 生成基因染色体定位图谱。")
            x <- plotsAdd(x, p.locateChr)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # lc.markers <- step2(lc.markers)
    setMethod(f = "step2", signature = c(x = "job_locate"), definition = function (x, 
        ...) 
    {
        .local <- function (x, org = "Homo sapiens") 
        {
            step_message("Get location data.")
            data <- get_mRNA_subcellular_data(org = org)
            data <- dplyr::filter(data, RNA_Symbol %in% object(x))
            if (any(whichNot <- !object(x) %in% data$RNA_Symbol)) {
                message(glue::glue("Not got: {object(x)[ whichNot ]}"))
            }
            data <- dplyr::arrange(data, dplyr::desc(RNALocate_Score))
            data <- dplyr::distinct(data, RNA_Symbol, Subcellular_Localization, 
                .keep_all = TRUE)
            x$locateData <- data
            p.locateScore <- wrap_scale(.plot_subcellular_scores(data), 
                length(unique(data$Subcellular_Localization)), length(object(x)[!whichNot]), 
                pre_height = 3.5, min_width = 2)
            x <- methodAdd(x, "从 RNALocate v3.0 (<http://www.rnalocate.org/>) 获取 mRNA 亚细胞定位数据，并用 R 包 `ggplot2` ⟦pkgInfo('ggplot2')⟧将定位和得分数据可视化。")
            p.locateScore <- set_lab_legend(p.locateScore, glue::glue("{x@sig} RNA Subcellular Localization Distribution"), 
                glue::glue("RNA 亚细胞定位分布|||纵坐标为不同基因，横坐标为的预测的蛋白质亚细胞定位得分：RNA 亚细胞定位关联信息来自不同类型的资源，包括实验证据和预测证据；实验证据对置信度评分的贡献应该比预测证据更大；强有力的实验证据应该比薄弱的实验证据提供更可靠的证据；有更多证据支持的 RNA 亚细胞定位关联应比证据较少支持的关联具有更高的置信度评分 (<http://www.rnalocate.org/help>)。"))
            top <- dplyr::distinct(data, RNA_Symbol, .keep_all = TRUE)
            snap <- glue::glue("蛋白 {top$RNA_Symbol} 分布于 {top$Subcellular_Localization}")
            x <- snapAdd(x, "如图{aref(p.locateScore)}，依据 RNALocate 评分准则 (见图注或 <http://www.rnalocate.org/help>) 最有证据证明 {bind(snap)}。")
            x <- plotsAdd(x, p.locateScore)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(lc.markers)
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
    
    
    # clear(gm.markers)
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

