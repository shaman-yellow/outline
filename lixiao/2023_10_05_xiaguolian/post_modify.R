# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "夏国连生信支持+补充分析+补充分析2"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(10),
  type = c("固定业务", rep("其他业务", 2)),
  title = "夏国连生信支持：筛选丹参酮治疗脓毒症的关键差异表达基因及相关信号通路",
  status = "完成",
  coef = c(.25, cf(500), cf(500)),
  date = "2023-10-09",
  info = od_get_info(),
  id = c("夏国连生信支持", "夏国连补充分析1", "夏国连补充分析2"),
  receive_date = "2023-10-05",
  score = od_get_score(),
  member = "黄礼闯"
)
