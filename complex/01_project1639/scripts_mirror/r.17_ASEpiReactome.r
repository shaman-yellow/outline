# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "17_ASEpiReactome")
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

srn.GSE215968_AS_Epi <- readRDS("./rds_jobSave/srn.GSE215968_AS_Epi.6.rds")
rt.GSE215968_AS_Epi <- asjob_reactome(srn.GSE215968_AS_Epi)
rt.GSE215968_AS_Epi <- step1(rt.GSE215968_AS_Epi)
clear(rt.GSE215968_AS_Epi)

rt.GSE215968_AS_Epi <- step2(rt.GSE215968_AS_Epi, use = "p.value")
rt.GSE215968_AS_Epi <- step3(rt.GSE215968_AS_Epi)
clear(rt.GSE215968_AS_Epi)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  rt.GSE215968_AS_Epi@plots$step3$p.hps$pathways
  wrap(rt.GSE215968_AS_Epi@plots$step3$p.hps$genes, 5, 7)
  notshow(rt.GSE215968_AS_Epi@tables$step2$t.wilcox$pathways)
  notshow(rt.GSE215968_AS_Epi@tables$step2$t.wilcox$genes)
})


