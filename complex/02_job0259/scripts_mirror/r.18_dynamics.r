# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "18_dynamics")
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

vn.drugs_ex <- readRDS("./rds_jobSave/vn.drugs_ex.8.rds")
vn.metabolite <- readRDS("./rds_jobSave/vn.metabolite.8.rds")

dy.drug_metabolite <- asjob_dynamic(list(Drug = vn.drugs_ex, Metabolite = vn.metabolite))
dy.drug_metabolite <- step1(dy.drug_metabolite)
dy.drug_metabolite <- step2(dy.drug_metabolite, "./dynamics")
clear(dy.drug_metabolite)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  dy.drug_metabolite@plots$step2$p.rmsd
  dy.drug_metabolite@plots$step2$p.rmsf
  dy.drug_metabolite@plots$step2$p.hbond
  dy.drug_metabolite@plots$step2$p.energy
})


