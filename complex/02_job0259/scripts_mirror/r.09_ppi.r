# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "09_ppi")
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

ven.GSE171213_candidates <- readRDS("./rds_jobSave/ven.GSE171213_candidates.1.rds")

sdb.GSE171213_candidates <- asjob_stringdb(feature(ven.GSE171213_candidates))
sdb.GSE171213_candidates <- step1(
  sdb.GSE171213_candidates, network_type = "full", score_threshold = 400, MCC = FALSE
)
clear(sdb.GSE171213_candidates)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  sdb.GSE171213_candidates@plots$step1$p.ppi
  notshow(sdb.GSE171213_candidates@tables$step1$mapped)
  notshow(sdb.GSE171213_candidates@params$edges)
})


