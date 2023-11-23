# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang in Wie-Biotech'")

id <- "BI2023072101-3+昼夜节律相关+未见肿瘤报道+预后关联单细胞分析+3-5分"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  type = "备单业务",
  title = "结合 scRNA-seq 和 bulk RNA-seq 探究昼夜节律基因对于 ccRCC 的预后评估价值",
  status = "完成",
  coef = .33,
  date = "2023-08-25",
  info = od_get_info(),
  id = "BI2023072101",
  receive_date = od_get_date(),
  score = "3-5",
  member = "黄礼闯"
)
