# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "07_immune")
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

des.iua <- readRDS("./rds_jobSave/des.iua.3.rds")
fea.markers <- as_feature(c("H1-4", "FXYD7"), ref = "生物标识物基因")

iobr.iua <- asjob_iobr(des.iua, source = "biomart")
iobr.iua <- step1(iobr.iua, method = "xcell")

# the `map` in utils.tool will be covered by `purrr::map`
devtools::load_all(myPkg)

iobr.iua <- step2(iobr.iua)
iobr.iua <- step3(iobr.iua, fea.markers)
clear(iobr.iua)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  iobr.iua@plots$step2$p.boxplot
  notshow(iobr.iua@tables$step2$t.groupCor)
  iobr.iua@plots$step2$p.cor
  notshow(iobr.iua@tables$step2$t.cells_cor)
  iobr.iua@plots$step3$p.GeneCellCor
  notshow(iobr.iua@tables$step3$t.geneCellCor)
  notshow(iobr.iua@params$allres$xcell)
})


