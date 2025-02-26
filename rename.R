
files <- list.files("~/utils.tool/R/", "workflow_[0-9]+", full.names = TRUE)
newfiles <- s(files, "workflow_", "workflow_0")
file.rename(files, newfiles)
