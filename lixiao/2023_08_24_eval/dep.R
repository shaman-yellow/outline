

sra <- asjob_sra(meta, "~/disk_sda1/CRA007013")

qi <- asjob_qiime(sra)
qi@object %<>% mutate(group = stringr::str_extract(`sample-id`, "[A-Z]+"))
qi <- set_remote(qi, path = "/data/hlc/CRA007013")
qi <- step1(qi)


