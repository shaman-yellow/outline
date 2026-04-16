# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "16_ASEpiMonocle2")
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

# cache <- "./rds_jobSave/mn.GSE215968_AS_Epi.1.rds"
# mn.GSE215968_AS_Epi <- readRDS(cache)
srn.GSE215968_AS_Epi <- readRDS("./rds_jobSave/srn.GSE215968_AS_Epi.6.rds")

mn.GSE215968_AS_Epi <- asjob_monocle2(
  srn.GSE215968_AS_Epi, c("IUA", "control")
)

mn.GSE215968_AS_Epi <- step1(mn.GSE215968_AS_Epi)
mn.GSE215968_AS_Epi <- step2(mn.GSE215968_AS_Epi)
mn.GSE215968_AS_Epi <- step3(mn.GSE215968_AS_Epi)

fea.markers <- as_feature(c("H1-4", "FXYD7"), ref = "生物标识物基因")
mn.GSE215968_AS_Epi <- step4(
  mn.GSE215968_AS_Epi, fea.markers, relative_expr = FALSE,
  recode = c("HIST1H1E" = "H1-4")
)
clear(mn.GSE215968_AS_Epi)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(mn.GSE215968_AS_Epi@plots$step3$p.traj, .7, .7)
  mn.GSE215968_AS_Epi@plots$step4$p.geneInPseudo$scsa_cell
  notshow(mn.GSE215968_AS_Epi@params$diff_genes)
})


