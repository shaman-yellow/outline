# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "协助业务：A2023060507-c+客户：王益斐+销售：龙艳+脓毒症肠损伤+2-3分-生信分析"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "其他业务",
  title = "脓毒症肠损伤联合肠道菌与代谢物分析",
  status = "完成",
  coef = NA,
  date = "2023-11-22",
  info = od_get_info(),
  id = "A2023060507",
  receive_date = od_get_date(),
  score = "2-3",
  member = "黄礼闯"
)
