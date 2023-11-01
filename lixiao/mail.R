
pkgload::load_all("~/mailman")

bt <- reticulate::import_builtins()

os <- reticulate::import("os")
sys <- reticulate::import("sys")
m <- reticulate::import("mailbox")
mdir <- m$Maildir(".")

obj <- mdir$get_message(mdir$keys()[1])

att <- obj$get_payload()

n <- lapply(att,
  function(x) {
    if (!x$is_multipart())
      x
  })
n <- lst_clear0(n)

test <- n[[1]]
att <- test$get_payload(decode = T)

fp <- bt$open(test$get_filename(), "wb")
fp$write(att)
fp$close()


