# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

file.copy("./output.pdf", "白晓霞订单.pdf")
package_results(head = NULL, masterZip = NULL, report = "白晓霞订单.pdf")

file.rename("./client.zip", "白晓霞订单.zip")

