# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

file.copy("./output.pdf", report <- paste0("说明.pdf"), T)
zip("results.zip", c(report, "./touchPDB_0.0.0.9000.tar.gz", "./annotation.html"))

info <- items(
  type = "固定业务",
  title = "蛋白质信息获取",
  status = "完成",
  coef = .25,
  date = "2023-09-19",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = "2023-09-12",
  score = od_get_score(),
  member = "黄礼闯"
)
