# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "IN2023110603-3+销售：吴航贵+客户：袁路+糖尿病视网膜病变+生信分析3-4分"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  type = "固定业务",
  title = "OCTA 在糖尿病视网膜病变中的应用",
  status = "完成",
  coef = .25,
  date = "2023-11-17",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
