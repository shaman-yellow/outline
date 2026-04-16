# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "05_expression_validate")
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

des.iua <- readRDS("./rds_jobSave/des.iua.3.rds")
vn.learn <- readRDS("./rds_jobSave/vn.learn.1.rds")
des.validate_train <- focus(
  des.iua, feature(vn.learn), 
  .name = "learn", run_roc = FALSE, test = "fp.test", nrow = 1
)
object(des.validate_train) <- NULL
clear(des.validate_train)

geo.gse224093 <- job_geo("GSE224093")
geo.gse224093 <- step1(geo.gse224093)
geo.gse224093 <- step2(geo.gse224093, get_supp = TRUE)
# geo.gse224093$dir_files
data.gse224093 <- ftibble(geo.gse224093$dir_files)
data.gse224093 <- dplyr::mutate(
  data.gse224093, GeneName = dplyr::recode(
    GeneName, "HIST1H1E" = "H1-4", "PRCAT47" = "ARLNC1", .default = GeneName
  )
)


# metadata.gse224093 <- expect(geo.gse224093, geo_cols())
metadata.gse224093 <- group_strings(
  colnames(data.gse224093)[-1], 
  c(control = "Con", IUA = "Ba"), "sample"
)
genes.gse224093 <- dplyr::select(data.gse224093, GeneName)

list.gse224093 <- prepare_expr_data(
  metadata.gse224093, data.gse224093, genes.gse224093
)
lm.validate_gse224093 <- job_limma_normed(
  list.gse224093$counts, list.gse224093$metadata
)
lm.validate_gse224093 <- step1(lm.validate_gse224093)
lm.validate_gse224093 <- focus(
  lm.validate_gse224093, feature(vn.learn),
  ref.use = "rownames", .name = "learn", test = "fp.test",
  levels = c("IUA", "control"), nrow = 1
)
lm.validate_gse224093@plots$step2$p.BoxPlotOfDEGs_learn
clear(lm.validate_gse224093)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(des.validate_train@params$focusedDegs_learn$p.BoxPlotOfDEGs, 5, 2.5)
  wrap(lm.validate_gse224093@plots$step2$p.BoxPlotOfDEGs_learn, 5, 2.5)
})


