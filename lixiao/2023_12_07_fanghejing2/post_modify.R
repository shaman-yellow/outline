# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- odb("name", "analysis")
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(12),
  type = "其他业务",
  title = odb("name", "analysis"),
  status = "完成",
  coef = NA,
  date = "2023-12-08",
  info = od_get_info(),
  id = paste0(odb("hname"), "-", id),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
