## excellent datasets: 35863004 https://ngdc.cncb.ac.cn/gsa/browse/CRA007013

# ==========================================================================
# analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## useless candidate 35548353: PRJNA812954
## 35548353 PRJNA778921

# The Intestinal Microbiota Composition in Early and Late Stages of Diabetic Kidney Disease
## 37341590
project <- "PRJNA824185"
primer_f <- "CCTACGGGNGGCWGCAG"
primer_r <- "GACTACHVGGGTATCTAATCC"
dir.create("sra_data")
cdRun("esearch -db sra -query ", project, " | efetch -format runinfo > ./sra_data/info.csv")

info <- ftibble("./sra_data/info.csv")

## download sra
pbapply::pblapply(info$Run,
  function(id) {
    path <- "./sra_data"
    exists <- file.exists(paste0(path, "/", id))
    while (!exists) {
      cdRun("prefetch ", id, " ", "--output-directory ", path)
      exists <- file.exists(paste0(path, "/", id))
    }
  })

## as fastq
files <- list.files("./sra_data/", "\\.sra$", full.names = T, recursive = T)
pbapply::pblapply(files,
  function(file) {
    path <- get_path(file)
    cdRun("fastq-dump --gzip --split-3 ", file, " -O ", path)
  })

## arrange metadata
info <- mutate(info, SampleName = gs(SampleName, "_", "."))
metadata <- select(info, "sample-id" = SampleName, Run)
filepath <- lapply(metadata$Run,
  function(id) {
    path <- list.files(paste0("./sra_data/", id), "fastq\\.gz", full.names = T)
    normalizePath(path)
  })
fun <- function(lst, n) vapply(lst, function(vec) vec[n], character(1))
metadata[[ "forward-absolute-filepath" ]] <- fun(filepath, 1)
metadata[[ "reverse-absolute-filepath" ]] <- fun(filepath, 2)
metadata <- filter(metadata, !grepl("DM", `sample-id`))
metadata <- mutate(metadata, group = stringr::str_extract(`sample-id`, "[A-Z]+"))

write_tsv(metadata, "./sra_data/metadata.tsv")

## activate conda
conda_env <- filter(reticulate::conda_list(), grepl("qiime", name))$name
base::Sys.setenv(RETICULATE_PYTHON = paste0("/home/echo/miniconda3/envs/", conda_env, "/bin/python"))
reticulate::py_config()
reticulate::use_condaenv(conda_env, "~/miniconda3/bin/conda", required = TRUE)
platform <- reticulate::import("platform")
cdRun("qiime")

#| import
## https://docs.qiime2.org/2023.7/tutorials/importing/#sequence-data-with-sequence-quality-information-i-e-fastq
cdRun(
  "qiime tools import",
  " --type 'SampleData[PairedEndSequencesWithQuality]'",
  " --input-path metadata.tsv",
  " --output-path demux.qza",
  " --input-format PairedEndFastqManifestPhred33V2",
  path = "./sra_data"
)

#| Demultiplexing-sequences-visualization
cdRun(
  "qiime demux summarize ",
  " --i-data demux.qza ",
  " --o-visualization demux.qzv",
  path = "./sra_data"
)

#| show-demux
qiime_vis <- function(file) {
  cdRun("qiime tools view ", file)
}
qiime_vis("./sra_data/demux.qzv")

#| Sequence-quality-control-and-feature-table-construction-with-DADA2
cdRun(
  "time qiime dada2 denoise-paired ",
  " --i-demultiplexed-seqs demux.qza ",
  " --p-n-threads 7 ",
  " --p-trim-left-f 0 --p-trim-left-r 0 ",
  " --p-trunc-len-f 250 --p-trunc-len-r 250 ",
  " --o-table table.qza ",
  " --o-representative-sequences rep-seqs.qza ",
  " --o-denoising-stats denoising-stats.qza",
  path = "./sra_data"
)

cdRun(
  "qiime metadata tabulate ",
  " --m-input-file denoising-stats.qza ",
  " --o-visualization denoising-stats.qzv",
  path = "./sra_data"
)
qiime_vis("./sra_data/denoising-stats.qzv")

#| FeatureTable-and-FeatureData-summaries
cdRun(
  "qiime feature-table summarize ",
  " --i-table table.qza ",
  " --m-sample-metadata-file metadata.tsv ",
  " --o-visualization table.qzv",
  path = "./sra_data"
)

qiime_vis("./sra_data/table.qzv")
min <- 3697
max <- 19116

cdRun(
  "qiime feature-table tabulate-seqs ",
  " --i-data rep-seqs.qza ",
  " --o-visualization rep-seqs.qzv",
  path = "./sra_data"
)
qiime_vis("./sra_data/rep-seqs.qzv")

#| Generate-a-tree-for-phylogenetic-diversity-analyses
cdRun(
  "qiime phylogeny align-to-tree-mafft-fasttree ",
  " --i-sequences rep-seqs.qza ",
  " --output-dir tree",
  path = "./sra_data"
)

