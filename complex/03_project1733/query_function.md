
接下来，我会不断提供给你函数，希望你能根据函数的逻辑，
为我提供分析的目的。注意，我在做生物信息学的研究，
主要目的是形成分析报告，生物信息学方向的，
你可以视作一种论文级别的写作。我希望你尽可能忽视函数中的
技术性操作，例如，缓存等操作，而是从论文发表的角度来
选取需要说明的要点，为我展开论述，这样我才好利用你的文字辅助我的工作。
请提供一段中文的论述，简明扼要些，不要无限制地展开。

补充一下，你提供给我的文字，我会嵌入到我的 R 代码框架中，
用于自动化报告生成。因此，请你以 glue::glue 为基础，为我提供文字。
例如：“设置参数 {pval_threshold} …… ”
此外，请你视情况对某些参数使用 round 或 signif 等函数，方便我在报告中展示。
同时，你需要视情况，来展示某些要点参数——不是很重要的参数就不需要罗列在其中了。
请你以论文发表为导向来思考这些问题。

再次补充：对于某些重要 R 包 (获取数据来源或者主要分析内容的R 包) 
你需要以 “以 R 包 `which` ⟦pkgInfo('which')⟧”这种格式来说明 R 包，
⟦⟧ 这个是我特殊设置的 glue::glue 识别符号，专门用于 R 包这方面的处理。

提示，目前阶段，我需要你提供的内容全都会是双样本孟德尔随机化的分析。
你的说明会被我嵌入到报告中间阶段——所以你没必要从头开始说明，显得重复。

我给你提供的第一个函数是：


.get_exposure_opengwas_eqtlgen <- function(
  genes,
  pval_threshold = 5e-08,
  clump_r2 = 0.01,
  clump_kb = 10000L,
  rerun = FALSE
)
{
  fun_get_data <- function(...) {
    .check_pkg("AnnotationDbi")
    .check_pkg("org.Hs.eg.db")
    .check_pkg("TwoSampleMR")

    message(glue::glue("Mapping {length(genes)} genes to Ensembl and eQTLGen IDs..."))

    # 1. Map to Ensembl for GTEx
    map <- AnnotationDbi::select(
      org.Hs.eg.db::org.Hs.eg.db,
      keys = as.character(genes),
      keytype = "SYMBOL",
      columns = c("SYMBOL", "ENSEMBL")
    )

    map <- tibble::as_tibble(map)
    map <- dplyr::filter(map, !is.na(ENSEMBL))
    map <- dplyr::distinct(map)

    # Add id.exposure to map for joining later
    map <- dplyr::mutate(map, id.exposure = paste0("eqtl-a-", ENSEMBL))

    all_query_ids <- unique(map$id.exposure)

    # 2. Fetch instruments from OpenGWAS of eQTLGen
    message(glue::glue("Querying OpenGWAS for eQTLGen data..."))

    res_raw <- tryCatch({
      TwoSampleMR::extract_instruments(
        outcomes = all_query_ids,
        p1 = pval_threshold,
        clump = TRUE,
        r2 = clump_r2,
        kb = clump_kb
      )
    }, error = function(e) {
      message("API request failed: ", e$message)
      return(NULL)
    })

    if (is.null(res_raw) || !nrow(res_raw)) {
      message("No significant eQTLs found in database.")
      return(NULL)
    }

    res_with_symbol <- dplyr::left_join(
      res_raw,
      dplyr::select(map, SYMBOL, id.exposure),
      by = "id.exposure"
    )

    res_with_symbol <- dplyr::filter(res_with_symbol, SYMBOL %in% genes)

    if (!nrow(res_with_symbol)) {
      message("No significant results remain after filtering for requested genes.")
      return(NULL)
    }
    res_with_symbol <- dplyr::relocate(res_with_symbol, SYMBOL)
    tibble::as_tibble(res_with_symbol)
  }

  data <- expect_local_data(
    "tmp", "exposure_eqtl", fun_get_data,
    list(as.character(genes), pval_threshold, clump_r2, clump_kb),
    rerun = rerun
  )
  which_not_in_data(data, "SYMBOL", genes)
  message(
    glue::glue("All results stat: {try_snap(data, 'SYMBOL', 'SNP')}")
  )
  return(data)
}



