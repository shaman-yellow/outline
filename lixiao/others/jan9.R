
data <- fxlsx("./test10.xlsx")
colnames(data) <- c("name", "inst")

options("elsevier_api_key" = "58f69947f6da2b226a04c902900961b5")
rscopus:::is_elsevier_authorized()
rscopus::author_df(last_name = "Muschelli", first_name = "John", verbose = FALSE, general = FALSE)
