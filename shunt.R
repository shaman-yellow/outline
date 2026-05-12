
# devtools::check("~/test_utils.tool")

dir.create("~/union")
list.files("~/union")

fun_names <- function(files) {
  paste0("~/utils.tool/R/", files)
}
# unlink("~/union/union.utils", TRUE, TRUE)
# unlink("~/union/union.publish", TRUE, TRUE)

# ==========================================================================
# uilts
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

utils <- c("alignment_merge.R", "collate_codes_as_report.R",
  "convert_dictionary.R", "create_xlsx.R", "cross_select.R",
  "diann.R", "dot_heatmap.R", "generate_slidy.R", "get_data.R", 
  "legend.R", "lite_research.R",
  "lite.citation.R", "make_temp.R", "metabo_collate.R",
  "monocle_plot_pseudo_heatmap.R", "output_identification.R",
  "pathway_enrichment.R", "pick_annotation.R", "plot_EIC_stack.R",
  "plotKO.R", "qi_get_format.R", "query_cids.R",
  "query_classification.R", "query_inchikey.R", "query_others.R",
  "query_sdfs.R", "query_synonyms.R",
  "shunt_package.R", "simulate_and_evaluate.R", "stack_ms2.R",
  "tmp.ahr.R", "Z_class-resp.R"
)

new_package.fromFiles(
  "~/union/union.utils", fun_names(utils), import = c("methods")
)
pkgload::unload("utils.tool")
devtools::load_all("~/union/union.utils")

# ==========================================================================
# publish
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

publish <- c(
  "a.R", "aaa.R", "des.R", "exReport.R", "exReport2.R", "grid_draw.R", "flowChart.R", 
  "guess_class.R", "live.R", "live2.R", "pretty_table.R", "write_thesis.R",
  "hugo_doks.R"
)

new_package.fromFiles(
  "~/union/union.publish", fun_names(publish), depends = "union.utils"
)
file.copy(
  "~/utils.tool/inst/extdata/", "~/union/union.publish/inst/extdata/", TRUE, TRUE
)
roxygen2::roxygenise("~/union/union.publish")
devtools::load_all("~/union/union.publish")

# ==========================================================================
# project
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# unlink("~/union/union.project", TRUE, TRUE)
project <- c("workflow_000.R", "remote_api.R", "report_bosai.R",
  "report_complex.R", "report_huibang.R", "report_lixiao.R")
new_package.fromFiles(
  "~/union/union.project", fun_names(project), depends = "union.publish"
)
roxygen2::roxygenise("~/union/union.project")
devtools::load_all("~/union/union.project")

# ==========================================================================
# others
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

