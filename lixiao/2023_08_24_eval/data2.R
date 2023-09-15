# ==========================================================================
# other optional data (raw)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## [@AlterationsOfZhang2022]
dir.create("CRA007013")
setwd("~/disk_sda1/CRA007013")

link <- start_drive(browser = "fire")
link$open()

html <- link$getPageSource()[[1]]

cra <- stringr::str_extract_all(gs(html, "\n|\t", ""),
  "<a href=\"browse/CRA007013[^>]*>CRR[^<]*</a>|<td colspan=\"2\">[^<]*</td>")[[1]]
cra <- vapply(cra, function(ch) stringr::str_extract(ch, "(?<=>).*(?=<)"), character(1), USE.NAMES = F)
cra <- split(cra, rep(1:2, length(cra) / 2))
cra <- tibble::tibble(sample = cra[[ 2 ]], access = cra[[ 1 ]])
saveRDS(cra, "cra.rds")

used <- filter(cra, grepl("DN|CON", sample))

# redownload <- get_realname(fp@params$failed)
# unlink(redownload, T, T)

prj <- "CRA007013"
isOk <- pbapply::pblapply(used$access,
  function(id) {
    dir.create(id)
    files <- paste0(id, "/", id, "_", c("f", "r"), 1:2, ".fastq.gz")
    prefix <- paste0("https://cncb-gsa.obs.cn-north-4.myhuaweicloud.com:443/data/gsapub/", prj, "/")
    lapply(files,
      function(file) {
        if (!file.exists(file))
          res <- try(cdRun("wget ", paste0(prefix, file), path = id))
        else {
          message()
          cli::cli_alert_info("File exists.")
        }
      })
  })

lapply(fp@params$failed,
  function(path) {
    name <- get_realname(path)
    # system(paste0("ssh remote ", "'rm -r ", path, "'"))
    system(paste0("scp -r ", name, " remote:", object(fp)))
  })

## excellent datasets: 35863004 https://ngdc.cncb.ac.cn/gsa/browse/CRA007013
meta <- openxlsx::read.xlsx("./gsa_data/CRA007013.xlsx")
meta <- as_tibble(filter(meta, grepl("CON|DN", Sample.name)))

# ==========================================================================
# as sra
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setwd("~/outline/lixiao/2023_08_24_eval")

meta <- readRDS("~/disk_sda1/cra.rds")
meta <- rename(meta, SampleName = sample, Run = access)
meta <- filter(meta, grepl("^DN|^CON", SampleName))
meta <- mutate(meta, group = stringr::str_extract(SampleName, "[A-Z]+"))

fp <- job_fastp("/data/hlc/CRA007013")
fp <- set_remote(fp)
fp <- step1(fp, workers = 28)
fp <- step2(fp)

saveRDS(fp, "./fp_cra.rds")

# ==========================================================================
# biobakery
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

fp <- readRDS("./fp_cra.rds")

bk <- asjob_biobakery(fp)
bk <- set_remote(bk, bk$wd)


