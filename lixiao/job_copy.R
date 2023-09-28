

# for sync to
# http://192.168.18.99:8000/#shared-libs/lib/ad3a6679-47ad-48c9-9b7d-3d8604693669/%E9%BB%84%E7%A4%BC%E9%97%AF
# files first copy to ~/disk_sdb1/my_job

thedir <- function(month, year = 2023) {
  month <- as.character(month)
  if (nchar(month) < 2) {
    month <- paste0("0", month)
  }
  paste0("~/disk_sdb1/my_job/", year, month)
}

cp <- function(from, to) {
  if (!dir.exists(to)) {
    dir.create(to)
  }
  file.copy(from, to, T, T)
}

cp("~/outline/lixiao/2023_06_25_fix/N2023062002.zip", thedir(7))
cp("~/outline/lixiao/2023_06_30_eval/results_chem_docking.zip", thedir(7))

cp("~/outline/lixiao/2023_07_07_eval/IN2023072803-3+销售：周燕青+客户：戴心怡+斑痕增生+生信分析.zip", thedir(8))
cp("~/outline/lixiao/2023_07_24_base/BI2023072101-3+昼夜节律相关+未见肿瘤报道+预后关联单细胞分析+3-5分.zip", thedir(8))
cp("~/outline/lixiao/2023_08_24_eval/沈顺订单.zip", thedir(8))
writeLines("沈顺订单分为两部分，本月为第一部分。", "~/disk_sdb1/my_job/202308/ps.txt")

cp("~/outline/lixiao/2023_08_17_eval/白晓霞订单.zip", thedir(9))
cp("~/outline/lixiao/2023_08_24_eval/沈顺订单.zip", thedir(9))
cp("~/outline/lixiao/2023_09_13_pdb/results_touchPDB.zip", thedir(9))
cp("~/outline/lixiao/2023_07_20_yuye/IN2023072801-3+销售：王双+客户：于骅+恶性肿瘤肌少症+2-3分.zip", thedir(9))
writeLines("沈顺订单分为两部分，本月为第二部分。", "~/disk_sdb1/my_job/202309/ps.txt")


