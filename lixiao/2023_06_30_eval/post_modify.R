# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Results of Molecular Docking\nauthor: Huang Lichuang in Wie-Biotech")

file.copy("./output.pdf", "eval.pdf", T)

package_results(head = NULL, masterZip = NULL)

info <- items(
  type = "固定业务",
  title = "分子对接分析",
  status = "完成",
  coef = .5,
  date = "2023-07-07",
  info = od_get_info(),
  id = od_get_id(),
  receive_date = od_get_date(),
  score = od_get_score(),
  member = "黄礼闯"
)
