# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "02_scissor")
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

geo.GSE189642 <- job_geo("GSE189642")
geo.GSE189642 <- step1(geo.GSE189642)
geo.GSE189642 <- step2(geo.GSE189642)
clear(geo.GSE189642)

metadata.GSE189642 <- expect(geo.GSE189642, geo_cols(group = "group.ch1"))
metadata.GSE189642 <- dplyr::mutate(
  metadata.GSE189642, group = paste0("IBL_", group)
)

des.GSE189642 <- asjob_deseq2(geo.GSE189642, metadata.GSE189642)
des.GSE189642 <- step1(des.GSE189642)
des.GSE189642 <- step2(des.GSE189642, IBL_High - IBL_Low)
des.GSE189642 <- step3(des.GSE189642)
clear(des.GSE189642)

srn.GSE150825 <- qs::qread("./rds_jobSave/srn.GSE150825.6.qs")

ssr.GSE150825 <- do_scissor(srn.GSE150825, des.GSE189642)
ssr.GSE150825 <- step1(ssr.GSE150825, "small")
ssr.GSE150825 <- step2(ssr.GSE150825, c(5e-3, 5e-4), k = 8, workers = 8)
ssr.GSE150825 <- step3(ssr.GSE150825)
Sys.time()

clear(ssr.GSE150825, FALSE)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

