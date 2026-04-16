# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "14_immune")
if (!dir.exists(output)) {
  dir.create(output, recursive = TRUE)
}
setwd(ORIGINAL_DIR)

.libPaths(c('/data/nas2/software/miniconda3/envs/public_R/lib/R/library/', '/data/nas1/huanglichuang_OD/conda/envs/extra_pkgs/lib/R/library/'))

myPkg <- "./utils.tool"
if (!dir.exists(myPkg)) {
  stop('Can not found package: ', myPkg)
}
devtools::load_all(myPkg)
setup.huibang()

# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

lm.GSE16134 <- readRDS("./rds_jobSave/lm.GSE16134.3.rds")
fea.markers <- load_feature()

iobr.GSE16134 <- asjob_iobr(lm.GSE16134, source = "biomart")
iobr.GSE16134 <- step1(iobr.GSE16134, method = "ciber")

# the `map` in utils.tool will be covered by `purrr::map`
devtools::load_all(myPkg)

iobr.GSE16134 <- step2(iobr.GSE16134)
iobr.GSE16134 <- step3(iobr.GSE16134, fea.markers)
clear(iobr.GSE16134)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  iobr.GSE16134@plots$step2$p.boxplot
  notshow(iobr.GSE16134@tables$step2$t.groupCor)
  z7(iobr.GSE16134@plots$step2$p.cor, 1.1, 1.1)
  notshow(iobr.GSE16134@tables$step2$t.cells_cor)
  z7(iobr.GSE16134@plots$step3$p.GeneCellCor, 1, 1.2)
  notshow(iobr.GSE16134@tables$step3$t.geneCellCor)
  notshow(iobr.GSE16134@params$allres$cibersort)
})


