# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "10_network")
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

fea.markers <- as_feature(c("H1-4", "FXYD7"), ref = "生物标识物基因")
rn.markers <- asjob_regNet(fea.markers)
rn.markers <- step1(rn.markers, c("HIST1H1E" = "H1-4"))
rn.markers <- step2(rn.markers, 1:2)
rn.markers <- step3(rn.markers)
rn.markers <- step4(rn.markers)
rn.markers <- step5(rn.markers)
clear(rn.markers)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  rn.markers@plots$step5$p.regNet
  notshow(rn.markers@params$all_lncRNA)
  notshow(rn.markers@params$all_miRNA)
})


