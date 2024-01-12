
data <- fxlsx("./test10.xlsx")
colnames(data) <- c("name", "inst")

data <- head(data)

res <- search.scopus(data, n = 2)

file.remove("./scopus.rds")

openxlsx::write.xlsx(res, "test.xlsx")
data <- fxlsx("./test.xlsx")


