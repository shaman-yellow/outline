

test <- dplyr::mutate(data,
  last.name = strx(name, "^[^,]+"),
  first.name = gs(name, "[^,]*, (.*?)", "\\1")
)

link <- start_drive()
link$open()

link$navigate("https://www.scopus.com/freelookup/form/author.uri?zone=TopNavBar&origin=NO%20ORIGIN%20DEFINED")
x <- test[4, ]
Sys.sleep(1)
fun_input("//div//input[@id='lastname']", x$last.name)
fun_input("//div//input[@id='firstname']", x$first.name)
fun_input("//div//input[@id='institute']", x$inst)
fun_search("//div//button[@id='authorSubmitBtn']")

html <- link$getPageSource()[[1]]
tables <- get_table.html(html)

ele <- link$findElement("xpath", "//div//input[@id='firstname']")
ele$clearElement()
ele$sendKeysToElement(list("test"))



# ==========================================================================
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

data <- dplyr::mutate(data,
  last.name = strx(name, "^[^,]+"),
  first.name = gs(name, "[^,]*, (.*?)", "\\1")
)

# options("elsevier_api_key" = "58f69947f6da2b226a04c902900961b5")
# rscopus:::is_elsevier_authorized()
# rscopus::author_df(last_name = "Muschelli", first_name = "John", verbose = FALSE, general = FALSE)

# nohup
fun_input <- function(xpath, x) {
  ele <- link$findElement("xpath", xpath)
  ele$sendKeysToElement(list(x))
}
fun_search <- function(xpath) {
  ele <- link$findElement("xpath", xpath)
  ele$sendKeysToElement(list(key = "enter"))
}

link <- start_drive()
link$open()
link$navigate("https://www.scopus.com/freelookup/form/author.uri?zone=TopNavBar&origin=NO%20ORIGIN%20DEFINED")

x <- data[1, ]
fun_input("//div//input[@id='lastname']", x$last.name)
fun_input("//div//input[@id='firstname']", x$first.name)
fun_input("//div//input[@id='institute']", x$inst)
fun_search("//div//button[@id='authorSubmitBtn']")

html <- link$getPageSource()[[1]]
tables <- get_table.html(html)

fun_format <- function(x) {
  x <- as_tibble(x[[1]])
  colnames(x) <- gs(make.names(gs(colnames(x), "\n", "")), "^([^.]+\\.[^.]+).*", "\\1")
  x <- dplyr::select(x, Author, Documents, h.index, Affiliation, City, Country.Territory)
  x <- dplyr::filter(x, !is.na(h.index))
  x <- dplyr::mutate_all(x, function(x) gs(strx(x, "^[^\n]+"), "^\\s*", ""))
  x <- dplyr::mutate(x, Documents = as.double(Documents), h.index = as.double(h.index))
  x
}
y <- fun_format(tables)
y


