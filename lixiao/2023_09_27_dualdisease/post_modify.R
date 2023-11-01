# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "BI2023080108：集成多组 CKD 单细胞数据集发现 IgA 相比于其它 CKD 的与 RCC 之间转化的更高风险"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

## for check

"孙慧 <sunhui@wie-biotech.com>"
"汪丽-业务进度 <wl@hzlxsw.com>"

## final:
"陈芳媛 <wengyuan@wie-biotech.com>"
