# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "06_reactome")
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

rt.GSE171213_Den_Epi <- asjob_reactome(srn.GSE171213_Den_Epi)
rt.GSE171213_Den_Epi <- step1(rt.GSE171213_Den_Epi)
rt.GSE171213_Den_Epi <- step2(rt.GSE171213_Den_Epi)
rt.GSE171213_Den_Epi <- step3(rt.GSE171213_Den_Epi, mode = "pathway")
clear(rt.GSE171213_Den_Epi)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
#' @meth {get_meth(rt.GSE171213_Den_Epi)}
  rt.GSE171213_Den_Epi@plots$step3$p.hps$pathways
  notshow(rt.GSE171213_Den_Epi@tables$step2$t.wilcox$pathways)
})


