
update.packages(ask = FALSE, checkBuilt = TRUE)

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

packageVersion("BiocManager")

BiocManager::install(ask = FALSE, 
  c("usethis", "devtools", "officer", "gt", "bibtex")
)

install.packages(c("flextable", "showtext"))

# install.packages(c("CliquePercolation", "qgraph", "Matrix"))

# conda install -c conda-forge openbabel
BiocManager::install(ask = FALSE, c("BiocStyle", "ChemmineOB"))
BiocManager::install(ask = FALSE, c("rvest"))

# install.packages(c("igraph", "ggraph"))

install.packages("ggplot2")
install.packages("systemfonts")
# install.packages(c("ggimage", "rsvg"))
# conda install -c conda-forge r-rsvg r-ggimage
if (!requireNamespace("remotes", quietly = TRUE))
    install.packages("remotes")
remotes::install_github("Cao-lab-zcmu/MCnebula2")

install.packages("pak")
yulab_pkgs <- c("YuLab-SMU/yulab.utils",
  "YuLab-SMU/enrichit", "YuLab-SMU/ggtangle",
  "YuLab-SMU/GOSemSim", "YuLab-SMU/DOSE", "YuLab-SMU/enrichplot",
  "YuLab-SMU/tidytree", "YuLab-SMU/treeio", "YuLab-SMU/ggtree"
)
pak::pkg_install(yulab_pkgs)
pak::pkg_install("YuLab-SMU/clusterProfiler")

BiocManager::install(ask = FALSE, c("FELLA", "xcms", "ggtree", "BiocParallel"))
## For tools query chemical classification via ClassyFire API
remotes::install_github('aberHRML/classyfireR')

BiocManager::install(ask = FALSE, "ChemmineR")
pak::pkg_install("Cao-lab-zcmu/exMCnebula2")

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
    BiocManager::install(ask = FALSE, new_pkgs)
    message(c(new_pkgs, " packages added..."))
  }
  if((length(new_pkgs)<1)){
    message("No new packages added...")
  }
}

# conda install -c conda-forge graphviz-dev
metanr_packages()
# conda install -c conda-forge r-qs
BiocManager::install(ask = FALSE, 'xia-lab/MetaboAnalystR')

install.packages(c("pdftools", "officedown"))

# install.packages("curl")
BiocManager::install(ask = FALSE, c("limma", "biomaRt", "STRINGdb"))
# remotes::install_github('YuLab-SMU/clusterProfiler')

install.packages("RSelenium")

install.packages(c("car", "rms"))
BiocManager::install(ask = FALSE, "ropls")

install.packages(c("randomForest"))
install.packages(c("pROC"))
install.packages(c("DescTools"))
BiocManager::install(ask = FALSE, update = FALSE, c("meta", "GEOquery"))

# BiocManager::install(ask = FALSE, "GenomicAlignments")
BiocManager::install(ask = FALSE, "rtracklayer")
BiocManager::install(ask = FALSE, "BSgenome.Hsapiens.UCSC.hg38")

install.packages("ggVennDiagram")

# remotes::install_version("RCurl", version = "1.4.2")
BiocManager::install(ask = FALSE, "RNAseq123")
BiocManager::install(ask = FALSE, "WGCNA", update = FALSE)
install.packages(
  c("simputation", "naniar", "agricolae", "survival", "survminer", "pander")
)

## <https://satijalab.org/seurat/>
## <https://satijalab.org/seurat/articles/install.html>

install.packages('harmony')
# reinstall("harmony")
BiocManager::install(ask = FALSE, "SparseArray")
# install.packages(c("sva"))
BiocManager::install(ask = FALSE, c('fastDummies', 'RcppHNSW', 'RSpectra'))
# remotes::install_github("satijalab/seurat-object")
# remotes::install_github("atijalab/sctransform")
remotes::install_github("satijalab/seurat", force = TRUE)
remotes::install_github("HenrikBengtsson/future", 
  ref = "develop")
# devtools::install_github("thomasp85/patchwork")

