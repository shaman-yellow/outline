# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "沈顺订单"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)

file.rename("./client.zip", paste0(id, ".zip"))

## for check

"孙慧 <sunhui@wie-biotech.com>"
"汪丽-业务进度 <wl@hzlxsw.com>"

## final:
"陈芳媛 <wengyuan@wie-biotech.com>"

file.copy("./index.Rmd", "eval.Rmd")

info <- items(
  type = "固定业务",
  title = "沈顺订单：结合网络药理、16s rRNA、代谢组分析中药复方对糖尿病肾病的作用和靶点（分两部分）",
  status = "完成",
  coef = list(.33, .25),
  date = "2023-09-21",
  info = od_get_info(),
  id = "",
  receive_date = od_get_date(),
  score = "",
  member = "黄礼闯"
)
