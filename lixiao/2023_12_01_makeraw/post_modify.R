# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "2021112501-原始数据提供"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(12),
  type = "其他业务",
  title = "原始数据提供",
  status = "完成",
  coef = NA,
  date = "2023-12-04",
  info = od_get_info(),
  id = "2021112501-原始数据提供",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
