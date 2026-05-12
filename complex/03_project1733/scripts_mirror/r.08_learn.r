# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "08_learn")
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
des.GSE189642 <- readRDS("./rds_jobSave/des.GSE189642.3.rds")

ml.train <- asjob_mlearn(
  des.GSE189642, feature(ven.candidates)
)

ml10.train <- asjob_mlearn10(ml.train)
ml10.train <- step1(
  ml10.train, 5L, exclude = c("XGBoost", "GBM", "RF", "BT"), sizes = 4:8
)
ml10.train <- step2(ml10.train)
ml10.train <- step3(ml10.train)
clear(ml10.train)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  ml10.train@plots$step1$p.rfe_imp
  notshow(ml10.train@plots$step1$p.rfe_kappa)
  notshow(ml10.train@plots$step1$p.rfe_acc)
  feature(ml10.train, "rfe")
  ml10.train@plots$step1$p.rocs
  ml10.train@plots$step1$p.confusions
  ml10.train@plots$step1$p.evaluation
  notshow(ml10.train@params$res_roc$summary)
  notshow(ml10.train@params$res_evaluation$summary)
  ml10.train@plots$step2$p.score
})

#| OVERTURE
output_with_counting_number({
  ml10.train@plots$step3$p.importance
  ml10.train@plots$step3$p.summary
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
    # ml.train <- asjob_mlearn(des.GSE189642, feature(ven.candidates))
    setMethod(f = "asjob_mlearn", signature = c(x = "job_deseq2"), 
        definition = function (x, ...) 
        {
            .local <- function (x, ref, group = "group", levels = rev(.guess_compare_deseq2(x, 
                1L)), seed = 987456L) 
            {
                if (x@step < 1L) {
                    stop("x@step < 1L.")
                }
                object <- x$vst
                if (is.null(object)) {
                    stop("is.null(object).")
                }
                data <- SummarizedExperiment::assay(object)
                if (is(ref, "feature")) {
                    snap <- snap(ref)
                    ref <- resolve_feature(ref)
                    if (length(ref) <= 2) {
                      stop("length(ref) <= 2, too few genes.")
                    }
                    snapAdd_onExit("x", "以 {x$project} 为训练集，将{snap}用于机器学习筛选关键基因。")
                }
                if (any(!ref %in% rownames(data))) {
                    stop("any(!ref %in% rownames(data)).")
                }
                data <- t(data[rownames(data) %in% ref, ])
                metadata <- data.frame(object@colData)
                levels <- eval(levels)
                project <- x$project
                x <- .job_mlearn(object = data)
                x$metadata <- metadata
                x$project <- project
                x$levels <- levels
                x$target <- factor(metadata[[group]], levels = levels)
                x$seed <- seed
                return(x)
            }
            .local(x, ...)
        })
    
    
    # ml10.train <- asjob_mlearn10(ml.train)
    setMethod(f = "asjob_mlearn10", signature = c(x = "job_mlearn"), 
        definition = function (x, ...) 
        {
            .job_mlearn10(copy_job(x))
        })
    
    
    # ml10.train <- step1(ml10.train, 5L, exclude = c("XGBoost", "GBM", 
    #     "RF", "BT"), sizes = 4:8)
    setMethod(f = "step1", signature = c(x = "job_mlearn10"), definition = function (x, 
        ...) 
    {
        .local <- function (x, n = 10L, nthread = 1L, validate = NULL, 
            use_rfe = TRUE, nkeep = 10L, debug = FALSE, repeats = 10L, 
            exclude = c("XGBoost"), sizes = NULL) 
        {
            step_message("Run caret")
            if (!is.null(validate)) {
                if (!is(validate, "job_mlearn10") && !is(validate, 
                    "job_mlearn")) {
                    stop("Not valid input of validation dataset.")
                }
            }
            x <- methodAdd(x, "采用多种机器学习算法，从候选基因集中筛选关键基因。")
            if (!debug) {
                res_ml_train10 <- x$res_ml_train10 <- run_ml_train10(object(x), 
                    x$target, x$levels[2], cv_folds = n, nthread = nthread, 
                    seed = x$seed, use_rfe = use_rfe, repeats = repeats, 
                    exclude = exclude, rfe_sizes = sizes)
            }
            else {
                res_ml_train10 <- x$res_ml_train10
            }
            if (use_rfe) {
                x <- methodAdd(x, "在机器学习模型构建前，为减少冗余特征、降低过拟合风险并提升模型稳定性，本研究采用递归特征消除法（recursive feature elimination，RFE）进行变量筛选。RFE 通过迭代训练模型并依据变量贡献度逐步剔除低重要性特征，从而获得最优特征子集。针对不同分类算法，分别调用对应的特征筛选函数进行独立分析，包括随机森林（RF）、逻辑回归（LR）、决策树（DT）、朴素贝叶斯（NB）及线性判别分析（LDA）等模型。最终选择交叉验证表现最佳的特征组合用于后续模型训练与验证。")
                t.rfe_imp <- .get_rfe_importance_ml_train10(res_ml_train10)
                t.rfe_imp <- set_lab_legend(t.rfe_imp, glue::glue("{x@sig} rfe feature importance"), 
                    glue::glue("RFE feature 重要性数据"))
                x <- tablesAdd(x, t.rfe_imp)
                layout <- wrap_layout(NULL, length(res_ml_train10$models))
                p.rfe_imp <- .plot_importance_ml_train10(t.rfe_imp, 
                    ncol = layout$ncol)
                p.rfe_imp <- set_lab_legend(add(layout, p.rfe_imp), 
                    glue::glue("{x@sig} RFE feature importance"), 
                    glue::glue("RFE 特征重要性|||每个分面（facet）代表一种独立的建模算法，不同颜色对应不同算法类别。横坐标表示特征名称，纵坐标表示平均特征重要性（Average Importance），数值越高说明该变量在模型判别过程中贡献越大。柱状图长度反映特征的重要性强弱，并按照重要性从高到低排序显示。"))
                t.rfe_perf <- .get_rfe_performance_ml_train10(res_ml_train10)
                t.rfe_perf <- set_lab_legend(t.rfe_perf, glue::glue("{x@sig} rfe performance"), 
                    glue::glue("RFE 性能数据"))
                lst_rfe_perf <- .plot_rfe_performance_ml_train10(t.rfe_perf, 
                    ncol = layout$ncol)
                p.rfe_kappa <- lst_rfe_perf$p.kappa
                p.rfe_kappa <- set_lab_legend(add(layout, p.rfe_kappa), 
                    glue::glue("{x@sig} RFE performance Kappa curve"), 
                    glue::glue("Kappa 值随特征数量变化曲线|||代表随着输入特征数量变化所对应的交叉验证 Kappa 系数。每个分面代表一种独立建模算法。横坐标表示纳入模型的特征数量（Number of Variables），纵坐标表示交叉验证 Kappa 值（Cross-validated Kappa）。折线及散点表示不同特征子集下模型的平均 Kappa 值，误差线表示标准差（SD）。红色虚线表示该模型达到最佳分类一致性时对应的最优特征数量。Kappa 系数综合考虑随机一致性的影响，可更客观评估模型预测结果与真实分类之间的一致程度。该图可用于辅助判断模型在不同特征维度下的稳健性，尤其适用于类别分布不均衡数据的性能评估。"))
                p.rfe_acc <- lst_rfe_perf$p.acc
                p.rfe_acc <- set_lab_legend(add(layout, p.rfe_acc), 
                    glue::glue("{x@sig} RFE performance accuracy curve"), 
                    glue::glue("准确率随特征数量变化曲线|||各机器学习模型在递归特征消除（recursive feature elimination，RFE）过程中，随着输入特征数量变化所对应的交叉验证准确率（Accuracy）表现。每个分面代表一种独立建模算法。横坐标表示纳入模型的特征数量（Number of Variables），纵坐标表示交叉验证准确率（Cross-validated Accuracy）。折线及散点表示不同特征子集下模型的平均分类准确率，误差线表示标准差（SD），用于反映模型在重复验证中的稳定性。红色虚线表示该模型获得最高准确率时对应的最优特征数量。"))
                x <- plotsAdd(x, p.rfe_imp, p.rfe_kappa, p.rfe_acc)
            }
            x <- methodAdd(x, "为提高模型评估的稳定性并减少由于样本划分带来的随机性影响，本研究采用重复k折交叉验证（repeated k-fold cross-validation）进行模型性能评估。具体而言，数据集被随机划分为 k 个互斥子集，每次选择其中一个子集作为验证集，其余作为训练集，完成一次 k 折交叉验证。该过程在不同随机划分下重复进行 n 次（repeats, n = {repeats}），最终模型性能取所有重复实验结果的平均值。该方法能够有效降低单次数据划分带来的偏差，尤其适用于小样本数据集的模型评估。")
            text_methods <- .description_ml_train10(object(x), cv_folds = n, 
                mlt10 = res_ml_train10)
            text_methods <- paste0(seq_along(text_methods), ". ", 
                text_methods)
            x <- methodAdd(x, paste0("\n\n\n", bind(text_methods, 
                co = "\n\n\n"), "\n\n\n"))
            if (is.null(validate)) {
                res_ml_train10$is_external_data <- FALSE
                x <- methodAdd(x, "对各模型以混淆矩阵、ROC 以及预测性能评估。")
            }
            else {
                Class <- res_ml_train10$data$Class
                inputs_validate <- .as_input_for_ml_train10(object(validate), 
                    validate$target, validate$levels[2])
                res_ml_train10$data <- inputs_validate$dat
                res_ml_train10$data$Class <- map_factor(res_ml_train10$data$Class, 
                    Class)
                res_ml_train10$is_external_data <- TRUE
                x$validate_ml_train10 <- res_ml_train10
                x$validate_ml_train10$project <- validate$project
                x <- methodAdd(x, "以 ⟦mark$blue('{validate$project}')⟧ 作为外部验证集，对各模型以混淆矩阵和 ROC 评估。")
            }
            x$res_evaluation <- .evaluation_ml_train10(res_ml_train10)
            x$res_roc <- .roc_ml_train10(res_ml_train10)
            p.rocs <- .plot_roc_ml_train10(x$res_roc)
            p.rocs <- set_lab_legend(wrap(p.rocs, 7, 6.5), glue::glue("{x@sig} ROC evaluation of models"), 
                glue::glue("各模型 ROC|||受试者工作特征曲线（ROC）评价各模型对高负荷组与低负荷组样本的区分能力。横坐标表示假阳性率（False Positive Rate, FPR），纵坐标表示真阳性率（True Positive Rate, TPR）。对角虚线表示随机分类水平（AUC = 0.5）。不同颜色曲线代表不同模型，曲线越接近左上角表示模型分类性能越优，曲线下面积（Area Under the Curve, AUC）越大说明模型判别能力越强。"))
            layout <- wrap_layout(NULL, length(res_ml_train10$models))
            p.confusions <- .plot_confusion_ml_train10(x$res_evaluation, 
                ncol = layout$ncol)
            p.confusions <- set_lab_legend(add(layout, p.confusions), 
                glue::glue("{x@sig} confusion matrix of models"), 
                glue::glue("各模型混淆矩阵|||子图对应一种模型，横坐标表示真实类别（Reference），纵坐标表示预测类别（Prediction）。颜色深浅代表该单元格中的样本数量，颜色越深表示数量越多。矩阵左上角与右下角分别表示正确分类的阴性样本和阳性样本，右上角与左下角表示误分类样本。混淆矩阵可直观反映模型的分类准确率、敏感性及特异性，用于综合比较不同模型的预测性能。"))
            layout <- wrap_layout(NULL, 5L)
            p.evaluation <- .plot_evaluation_ml_train10(x$res_evaluation, 
                ncol = layout$ncol)
            p.evaluation <- set_lab_legend(add(layout, p.evaluation), 
                glue::glue("{x@sig} prediction comprehensive comparison"), 
                glue::glue("机器学习模型分类性能指标综合比较图|||每个分面代表一种评价指标，包括准确率（Accuracy）、Kappa 系数（Kappa）、灵敏度（Sensitivity）、特异度（Specificity）及 F1 值（F1-score）。横坐标为模型名称，纵坐标为对应指标得分，柱状图高度表示模型在该指标上的性能水平，图中数字为具体数值。其中，Accuracy 反映总体预测正确率；Kappa 用于评价模型预测结果与真实分类的一致性，并校正随机因素影响；Sensitivity 表示识别阳性样本的能力；Specificity 表示识别阴性样本的能力；F1-score 为精确率与召回率的综合指标，适用于类别不平衡数据的评估。数值越高通常表示模型表现越优。图中出现 “NA” 表示该指标在当前预测结果下无法计算，提示模型可能存在类别预测失衡或判别能力不足。"))
            x <- plotsAdd(x, p.rocs, p.confusions, p.evaluation)
            x$.feature_rfe <- as_feature(res_ml_train10$feature_rfe, 
                "RFE 筛选后用于各模型训练的基因")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ml10.train <- step2(ml10.train)
    setMethod(f = "step2", signature = c(x = "job_mlearn10"), definition = function (x, 
        ...) 
    {
        .local <- function (x, which = 1L) 
        {
            step_message("Select best model.")
            x <- snapAdd(x, "为客观筛选综合性能最优的机器学习模型，本研究结合判别能力与分类表现，对各候选模型进行多指标综合评价。首先整合受试者工作特征曲线下面积（area under the curve，AUC）、准确率（Accuracy）、Kappa 系数（Kappa）及 F1-score 等指标。随后构建加权综合评分体系：AUC、Kappa、F1-score 与 Accuracy 分别赋予 0.40、0.25、0.20 和 0.15 的权重，以突出模型判别能力与稳定性的重要性。对于个别模型无法计算的指标（NA 值），按 0 处理，以避免高估其性能。最终依据综合得分对所有模型进行降序排序，选择得分最高者作为最优预测模型，并用于后续诊断效能验证及关键特征解析。")
            lst_best <- .select_best_model_ml_train10(x$res_roc, 
                x$res_evaluation)
            p.score <- .plot_best_model_score_ml_train10(lst_best$summary)
            p.score <- set_lab_legend(wrap_scale(p.score, 12, nrow(lst_best$summary), 
                h.size = 0.15), glue::glue("{x@sig} comprehensive score evaluation cross models"), 
                glue::glue("各模型综合评分|||综合评分由受试者工作特征曲线下面积（AUC）、准确率（Accuracy）、Kappa 系数（Kappa）及 F1-score 加权计算获得。"))
            x <- plotsAdd(x, p.score)
            dat <- lst_best$summary[which, , drop = FALSE]
            fea <- feature(x, "rfe")[[dat$Model]]
            x$.feature_best <- as_feature(fea@.Data, "Features of Best Model")
            x <- snapAdd(x, "基于多指标综合评分体系对各机器学习模型进行排序后{aref(p.score)}，⟦mark$red('{dat$Model} 模型获得最高综合得分（Score = {round(dat$Score, 3)}），被确定为最优预测模型')⟧。该模型的受试者工作特征曲线下面积（AUC）为 {round(dat$AUC, 3)}，准确率（Accuracy）为 {round(dat$Accuracy, 3)}，Kappa 系数为 {round(dat$Kappa, 3)}，F1-score 为 {round(dat$F1, 3)}。对应特征基因为: {bind(fea)}。")
            x$comprehensive_summary <- lst_best$summary
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ml10.train <- step3(ml10.train)
    setMethod(f = "step3", signature = c(x = "job_mlearn10"), definition = function (x, 
        ...) 
    {
        .local <- function (x, use = c("validate", "train"), model = x$comprehensive_summary$Model[1]) 
        {
            use <- match.arg(use)
            dalex_explain <- .generate_dalex_explain_ml_train10(x$res_ml_train10, 
                model)
            x <- snapAdd(x, "为进一步解释最优机器学习模型的预测机制并识别关键特征基因，在模型构建完成后进行 SHAP（Shapley Additive Explanations）分析。SHAP 基于博弈论思想，通过计算各特征对单一样本预测结果的边际贡献值，量化变量对模型输出的影响方向与作用强度。")
            line <- .get_description("shap.md")
            x <- snapAdd(x, "{line}")
            x <- snapAdd(x, "本研究采用训练完成的最优分类模型，计算各候选基因在全部样本中的 SHAP 值，并进一步汇总平均绝对 SHAP 值评估全局特征重要性，同时结合样本层面的 SHAP 分布展示不同基因在个体预测中的贡献差异。\n\n")
            if (use == "validate" && !is.null(x$validate_ml_train10)) {
                lst <- .as_input_for_dalex_explain_ml_train10(x$res_ml_train10, 
                    model, data = x$validate_ml_train10$data)
                data <- lst$data
                x <- snapAdd(x, "以外部验证集 {x$validate_ml_train10$project} 作为评估数据，以 R 包 `DALEX` ⟦pkgInfo('DALEX')⟧ 使用 SHAP 方法来解释模型的预测结果。")
            }
            else {
                data <- dalex_explain$data
                x <- snapAdd(x, "以 R 包 `DALEX` ⟦pkgInfo('DALEX')⟧ 使用 SHAP 方法对数据集 {x$project} 来解释模型的预测结果。")
            }
            lst_shap <- .shap_analysis_dalex_explain(dalex_explain, 
                data)
            ps.shap <- .plot_shap_analysis(lst_shap)
            p.importance <- ps.shap$p.importance
            p.importance <- set_lab_legend(wrap_scale(p.importance, 
                12, ncol(data), h.size = 0.2), glue::glue("{x@sig} Global SHAP Feature Importance"), 
                glue::glue("全局 SHAP 特征重要性条形图|||各变量平均绝对 SHAP 值（Mean |SHAP value|），反映该特征在全部样本中的总体影响强度。SHAP 绝对值越大，说明该变量对模型预测结果贡献越大，重要性越高"))
            p.summary <- ps.shap$p.summary
            p.summary <- set_lab_legend(wrap_scale(p.summary, 12, 
                ncol(data), h.size = 0.2), glue::glue("{x@sig} SHAP Summary Distribution"), 
                glue::glue("SHAP 分布汇总图|||每个样本中各特征对应的 SHAP 值分布情况。横坐标为 SHAP 值，纵坐标为特征名称，每个散点代表一个样本在该特征上的贡献值。SHAP 值大于 0 表示该特征推动模型预测趋向目标类别（阳性组/疾病组），SHAP 值小于 0 表示推动预测趋向对照类别（阴性组/正常组）；绝对值越大，影响越强。"))
            snap <- .stat_shap_analysis(lst_shap, p.importance, p.summary)
            x <- snapAdd(x, "{snap}")
            x <- plotsAdd(x, p.importance, p.summary)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(ml10.train)
    setMethod(f = "clear", signature = c(x = "job_mlearn10"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ..., name = substitute(x, parent.frame(1))) 
        {
            eval(name)
            x <- callNextMethod(x, ..., name = name, expr_lite = expression({
                x$res_ml_train10$models <- NULL
            }))
            return(x)
        }
        .local(x, ...)
    })
    
    
}