#| calculate-diversity-core-metrics
cdRun(
  "qiime diversity core-metrics-phylogenetic ",
  " --i-phylogeny tree/rooted_tree.qza ",
  " --i-table table.qza ",
  " --p-sampling-depth ", min,
  " --m-metadata-file metadata.tsv ",
  " --output-dir diversity",
  path = "./sra_data"
)

#| Alpha-diversity-analysis
dir.create("./sra_data/diversity_alpha_group_significant")
pbapply::pblapply(c("faith_pd", "shannon", "observed_features", "evenness"),
  function(method) {
    cdRun(
      "qiime diversity alpha-group-significance ",
      " --i-alpha-diversity diversity/", method, "_vector.qza ",
      " --m-metadata-file metadata.tsv ",
      " --o-visualization diversity_alpha_group_significant/", method, ".qzv",
      path = "./sra_data"
    )
  })

#| Alpha-rarefaction-plotting
cdRun(
  "qiime diversity alpha-rarefaction ",
  " --i-table table.qza ",
  " --i-phylogeny tree/rooted_tree.qza ",
  " --p-max-depth ", max,
  " --m-metadata-file metadata.tsv ",
  " --o-visualization alpha-rarefaction.qzv",
  path = "./sra_data"
)
qiime_vis("./sra_data/alpha-rarefaction.qzv")

#| Beta-diversity-analysis
dir.create("./sra_data/diversity_beta_group_significant")
pbapply::pblapply(c("unweighted_unifrac", "bray_curtis", "weighted_unifrac", "jaccard"),
  function(index) {
    cdRun(
      "qiime diversity beta-group-significance ",
      " --i-distance-matrix diversity/", index, "_distance_matrix.qza ",
      " --m-metadata-file metadata.tsv ",
      " --m-metadata-column ", "group",
      " --p-pairwise ",
      " --o-visualization ", "diversity_beta_group_significant/",
      index, "_", "group", "_significance.qzv",
      path = "./sra_data"
    )}
)
qiime_vis("./sra_data/diversity_beta_group_significant/unweighted_unifrac_group_significance.qzv")

#| Taxonomic-analysis
## download
cdRun("wget -O ../weighted_silva_2023_07.qza",
  " https://data.qiime2.org/2023.7/common/silva-138-99-nb-weighted-classifier.qza")

cdRun(
  "qiime feature-classifier classify-sklearn ",
  " --i-classifier /home/echo/outline/lixiao/weighted_silva_2023_07.qza ",
  " --i-reads rep-seqs.qza ",
  " --o-classification taxonomy.qza",
  path = "./sra_data"
)

cdRun(
  "qiime metadata tabulate ",
  " --m-input-file taxonomy.qza ",
  " --o-visualization taxonomy.qzv",
  path = "./sra_data"
)

qiime_vis("./sra_data/taxonomy.qzv")

cdRun(
  "qiime taxa barplot ",
  " --i-table table.qza ",
  " --i-taxonomy taxonomy.qza ",
  " --m-metadata-file metadata.tsv ",
  " --o-visualization taxa-bar-plots.qzv",
  path = "./sra_data"
)

qiime_vis("./sra_data/taxa-bar-plots.qzv")


#| Differential-abundance-testing-with-ANCOM
ancom_test <- function(level = 6, table = "table.qza", path = "./sra_data") {
  if (!is.null(level)) {
    cdRun(
      "qiime taxa collapse ",
      " --i-table ", table,
      " --i-taxonomy taxonomy.qza ",
      " --p-level ", level,
      " --o-collapsed-table ", ntable <- paste0("table_level_", level, ".qza"),
      path = "./sra_data"
    )
    table <- ntable
  }
  cdRun(
    "qiime composition add-pseudocount ",
    " --i-table ", table,
    " --o-composition-table ", com_table <- paste0("comp_table_level_", level, ".qza"),
    path = path
  )
  cdRun(
    "qiime composition ancom ",
    " --i-table ", com_table,
    " --m-metadata-file metadata.tsv ",
    " --m-metadata-column ", "group",
    " --o-visualization ", res <- paste0("ancom_test_group_level_", level, ".qzv"),
    path = path
  )
  paste0(path, "/", res)
}

ancom_test(NULL)
ancom_test(6)
ancom_test(5)
ancom_test(4)

qiime_vis("./sra_data/ancom_test_group_level_.qzv")
qiime_vis("./sra_data/ancom_test_group_level_6.qzv")
qiime_vis("./sra_data/ancom_test_group_level_5.qzv")
qiime_vis("./sra_data/ancom_test_group_level_4.qzv")

## qiime2 processing
## https://docs.qiime2.org/2023.7/tutorials/
## https://docs.qiime2.org/2023.7/tutorials/moving-pictures-usage/
## https://docs.qiime2.org/2023.7/tutorials/importing/#sequence-data-with-sequence-quality-information-i-e-fastq

## Taxonomy classifiers
## https://docs.qiime2.org/2023.7/data-resources/


## excellent: https://www.jianshu.com/p/4e7e334147c5
## index: https://www.jianshu.com/nb/48116784
## useless: https://gregcaporaso.github.io/q2book/front-matter/preface.html
## extra: https://blog.csdn.net/Y_Alex12/article/details/131494824

