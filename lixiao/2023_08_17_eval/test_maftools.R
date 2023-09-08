
file <- "~/disk_sdb5/08_17/res_filtered_all.hg38_multianno.txt"

require(maftools)
test <- annovarToMaf(file, refBuild = "hg38")
test <- read.maf(test)

test <- oncoplot(maf = test, top = 10)