BiocManager::install(ask = FALSE, c('HDF5Array', 'beachmat'))
BiocManager::install(ask = FALSE, "glmGamPoi")

reticulate::install_miniconda()
reticulate::py_install(packages = 'umap-learn')

BiocManager::install(ask = FALSE, c("SingleR"))
BiocManager::install(ask = FALSE, c("celldex"))

BiocManager::install(ask = FALSE, c('NMF', 'circlize', 'ComplexHeatmap', 'BiocNeighbors'))
# pip  install umap-learn
devtools::install_github('immunogenomics/presto')
remotes::install_github("jinworks/CellChat", force = TRUE)

remotes::install_github('satijalab/seurat-wrappers')

BiocManager::install(ask = FALSE, c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats',
    'limma', 'lme4', 'S4Vectors', 'SingleCellExperiment',
    'SummarizedExperiment', 'batchelor', 'HDF5Array',
    'terra', 'ggrastr'))
BiocManager::install(ask = FALSE, "rsample")

# remotes::install_version("Matrix", version = "1.6-3")
# install.packages('irlba', force = T)
# BPCells
remotes::install_github("bnprks/BPCells/r")
# remotes::install_github("r-spatial/sf")
# conda install -c bioconda r-monocle3

# conda install -c conda-forge r-base=4.4
# conda install -c conda-forge r-sf 
BiocManager::install(version = "3.20", force = TRUE)
# BiocManager::install(ask = FALSE, "Biobase", force = TRUE)

BiocManager::install("matrixStats", version = "3.20", force = TRUE)
pak::pkg_install('cole-trapnell-lab/monocle3')

BiocManager::install(ask = FALSE, c("org.Mm.eg.db", "org.Hs.eg.db"))
BiocManager::install(ask = FALSE, "rly")
remotes::install_github("cole-trapnell-lab/garnett", ref = "monocle3")

## 
install.packages(c("ggupset", "UpSetR"))

## remotes::install_github("yixianfan/CRDscore")
## BiocManager::install(ask = FALSE, "Rsamtools")

# BiocManager::install(ask = FALSE, "TCGAbiolinks")
remotes::install_github("BioinformaticsFMRP/TCGAbiolinks")
remotes::install_github("ropensci/UCSCXenaTools")

install.packages(c("grImport", "EFS", "lazyWeave"))

# system("pip3 install umap-learn")

install.packages("spiralize")

## https://bioconductor.org/packages/release/bioc/html/MicrobiotaProcess.html
## https://bioconductor.org/packages/release/bioc/vignettes/MicrobiotaProcess/inst/doc/MicrobiotaProcess.html
BiocManager::install(ask = FALSE, "biomformat")
# BiocManager::install(ask = FALSE, "MicrobiotaProcess")
BiocManager::install(ask = FALSE, "qiime2R")

BiocManager::install("survival", force = TRUE)
BiocManager::install("libcoin", force = TRUE)
remotes::install_github("YuLab-SMU/MicrobiotaProcess", force = TRUE)
# library(MicrobiotaProcess)

install.packages(c("gghalves", "ggh4x", "corrr", "ggside"))

install.packages("gsalib")

install.packages("vcfR")
BiocManager::install(ask = FALSE, "maftools")

BiocManager::install(ask = FALSE, "org.Ss.eg.db")
# install.packages("queryup")
BiocManager::install(ask = FALSE, "UniProt.ws")


# BiocManager::install(ask = FALSE, 'biodbUniprot')

install.packages("r3dmol")

install.packages("ggpval")

library(pathview)
BiocManager::install(
  ask = FALSE, update = FALSE, force = TRUE, "RSQLite"
)
BiocManager::install(
  ask = FALSE, update = FALSE, force = TRUE, "pathview"
)

## Estimating the population abundance of tissue-infiltrating immune and stromal cell populations using gene expression
## [@EstimatingTheBecht2016]
## https://github.com/ebecht/MCPcounter

## xCell: digitally portraying the tissue cellular heterogeneity landscape
## https://github.com/dviraran/xCell

