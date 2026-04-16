# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "03_ppi")
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

vn.iua_arlnc1 <- readRDS("./rds_jobSave/vn.iua_arlnc1.1.rds")
sdb.iua_arlnc1 <- asjob_stringdb(feature(vn.iua_arlnc1))
sdb.iua_arlnc1 <- step1(
  sdb.iua_arlnc1, network_type = "full", score_threshold = 400, MCC = FALSE
)
clear(sdb.iua_arlnc1)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  sdb.iua_arlnc1@plots$step1$p.ppi
  notshow(sdb.iua_arlnc1@tables$step1$mapped)
  notshow(sdb.iua_arlnc1@params$edges)
})


