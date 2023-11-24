# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "IN2023072803-3+销售：周燕青+客户：戴心怡+斑痕增生+生信分析"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "固定业务",
  title = od_get_title(),
  status = "完成",
  coef = .25,
  date = "2023-11-27",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