## MitoCarta3.0（http://www.broadinstitute.org/mitocarta）

## ST
BiocManager::install(ask = FALSE, "hdf5r")

devtools::install_github("liuhong-jia/scAnno")
# BiocManager::install(ask = FALSE, "rjags")
# conda remove jags r-rjags --force
# conda install -c conda-forge jags r-rjags
# conda install --force-reinstall -c conda-forge r-base jags r-rjags libstdcxx-ng
install.packages("rjags", configure.args = "--enable-rpath")
BiocManager::install(ask = FALSE, force = TRUE, update = FALSE, "infercnv")
library(infercnv)

# remotes::install_github("Bioconductor/BiocGenerics")
# remotes::install_github("Bioconductor/S4Vectors")
# remotes::install_github("Bioconductor/Biostrings")
# remotes::install_github("Bioconductor/GenomicFeatures")
# BiocManager::install("GenomicFeatures")
# remotes::install_github("Bioconductor/GenomicRanges")
# reinstall("GenomicFeatures")
# library(GenomicFeatures)

remotes::install_github("navinlabcode/copykat")

## GWAS: GAPIT <https://github.com/jiabowang/GAPIT>
## GWAS: PoPs <https://www.nature.com/articles/s41588-023-01443-6#code-availability>

## Transcriptomic deconvolution in cancer and other heterogeneous tissues remains challenging. Available methods lack the ability to estimate both component-specific proportions and expression profiles for individual samples
## https://wwylab.github.io/DeMixT/
## https://github.com/wwylab/TmS

## https://www.bioconductor.org/packages/devel/bioc/vignettes/RUVSeq/inst/doc/RUVSeq.html

## Robust integration of multiple single-cell RNA sequencing datasets using a single reference space
## https://github.com/bioinfoDZ/RISC
## https://github.com/bioinfoDZ/RISC/blob/master/GSE123813_Vignette_RISC_v1.6.pdf
remotes::install_github("cvarrichio/Matrix.utils")
devtools::install_github("https://github.com/bioinfoDZ/RISC.git")

BiocManager::install(ask = FALSE, "DropletUtils")

## De novo detection of somatic mutations in high-throughput single-cell profiling data sets
## [@DeNovoDetectiMuyas2023]
## https://github.com/cortes-ciriano-lab/SComatic

## PhyloVelo - Phylogeny-based transcriptomic velocity of single cells
## https://github.com/kunwang34/PhyloVelo

install.packages("filesstrings")

## https://phylovelo.readthedocs.io/en/latest/notebook/cd8%2BTcells-Copy1.html

## https://github.com/velocyto-team/velocyto.R
remotes::install_github("velocyto-team/velocyto.R")

devtools::install_github("Hy4m/linkET")

# https://github.com/irrationone/cellassign

# reinstall("readr")
# reinstall("readxl")
install.packages("bibliometrix")
# library(bibliometrix)

# https://cran.r-project.org/web/packages/PantaRhei/vignettes/panta-rhei.html
install.packages("lubridate")
install.packages("openxlsx2")
# https://jokergoo.github.io/ComplexHeatmap-reference/book/index.html

install.packages("randomForestSRC")
install.packages("ggthemes")

# install.packages("ecce")
install.packages("gtranslate")

remotes::install_github("omarwagih/ggseqlogo")

install.packages("showtext")

options(timeout = 100000)
BiocManager::install(ask = FALSE, "SNPlocs.Hsapiens.dbSNP155.GRCh38")
BiocManager::install(ask = FALSE, "BSgenome.Hsapiens.NCBI.GRCh38")
BiocManager::install(ask = FALSE, "GenomicFiles")

# BiocManager::install(ask = FALSE, "MungeSumstats")
remotes::install_github("Al-Murphy/MungeSumstats")

# conda install -c conda-forge r-magick
# conda install -c conda-forge imagemagick
install.packages("magick")
# install.packages("PubChemR")
devtools::install_github("selcukorkmaz/PubChemR")
# BiocManager::install(ask = FALSE, "GEOmetadb")
install.packages("rscopus")
install.packages("foreign")

