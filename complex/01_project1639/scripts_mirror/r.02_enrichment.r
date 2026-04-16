# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "02_enrichment")
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

# options(clusterProfiler.download.method = "wget")

# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

vn.iua_arlnc1 <- readRDS("./rds_jobSave/vn.iua_arlnc1.1.rds")
# feature(vn.iua_arlnc1)

en.iua_arlnc1 <- asjob_enrich(feature(vn.iua_arlnc1))
en.iua_arlnc1 <- step1(en.iua_arlnc1, use = "pvalue")
en.iua_arlnc1@snap
clear(en.iua_arlnc1)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  z7(en.iua_arlnc1@plots$step1$p.kegg$ids, 1, .5)
  notshow(en.iua_arlnc1@tables$step1$res.kegg$ids)
  en.iua_arlnc1@plots$step1$p.go$ids
  notshow(en.iua_arlnc1@tables$step1$res.go$ids)
})


