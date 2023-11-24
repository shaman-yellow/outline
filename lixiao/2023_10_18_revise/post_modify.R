# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "修改业务：2023041204-潘一伟&魏伦全"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(10),
  type = "其他业务",
  title = "修改业务：2023041204-潘一伟&魏伦全",
  status = "完成",
  coef = 0.083,
  date = "2023-10-20",
  info = od_get_info(),
  id = "2023041204",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
