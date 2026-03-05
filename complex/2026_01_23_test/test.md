
I found a solution. First, the following two functions can create completion files for an R package:

(The functions generate a record file into: `file.path(Sys.getenv("RNVIM_COMPLDIR"), "extra_completion_packages.rds")`. This file is mainly used to prevent the generated completion files from being automatically deleted by R.nvim's internal mechanism.)


```r
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
  rds.exPkgs <- file.path(bdir, "extra_completion_packages.rds")
  if (file.exists(rds.exPkgs)) {
    exPkgs <- readRDS(rds.exPkgs)
  } else {
    exPkgs <- NULL
  }
  if (!any(names(exPkgs) == pkgname)) {
    exr <- pvl
    names(exr) <- pkgname
    saveRDS(c(exPkgs, exr), rds.exPkgs)
    message("Write RDS file: ", rds.exPkgs)
  }
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

Subsequently, it is necessary to modify the functions in `R.nvim/nvimcom/R/bol.R`:

```diff
diff --git a/nvimcom/R/bol.R b/nvimcom/R/bol.R
index 2139926..367de7d 100644
--- a/nvimcom/R/bol.R
+++ b/nvimcom/R/bol.R
@@ -605,6 +605,14 @@ nvim.build.cmplls <- function() {
 
     p <- merge(cp, ip, all = TRUE)
 
+    rds.exPkgs <- file.path(bdir, "extra_completion_packages.rds")
+    if (file.exists(rds.exPkgs)) {
+      exPkgs <- readRDS(rds.exPkgs)
+      if (length(exPkgs)) {
+        p <- p[!p$pkg %in% names(exPkgs), ]
+      }
+    }
+
     # Delete cache files of uninstalled packages
     u <- p[is.na(p$ivrs) & !is.na(p$cvrs), ]
     if (nrow(u) > 0) {
```

Indeed, this is a very niche requirement, and other users may not have this need.


