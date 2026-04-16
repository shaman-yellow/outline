# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "13_seurat")
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

if (FALSE) {
  geo.GSE215968 <- job_geo("GSE215968")
  geo.GSE215968 <- step1(geo.GSE215968)
  metadata.GSE215968 <- expect(geo.GSE215968, geo_cols())
  metadata.GSE215968
  allsamples <- metadata.GSE215968$sample
  allsamples
}

if (FALSE) {
  # just run for the first time
  file <- "../GEO/GSE215968/GSE215968_RAW.tar"
  parentDir <- dirname(file)
  untar(file, exdir = dirname(file))
  # exfiles <- list.files("../GEO/GSE215968/", pattern = "raw_count", full.names = TRUE)
  files <- list.files("../GEO/GSE215968/", pattern = "run_count", full.names = TRUE)
  # length(files)
  files_sampleName <- stringr::str_extract(files, "GSM[0-9]+")
  files_used <- files[ files_sampleName %in% allsamples ]
  files_sampleName <- stringr::str_extract(files_used, "GSM[0-9]+")
  lapply(seq_along(files_sampleName), 
    function(n) {
      dir.create(dir <- file.path(parentDir, files_sampleName[n]))
      untar(files[n], exdir = dir)
    })
  dirs <- lapply(file.path(parentDir, files_sampleName),
    function(path) {
      normalizePath(dirname(list.files(path, full.names = TRUE, recursive = TRUE)[1]))
    })
  metadata_files <- tibble::tibble(
    sample = files_sampleName, target = unlist(dirs)
  )
  metadata_files <- tibble::as_tibble(merge(
    metadata_files, metadata.GSE215968, by = "sample"
  ))
  metadata_files
  write.csv(metadata_files, "metadata_GSE215968_used.csv", row.names = FALSE)
}

metadata.GSE215968 <- vroom::vroom("./metadata_GSE215968_used.csv")
metadata.GSE215968 <- dplyr::select(
  metadata.GSE215968, sample, group, tissue.ch1, target
)
metadata.GSE215968

srn.GSE215968 <- job_seurat5n(
  metadata.GSE215968$target, metadata.GSE215968$sample
)
srn.GSE215968 <- step1(srn.GSE215968, 200, 6000, 20000, 20)

clear(srn.GSE215968, allow_qs = FALSE)

srn.GSE215968 <- step2(srn.GSE215968, 20, sct = TRUE)
srn.GSE215968 <- step3(srn.GSE215968)
srn.GSE215968 <- step4(srn.GSE215968)
srn.GSE215968 <- step5(srn.GSE215968, 5)

if (TRUE) {
  markers <- fxlsx("./markers.xlsx", 1, 2)
  markerEx <- fxlsx("./markers.xlsx", 2)
  markerEx <- dplyr::filter(markerEx, grpl(CellType, "^AS"))
  markers <- dplyr::bind_rows(markers, markerEx)
  funClean <- function(x) gs(x, "^[ ]+|[ ]+$", "")
  markers <- dplyr::mutate(
    markers, Gene = funClean(Gene),
    CellType = funClean(CellType),
    CellType = dplyr::recode(
      CellType, .default = CellType,
      "Endothelial" = "Endothelium",
      "Endothelial artery" = "Endothelium",
      "Endothelial vein" = "Endothelium",
      "dStroma" = "Stromal",
      "eStroma" = "Stromal",
      "FibroblastC7" = "Fibroblasts",
      "MAIT" = "MAIT cells",
      "AS-Epithelium" = "AS Epithelium"
    )
  )
  markers <- dplyr::filter(markers, CellType != "Fibroblasts")
  markers
}

omarkers <- fxlsx("./seurat_output_pmid37735465.xlsx", 1, 2)
omarkers <- dplyr::filter(omarkers, p_val_adj < 1e-9, avg_log2FC > 1)
omarkers

ref.markers <- as_markers(
  df = omarkers[, 6:7], snap = "PMID: 37735465"
)
ref.markers

