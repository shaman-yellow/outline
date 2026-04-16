# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "08_nomogram")
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

rms.iua <- asjob_rms(des.iua, fea.markers)
rms.iua <- step1(rms.iua)
rms.iua <- step2(rms.iua)
clear(rms.iua)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  rms.iua@plots$step1$p.nomo
  notshow(rms.iua@params$res_lrm$data)
  rms.iua@plots$step1$p.rocs
  rms.iua@plots$step1$p.cal
  rms.iua@plots$step2$p.dcas
})


