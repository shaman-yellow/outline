# https://cran.r-project.org/web/packages/openxlsx/vignettes/Formatting.html
wb <- openxlsx::loadWorkbook("./performance_templ/test.xlsx")

# https://cran.r-project.org/web/packages/openxlsx2/index.html
# https://janmarvin.github.io/openxlsx2/reference/index.html
wb <- openxlsx2::wb_load("./performance_templ/test.xlsx")
pos.body <- list(7, 1)
pos.date <- list(3, 1)

wb <- openxlsx2::wb_add_data(wb, 1, head(mtcars),
  dims = do.call(openxlsx2::wb_dims, pos.body))
wb <- openxlsx2::wb_add_data(wb, 1, "2023年 10月 01日至2023年 11月 31日",
  dims = do.call(openxlsx2::wb_dims, pos.date))

openxlsx2::wb_save(wb, "./performance_templ/output.xlsx")