workflow <- c("workflow_001_seurat.R", "workflow_002_wgcna.R",
  "workflow_003_cellchat.R", "workflow_004_monocle.R", "workflow_005_seuratn.R",
  "workflow_006_garnett.R", "workflow_007_enrich.R", "workflow_008_limma.R",
  "workflow_009_tcga.R", "workflow_010_lasso.R", "workflow_011_survival.R",
  "workflow_012_qiime.R", "workflow_013_herb.R", "workflow_014_stringdb.R",
  "workflow_015_sra.R", "workflow_016_mp.R", "workflow_017_fastp.R",
  "workflow_018_gatk.R", "workflow_019_geo.R", "workflow_020_metabo.R",
  "workflow_021_vina.R", "workflow_022_biobakery.R", "workflow_023_annova.R",
  "workflow_024_fella.R", "workflow_025_gsea.R", "workflow_026_seuratSp.R",
  "workflow_027_infercnv.R", "workflow_028_kat.R", "workflow_029_mn2kat.R",
  "workflow_030_risc.R", "workflow_031_esearch.R", "workflow_032_catr.R",
  "workflow_033_kallisto.R", "workflow_034_edqtl.R", "workflow_035_biomart.R",
  "workflow_036_biblio.R", "workflow_037_maf.R", "workflow_038_rfsrc.R",
  "workflow_039_miranda.R", "workflow_040_hybrid.R", "workflow_041_circr.R",
  "workflow_042_ogwas.R", "workflow_043_gutmd.R", "workflow_044_classyfire.R",
  "workflow_045_biomart2.R", "workflow_046_tcmsp.R", "workflow_047_uniprotkb.R",
  "workflow_048_pubchemr.R", "workflow_049_swiss.R", "workflow_050_genecard.R",
  "workflow_051_gmix.R", "workflow_052_hawkdock.R", "workflow_053_plantdb.R",
  "workflow_054_superpred.R", "workflow_055_tfbs.R", "workflow_056_hob.R",
  "workflow_057_m6a.R", "workflow_058_bindingdb.R", "workflow_059_bowtie2.R",
  "workflow_060_metaphlan.R", "workflow_061_msconvert.R", "workflow_062_xcms.R",
  "workflow_063_sirius.R", "workflow_064_ocr.R", "workflow_065_adcp.R",
  "workflow_066_unitmp.R", "workflow_067_prr.R", "workflow_068_musite.R",
  "workflow_069_epifactor.R", "workflow_070_batman.R", "workflow_071_ctd.R",
  "workflow_072_abismal.R", "workflow_073_tcmsp2.R", "workflow_074_dl.R",
  "workflow_075_cluspro.R", "workflow_076_scfea.R", "workflow_077_methy.R",
  "workflow_078_cgi.R", "workflow_079_ucscTable.R", "workflow_080_dmr.R",
  "workflow_081_cardinal.R", "workflow_082_fusion.R", "workflow_083_seurat5n.R",
  "workflow_084_katn.R", "workflow_085_mfuzz.R", "workflow_086_estimate.R",
  "workflow_087_fe.R", "workflow_088_gds.R", "workflow_089_pubmed.R",
  "workflow_090_mime.R", "workflow_091_pathview.R", "workflow_092_venn.R",
  "workflow_093_xena.R", "workflow_094_nscfea.R", "workflow_095_vep.R",
  "workflow_096_lnctard.R", "workflow_097_diag.R", "workflow_098_diagn.R",
  "workflow_099_ideal.R", "workflow_100_markers.R", "workflow_101_gtopdb.R",
  "workflow_102_ps.R", "workflow_103_seurat_sub.R", "workflow_104_htf.R",
  "workflow_105_matrisome.R", "workflow_106_ssgsea.R", "workflow_107_aucell.R",
  "workflow_108_iobr.R", "workflow_109_deseq2.R", "workflow_110_mlearn.R",
  "workflow_111_corgsea.R", "workflow_112_rms.R", "workflow_113_locate.R",
  "workflow_114_regNet.R", "workflow_115_gBan.R", "workflow_116_cellchatn.R",
  "workflow_117_monocle2.R", "workflow_118_reactome.R", "workflow_119_genemania.R",
  "workflow_120_mebocost.R", "workflow_121_scteni.R", "workflow_122_scenic.R",
  "workflow_123_hdwgcna.R", "workflow_124_scMeta.R", "workflow_125_gutmg.R",
  "workflow_126_mimedb.R", "workflow_127_mr.R", "workflow_128_scissor.R",
  "workflow_129_mlearn10.R", "workflow_zzz_anno.R", "workflow_zzz_herb.R",
  "workflow_zzz_protein_db.R", "workflow_zzz_testThis.R"
)

fun_num <- function(n) {
  sprintf("%02d", n)
}

num_files <- vapply(workflow, FUN.VALUE = character(1),
  function(file) {
    num <- strx(file, "[0-9]+")
    if (is.na(num)) {
      "zzz"
    } else {
      sprintf("%02d", as.integer(num)  %/% 10)
    }
  })

groups <- split(workflow, num_files)
groups

lapply(names(groups),
  function(seq) {
    group <- groups[[ seq ]]
    new_package.fromFiles(
      glue::glue("~/union/union.series.{seq}"), fun_names(group),
      depends = c("union.project", "data.table")
    )
  })

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

new_package("~/union/utils.tool", NULL, NULL)
# new_package("~/union/union.series.13", NULL, depends = "union.project")

# ==========================================================================
# extdata
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

system("find ~/union/union.publish/inst/extdata/ -type f -exec sed -i 's|~/utils.tool|~/union/union.publish|g' {} +")
system("find ~/union/union.publish/inst/extdata/ -type f -exec sed -i 's|utils.tool|union.publish|g' {} +")
system("find ~/.vim/luaSnipmate/complex/ -type f -exec sed -i 's|~/utils.tool|~/union/union.publish|g' {} +")
system("find ~/.vim/luaSnipmate/complex/ -type f -exec sed -i 's|utils.tool|union.publish|g' {} +")

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

devtools::load_all("~/union/union.utils")
load_unions()

system.file(package = "union.utils")
find.package("union.utils")


# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


lapply(
  list.files("~/union/", "union\\.", full.names = TRUE),
  function(x) {
    fun <- function(wd) {
      setwd(wd)
      usethis::use_package("data.table", "Depends")
    }
    callr::r(fun, list(wd = x), show = TRUE)
  }
)

fun <- function(wd) {
  setwd(wd)
  usethis::use_package("ggraph", "Imports")
}
callr::r(fun, list(wd = "~/union/union.project"), show = TRUE)

