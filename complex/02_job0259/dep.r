
# ==========================================================================

geo.validate_GSE173078 <- job_geo("validate_GSE173078")
geo.validate_GSE173078 <- step1(geo.validate_GSE173078)
geo.validate_GSE173078 <- step2(geo.validate_GSE173078)
clear(geo.validate_GSE173078)

metadata.validate_GSE173078 <- expect(
  geo.validate_GSE173078, geo_cols(group = "phenotype.ch1"), force = TRUE
)
metadata.validate_GSE173078 <- dplyr::filter(metadata.validate_GSE173078, group != "Gingivitis")
metadata.validate_GSE173078 <- dplyr::mutate(
  metadata.validate_GSE173078, group = ifelse(
    group == "Healthy", "HC", "PD"
  )
)

des.validate_GSE173078 <- asjob_deseq2(
  geo.validate_GSE173078, metadata.validate_GSE173078, recode = c("TENT5C" = "FAM46C")
)
des.validate_GSE173078 <- step1(des.validate_GSE173078)

des.validate_GSE173078 <- focus(
  des.validate_GSE173078, feature(ven.learn),
  ref.use = "symbol", .name = "learn", test = "wilcox.test",
  levels = c("PD", "HC")
)
clear(des.validate_GSE173078)
