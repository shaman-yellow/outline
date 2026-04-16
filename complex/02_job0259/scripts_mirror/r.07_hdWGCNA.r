# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "07_hdWGCNA")
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

srn.GSE171213_Den_Epi <- readRDS(
  "./rds_jobSave/srn.GSE171213_Den_Epi.6.rds"
)

hdw.GSE171213_Den_Epi <- asjob_hdwgcna(srn.GSE171213_Den_Epi)

hdw.GSE171213_Den_Epi <- step1(hdw.GSE171213_Den_Epi, auto = TRUE)

hdw.GSE171213_Den_Epi <- step2(
  hdw.GSE171213_Den_Epi, NULL, .85
)
hdw.GSE171213_Den_Epi <- step3(hdw.GSE171213_Den_Epi, 50, .75)
hdw.GSE171213_Den_Epi <- step4(hdw.GSE171213_Den_Epi)
hdw.GSE171213_Den_Epi <- step5(hdw.GSE171213_Den_Epi)
hdw.GSE171213_Den_Epi <- step6(hdw.GSE171213_Den_Epi)
hdw.GSE171213_Den_Epi <- step7(hdw.GSE171213_Den_Epi)

clear(hdw.GSE171213_Den_Epi)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  hdw.GSE171213_Den_Epi@plots$step2$p.sft
  hdw.GSE171213_Den_Epi@plots$step3$p.dg
  hdw.GSE171213_Den_Epi@plots$step4$p.cor_hMEs
  hdw.GSE171213_Den_Epi@plots$step5$p.kme
  hdw.GSE171213_Den_Epi@plots$step5$p.umap_hMEs
  hdw.GSE171213_Den_Epi@plots$step5$p.dot_hMEs
  notshow(hdw.GSE171213_Den_Epi$modules)
  hdw.GSE171213_Den_Epi@plots$step6$ps.cor_module_traits
  notshow(hdw.GSE171213_Den_Epi@tables$step6$ts.cor_module_traits)
  hdw.GSE171213_Den_Epi@plots$step7$p.scatter
  hdw.GSE171213_Den_Epi@plots$step7$p.network
  feature(hdw.GSE171213_Den_Epi)
})


