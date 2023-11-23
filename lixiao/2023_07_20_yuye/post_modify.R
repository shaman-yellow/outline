# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Analysis\nauthor: 'Huang LiChuang of Wie-Biotech'")

id <- "IN2023072801-3+销售：王双+客户：于骅+恶性肿瘤肌少症+2-3分"
file.copy("./output.pdf", report <- paste0(id, ".pdf"), T)

package_results(head = NULL, masterZip = NULL, report = report)
file.rename("./client.zip", paste0(id, ".zip"))

info <- items(
  type = "固定业务",
  title = "筛选肌少症（Sarcopenia）、结直肠癌（colorectal cancer）、化疗（Chemotherapy）共同的通路",
  status = "完成",
  coef = .25,
  date = "2023-09-28",
  info = od_get_info(),
  id = "IN2023072801",
  receive_date = "2023-09-12",
  score = "2-3",
  member = "黄礼闯"
)
