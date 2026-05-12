# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/04_job0395"
output <- file.path(ORIGINAL_DIR, "05_learn")
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

lm.GSE134347 <- qs::qread("./rds_jobSave/lm.GSE134347.3.qs")
ven.candidates <- readRDS("./rds_jobSave/ven.candidates.1.rds")

ml.candidates <- asjob_mlearn(
  lm.GSE134347, feature(ven.candidates)
)

ml.candidates <- step1(ml.candidates, seed = 63155L)
ml.candidates <- step2(ml.candidates, 10L, alpha = .7, seed = 31468L)
ml.candidates <- step3(ml.candidates, top = 20L, seed = 7914L)
clear(ml.candidates)

ven.learn <- asjob_venn(ml.candidates)
ven.learn <- step1(ven.learn)
clear(ven.learn)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  ml.candidates@plots$step1$p.svm
  feature(ml.candidates)
  z7(ml.candidates@plots$step2$p.lasso_cv, 1.2, 1.5)
  z7(ml.candidates@plots$step2$p.coefs_path, 1.2, 1.5)
  ml.candidates@plots$step3$p.error
  ml.candidates@plots$step3$p.tops
  notshow(ml.candidates@tables$step3$t.tops)
  ven.learn@plots$step1$p.venn
  feature(ven.learn)
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
    # ml.candidates <- asjob_mlearn(lm.GSE134347, feature(ven.candidates))
    setMethod(f = "asjob_mlearn", signature = c(x = "job_limma"), 
        definition = function (x, ...) 
        {
            .local <- function (x, ref, group = "group", levels = rev(.guess_compare_limma(x, 
                1L)), seed = 987456L) 
            {
                if (x@step < 1L) {
                    stop("x@step < 1L.")
                }
                object <- x$normed_data
                if (is.null(object)) {
                    stop("is.null(object).")
                }
                data <- object$E
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
                metadata <- data.frame(object$targets)
                levels <- eval(levels)
                project <- x$project
                x <- .job_mlearn(object = data)
                x$project <- project
                x$metadata <- metadata
                x$levels <- levels
                x$target <- factor(metadata[[group]], levels = levels)
                x$seed <- seed
                return(x)
            }
            .local(x, ...)
        })
    
    
    # ml.candidates <- step1(ml.candidates, seed = 63155L)
    setMethod(f = "step1", signature = c(x = "job_mlearn"), definition = function (x, 
        ...) 
    {
        .local <- function (x, subset_sizes = 15:50, n = 10, method = "cv", 
            kernel = "linear", seed = x$seed, workers = NULL, ..., 
            rerun = FALSE, skip = FALSE) 
        {
            step_message("SVM-RFE.")
            if (skip) {
                return(x)
            }
            data <- object(x)
            target <- x$target
            args <- as.list(environment())
            args$rerun <- args$x <- NULL
            dir.create("tmp", FALSE)
            svm_rfe <- expect_local_data("tmp", "svm_rfe", .run_svm_rfe, 
                args, rerun = rerun)
            x$svm_rfe <- svm_rfe
            p.svm <- caret:::ggplot.rfe(svm_rfe) + lims(x = range(subset_sizes)) + 
                theme_classic()
            p.svm <- set_lab_legend(wrap(p.svm, 5.5, 4), glue::glue("{x@sig} SVM-RFE candidate subset sizes evaluation"), 
                glue::glue("SVM-RFE候选子集正确率曲线|||{n}折交叉验证准确率（{n}x CV Accuracy）随特征数量变化的趋势。"))
            svm_rfe_res <- list(best_size = svm_rfe$bestSubset, features = caret::predictors(svm_rfe))
            x$svm_rfe_res <- svm_rfe_res
            x$t.svm_rfe_accuracy <- dplyr::arrange(as_tibble(svm_rfe$results), 
                dplyr::desc(Accuracy))
            x <- plotsAdd(x, p.svm)
            x <- methodAdd(x, "以 R 包 `e1071` ⟦pkgInfo('e1071')⟧ 构建支持向量机递归特征消除模型 (SVM-RFE)。核函数设定为线性核 (kernel = {kernel}) ；以 R 包 `caret` ⟦pkgInfo('caret')⟧ 实现递归特征消除流程，采用 {n} 折交叉验证评估模型分类性能，依据分类准确率 (Accuracy) 从高到低排序筛选最优特征基因子集。")
            x <- snapAdd(x, "SVM-RFE 最佳子集数为 {svm_rfe_res$best_size}{aref(p.svm)}，准确率 (Accuracy) 为 {round(x$t.svm_rfe_accuracy$Accuracy[1], 3)}，误差值 (AccuracySD) 为 {round(x$t.svm_rfe_accuracy$AccuracySD[1], 3)}，对应 feature 为：{bind(svm_rfe_res$features)}。\n\n\n\n")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ml.candidates <- step2(ml.candidates, 10L, alpha = 0.7, seed = 31468L)
    setMethod(f = "step2", signature = c(x = "job_mlearn"), definition = function (x, 
        ...) 
    {
        .local <- function (x, n = 10, lambda.type = c("1se", "min"), 
            alpha = 1, seed = x$seed, ...) 
        {
            step_message("Lasso")
            lambda.type <- match.arg(lambda.type)
            lambda.type <- paste0("lambda.", lambda.type)
            data <- object(x)
            target <- x$target
            set.seed(seed)
            cv_lasso <- e(glmnet::cv.glmnet(x = data, y = target, 
                family = "binomial", alpha = alpha, nfolds = n, standardize = TRUE, 
                parallel = FALSE))
            lambda <- cv_lasso[[lambda.type]]
            coefs <- coef(cv_lasso, s = lambda)
            coefs_matrix <- as.matrix(coefs)
            whichCoefs <- which(coefs_matrix[, 1] != 0 & rownames(coefs_matrix) != 
                "(Intercept)")
            selected <- rownames(coefs_matrix)[whichCoefs]
            x$lasso_res <- list(cv_lasso = cv_lasso, coefs = coefs_matrix, 
                features = selected, type = lambda.type)
            expr <- expression({
                fun <- function() {
                    cv <- cv_lasso
                    requireNamespace("glmnet")
                    suffix <- c("1se", "min")
                    types <- paste0("lambda.", suffix)
                    y <- max(cv$cvm)
                    lambdas <- vapply(types, function(x) cv[[x]], 
                      double(1))
                    x <- log(lambdas)
                    labels <- glue::glue("log(λ) ({suffix})\n = {signif(log(lambdas), 2)}")
                    plot(cv, sign.lambda = 1)
                    text(x, y, labels, adj = 1)
                }
                fun()
            })
            p.lasso_cv <- as_grob(expr, environment())
            p.lasso_cv <- set_lab_legend(wrap(p.lasso_cv, 5.5, 4, 
                showtext = TRUE), glue::glue("{x@sig} LASSO Cross Validation"), 
                glue::glue("LASSO 交叉验证误差|||Lasso 回归模型的交叉验证图，用于选择正则化参数 λ。图中展示了不同 λ 值下的二项式偏差（Binomial Deviance）。横坐标是log(λ)，即正则化参数 λ 的对数值。随着 λ 值的增加，模型的复杂度降低，正则化强度增加。纵坐标是二项式偏差。"))
            expr <- expression({
                fun <- function() {
                    cv <- cv_lasso
                    requireNamespace("glmnet")
                    suffix <- c("1se", "min")
                    types <- paste0("lambda.", suffix)
                    lambdas <- vapply(types, function(x) cv[[x]], 
                      double(1))
                    x <- log(lambdas)
                    if (any(formalArgs(glmnet:::plot.glmnet) == "sign.lambda")) {
                      plot(cv$glmnet.fit, sign.lambda = 1, label = FALSE, 
                        xvar = "lambda")
                    } else {
                      plot(cv$glmnet.fit, label = FALSE, xvar = "lambda")
                    }
                    abline(v = x, lty = 2)
                    labels <- glue::glue("log(λ) ({suffix})\n = {signif(log(lambdas), 2)}")
                    text(x, par("usr")[4] * 0.7, labels, adj = 1)
                }
                fun()
            })
            p.coefs_path <- as_grob(expr, environment())
            p.coefs_path <- set_lab_legend(wrap(p.coefs_path, 5.5, 
                4, showtext = TRUE), glue::glue("{x@sig} Lasso Coefficient path"), 
                glue::glue("LASSO 系数路径|||Lasso 回归系数路径图，展示了不同特征的系数随正则化参数 log(λ) 变化的情况。横坐标是 log(λ)，纵坐标是模型中各个特征的系数值。随着 λ 值的增加（从右到左），更多的特征系数被压缩至零，这是Lasso回归的特征选择过程。"))
            x <- plotsAdd(x, p.lasso_cv, p.coefs_path)
            prin <- if (lambda.type == "lambda.1se") 
                "1-SE"
            else "最小误差"
            if (alpha == 1) {
                x <- methodAdd(x, "以 R 包 glmnet ⟦pkgInfo('glmnet')⟧ 开展 LASSO 逻辑回归分析。设置 α = 1 实现 L1 正则化，通过 {n} 折交叉验证结合{prin}准则确定最优 λ 值。")
            }
            else if (alpha < 1) {
                x <- methodAdd(x, "以 R 包 glmnet ⟦pkgInfo('glmnet')⟧ 开展 LASSO (Elastic Net) 回归分析。设置 α = {alpha} 实现 L1 与 L2 正则化的加权组合，通过 {n} 折交叉验证结合{prin}准则确定最优 λ 值。")
            }
            else {
                stop("alpha?")
            }
            x <- snapAdd(x, "LASSO 筛选的核心 feature（非零系数）数量为 {length(selected)}{aref(p.lasso_cv)}，对应为：{bind(selected)}。\n\n\n\n")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # ml.candidates <- step3(ml.candidates, top = 20L, seed = 7914L)
    setMethod(f = "step3", signature = c(x = "job_mlearn"), definition = function (x, 
        ...) 
    {
        .local <- function (x, ntree = 1000, top = 10, seed = x$seed, 
            ...) 
        {
            step_message("Random Forest.")
            data <- object(x)
            target <- x$target
            mtry = floor(sqrt(ncol(data)))
            set.seed(seed)
            rf_model <- e(randomForest::randomForest(x = data, y = target, 
                ntree = ntree, mtry = mtry, importance = TRUE, proximity = FALSE, 
                oob.prox = FALSE, keep.forest = TRUE))
            error_data <- as_tibble(rf_model$err.rate)
            error_data <- dplyr::mutate(error_data, trees = seq_len(nrow(error_data)))
            error_data <- tidyr::pivot_longer(error_data, -trees, 
                names_to = "Error_Type", values_to = "Error_Rate")
            p.error <- ggplot(error_data, aes(x = trees, y = Error_Rate, 
                color = Error_Type)) + geom_line() + labs(x = "Number of trees", 
                y = "Error Rate") + theme_minimal() + theme(legend.title = element_blank())
            p.error <- set_lab_legend(wrap(p.error, 5, 3), glue::glue("{x@sig} Trend of random forest error rate"), 
                glue::glue("随机森林误差率随树数量变化趋势图|||在训练过程中模型对不同组别识别的错误概。OOB 为总体袋外误差（OOB error），即所有类别的平均误差率。随着树的数量增加，总体误差率逐渐趋于稳定。"))
            importance_df <- as_tibble(randomForest::importance(rf_model), 
                idcol = "feature")
            importance_df <- dplyr::arrange(importance_df, dplyr::desc(MeanDecreaseGini))
            t.tops <- head(importance_df, top)
            t.tops <- set_lab_legend(t.tops, glue::glue("{x@sig} top importance feature"), 
                glue::glue("按 MeanDecreaseGini 降低排序的Top Feature。"))
            x$rf_res <- list(rf_model = rf_model, features = t.tops$feature)
            x <- tablesAdd(x, t.tops)
            x <- plotsAdd(x, p.error)
            x <- methodAdd(x, "以 R 包 `randomForest` ⟦pkgInfo('randomForest')⟧ 构建随机森林分类模型，设定决策树数量（ntree）为 {ntree}，特征选择数 (mtry) 为基因总数的平方根，通过袋外数据 (OOB) 评估模型误差率，计算 Feature 重要性评分，筛选相对重要性 top {top}；同时分析分类树数量与误差率的关联趋势，确定模型最优复杂度。")
            x <- snapAdd(x, "随机森林特征重要性 Top {top} 基因 (PMID: 37065165; PMID: 16398926; PMID: 41243474)：{bind(t.tops$feature)}{aref(p.error)}。\n\n\n\n")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(ml.candidates)
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
    
    
    # ven.learn <- asjob_venn(ml.candidates)
    setMethod(f = "asjob_venn", signature = c(x = "job_mlearn"), 
        definition = function (x, ...) 
        {
            .local <- function (x) 
            {
                job_venn(lst = feature(x), mode = "ck")
            }
            .local(x, ...)
        })
    
    
    # ven.learn <- step1(ven.learn)
    setMethod(f = "step1", signature = c(x = "job_venn"), definition = function (x, 
        ...) 
    {
        step_message("Intersection.")
        p.venn <- new_venn(lst = object(x), force_upset = FALSE, 
            ...)
        p.venn <- set_lab_legend(p.venn, glue::glue("{x@sig} intersection of {bind(names(object(x)), co = ' with ')}"), 
            glue::glue("{bind(names(object(x)))} 交集维恩图|||不同颜色圆圈代表不同数据集，中间重叠部分表示同时存在多个集合中。图中 {length(p.venn$ins)} 交集为：{less(p.venn$ins, 20)}。"))
        x$.append_heading <- FALSE
        if (identical(parent.frame(1), .GlobalEnv)) {
            job_append_heading(x, heading = glue::glue("汇总: ", 
                bind(names(object(x)), co = " + ")))
        }
        if (length(p.venn$ins) < 10) {
            iter <- glue::glue(" ({bind(p.venn$ins)}) ")
        }
        else {
            iter <- ""
        }
        x <- snapAdd(x, "对{bind(names(object(x)))} 取交集，得到{length(p.venn$ins)}个交集{iter}{aref(p.venn)}。")
        x <- plotsAdd(x, p.venn)
        if (!is.null(x$analysis)) {
            feature(x) <- as_feature(p.venn$ins, x$analysis, nature = x$nature, 
                ...)
        }
        else {
            x$.feature <- as_feature(p.venn$ins, x, nature = x$nature, 
                ...)
        }
        return(x)
    })
    
    
    # clear(ven.learn)
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

