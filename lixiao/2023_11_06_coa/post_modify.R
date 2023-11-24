# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "上海东方医院周久立-生信支持申请"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "其他业务",
  title = "头颈部鳞癌中crebbp的表达",
  status = "完成",
  coef = NA,
  date = "2023-11-06",
  info = od_get_info(),
  id = "周久立生信支持",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
