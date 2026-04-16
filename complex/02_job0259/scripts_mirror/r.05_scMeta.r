# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "05_scMeta")
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

srn.GSE171213_Den_Epi <- readRDS("./rds_jobSave/srn.GSE171213_Den_Epi.6.rds")

srm.GSE171213_Den_Epi <- asjob_scMeta(srn.GSE171213_Den_Epi)
srm.GSE171213_Den_Epi <- step1(srm.GSE171213_Den_Epi)
clear(srm.GSE171213_Den_Epi)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srm.GSE171213_Den_Epi@plots$step1$p.hp
  notshow(srm.GSE171213_Den_Epi@tables$step1$t.wilcox)
})


