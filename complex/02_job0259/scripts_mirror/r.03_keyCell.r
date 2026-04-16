# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "03_keyCell")
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

srn.GSE171213 <- readRDS("./rds_jobSave/srn.GSE171213.1.rds")
metaCells <- readRDS("./rds_jobSave/lite/srn.GSE171213.6.rds")

srn.GSE171213_Den_Epi <- asjob_seurat_sub(
  srn.GSE171213, metaCells, "Dental_Epithelial_Cell"
)
clear(srn.GSE171213_Den_Epi)
rm(srn.GSE171213)

srn.GSE171213_Den_Epi <- step1(srn.GSE171213_Den_Epi)
requireNamespace("Seurat")
srn.GSE171213_Den_Epi <- step2(srn.GSE171213_Den_Epi)
srn.GSE171213_Den_Epi <- step3(srn.GSE171213_Den_Epi, 1:15, 0.2)
clear(srn.GSE171213_Den_Epi)

# spsv(z7(srn.GSE171213_Den_Epi@plots$step3$p.umapInt, 1.3, 1))
srn.GSE171213_Den_Epi <- step4(srn.GSE171213_Den_Epi)

srn.GSE171213_Den_Epi@step <- 4L
srn.GSE171213_Den_Epi <- step5(
  srn.GSE171213_Den_Epi, 5, force = TRUE, min.pct = .1
)

as_epithelium_db <- list(

  Dental_Epithelial_Cell = list(
    markers = c("EPCAM", "KRT14", "KRT17", "KRT19", "ODAM", "SPRR2F"),
    pmid = c("41143768", "12905270")
    ),

  Basal_epithelium = list(
    markers = c("KRT5", "KRT14", "ITGA6", "TP63"),
    pmid = c("26634892")
  ),

  Suprabasal_epithelium = list(
    markers = c("KRT1", "KRT10", "IVL", "KRT13"),
    pmid = c("26634892")
  ),

  Differentiated_epithelium = list(
    markers = c("FLG", "LOR", "SPRR1A", "SPRR2A"),
    pmid = c("30027204")
  ),

  Proliferative_epithelium = list(
    markers = c("MKI67", "TOP2A", "BIRC5", "PCNA"),
    pmid = c("31792404")
  ),

  Inflammatory_epithelium = list(
    markers = c("CXCL8", "CXCL1", "CXCL2", "CCL20", "ICAM1", "NFKBIA"),
    pmid = c("34949679")
  ),

  Interferon_response_epithelium = list(
    markers = c("ISG15", "IFI6", "IFIT1", "MX1"),
    pmid = c("31209474")
  ),

  Antimicrobial_epithelium = list(
    markers = c("DEFB4A", "S100A7", "S100A8", "S100A9"),
    pmid = c("21960570")
  ),

  Junctional_epithelium_like = list(
    markers = c("KRT19", "ODAM", "LAMC2"),
    pmid = c("19723633")
  )

)

ref.markers <- as_markers(as_epithelium_db)

srn.GSE171213_Den_Epi@step <- 5L
requireNamespace("Seurat")
srn.GSE171213_Den_Epi <- step6(
  srn.GSE171213_Den_Epi, "", ref.markers, ref.markers, filter.fc = .3, filter.p = .05,
  # keep_markers = 2, rerun = TRUE,
  forceCluster = c("Junctional_epithelium_like" = 0L)
)
# scsa_check(srn.GSE171213_Den_Epi, "", 0:6)
clear(srn.GSE171213_Den_Epi)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srn.GSE171213_Den_Epi@plots$step3$p.umapUint
  srn.GSE171213_Den_Epi@plots$step3$p.umapInt
  srn.GSE171213_Den_Epi@tables$step6$t.validMarkers
  z7(srn.GSE171213_Den_Epi@plots$step6$p.markers_cluster, 1, 1.1)
  z7(srn.GSE171213_Den_Epi@plots$step6$p.markers, 1, 1.4)
  wrap(srn.GSE171213_Den_Epi@plots$step6$p.props_scsa, 7, 5)
  wrap(srn.GSE171213_Den_Epi@plots$step6$p.props_scsa_stat, 4, 4)
  wrap(srn.GSE171213_Den_Epi@plots$step6$p.map_scsa, 5, 3)
  notshow(srn.GSE171213_Den_Epi@tables$step5$all_markers)
  notshow(srn.GSE171213_Den_Epi@tables$step5$all_markers_no_filter)
  notshow(srn.GSE171213_Den_Epi@tables$step6$scsa_res_all)
  notshow(srn.GSE171213_Den_Epi@tables$step6$t.props_scsa)
  notshow(srn.GSE171213_Den_Epi@params$final_metadata)
})


