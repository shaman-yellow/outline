# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "曹卓肺癌和癌旁组织对比分析"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "固定业务",
  title = od_get_title(),
  status = "完成",
  coef = .25,
  date = "2023-11-28",
  info = od_get_info(),
  id = "曹卓肺癌和癌旁组织对比分析",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
