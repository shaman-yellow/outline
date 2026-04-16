# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "06_gsea")
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
fea.validated <- as_feature(c("H1-4", "FXYD7"), ref = "表达量验证基因")
fea.validated

corgsea.marker <- asjob_corgsea(des.iua, fea.validated)
corgsea.marker <- step1(corgsea.marker)
corgsea.marker@step <- 1L
corgsea.marker <- step2(corgsea.marker)
clear(corgsea.marker)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(corgsea.marker@plots$step2$p.codes$`H1-4`, 7, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$`H1-4`)
  wrap(corgsea.marker@plots$step2$p.codes$FXYD7, 7, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$FXYD7)
})


