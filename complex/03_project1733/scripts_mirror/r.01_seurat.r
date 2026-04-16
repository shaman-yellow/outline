# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
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

geo.GSE150825 <- job_geo("GSE150825")
geo.GSE150825 <- step1(geo.GSE150825)
geo.GSE150825 <- step2(geo.GSE150825, ".", get_sup = TRUE)
clear(geo.GSE150825)

metadata.GSE150825 <- expect(geo.GSE150825, geo_cols())
metadata.GSE150825 <- dplyr::filter(
  metadata.GSE150825, grpl(title, "RNA-seq"),
  grpl(title, "^NPC")
)
metadata.GSE150825 <- dplyr::mutate(
  metadata.GSE150825, id = paste0(
    "NPC_", strx(title, "[0-9]+")
  )
)
metadata.GSE150825

if (FALSE) {
  fun_prepare <- function() {
    files <- list.files(
      geo.GSE150825$dir, "matrix|feature|barcodes", full.names = TRUE
    )
    dir <- file.path(dirname(files[1]), "NPC")
    dir.create(dir, FALSE)
    file.rename(files, s(files, "GSE[0-9]+_", "NPC/"))
    dir
  }
  dir_GSE150825 <- fun_prepare()
}

sr.GSE150825 <- job_seurat(dir_GSE150825, "GSE150825")
clear(sr.GSE150825)

sr.GSE150825 <- mutate(
  sr.GSE150825,
  id = paste0("NPC_", strx(colnames(object(sr.GSE150825)), "[0-9]+$"))
)
sr.GSE150825 <- getsub(sr.GSE150825, id %in% !!metadata.GSE150825$id)
sr.GSE150825 <- map(
  sr.GSE150825, metadata.GSE150825, "id", "id", "sample", "orig.ident"
)

srn.GSE150825 <- asjob_seurat5n(sr.GSE150825)
clear(srn.GSE150825)

srn.GSE150825 <- step1(srn.GSE150825, 200, 5000, 20000, 15)
clear(srn.GSE150825)

srn.GSE150825 <- step2(srn.GSE150825, sct = TRUE, workers = 5)
srn.GSE150825 <- step3(srn.GSE150825)
clear(srn.GSE150825)

srn.GSE150825 <- step4(srn.GSE150825)
srn.GSE150825 <- step5(srn.GSE150825, 5)
clear(srn.GSE150825)

npc_cell_markers <- list(

  B_Cell = list(
    markers = c("MS4A1", "CD79A", "CD79B", "CD19", "BANK1"),
    pmid = c("31477924", "33417831")
  ),

  Plasma_B_Cell = list(
    markers = c("SDC1", "MZB1", "XBP1", "PRDM1", "IGHG1"),
    pmid = c("31477924", "31209404")
  ),

  T_Cell = list(
    markers = c("CD3D", "CD3E", "CD3G", "CD2", "TRAC"),
    pmid = c("33417831", "31133762")
  ),

  NK_Cell = list(
    markers = c("NKG7", "GNLY", "KLRD1", "GZMB", "PRF1"),
    pmid = c("33417831", "32059779")
  ),

  Myeloid_Cell = list(
    markers = c("LYZ", "CD68", "CD14", "FCGR3A"),
    pmid = c("33417831", "31133762")
  ),

  Mast_Cell = list(
    markers = c("TPSAB1", "TPSB2", "CPA3", "KIT", "MS4A2", "HDC"),
    pmid = c("31133762", "32059779")
  ),

  Fibroblast = list(
    markers = c("COL1A1", "COL1A2", "DCN", "LUM", "FAP"),
    pmid = c("32059779", "29808064")
  ),

  Tumor_Associated = list(
    markers = c("MKI67", "TOP2A"),
    pmid = c("37880655", "34805184")
  ),

  Squamous_Epithelial_Basal = list(
      markers = c("KRT15", "S100A2", "PERP", "CLDN4"),
      pmid = c("28481227", "23217540")
  ),

  Ciliated_Epithelial = list(
    markers = c("TPPP3", "PIFO", "RSPH1", "DNAH5", "FOXJ1"),
    pmid = c("33279404")
  )

)

ref.markers <- show.markers <- as_markers(npc_cell_markers)

requireNamespace("Seurat")
srn.GSE150825@step <- 5L
srn.GSE150825 <- step6(
  srn.GSE150825, "", ref.markers, show.markers
)
clear(srn.GSE150825)

save_small.huibang("seurat")
# load("rdata_smallObject/seurat.rdata")


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

