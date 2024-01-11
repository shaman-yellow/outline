
data <- fxlsx("./test10.xlsx")
colnames(data) <- c("name", "inst")

res <- search.scopus(data)
openxlsx::write.xlsx(res, "test.xlsx")

