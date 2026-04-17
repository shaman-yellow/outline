
.prepare_scissor_X_Y_network_KeepSparse <- function(
  bulk_dataset, sc_dataset, phenotype,
  family = c("binomial", "cox", "gaussian"),
  Save_file = "scissor_inputs.qs", save = TRUE, qs_nthreads = 5L, ...)
{
  family <- match.arg(family)
  common <- intersect(rownames(bulk_dataset), rownames(sc_dataset))
  if (!length(common)) {
    stop("There is no common genes between the given single-cell and bulk samples.")
  }
  if (is(sc_dataset, "Seurat")) {
    assay <- sc_dataset@assays$RNA
    if (is(assay, "Assay5")) {
      assay <- as(assay, "Assay")
    }
    message("Convert `RNA@data` as matrix...")
    sc_exprs <- as.matrix(assay@data)
    message("For `RNA_snn`, Improved the Scissor code to keep 'RNA_stnn' as sparse matrix!")
    network <- as(sc_dataset@graphs$RNA_snn, "sparseMatrix")
  } else {
    stop("...")
  }
  # the same effect in `Scissor`, but with sparse matrix
  Matrix::diag(network) <- 0
  network@x[ network@x != 0 ] <- 1
  dataset0 <- cbind(bulk_dataset[common, ], sc_exprs[common, ])
  dataset1 <- preprocessCore::normalize.quantiles(dataset0)
  rownames(dataset1) <- rownames(dataset0)
  colnames(dataset1) <- colnames(dataset0)
  Expression_bulk <- dataset1[, 1:ncol(bulk_dataset)]
  Expression_cell <- dataset1[, (ncol(bulk_dataset) + 1):ncol(dataset1)]
  cli::cli_alert_info("stats::cor")
  X <- cor(Expression_bulk, Expression_cell)
  quality_check <- quantile(X)
  message("Performing quality-check for the correlations")
  message("The five-number summary of correlations:")
  print(quality_check)
  if (quality_check[3] < 0.01) {
    warning("The median correlation between the single-cell and bulk samples is relatively low.")
  }
  if (family == "binomial") {
    Y <- as.numeric(phenotype)
  }
  if (family == "gaussian") {
    Y <- as.numeric(phenotype)
  }
  if (family == "cox") {
    Y <- as.matrix(phenotype)
    if (ncol(Y) != 2) {
      stop("The size of survival data is wrong. Please check Scissor inputs and selected regression type.")
    }
  }
  if (save) {
    .qsave_multi(X, Y, network, file = Save_file, nthreads = qs_nthreads)
  }
  return(list(X = X, Y = Y, network = network))
}

.run_scissor_with_X_Y_network_KeepSparse <- function(X, Y, network, 
  alpha, family, cutoff = .2)
{
  if (!is(network, "sparseMatrix")) {
    stop('!is(network, "sparseMatrix").')
  }
  set.seed(123L)
  require(Matrix)
  fun_name <- switch(
    family, "binomial" = "LogL0", "cox" = "CoxL0", "gaussian" = "LmL0"
  )
  fun_internal <- get(
    fun_name, envir = asNamespace("Scissor")
  )
  body(fun_internal) <- as.call(
    append(
      as.list(body(fun_internal)),
      # insert to repalce `diag` with `Matrix::diag`
      substitute(diag <- Matrix::diag),
      after = 1L
    )
  )
  replaceFunInPackage(fun_name, fun_internal, "Scissor")
  for (i in seq_along(alpha)) {
    cli::cli_alert_info("fit0: Scissor::APML1(...)")
    fit0 <- Scissor::APML1(
      X, Y, family = family, penalty = "Net",
      alpha = alpha[i], Omega = network, nlambda = 100, 
      nfolds = min(10L, nrow(X))
    )
    cli::cli_alert_info("fit1: Scissor::APML1(...)")
    fit1 <- Scissor::APML1(
      X, Y, family = family, penalty = "Net", 
      alpha = alpha[i], Omega = network, lambda = fit0$lambda.min
    )
    if (family == "binomial") {
      Coefs <- as.numeric(fit1$Beta[2:(ncol(X) + 1)])
    } else {
      Coefs <- as.numeric(fit1$Beta)
    }
    Cell1 <- colnames(X)[which(Coefs > 0)]
    Cell2 <- colnames(X)[which(Coefs < 0)]
    percentage <- (length(Cell1) + length(Cell2))/ncol(X)
    print(sprintf("alpha = %s", alpha[i]))
    print(sprintf("Scissor identified %d Scissor+ cells and %d Scissor- cells.", 
        length(Cell1), length(Cell2)))
    print(sprintf("The percentage of selected cell is: %s%%", 
        formatC(percentage * 100, format = "f", digits = 3)))
    if (percentage < cutoff) {
      break
    }
  }
  list(para = list(alpha = alpha[i], lambda = fit0$lambda.min, 
      family = family), Coefs = Coefs, Scissor_pos = Cell1, 
    Scissor_neg = Cell2, cell_num = length(Cell1) + length(Cell2))
}

replaceFunInPackage <- function(name, fun, package) {
  nameSpace <- asNamespace(package)
  unlockBinding(name, nameSpace)
  assign(name, fun, envir = nameSpace)
  lockBinding(name, nameSpace)
}

.qsave_multi <- function(..., file, nthreads = 5L) {
  objs <- list(...)
  nm <- as.character(substitute(list(...)))[-1]
  names(objs) <- nm
  qs::qsave(objs, file, nthreads = nthreads)
}

.qload_multi <- function(file, assign = FALSE, envir = parent.frame(), nthreads = 5L)
{
  objs <- qs::qread(file, nthreads = nthreads)
  if (assign) {
    list2env(objs, envir = envir)
    invisible()
  } else {
    objs
  }
}

