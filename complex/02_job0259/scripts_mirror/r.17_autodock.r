# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "17_autodock")
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

vn.drugs_ex <- readRDS("./rds_jobSave/vn.drugs_ex.7.rds")
clear(vn.drugs_ex)

# vn.drugs <- readRDS("./rds_jobSave/vn.drugs.7.rds")
# clear(vn.drugs)

vn.metabolite <- readRDS("./rds_jobSave/vn.metabolite.7.rds")
clear(vn.metabolite)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  vn.drugs_ex@plots$step5$p.res_vina
  vn.drugs_ex@tables$step5$t.showData
  vn.drugs_ex@plots$step6$figs$Top_C3_139587843
  vn.drugs_ex@plots$step6$figs$Top_CYP24A1_171120089
  vn.drugs_ex@plots$step7$figs$Top_C3_139587843
  vn.drugs_ex@plots$step7$figs$Top_CYP24A1_171120089
  notshow(vn.drugs_ex@tables$step5$res_dock)
})

#| OVERTURE
output_with_counting_number({
  vn.metabolite@plots$step5$p.res_vina
  vn.metabolite@tables$step5$t.showData
  vn.metabolite@plots$step6$figs$Top_C3_5906
  vn.metabolite@plots$step6$figs$Top_CYP24A1_5906
  vn.metabolite@plots$step7$figs$Top_C3_5906
  vn.metabolite@plots$step7$figs$Top_CYP24A1_5906
  notshow(vn.metabolite@tables$step5$res_dock)
})