show.markers <- as_markers(
  df = markers[, 2:1], snap = "PMID: 37735465"
)

rn <- match_strings(ref.markers$cell, show.markers$cell, .2)
show.markers <- dplyr::mutate(
  show.markers, cell = dplyr::recode(
    cell, !!!setNames(rn$x, rn$y)
  )
)
show.markers

# srn.GSE215968 <- qs::qread("./rds_jobSave/srn.GSE215968.6.qs")
# load("./rdata_smallObject/seurat.rdata")

srn.GSE215968 <- mutate(
  srn.GSE215968, group = dplyr::recode(
    orig.ident, !!!setNames(metadata.GSE215968$group, metadata.GSE215968$sample)
    ), group = s(group, "_Pre$", ""),
  group = dplyr::recode(group, "AS" = "IUA", "WOI_Control" = "control")
)

srn.GSE215968@step <- 5L
requireNamespace("Seurat")
srn.GSE215968 <- step6(
  srn.GSE215968, "", ref.markers, show.markers, filter.fc = .3, filter.p = .05,
  # keep_markers = 2,
  forceCluster = c(
    Stromal = 3L, Stromal = 20L, Epithelium = 30L, 
    Epithelium = 29L, Epithelium = 18L
  )
)
# scsa_check(srn.GSE215968, "AS Epithelium")

fea.markers <- as_feature(
  c("H1-4", "FXYD7"), ref = "生物标识物基因"
)

srn.GSE215968 <- focus(
  srn.GSE215968, fea.markers, name = "by_cell",
  recode = c("HIST1H1E" = "H1-4")
)
srn.GSE215968 <- focus(
  srn.GSE215968, fea.markers, "group", name = "by_group", facetTest = "scsa_cell",
  recode = c("HIST1H1E" = "H1-4")
)

# srn.GSE215968@plots$step5$p.toph <- NULL
# srn.GSE215968@snap$step3 <- ""
clear(srn.GSE215968)
save_small.huibang("seurat")

cc.GSE215968_control <- asjob_cellchat(
  getsub(srn.GSE215968, group == "control")
)
clear(cc.GSE215968_control)

cc.GSE215968_iua <- asjob_cellchat(
  getsub(srn.GSE215968, group == "IUA")
)
clear(cc.GSE215968_iua)

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  wrap(srn.GSE215968@plots$step1$p.qc_pre, 20, 15)
  wrap(srn.GSE215968@plots$step1$p.qc_aft, 20, 15)
  srn.GSE215968@plots$step2$p.pca_rank
  z7(srn.GSE215968@plots$step3$p.umapUint, 1.5, 1)
  z7(srn.GSE215968@plots$step3$p.umapInt, 1.5, 1)
})

#| OVERTURE
output_with_counting_number({
  srn.GSE215968@tables$step6$t.validMarkers
  srn.GSE215968@plots$step6$p.markers_cluster
  srn.GSE215968@plots$step6$p.markers
  srn.GSE215968@plots$step6$p.map_scsa
  z7(srn.GSE215968@plots$step6$p.props_scsa, .8, .7)
  z7(srn.GSE215968@plots$step6$p.props_scsa_group, 1, 5)
  srn.GSE215968@plots$step6$p.props_scsa_stat
  notshow(srn.GSE215968@tables$step5$all_markers)
  notshow(srn.GSE215968@tables$step5$all_markers_no_filter)
  notshow(srn.GSE215968@tables$step6$scsa_res_all)
  notshow(srn.GSE215968@tables$step6$t.props_scsa)
  notshow(srn.GSE215968@params$final_metadata)
})

#| OVERTURE
output_with_counting_number({
  z7(srn.GSE215968@params$focus_by_group$plist.vlnFacet$`H1-4`, .5, .7)
  z7(srn.GSE215968$focus_by_group$plist.vlnFacet$FXYD7, .5, .7)
})


