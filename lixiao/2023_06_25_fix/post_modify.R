# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

write_thesisDocx("index.Rmd", "output.Rmd", "Report of Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

package_results()

info <- list(
  type = "固定业务",
  title = "...",
  status = "完成",
  coef = .25,
  date = Sys.Date(),
  receive_date = od_get_date(),
  info = od_get_info(),
  id = od_get_id(),
  score = od_get_score(),
  member = "黄礼闯"
)

