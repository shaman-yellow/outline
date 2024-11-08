
list.dirs()
list.files(".", "*.pdf", recursive = T)

files <- c("2024_06_04_caozhuo2/空代+空转+单细胞的联合分析+空代+空转+单细胞的联合分析.pdf",
"2024_02_21_daixinyi2/IN2024042201-3+销售：周燕青+客户：戴心怡+HNRNPH1、Wnt 与瘢痕增生的关联性挖掘+SCI 0-3分分.pdf",
"2024_04_03_shiweiming/N2024040301-3+销售：金华\\邱海玉+客户：施卫明+XX基因通过促进糖酵解促进巨噬细胞M1极化.pdf")
zip("../bosai/example.zip", files)

