# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "15_graphBan")
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

fea.markers <- load_feature()

gb.markers <- asjob_gBan(fea.markers)
gb.markers <- step1(
  gb.markers, db = "cmnpd"
)

gb.markers <- step2(gb.markers)
gb.markers <- step3(gb.markers)
clear(gb.markers)

# load results file
gb.markers@step <- 3L
gb.markers <- step4(
  gb.markers, "graphBan_res_", cutoff = .99, method_keep = "all"
)
clear(gb.markers)
gb.markers <- step5(gb.markers, skip = TRUE)
gb.markers <- step6(gb.markers, skip = TRUE)
gb.markers@step <- 6L
gb.markers <- step7(gb.markers)
clear(gb.markers)


gbEval.markers <- readRDS("./rds_jobSave/gb.markers.4.rds")
clear(gbEval.markers)
gbEval.markers <- step5(gbEval.markers, "./GraphBAN_MARKERS/admet.csv")
gbEval.markers$smiles_keep
gbEval.markers$file_smiles_for_swiss
gbEval.markers <- step6(gbEval.markers, "GraphBAN_MARKERS/swissadme.csv")
gbEval.markers <- step7(gbEval.markers)
clear(gbEval.markers)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  notshow(gb.markers@params$info_compounds)
  notshow(gb.markers@params$split_by_genes)
  notshow(gb.markers@tables$step7$t.final_candidates)
  gb.markers@plots$step4$p.common
})

#| OVERTURE
output_with_counting_number({
  gbEval.markers@tables$step7$t.final_candidates_mutate
  notshow(gbEval.markers@params$admet)
  notshow(gbEval.markers@params$admet_filter)
  notshow(gbEval.markers@params$swissAdme)
  notshow(gbEval.markers@tables$step7$t.final_candidates)
})


