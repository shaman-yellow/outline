# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

browseURL(write_articlePdf("index.Rmd", "output.Rmd", ""))

id <- gid(theme = "rTMS和不完全性脊髓损伤")
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(12),
  type = "其他业务",
  title = "RNA-seq 探究 rTMS 对 SCI 和 NP 的影响",
  status = "完成",
  coef = .25,
  date = "2023-12-12",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
