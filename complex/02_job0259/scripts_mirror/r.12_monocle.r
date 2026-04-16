# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "12_monocle")
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

mn.GSE171213_Den_Epi <- asjob_monocle2(srn.GSE171213_Den_Epi)

mn.GSE171213_Den_Epi <- step1(mn.GSE171213_Den_Epi)
mn.GSE171213_Den_Epi <- step2(
  mn.GSE171213_Den_Epi, top = 100
)
mn.GSE171213_Den_Epi <- step3(mn.GSE171213_Den_Epi, root = 3)

fea.markers <- load_feature()

mn.GSE171213_Den_Epi <- step4(
  mn.GSE171213_Den_Epi, fea.markers,
  # recode = c("HIST1H1E" = "H1-4"),
  relative_expr = FALSE
)
mn.GSE171213_Den_Epi <- step5(mn.GSE171213_Den_Epi)
clear(mn.GSE171213_Den_Epi)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(mn.GSE171213_Den_Epi@plots$step3$p.traj, .7, .7)
  mn.GSE171213_Den_Epi@plots$step4$p.geneInPseudo$scsa_cell
  notshow(mn.GSE171213_Den_Epi@params$diff_genes)
  mn.GSE171213_Den_Epi@plots$step5$p.hp
  notshow(mn.GSE171213_Den_Epi@params$diff_test_pseudotime)
})


