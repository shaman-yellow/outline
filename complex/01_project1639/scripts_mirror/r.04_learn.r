# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "04_learn")
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
vn.iua_arlnc1 <- readRDS("./rds_jobSave/vn.iua_arlnc1.1.rds")

ml.iua_arlnc1 <- asjob_mlearn(
  des.iua, feature(vn.iua_arlnc1), seed = 1324234
)
ml.iua_arlnc1 <- step1(ml.iua_arlnc1)
ml.iua_arlnc1 <- step2(ml.iua_arlnc1, seed = 987456L)
ml.iua_arlnc1 <- step3(ml.iua_arlnc1)
clear(ml.iua_arlnc1)

vn.learn <- asjob_venn(ml.iua_arlnc1)
vn.learn <- step1(vn.learn)
clear(vn.learn)
feature(vn.learn)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  ml.iua_arlnc1@plots$step1$p.svm
  feature(ml.iua_arlnc1)
  z7(ml.iua_arlnc1@plots$step2$p.lasso_cv, 1.2, 1.5)
  z7(ml.iua_arlnc1@plots$step2$p.coefs_path, 1.2, 1.5)
  ml.iua_arlnc1@plots$step3$p.error
  notshow(ml.iua_arlnc1@tables$step3$t.tops)
  vn.learn@plots$step1$p.venn
  feature(vn.learn)
})


