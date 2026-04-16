# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "08_DEG")
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

geo.GSE16134 <- job_geo("GSE16134")
geo.GSE16134 <- step1(geo.GSE16134)
metadata.GSE16134 <- expect(
  geo.GSE16134, geo_cols(group = "gingival.tissue.phenotype.ch1"), force = TRUE
)
metadata.GSE16134 <- dplyr::mutate(
  metadata.GSE16134, group = ifelse(
    grpl(group, "^Diseased"), "PD", "HC"
  )
)

lm.GSE16134 <- asjob_limma(geo.GSE16134, metadata.GSE16134)
lm.GSE16134 <- step1(lm.GSE16134)
lm.GSE16134 <- step2(lm.GSE16134, PD - HC, cut.fc = .5)
lm.GSE16134 <- step3(lm.GSE16134)
clear(lm.GSE16134)

# hdw.GSE171213 <- readRDS("./rds_jobSave/lite/hdw.GSE171213.7.rds")
hdw.GSE171213_Den_Epi <- readRDS("./rds_jobSave/lite/hdw.GSE171213_Den_Epi.7.rds")

ven.GSE171213_candidates <- job_venn(
  `DEG (PD vs HC)` = feature(lm.GSE16134),
  `Module Genes (turquoise)` = feature(hdw.GSE171213_Den_Epi)[["module_genes"]],
  fun_map = gname
)
ven.GSE171213_candidates <- step1(ven.GSE171213_candidates)
clear(ven.GSE171213_candidates)



# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  lm.GSE16134@plots$step3$topDegs$`PD vs HC`$p.volcano
  lm.GSE16134@plots$step3$topDegs$`PD vs HC`$p.hp
  notshow(lm.GSE16134@tables$step2$tops$`PD vs HC`)
  feature(lm.GSE16134)
})

#| OVERTURE
output_with_counting_number({
  ven.GSE171213_candidates@plots$step1$p.venn
  feature(ven.GSE171213_candidates)
})


