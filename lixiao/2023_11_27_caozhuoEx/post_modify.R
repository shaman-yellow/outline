# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "曹卓三个补充订单"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "其他业务",
  title = "曹卓交付三个订单所需数据",
  status = "完成",
  coef = cf(500),
  date = "2023-11-27",
  info = od_get_info(),
  id = "曹卓补充订单",
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
