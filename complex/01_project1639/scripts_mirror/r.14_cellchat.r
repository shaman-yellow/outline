# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "14_cellchat")
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

cc.GSE215968_control <- readRDS("./rds_jobSave/cc.GSE215968_control.0.rds")
cc.GSE215968_control <- step1(cc.GSE215968_control)
cc.GSE215968_control <- step2(cc.GSE215968_control)
clear(cc.GSE215968_control)

cc.GSE215968_iua <- readRDS("./rds_jobSave/cc.GSE215968_iua.0.rds")
cc.GSE215968_iua <- step1(cc.GSE215968_iua)
cc.GSE215968_iua <- step2(cc.GSE215968_iua)
clear(cc.GSE215968_iua)


if (FALSE) {
  cc.GSE215968_control <- readRDS("./rds_jobSave/cc.GSE215968_control.2.rds")
  cc.GSE215968_iua <- readRDS("./rds_jobSave/cc.GSE215968_iua.2.rds")
}

cc.comparison <- asjob_cellchatn(
  list(Control = cc.GSE215968_control, IUA = cc.GSE215968_iua)
)
cc.comparison <- step1(cc.comparison)
cc.comparison <- step2(cc.comparison, "AS Epithelium")
clear(cc.comparison)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  cc.comparison@plots$step1$p.inters_counts
  cc.comparison@plots$step1$p.inters_weights
  wrap(cc.comparison@plots$step2$p.allCells_LP_comm_each_group$Control, 5, 6)
  cc.comparison@plots$step2$p.allCells_LP_comm_each_group$IUA
  wrap(cc.comparison@plots$step2$p.keyCellAsSource, 10, 4)
  notshow(cc.GSE215968_control@tables$step1$lp_net)
  notshow(cc.GSE215968_control@tables$step1$pathway_net)
  notshow(cc.GSE215968_control@tables$step2$t.lr_comm_bubble)
  notshow(cc.GSE215968_iua@tables$step1$lp_net)
  notshow(cc.GSE215968_iua@tables$step1$pathway_net)
  notshow(cc.GSE215968_iua@tables$step2$t.lr_comm_bubble)
  notshow(cc.comparison@params$keyCell_data$data.keyCellAsSource)
  notshow(cc.comparison@params$keyCell_data$data.keyCellAsTarget)
})


