

sra <- asjob_sra(meta, "~/disk_sda1/CRA007013")

qi <- asjob_qiime(sra)
qi@object %<>% mutate(group = stringr::str_extract(`sample-id`, "[A-Z]+"))
qi <- set_remote(qi, path = "/data/hlc/CRA007013")
qi <- step1(qi)


# GSE189005
ge <- job_geo("GSE189005")
ge <- step1(ge)
ge <- step2(ge, "results")

top_table1 <- fxlsx("./GSE189005/2. Differential RNA expression analysis in cluster B/Analysts-based classification/T2DN vs T2DwtC.xlsx")
top_table2 <- fxlsx("./GSE189005/3. Differential RNA expression analysis in cluster C/Analysts-based classification/T2DR_vs_T2DwtC.xlsx")


