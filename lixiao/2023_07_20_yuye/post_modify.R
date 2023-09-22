# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "IN2023072801-3+销售：王双+客户：于骅+恶性肿瘤肌少症+2-3分"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

## for check

"孙慧 <sunhui@wie-biotech.com>"
"汪丽-业务进度 <wl@hzlxsw.com>"

## final:
"陈芳媛 <wengyuan@wie-biotech.com>"
