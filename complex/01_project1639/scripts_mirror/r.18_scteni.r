# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "18_scteni")
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

if (FALSE) {
  srn.GSE215968_AS_Epi <- readRDS("./rds_jobSave/srn.GSE215968_AS_Epi.6.rds")
  saveRDS(srn.GSE215968_AS_Epi@object, "UMAP.rds")
}

fea.markers <- as_feature(c("H1-4"), ref = "生物标识物基因")
sct.GSE215968_AS_Epi <- asjob_scteni(NULL, fea.markers)
sct.GSE215968_AS_Epi <- step1(sct.GSE215968_AS_Epi)
sct.GSE215968_AS_Epi <- step2(
  sct.GSE215968_AS_Epi, dir = "sct_results", cut.z = 1, use.p = "p.value",
  recode = c("HIST1H1E" = "H1-4")
)
clear(sct.GSE215968_AS_Epi)

en.H1_4_knk <- asjob_enrich(feature(sct.GSE215968_AS_Epi))
en.H1_4_knk <- step1(en.H1_4_knk)
clear(en.H1_4_knk)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  sct.GSE215968_AS_Epi@plots$step2$ps.volcano$`H1-4`
  notshow(sct.GSE215968_AS_Epi@tables$step2$t.all_diff$`H1-4`)
  z7(en.H1_4_knk@plots$step1$p.kegg$ids, 1, .5)
  notshow(en.H1_4_knk@tables$step1$res.kegg$ids)
  en.H1_4_knk@plots$step1$p.go$ids
  notshow(en.H1_4_knk@tables$step1$res.go$ids)
})


