# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

file.copy("./output.pdf", report <- paste0("说明.pdf"), T)
zip("results.zip", c(report, "./touchPDB_0.0.0.9000.tar.gz", "./annotation.html"))


id <- "IN2023072803-3+销售：周燕青+客户：戴心怡+斑痕增生+生信分析"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

## for check

"孙慧 <sunhui@wie-biotech.com>"
"汪丽-业务进度 <wl@hzlxsw.com>"

## final:
"陈芳媛 <wengyuan@wie-biotech.com>"
