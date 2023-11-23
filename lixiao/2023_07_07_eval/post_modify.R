# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

file.copy("./output.pdf", "./eval.pdf", T)

id <- "IN2023072803-3+销售：周燕青+客户：戴心怡+斑痕增生+生信分析"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  type = "固定业务",
  title = "筛出（瘢痕增生）能够与 TCF-AS1 结合又能与 TCF4 结合的 RNA 结合蛋白",
  status = "完成",
  coef = .34,
  date = "2023-07-18",
  info = od_get_info(),
  id = "IN2023072803",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
