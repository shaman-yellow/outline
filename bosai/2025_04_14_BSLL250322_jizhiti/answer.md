
帮我翻译成合理的英文：

我对 `R.nvim` 的内部运行机制太不了解了。

我试着写了两个简单的函数用来补充我说的功能，但问题在于，我创建的补全文件会被 `R.nvim` 的某种机制给删除掉。
我不知道如何阻止，不知道 R.nvim 何处的代码涉及了维护相关的文件。
此外，我也不知道如何让我创建的补全文件可以立刻生效。
我目前看下来，似乎与 R.nvim 内部的 C 代码相关。我对 C 代码完全不熟悉。
你能提供一些帮助吗？

R package under specific circumstances

I don't really understand the inner workings of R.nvim.

I tried writing two simple functions to supplement the functionality I mentioned, but the problem is that the completion files I created are being deleted by some mechanism in R.nvim.
I don't know how to prevent this, nor do I know which part of R.nvim's code is involved in maintaining those files.
Additionally, I’m not sure how to make the completion files I created take effect immediately.

From what I’ve seen so far, it seems related to the C code inside R.nvim. I’m completely unfamiliar with C code.
Could you provide some help?

```R
#' Provide completion files for the specified R package.
#' 
#' Some R packages will not be provided with completion files by
#' `nvimcom` (R.nvim), such as R packages loaded using `devtools::load_all`.
#' This function provides additional completion.
#' However, it should be noted that the R package does not have an
#' Rd document, so it is currently not possible to obtain parameter
#' description for the completion.
#' 
#' @NOTE This function will generate an additional file saved in:
#' `file.path(Sys.getenv("RNVIM_COMPLDIR"), "extra_completion_packages.rds")`
#' 
#' @param pkgname The package name. 
build_completion_for_package <- function(pkgname) {
  allpkgs <- rownames(installed.packages())
  if (any(allpkgs == pkgname)) {
    stop(
      "The R package has already been installed and will be automatically ",
      "completed by nvimcom, so no additional completion is required."
    )
  }
  ns <- try(getNamespace(pkgname), TRUE)
  if (inherits(ns, "try-error")) {
    stop("There is no package named: ", pkgname)
  }
  bdir <- Sys.getenv("RNVIM_COMPLDIR")
  if (!dir.exists(bdir)) {
    stop("Unable to obtain a valid `RNVIM COMPDIR`.")
  }
  pvl <- as.character(packageVersion(pkgname))
  # rds.exPkgs <- file.path(bdir, "extra_completion_packages.rds")
  # if (file.exists(rds.exPkgs)) {
  #   exPkgs <- readRDS(rds.exPkgs)
  # } else {
  #   exPkgs <- NULL
  # }
  # if (!any(names(exPkgs) == pkgname)) {
  #   exr <- pvl
  #   names(exr) <- pkgname
  #   saveRDS(c(exPkgs, exr), rds.exPkgs)
  # }
  isFileExists <- function(file) {
    if (file.exists(file)) {
      message("File esits, update: ", file)
    }
    file
  }
  nvimcom:::nvim.bol(isFileExists(paste0(bdir, "/objls_", pkgname, "_", pvl)), pkgname)
  nvim.buildArgsWithoutDescription(isFileExists(paste0(bdir, "/args_", pkgname)), pkgname)
}

#' Build completion of augments without description
#' 
#' The R package does not have an Rd file. Therefore, the
#' completion does not involve the explanation of parameters.
#' 
#' @param afile The file to output.
#' @param pkg The package name.
nvim.buildArgsWithoutDescription <- function(afile, pkg) {
  envir <- asNamespace(pkg)
  sink(afile)
  all_objects <- ls(envir = envir)
  lapply(all_objects,
    function(name) {
      fun <- get(name, envir = envir)
      if (!is.function(fun)) {
        return(NULL)
      }
      args <- methods::formalArgs(fun)
      args <- paste0(
        paste0(args, "\x05", "`", args, "`: ", "..."), collapse = "\x06"
      )
      line <- paste0(name, "\x06", paste0(args, "\x06"))
      cat(line, sep = "", "\n")
    })
  sink()
  return(invisible(NULL))
}

```


