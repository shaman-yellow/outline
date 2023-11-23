# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "曹卓空间转录组"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  type = "固定业务",
  title = "曹卓空间转录组：癌细胞鉴定、亚群鉴定、marker分析、细胞通讯等分析",
  status = "完成",
  coef = .25,
  date = "2023-10-17",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = "2023-10-09",
  score = od_get_score(),
  member = "黄礼闯"
)
