

files <- list.files("./sep8", "gene_counts.tsv", full.names = T, recursive = T)
names(files) <- get_realname(files)

l0 <- list(l1 = list(l2 = list(l3 = list(l4 = list(l5 = list(l6 = list(l7 = list(l8 = 8))))))))

test <- .job_limma()
tt <- get_herb_data()
tt$target$Tax_id




n <- 0
counts <- pbapply::pblapply(files,
  function(file) {
    n <<- n + 1
    if (n == 1)
      header <<- readLines(file, n = 5)
    data <- ftibble(file, skip = 6, header = F)
  })

header <- strsplit(header[2], "\t")[[1]]

all_counts <- data.table::rbindlist(counts, idcol = T)
colnames(all_counts)[-1] <- header

data <- select(all_counts, .id, gene_name, unstranded)
data <- split_lapply_rbind(data, ~.id,
  function(data) {
    dplyr::distinct(data, gene_name, .keep_all = T)
  })

data <- tidyr::spread(data, .id, unstranded)

genes <- distinct(data, gene_name)
metadata <- group_strings(colnames(data)[-1], c(gdc = "."))
metadata$group[1:300] <- "fake"

lm <- job_limma(new_dge(metadata, data, genes))
lm <- step1(lm)

export <- as_tibble(lm@params$normed_data$E)
export <- mutate(export, rownames = lm@params$normed_data$genes$gene_name)
export <- rename(export, hgnc_symbol = rownames)
colnames(export)[-1] <- n(sample, ncol(export) - 1)

data.table::fwrite(export, "tcga_data.csv")
zip("tcga_data.zip", "./tcga_data.csv")
