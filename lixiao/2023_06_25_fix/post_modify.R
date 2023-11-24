# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

write_thesisDocx("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

package_results()

info <- items(
  belong = odate(7),
  type = "固定业务",
  title = "化合物靶点功能通路分析",
  status = "完成",
  coef = .5,
  date = "2023-06-29",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)

