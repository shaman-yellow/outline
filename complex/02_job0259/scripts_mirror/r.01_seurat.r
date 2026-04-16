# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "01_seurat")
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

geo.GSE171213 <- job_geo("GSE171213")
geo.GSE171213 <- step1(geo.GSE171213)
geo.GSE171213 <- step2(geo.GSE171213, get_sup = TRUE)

metadata.GSE171213 <- expect(geo.GSE171213, geo_cols())
metadata.GSE171213 <- dplyr::filter(metadata.GSE171213, group != "PDT")
metadata.GSE171213

meta_files <- tibble::tibble(files = list.files(geo.GSE171213$dir, "counts", full.names = TRUE))
meta_files <- dplyr::mutate(
  meta_files, sample = strx(files, "GSM[0-9]+")
)
meta_files

metadata.GSE171213 <- map(
  metadata.GSE171213, "sample", meta_files, "sample", "files", col = "files"
)
metadata.GSE171213

srn.GSE171213 <- job_seurat5n(
  metadata.GSE171213$files, metadata.GSE171213$sample, is10x = FALSE
)
srn.GSE171213 <- map(srn.GSE171213, metadata.GSE171213)

srn.GSE171213 <- step1(srn.GSE171213, 200, 3000, 10000, 25)
clear(srn.GSE171213)
srn.GSE171213 <- step2(srn.GSE171213)
srn.GSE171213 <- step3(srn.GSE171213)

srn.GSE171213 <- step4(srn.GSE171213)
srn.GSE171213 <- step5(srn.GSE171213, 5)
clear(srn.GSE171213)

periodontitis_cell_markers <- list(

  B_Cell = list(
    markers = c("MS4A1", "CD79A", "CD79B", "CD19", "BANK1"),
    pmid = c("37546811", "41143768")
    ),

  Dental_Epithelial_Cell = list(
    markers = c("EPCAM", "KRT14", "KRT17", "KRT19", "ODAM", "SPRR2F"),
    pmid = c("41143768", "12905270")
    ),

  Endothelia_Cell = list(
    markers = c("PECAM1", "VWF", "CDH5", "SELE", "KDR"),
    pmid = c("41143768", "8771561")
    ),

  Fibroblast = list(
    markers = c("COL1A1", "COL1A2", "DCN", "LUM", "FAP", "CXCL12"),
    pmid = c("41588193", "8771561")
    ),

  Mast_Cell = list(
    markers = c("TPSAB1", "TPSB2", "CPA3", "KIT", "HDC"),
    pmid = c("12213963", "20901232")
    ),

  MDSC = list(
    markers = c("S100A8", "S100A9", "ITGAM", "ARG1", "OLR1"),
    pmid = c("29915102", "32060018")
    ),

  Monocytic = list(
    markers = c("LYZ", "CD14", "FCGR3A", "S100A8", "S100A9"),
    pmid = c("37546811", "30726743")
    ),

  Neutrophil = list(
    markers = c("S100A8", "S100A9", "FCGR3B", "CXCR2", "MPO"),
    pmid = c("20901232", "37498709")
    ),

  Plasma_Cell = list(
    markers = c("IGHG1", "MZB1", "SDC1", "XBP1", "PRDM1"),
    pmid = c("41143768", "30545894")
    ),

  T_Cell = list(
    markers = c("CD3D", "CD3E", "CD2", "TRAC", "IL7R"),
    pmid = c("37546811", "30726743")
    ),

  Cycling_T_cells = list(
    markers = c("STMN1", "MKI67", "TOP2A", "PCNA", "HMGB2"),
    pmid = c("23827758", "30449622")
    ),

  IFN_activated_monocytes = list(
    markers = c("IRF7", "IRF8", "ISG15", "IFIT1", "MX1"),
    pmid = c("31178118", "30726743")
  )
)

show.markers <- as_markers(periodontitis_cell_markers)

ref.markers <- fxlsx(
  "GSE171213_markers_pmid_35154475.xlsx", startRow = 2, sheet = 2
)
ref.markers <- dplyr::filter(ref.markers, avg_logFC > 1, p_val_adj < 1e-5)
ref.markers <- dplyr::select(
  ref.markers, cell = cluster, markers = allmarkers.gene
)

requireNamespace("Seurat")
srn.GSE171213@step <- 5L
srn.GSE171213 <- step6(
  srn.GSE171213, "", ref.markers, show.markers, 
)
clear(srn.GSE171213)

save_small.huibang("seurat")

# load("rdata_smallObject/seurat.rdata")

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  srn.GSE171213@plots$step1$p.qc_pre
  srn.GSE171213@plots$step1$p.qc_aft
  srn.GSE171213@plots$step2$p.pca_rank
  z7(srn.GSE171213@plots$step3$p.umapUint, 1.5, 1)
  z7(srn.GSE171213@plots$step3$p.umapInt, 1.5, 1)
})

#| OVERTURE
output_with_counting_number({
  srn.GSE171213@tables$step6$t.validMarkers
  srn.GSE171213@plots$step3$p.umapLabel
  srn.GSE171213@plots$step6$p.markers_cluster
  srn.GSE171213@plots$step6$p.markers
  srn.GSE171213@plots$step6$p.map_scsa
  z7(srn.GSE171213@plots$step6$p.props_scsa, .8, .9)
  z7(srn.GSE171213@plots$step6$p.props_scsa_group, 1, 5)
  srn.GSE171213@plots$step6$p.props_scsa_stat
  notshow(srn.GSE171213@tables$step5$all_markers)
  notshow(srn.GSE171213@tables$step5$all_markers_no_filter)
  notshow(srn.GSE171213@tables$step6$scsa_res_all)
  notshow(srn.GSE171213@tables$step6$t.props_scsa)
  notshow(srn.GSE171213@params$final_metadata)
})


