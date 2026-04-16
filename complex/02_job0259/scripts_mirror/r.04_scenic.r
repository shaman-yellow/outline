# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "04_scenic")
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

srn.GSE171213 <- qs::qread("rds_jobSave/srn.GSE171213.6.qs", nthreads = 5)
requireNamespace("Seurat")

sce.GSE171213 <- asjob_scenic(srn.GSE171213)
sce.GSE171213 <- step1(sce.GSE171213, 32)
sce.GSE171213 <- step2(sce.GSE171213, 3)
sce.GSE171213 <- step3(sce.GSE171213)
clear(sce.GSE171213)

srn.GSE171213_Den_Epi <- readRDS("./rds_jobSave/srn.GSE171213_Den_Epi.6.rds")

# sce.GSE171213@step <- 3L
sce.GSE171213 <- step4(sce.GSE171213, srn.GSE171213_Den_Epi, "Dental_Epithelial_Cell")
clear(sce.GSE171213)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(sce.GSE171213@plots$step4$p.hp, 7, 5)
  notshow(sce.GSE171213@tables$step4$diff_regulon)
  notshow(sce.GSE171213@params$meta_regulons)
})


