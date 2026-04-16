# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "10_learn")
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
ven.GSE171213_candidates <- readRDS("./rds_jobSave/ven.GSE171213_candidates.1.rds")

ml.GSE171213_candidates <- asjob_mlearn(
  lm.GSE16134, feature(ven.GSE171213_candidates, snap = "候选关键基因")
)
ml.GSE171213_candidates <- step1(ml.GSE171213_candidates, skip = TRUE)
ml.GSE171213_candidates <- step2(ml.GSE171213_candidates)
ml.GSE171213_candidates <- step3(ml.GSE171213_candidates, top = 20)
ml.GSE171213_candidates <- step4(ml.GSE171213_candidates)

clear(ml.GSE171213_candidates)

ven.learn <- asjob_venn(ml.GSE171213_candidates)
ven.learn <- step1(ven.learn)
clear(ven.learn)
feature(ven.learn)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(ml.GSE171213_candidates@plots$step2$p.lasso_cv, 1.5, 1.5)
  z7(ml.GSE171213_candidates@plots$step2$p.coefs_path, 1.5, 1.5)
  ml.GSE171213_candidates@plots$step3$p.error
  ml.GSE171213_candidates@plots$step4$p.importance
  ml.GSE171213_candidates@plots$step4$p.auc
  notshow(ml.GSE171213_candidates@tables$step3$t.tops)
  feature(ml.GSE171213_candidates)
  ven.learn@plots$step1$p.venn
  feature(ven.learn)
})


