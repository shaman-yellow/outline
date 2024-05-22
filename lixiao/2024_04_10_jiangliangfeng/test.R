

data <- tibble::tibble(match = 1:10, id = 1:10, test = 1:10)

data <- dplyr::arrange(data, match, dplyr::desc(id))
data <- dplyr::distinct(data, match, id, .keep_all = T)
