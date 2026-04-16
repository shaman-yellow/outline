# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "02_metabolite")
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

mb.GSE171213 <- asjob_mebocost(srn.GSE171213)
mb.GSE171213 <- step1(mb.GSE171213)
mb.GSE171213 <- step2(mb.GSE171213)
mb.GSE171213 <- step3(mb.GSE171213)
mb.GSE171213 <- step4(mb.GSE171213)
mb.GSE171213 <- step5(mb.GSE171213)

clear(mb.GSE171213)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  mb.GSE171213@plots$step3$p.eventnum_bar
  mb.GSE171213@plots$step3$ps.heatmaps$PD
  mb.GSE171213@plots$step3$ps.heatmaps$HC
  notshow(mb.GSE171213@tables$step3$t.commu_res)
  mb.GSE171213@plots$step4$p.diff_flow
  notshow(mb.GSE171213@tables$step4$ts.diff_commu$PD_vs_HC)
  mb.GSE171213@plots$step5$p.score
  notshow(mb.GSE171213@tables$step5$t.overallScore)
})


