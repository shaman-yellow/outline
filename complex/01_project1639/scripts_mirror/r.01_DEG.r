# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/01_project1639"
output <- file.path(ORIGINAL_DIR, "01_DEG")
if (!dir.exists(output)) {
  dir.create(output, recursive = TRUE)
}
setwd(ORIGINAL_DIR)

.libPaths(c("/data/nas2/software/miniconda3/envs/public_R/lib/R/library/", "/data/nas1/huanglichuang_OD/conda/envs/extra_pkgs/lib/R/library/"))

devtools::load_all(myPkg <- "./utils.tool")
setup.huibang()


# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

data <- ftibble("./1639_rawdata2/GeneExpression/1_genes_fpkm_expression.txt")
data <- map_gene(data, "EntrezID")
data <- dplyr::filter(data, !is.na(SYMBOL))
counts <- dplyr::select(data, gene_name, dplyr::starts_with("count"))

metadata <- ftibble("./1639_rawdata2/group.csv")
metadata <- dplyr::select(metadata, sample, group)
metadata$group

# data[which(data$gene_name == data$gene_id), ]
genes <- dplyr::select(data, gene_name, dplyr::where(is.character))
genes

counts <- dplyr::select(data, gene_name, dplyr::starts_with("count"))
counts <- dplyr::rename_with(
  counts, function(x) sub("count\\.", "", x), dplyr::starts_with("count")
)
counts

cut.fc <- 1
ptype <- "pvalue"

des.iua <- job_deseq2(counts, metadata, genes)
#' @meth {get_meth(des.iua)}
des.iua <- step1(des.iua)
des.iua <- step2(des.iua, IUA - control, cut.fc = cut.fc, use = ptype)
des.iua <- step3(des.iua)
des.iua <- focus(des.iua, "ARLNC1", .name = "ARLNC1", which = NULL)
clear(des.iua)

des.arlnc1 <- job_deseq2(counts, metadata, genes)
des.arlnc1 <- filter(des.arlnc1, group == "IUA")
des.arlnc1 <- regroup(des.arlnc1, regroup(des.iua, "ARLNC1"))

des.arlnc1 <- step1(des.arlnc1)
des.arlnc1 <- step2(
  des.arlnc1, High - Low, cut.fc = cut.fc, use = ptype
)
des.arlnc1 <- step3(des.arlnc1)
clear(des.arlnc1)
feature(des.arlnc1)

vn.iua_arlnc1 <- job_venn(`DEGs (IUA vs Control)` = feature(des.iua), `ARLNC1 (High vs Low)` = feature(des.arlnc1))
vn.iua_arlnc1 <- step1(vn.iua_arlnc1)
clear(vn.iua_arlnc1)

# saves('analysis_workflow.rdata')
# loads('analysis_workflow.rdata')

# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  des.iua@plots$step3$topDegs$`IUA vs control`$p.hp
  des.iua@plots$step3$topDegs$`IUA vs control`$p.volcano
  notshow(des.iua@plots$step1$p.boxplot)
  notshow(des.iua@tables$step2$t.results$`IUA vs control`)
  notshow(des.iua@tables$step2$t.sigResults$`IUA vs control`)
  z7(des.iua@params$focusedDegs_ARLNC1$p.BoxPlotOfDEGs, .6, .6)
  wrap(des.iua@params$focusedDegs_ARLNC1$roc$ARLNC1$p.roc, 9, 6.5)
})

#| OVERTURE
output_with_counting_number({
  des.arlnc1@plots$step3$topDegs$`High vs Low`$p.hp
  notshow(des.arlnc1@tables$step2$t.results$`High vs Low`)
  notshow(des.arlnc1@tables$step2$t.sigResults$`High vs Low`)
  des.arlnc1@plots$step3$topDegs$`High vs Low`$p.volcano
})

#| OVERTURE
output_with_counting_number({
  vn.iua_arlnc1@plots$step1$p.venn
  feature(vn.iua_arlnc1)
})