BiocManager::install(ask = FALSE, "xcms")
# sudo apt install libgsl-dev
BiocManager::install(ask = FALSE, "curatedMetagenomicData")
install.packages("readxlsb")

install.packages("tesseract")

# for pRRophetic2
BiocManager::install(ask = FALSE, c("car", "ridge", "preprocessCore", "genefilter", "sva"))

BiocManager::install(ask = FALSE, "epidecodeR")

BiocManager::install(ask = FALSE, "ChemmineR")

install.packages("openai")
remotes::install_github("Winnie09/GPTCelltype")

# R CMD javareconf
# install.packages("rJava")
# conda install -c conda-forge r-rjava
install.packages("rcdk")

remove.packages(c("codetools", "lattice", "MASS", "nlme", "spatial"), lib = "/usr/lib/R/library")
devtools::install_github("cysouw/qlcMatrix")
BiocManager::install(ask = FALSE, "monocle")
install.packages("codetools")
install.packages("nlme")

pak::pkg_install("jokergoo/ComplexHeatmap")
pak::pkg_install("stemangiola/tidyHeatmap")

# BiocManager::install(ask = FALSE, version = "3.19")
# BiocManager::install(ask = FALSE, c("STRINGdb"))

BiocManager::install(ask = FALSE, "Rcpp")
BiocManager::install(ask = FALSE, c("ensembldb", "biovizBase"))
BiocManager::install(ask = FALSE, c("missMethyl", "minfi", "Gviz", "DMRcate", "methylationArrayAnalysis"))
remotes::install_github("ivanek/Gviz")

BiocManager::install(ask = FALSE, "methylKit")

remotes::install_github("hrbrmstr/ggchicklet")

BiocManager::install(ask = FALSE, "Cardinal")
remotes::install_github("kuwisdelu/matter", "RELEASE_3_19")
remotes::install_github("kuwisdelu/Cardinal", "RELEASE_3_19")
# remotes::install_local("~/matter/")
BiocManager::install(ask = FALSE, "CardinalWorkflows")

install.packages('harmony')

BiocManager::install(ask = FALSE, "Mfuzz")

# install.packages("gtsummary")
install.packages("summarytools")
install.packages("timeROC")
install.packages("estimate", repos = "http://r-forge.r-project.org")

BiocManager::install(ask = FALSE, "densvis")
devtools::install_github("califano-lab/PISCES")
# library(PISCES)
# browseVignettes(package = "PISCES")

# https://github.com/l-magnificence/Mime
if (!requireNamespace("CoxBoost", quietly = TRUE))
  devtools::install_github("binderh/CoxBoost")
if (!requireNamespace("fastAdaboost", quietly = TRUE))
  devtools::install_github("souravc83/fastAdaboost")

if (!requireNamespace("Mime", quietly = TRUE))
  devtools::install_github("l-magnificence/Mime")

BiocManager::install(ask = FALSE, "bio3d")

install.packages("tableone")

install.packages(c('optparse','RColorBrewer'))
BiocManager::install(ask = FALSE, "BSgenome.Hsapiens.1000genomes.hs37d5")
BiocManager::install(ask = FALSE, "SNPlocs.Hsapiens.dbSNP155.GRCh37")

install.packages("gwasrapidd")

install.packages("forestplot")
install.packages("ggridges")

devtools::install_github("jmzeng1314/AnnoProbe")

# BiocManager::install(ask = FALSE, "ChemmineR")
# remotes::install_github("Cao-lab-zcmu/exMCnebula2")

BiocManager::install(ask = FALSE, "RCy3")
BiocManager::install(ask = FALSE, "AUCell")

devtools::install_github("IOBR/IOBR")

install.packages("svMisc")

# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Is there an R package tool that enables data transfer between different R sessions?
# Because sometimes I need to analyze data in R in different conda
# environments, but I don't want to switch between different environments.
# I have this idea because I have knowledge of the refinement package, which
# allows R to easily call Python and implement data transfer.
# Can R have a function to call R in another session?


