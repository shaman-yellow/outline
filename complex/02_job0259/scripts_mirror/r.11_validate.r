# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "11_validate")
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

lm.GSE16134 <- readRDS("./rds_jobSave/lm.GSE16134.3.rds")
ven.learn <- readRDS("./rds_jobSave/ven.learn.1.rds")
lm.validate_train <- focus(
  copy_job(lm.GSE16134), feature(ven.learn, snap = "候选关键基因"), 
  .name = "learn", run_roc = TRUE, test = "wilcox.test"
)

object(lm.validate_train) <- NULL
clear(lm.validate_train)

geo.validate_GSE223924 <- job_geo("GSE223924")
geo.validate_GSE223924 <- step1(geo.validate_GSE223924)
geo.validate_GSE223924 <- step2(geo.validate_GSE223924)
clear(geo.validate_GSE223924)

metadata.validate_GSE223924 <- expect(
  geo.validate_GSE223924, geo_cols(), force = TRUE
)
metadata.validate_GSE223924 <- dplyr::filter(metadata.validate_GSE223924, group != "Peri_Implantitis")
metadata.validate_GSE223924 <- dplyr::mutate(
  metadata.validate_GSE223924, group = ifelse(
    group == "Healthy_control", "HC", "PD"
  )
)

des.validate_GSE223924 <- asjob_deseq2(
  geo.validate_GSE223924, metadata.validate_GSE223924
)
des.validate_GSE223924 <- step1(des.validate_GSE223924)

des.validate_GSE223924 <- focus(
  des.validate_GSE223924, feature(ven.learn, snap = "候选关键基因"),
  ref.use = "symbol", .name = "learn", test = "wilcox.test",
  levels = c("PD", "HC"), run_roc = TRUE
)
clear(des.validate_GSE223924)

clear_feature(as_feature(c("C3", "CYP24A1"), "关键基因"))


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
lm.validate_train@params$focusedDegs_learn$p.BoxPlotOfDEGs
lm.validate_train@params$focusedDegs_learn$p.rocs
des.validate_GSE223924@params$focusedDegs_learn$p.BoxPlotOfDEGs
des.validate_GSE223924@params$focusedDegs_learn$p.rocs
})


