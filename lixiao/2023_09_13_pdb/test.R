
lapply(c("cli", "pbapply", "R.utils", "r3dmol", "RCurl",
    "rmarkdown", "utils", "XML", "BiocManager", "shiny"),
  function(pkg) {
    if (!requireNamespace(pkg))
      install.packages(pkg)
  })

BiocManager::install(c("BiocStyle", "UniProt.ws"))
 
install.packages("./touchPDB_0.0.0.9000.tar.gz")

## test

require(touchPDB)

syms <- c("ERBB4", "Pik3r1", "AHR", "TP53")
pd <- new_pdb()
pd <- via_symbol(pd, syms)
anno(pd, syms)

