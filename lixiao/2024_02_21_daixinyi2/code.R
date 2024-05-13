
codes <- get_job_source(c(.get_job_list(type = "class"), "seuratn"))
exCodes <- normalizePath(paste0("~/utils.tool/R/",
  c("workflow_00.R", "aaa.R", "a.R", "lixiao.R", "lixiao2.R",
    "flowChart.R", "grid_draw.R", "legend.R", "dot_heatmap.R",
    "exReport2.R", "monocle_plot_pseudo_heatmap.R")))
new_package.fromFiles("utils.tool", c(codes, exCodes),
  exclude = c("nvimcom", "garnett", "boot", "",
    "WGCNA", "SingleR", "openai"),
  extdata = c("~/utils.tool/inst/extdata/articleWithCode.yml")
)
