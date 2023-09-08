# ==========================================================================
# convert ...
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pdb <- readLines('~/pinyinDB/misc/pinyin_huge.txt')
pdb <- tibble::tibble(V1 = stringr::str_extract(pdb, "^[a-z]*"),
  V2 = gsub('^[a-z ]*', '', pdb)
)

data <- lapply("~/Downloads/pinyin.txt",
  function(file) {
    lines <- readLines(file)
    pinyin <- stringr::str_extract(lines, "^[a-z]{1,}")
    chinese <- gsub("^[a-z ]{1,}", "", lines)
    data.frame(V1 = pinyin, V2 = chinese)
  })
data <- c(data, list(pdb))
data <- data.table::rbindlist(data)

data <- dplyr::mutate(data, V1 = gsub('\'', '', V1))
data <- split(data, data$V1)
len2 <- which(vapply(data, nrow, double(1)) > 1)

data[len2] <- lapply(data[len2],
  function(data) {
    name <- data[1, 1]
    V2 <- paste(data$V2, collapse = " ")
    V2 <- strsplit(V2, " ")[[1]]
    V2 <- unique(V2)
    V2 <- paste(V2, collapse = " ")
    data.frame(V1 = name, V2 = V2)
  })

data <- data.table::rbindlist(data)
data <- dplyr::arrange(data, V1)

data.table::fwrite(data, "~/pinyinDB/misc/pinyin_huge.txt",
  col.names = F, sep = " ", quote = F)


