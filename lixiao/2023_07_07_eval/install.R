
install.packages(c("usethis", "devtools", "officer", "gt", "rvest"))

# install.packages(c("CliquePercolation", "qgraph", "Matrix"))

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("BiocStyle", "ChemmineOB"))

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

BiocManager::install(c("limma", "biomaRt", "STRINGdb"))
remotes::install_github('YuLab-SMU/clusterProfiler')

install.packages("RSelenium")


