# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "BI2023080108：集成多组 CKD 单细胞数据集发现 IgA 相比于其它 CKD 的与 RCC 之间转化的更高风险"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(10),
  type = "备单业务",
  title = "集成多组 CKD 单细胞数据集发现 IgA 相比于其它 CKD 的与 RCC 之间转化的更高风险",
  status = "完成",
  coef = .25,
  date = "2023-11-01",
  info = od_get_info(),
  id = "BI2023080108",
  receive_date = od_get_date(),
  score = "3-5",
  member = "黄礼闯"
)
