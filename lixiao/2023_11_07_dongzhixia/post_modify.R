# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "董志霞-生信支持"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "其他业务",
  title = "分析客户数据差异基因查看是否存在胆固醇膜受体 GPBAR/TGR5 及其相关信号通路",
  status = "完成",
  coef = NA,
  date = "2023-11-10",
  info = od_get_info(),
  id = "董志霞生信支持",
  receive_date = "2023-11-07",
  score = od_get_score(),
  member = "黄礼闯"
)
