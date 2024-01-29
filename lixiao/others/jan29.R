
genes <- c("GABBR1")
genes <- c("GABBR2")

bm <- new_biomart()

genes <- c("GABBR1", "GABBR2")
res <- filter_biomart(bm, c("hgnc_symbol", "ensembl_transcript_id"), filters = "hgnc_symbol", genes)


