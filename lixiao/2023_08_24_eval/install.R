
install.packages(c("usethis", "devtools", "officer", "gt"))

# install.packages(c("CliquePercolation", "qgraph", "Matrix"))

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("BiocStyle", "ChemmineOB"))

BiocManager::install(c("rvest"))

# install.packages(c("igraph", "ggraph"))

if (!requireNamespace("remotes", quietly = TRUE))
    install.packages("remotes")
remotes::install_github("Cao-lab-zcmu/MCnebula2")

BiocManager::install(c("FELLA", "xcms", "ggtree"))
## For tools query chemical classification via ClassyFire API
remotes::install_github('aberHRML/classyfireR')
## For tools convert CID to KEGG ID
remotes::install_github('xia-lab/MetaboAnalystR')

metanr_packages <- function(){
  metr_pkgs <- c("impute", "pcaMethods", "globaltest", "GlobalAncova",
    "Rgraphviz", "preprocessCore", "genefilter", "sva", "limma", "KEGGgraph",
    "siggenes","BiocParallel", "MSnbase",
    "multtest","RBGL","edgeR","fgsea","devtools","crmn","httr","qs")
  list_installed <- installed.packages()
  new_pkgs <- subset(metr_pkgs, !(metr_pkgs %in% list_installed[, "Package"]))
  if(length(new_pkgs)!=0){
    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
    BiocManager::install(new_pkgs)
    message(c(new_pkgs, " packages added..."))
  }
  if((length(new_pkgs)<1)){
    message("No new packages added...")
  }
}

metanr_packages()

install.packages(c("pdftools", "officedown"))

BiocManager::install(c("limma", "biomaRt", "STRINGdb"))
remotes::install_github('YuLab-SMU/clusterProfiler')

install.packages("RSelenium")

install.packages(c("car", "rms"))
BiocManager::install("ropls")

install.packages(c("randomForest"))

install.packages(c("pROC"))

install.packages(c("DescTools"))

# install.packages(c("gmodels"))

BiocManager::install(c("meta"))
BiocManager::install(c("GEOquery"))

# BiocManager::install("GenomicAlignments")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")

install.packages("ggVennDiagram")

BiocManager::install("RNAseq123")

BiocManager::install("WGCNA")

install.packages(c("simputation", "naniar", "agricolae"))

install.packages(c("pander"))

install.packages(c("survival", "survminer"))

## <https://satijalab.org/seurat/>
## <https://satijalab.org/seurat/articles/install.html>

BiocManager::install("SparseArray")

install.packages(c("sva"))
BiocManager::install(c('fastDummies', 'RcppHNSW', 'RSpectra'))
remotes::install_github("satijalab/seurat", "seurat5")

BiocManager::install(c('HDF5Array', 'beachmat'))
BiocManager::install("glmGamPoi")

reticulate::install_miniconda()
reticulate::py_install(packages = 'umap-learn')

BiocManager::install(c("SingleR"))
BiocManager::install(c("celldex"))

BiocManager::install(c('NMF', 'circlize', 'ComplexHeatmap', 'BiocNeighbors'))
remotes::install_github("sqjin/CellChat")

remotes::install_github('satijalab/seurat-wrappers')

BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats',
    'limma', 'lme4', 'S4Vectors', 'SingleCellExperiment',
    'SummarizedExperiment', 'batchelor', 'HDF5Array',
    'terra', 'ggrastr'))
BiocManager::install("rsample")
remotes::install_github('cole-trapnell-lab/monocle3')

BiocManager::install(c("org.Mm.eg.db", "org.Hs.eg.db"))
BiocManager::install("rly")
remotes::install_github("cole-trapnell-lab/garnett", ref = "monocle3")

## 
install.packages("ggupset")
install.packages("UpSetR")

## remotes::install_github("yixianfan/CRDscore")
## BiocManager::install("Rsamtools")

BiocManager::install("TCGAbiolinks")

install.packages(c("grImport"))
install.packages(c("EFS"))
install.packages(c("lazyWeave"))

system("pip3 install umap-learn")

install.packages("spiralize")
