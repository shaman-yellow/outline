# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "15_ASEpiSubType")
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

srn.GSE215968 <- readRDS("./rds_jobSave/srn.GSE215968.1.rds")
metaCells <- readRDS("./rds_jobSave/lite/srn.GSE215968.6.rds")

srn.GSE215968_AS_Epi <- asjob_seurat_sub(
  srn.GSE215968, metaCells, "AS Epithelium"
)
clear(srn.GSE215968_AS_Epi)

srn.GSE215968_AS_Epi <- step1(srn.GSE215968_AS_Epi)
requireNamespace("Seurat")
srn.GSE215968_AS_Epi <- step2(srn.GSE215968_AS_Epi)
srn.GSE215968_AS_Epi <- step3(srn.GSE215968_AS_Epi, 1:15, 0.2)
clear(srn.GSE215968_AS_Epi)

# spsv(z7(srn.GSE215968_AS_Epi@plots$step3$p.umapInt, 1.3, 1))
srn.GSE215968_AS_Epi <- step4(srn.GSE215968_AS_Epi)

srn.GSE215968_AS_Epi@step <- 4L
srn.GSE215968_AS_Epi <- step5(
  srn.GSE215968_AS_Epi, 5, force = TRUE, min.pct = .1
)

as_epithelium_db <- list(

  Luminal_epithelium = list(
    markers = c("EPCAM", "KRT8", "KRT18", "KRT19",
      "MUC1", "CLDN3", "CLDN4", "TJP1"),
    pmid = c("29224780", "34949679")
    ),

  Glandular_epithelium = list(
    markers = c("FOXA2", "PAX8", "SOX17",
      "MUC1", "LIF", "SCGB1D4"),
    pmid = c("29224780", "31209474")
    ),

  Basal_Progenitor_epithelium = list(
    markers = c("KRT5", "KRT14", "TP63",
      "SOX9", "LGR5", "AXIN2"),
    pmid = c("30097489", "34949679")
    ),

  Ciliated_epithelium = list(
    markers = c("FOXJ1", "TPPP3", "PIFO",
      "DNAH5", "RSPH1"),
    pmid = c("29224780")
    ),

  Secretory_epithelium = list(
    markers = c("PAEP", "SPP1", "SCGB1D4",
      "MUC16", "LTF"),
    pmid = c("31209474", "29224780")
    ),

  Epithelium = list(markers = c("EPCAM", "WFDC2"), pmid = c("37735465")),

  EMT_like_epithelium = list(
    markers = c("VIM", "FN1", "CDH2",
      "SNAI1", "SNAI2",
      "ZEB1", "ZEB2",
      "TWIST1", "ACTA2"),
    pmid = c("26635009", "31383692")
    ),

  Inflammatory_epithelium = list(
    markers = c("CXCL8", "CXCL1", "CXCL2",
      "CCL20", "ICAM1", "NFKBIA"),
    pmid = c("34949679")
  )

)

ref.markers <- as_markers(as_epithelium_db)

if (FALSE) {
  srn.GSE215968_AS_Epi <- mutate(
    srn.GSE215968_AS_Epi,
    group = dplyr::recode(group, "AS" = "IUA", "WOI_Control" = "control")
  )
}


srn.GSE215968_AS_Epi@step <- 5L
requireNamespace("Seurat")
srn.GSE215968_AS_Epi <- step6(
  srn.GSE215968_AS_Epi, "", ref.markers, ref.markers, filter.fc = .3, filter.p = .05,
  # keep_markers = 2, rerun = TRUE,
  forceCluster = c("Epithelium" = 0L)
)
# scsa_check(srn.GSE215968_AS_Epi, "", 0:6)
clear(srn.GSE215968_AS_Epi)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srn.GSE215968_AS_Epi@plots$step3$p.umapUint
  srn.GSE215968_AS_Epi@plots$step3$p.umapInt
  srn.GSE215968_AS_Epi@tables$step6$t.validMarkers
  z7(srn.GSE215968_AS_Epi@plots$step6$p.markers_cluster, 1, 1.1)
  z7(srn.GSE215968_AS_Epi@plots$step6$p.markers, 1, 1.4)
  wrap(srn.GSE215968_AS_Epi@plots$step6$p.props_scsa, 7, 5)
  wrap(srn.GSE215968_AS_Epi@plots$step6$p.props_scsa_stat, 3, 3)
  wrap(srn.GSE215968_AS_Epi@plots$step6$p.map_scsa, 5, 3)
  notshow(srn.GSE215968_AS_Epi@tables$step5$all_markers)
  notshow(srn.GSE215968_AS_Epi@tables$step5$all_markers_no_filter)
  notshow(srn.GSE215968_AS_Epi@tables$step6$scsa_res_all)
  notshow(srn.GSE215968_AS_Epi@tables$step6$t.props_scsa)
  notshow(srn.GSE215968_AS_Epi@params$final_metadata)
})


