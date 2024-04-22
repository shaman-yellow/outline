
fun <- function() {
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
  Sys.sleep(1)
}


try(R.utils::withTimeout(fun(), timeout = 2))
