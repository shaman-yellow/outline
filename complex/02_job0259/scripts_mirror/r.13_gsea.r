# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "13_gsea")
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
fea.markers

corgsea.marker <- asjob_corgsea(lm.GSE16134, fea.markers)
corgsea.marker <- step1(corgsea.marker)
corgsea.marker <- step2(corgsea.marker)
clear(corgsea.marker)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(corgsea.marker@plots$step2$p.codes$C3, 7, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$C3)
  wrap(corgsea.marker@plots$step2$p.codes$CYP24A1, 7, 7)
  notshow(corgsea.marker@tables$step1$table_gsea$CYP24A1)
})


