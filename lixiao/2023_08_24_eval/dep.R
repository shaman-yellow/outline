

cids <- mp@tables$step5$db_data_matched$Substrate.PubChem.CID %>% .[!is.na(.)]
file_syno <- query_synonyms(cids, "synonyms", curl_cl = 5)
syno <- do.call(dplyr::bind_rows, extract_rdata_list(file_syno))

matchThat(syno$syno, make.names(la$tops))



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


qi <- asjob_qiime(fp, meta, "cra_remote_qiime")
qi <- set_remote(qi, "/data/hlc/CRA007013")
qi <- step1(qi)
qi <- step2(qi, 150, 150, workers = 30)

qi <- step3(qi)
qi <- step4(qi, 5000)
qi <- step5(qi, 10000)
qi <- step6(qi)
qi <- step7(qi)

