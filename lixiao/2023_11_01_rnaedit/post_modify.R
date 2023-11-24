# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "")

id <- "备单：RNA编辑+炎症疾病3-5分"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  belong = odate(11),
  type = "备单业务",
  title = "RNA 编辑和 IgA 肾病中 B 细胞免疫行为的关联性",
  status = "完成",
  coef = .25,
  date = "2023-11-21",
  info = od_get_info(),
  id = "BI20231103",
  receive_date = "2023-11-01",
  score = "3-5",
  member = "黄礼闯"
)
