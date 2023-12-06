# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "Treg 细胞差异表达基因"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(12),
  type = "其他业务",
  title = "ccRCC 单细胞数据的 Treg 细胞差异表达基因",
  status = "完成",
  coef = NA,
  date = "2023-12-05",
  info = od_get_info(),
  id = "Treg 细胞差异表达基因",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
