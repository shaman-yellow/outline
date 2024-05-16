

sdb.topFlux <- job_stringdb(readLines("test.txt"))
sdb.topFlux <- step1(sdb.topFlux)
saveRDS(sdb.topFlux, "sdb.rds")
