

sdb.topFlux <- job_stringdb(readLines("test.txt"))
sdb.topFlux <- step1(sdb.topFlux, 100)
saveRDS(sdb.topFlux, "sdb.rds")
