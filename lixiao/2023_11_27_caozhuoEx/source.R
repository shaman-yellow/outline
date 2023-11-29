
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7699235/
dir.create("material")
file.copy("~/Downloads/ijms-21-08730-s001.zip", "./material")
unzip("./material/ijms-21-08730-s001.zip", exdir = "./material")

mdata <- fxlsx("./material/Supplementary R1/Supplementary Table S2_GC MS data.xlsx")
data <- rename(mdata, compounds = 1)
data <- tidyr::gather(data, sample, value, -1)
data <- mutate(data, group = gs(sample, "^([a-zA-Z]+).*", "\\1"))
data <- dplyr::summarize(dplyr::group_by(data, compounds, group), mean = mean(value), sd = sd(value))
print(data, n = Inf)

sdata <- apply(data, 1,
  function(v) {
    rnorm(500, as.double(v[[ "mean" ]]), as.double(v[[ "sd" ]]))
  })
sdata <- as_tibble(t(sdata))
sdata <- cbind(select(data, 1:2), sdata)

mt <- job_metabo()
mt <- step1(mt, unique(sdata$compounds))
print(mt@tables$step1$mapped, n = Inf)

export <- map(sdata, "compounds", mt@tables$step1$mapped, "Query", "KEGG")
export <- filter(export, !is.na(KEGG))
export <- mutate(export, group = ifelse(group == "ctrl", "N", group))
autosv(export, "metabolites-expression")

data.c <- filter(export, group == "LC")
data.c <- tidyr::gather(data.c, name, value, -(1:2))
mcoords.c <- cbind(name = colnames(export)[-(1:2)], select(head(coords$LC, n = 500), row, col, barcodes, pse))
data.c <- tbmerge(data.c, mcoords.c, by = "name")
export.c <- relocate(data.c, KEGG, pse)

autosv(export.c, "metabo-coords")

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

data.ic <- tidyr::gather(export, name, value, -(1:2))
data.ic <- tbmerge(data.ic, distinct(export.c, name, barcodes), by = "name")
data.ic <- dplyr::mutate(data.ic, .barcodes = barcodes)
export.ic <- map(data.ic, "barcodes", as_tibble(sr@object@meta.data), "rownames", "scsa_copykat")
export.ic <- filter(export.ic, group == "LC")

autosv(export.ic, "cancer-metabo-level")

export.ic2 <- map(data.ic, "barcodes", as_tibble(sr@object@meta.data), "rownames", "cell_mapped")
export.ic2 <- filter(export.ic2, group == "LC")

autosv(export.ic2, "cancer-subtypes-metabo-level")

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sr <- readRDS("~/disk_sdb1/2023_10_06_lunST/st.6.rds")
table(ids(sr, "scsa_copykat", unique = F))

mn <- readRDS("~/disk_sdb1/2023_10_06_lunST/mn.4.rds")
data.pse <- as_tibble(data.frame(pseu = monocle3::pseudotime(mn@object)))

coords <- as_tibble(sr@object@images$slice1@coordinates)
barcodes <- coords$rownames
coords <- map(coords, "rownames", as_tibble(sr@object@meta.data), "rownames", "cancer_mapped")
coords$barcodes <- barcodes
coords <- mutate(coords, pse = data.pse$pseu[match(barcodes, data.pse$rownames)])
coords <- split(coords, ifelse(grpl(coords$cancer_mapped, "cancer"),  "LC", "N"))

autosv(data.table::rbindlist(coords), "st-coords")

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6857945/
# metabolites and disease
file.copy("~/Downloads/pone.0225380.s001.xls", "./material")
save.image("simu.rdata")
