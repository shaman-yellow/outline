# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "16_nomogram")
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

rms.GSE189642 <- asjob_rms(des.GSE189642, fea.markers)
rms.GSE189642 <- step1(rms.GSE189642, penalty = 1)
rms.GSE189642 <- step2(rms.GSE189642)
clear(rms.GSE189642)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  rms.GSE189642@plots$step1$p.nomo
  notshow(rms.GSE189642@params$res_lrm$data)
  rms.GSE189642@plots$step1$p.rocs
  rms.GSE189642@plots$step1$p.cal
  rms.GSE189642@plots$step2$p.dcas
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
    # rms.GSE189642 <- asjob_rms(des.GSE189642, fea.markers)
    setMethod(f = "asjob_rms", signature = c(x = "job_deseq2"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ref, target = "group", format_name = TRUE, 
            levels = rev(.guess_compare_deseq2(x, 1L))) 
        {
            if (x@step < 1L) {
                stop("x@step < 1L.")
            }
            if (!is(ref, "feature")) {
                stop("!is(ref, \"feature\").")
            }
            ref <- resolve_feature_snapAdd_onExit("x", ref)
            data <- SummarizedExperiment::assay(x$vst)
            if (any(!ref %in% rownames(data))) {
                stop("any(!ref %in% rownames(data)).")
            }
            data <- as_tibble(t(data[rownames(data) %in% ref, ]), 
                idcol = "sample")
            metadata <- x$vst@colData
            data <- map(data, "sample", metadata, "sample", target, 
                col = "group")
            if (format_name) {
                message(glue::glue("Colnames: {bind(colnames(data))}"))
                colnames(data) <- formal_name(colnames(data))
                message(glue::glue("Reset as: {bind(colnames(data))}"))
                target <- formal_name(target)
            }
            data[[target]] <- factor(data[[target]], levels = levels)
            x <- .job_rms(object = data)
            x$metadata <- metadata
            x$target <- target
            return(x)
        }
        .local(x, ...)
    })
    
    
    # rms.GSE189642 <- step1(rms.GSE189642, penalty = 1)
    setMethod(f = "step1", signature = c(x = "job_rms"), definition = function (x, 
        ...) 
    {
        .local <- function (x, target = x$target, seed = x$seed, 
            penalty = 1, loocv = "auto", ...) 
        {
            step_message("Logistic ...")
            data <- object(x)[, colnames(object(x)) != "sample"]
            set.seed(seed)
            if (identical(loocv, "auto") && nrow(data) < 40) {
                loocv <- TRUE
            }
            x$res_lrm <- new_lrm(data, formula = target, penalty = penalty, 
                loocv = loocv)
            x$res_nomo <- new_nomo(x$res_lrm, ...)
            x <- methodAdd(x, "以 R 包 `rms` ⟦pkgInfo('rms')⟧ 依据各独立诊断因子的权重赋值打分，将各因子评分求和得到总评分，作为风险评估模型，进而推断受试者的患病风险。")
            p.nomo <- x$res_nomo$p.nomo_reg
            p.nomo <- set_lab_legend(p.nomo, glue::glue("{x@sig} nomogram"), 
                glue::glue("风险评估列线图|||第一部分为 Points，表示风险分数为某个取值时的单项得分；第二部分为变量，变量后面线段的取值范围表示该变量对结局事件的总贡献值。线段上的刻度表示变量的不同取值；第三部分为 Total Points，表示变量取值的单项得分的总分。"))
            x <- methodAdd(x, "以 R 包 `regplot` ⟦pkgInfo('regplot')⟧ 绘制该评估模型的列线图 (优化的列线图)。")
            x <- snapAdd(x, "列线图{aref(p.nomo)}将复杂的回归方程，转变为了可视化的图形，使预测模型的结果更具有可读性，方便对患者进行评估。如图{aref(p.nomo)}，每一个关键基因对应一个评分，各关键基因评分相加对应总评分，根据总评分预测疾病发病风险。")
            p.rocs <- x$res_lrm$p.rocs
            p.rocs <- set_lab_legend(p.rocs, glue::glue("{x@sig} ROC evaluation of diagnostic indicators"), 
                glue::glue("各诊断指标的ROC|||{detail('note_roc')}"))
            x <- methodAdd(x, "以 R 包 `pROC` ⟦pkgInfo('pROC')⟧ 绘制该诊断模型的受试者工作特征 (ROC) 曲线，以曲线下面积 (Area Under the Curve，AUC) 评估模型效能。")
            if (loocv) {
                x <- methodAdd(x, "此外，为解决样本量较小的问题，减少模型在训练集上产生的过拟合偏倚，并更客观地评估模型的泛化能力，采用留一交叉验证（leave-one-out cross-validation，LOOCV）对列线图模型进行内部验证。具体而言，每次保留1个样本作为验证集，其余样本用于模型训练，重复进行直至所有样本均完成1次独立验证，最终汇总全部预测结果用于绘制 ROC 曲线并计算受试者工作特征曲线下面积（AUC），以评价模型的判别性能")
            }
            x <- snapAdd(x, "ROC 评估{aref(p.rocs)}各诊断指标：{bind(x$res_lrm$aucs)} (AUC 介于 0.7-1 提示模型具有较好的预测效能)。")
            p.cal <- x$res_lrm$p.cal
            exLegend <- if (packageVersion("rms") >= "8.1.1") {
                "；C.L.为置信区间，如果对角线在 C.L. 内，模型校准良好"
            }
            else {
                ""
            }
            hl.pvalue <- x$res_lrm$hl.test$p.value
            p.cal <- set_lab_legend(p.cal, glue::glue("{x@sig} calibration curve"), 
                glue::glue("列线图校准曲线|||Ideal 表示理想情况下预测概率与实际概率完全一致的情况，Apparent 表示模型预测概率的表观校准情况，Bias-corrected 表示经过偏差校正后的校准情况{exLegend}。Hosmer-Lemesho 检验 P = {fmt(hl.pvalue)}。"))
            x <- methodAdd(x, "以 R 包 `rms` 对列线图绘制校准曲线，评估模型预测风险与实际患病风险的一致性（校准曲线越贴近对角线，表明一致性越高。")
            x <- snapAdd(x, "校准曲线{aref(p.cal)}斜率接近 1 且 P &gt; 0.05，说明列线图的预测准确性较好。")
            x <- snapAdd(x, "Hosmer-Lemesho 检验 P 为{fmt(hl.pvalue)} (P &gt; 0.05 说明通过 HL 检验，预测值与真实值之间并无非常明显的差异)。")
            x <- plotsAdd(x, p.nomo, p.rocs, p.cal)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # rms.GSE189642 <- step2(rms.GSE189642)
    setMethod(f = "step2", signature = c(x = "job_rms"), definition = function (x, 
        ...) 
    {
        .local <- function (x, B = 500, ...) 
        {
            step_message("rmda.")
            data <- x$res_lrm$data
            markers <- colnames(data)[colnames(data) != x$target]
            markers <- c(as.list(markers), list("nomogram"))
            data[[x$target]] <- .check_events_for_factor(data[[x$target]])
            nomogram <- plogis(predict(x$res_lrm$fit, type = "lp"))
            data <- dplyr::mutate(data, nomogram = !!nomogram)
            cli::cli_h1("rmda::decision_curve")
            dcas <- lapply(markers, function(marker) {
                rmda::decision_curve(as.formula(paste0(x$target, 
                    "~", marker)), data, study.design = "case", bootstrap = B, 
                    ...)
            })
            p.dcas <- funPlot(rmda::plot_decision_curve, list(x = dcas, 
                curve.names = unlist(markers), confidence.intervals = FALSE))
            p.dcas <- set_lab_legend(p.dcas, glue::glue("{x@sig} Decision curve analysis"), 
                glue::glue("决策曲线分析 (Decision curve analysis)|||DCA 用于评估不同模型在不同阈值下的净收益。横坐标为风险阈值，纵坐标为净获益率，平行于 x 轴的虚线 None 是不对任何人进行干预，抛物线形状的虚线 All 是对所有人进行干预，实线代表各指标的干预效果。"))
            x <- methodAdd(x, "以 R 包 `rmda` ⟦pkgInfo('rmda')⟧ 进行决策曲线分析 (Decision curve analysis，DCA) 并绘制 DCA 曲线。")
            x <- snapAdd(x, "DCA 分析{aref(p.dcas)}可知，Nomogram 在阈值范围内的净收益高于 All 和 None 策略，同时高于其他独立诊断因子，显示出其在预测中的潜在价值。")
            x <- plotsAdd(x, p.dcas)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(rms.GSE189642)
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

