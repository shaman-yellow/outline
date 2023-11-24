# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

file.copy("./output.pdf", "白晓霞订单.pdf")
package_results(head = NULL, masterZip = NULL, report = "白晓霞订单.pdf")

file.rename("./client.zip", "白晓霞订单.zip")

info <- items(
  belong = odate(9),
  type = "固定业务",
  title = "白晓霞订单：妊娠期肝内胆汁淤积症筛选基因突变",
  status = "完成",
  coef = .25,
  date = "2023-09-08",
  info = od_get_info(),
  id = "白晓霞订单",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
