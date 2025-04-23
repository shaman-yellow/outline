Terror <- readRDS("./test.rds")

p <- ggplot(Terror) +
  geom_col(aes(x = group, y = expr, fill = group), position = "dodge") +
  ggforce::facet_row(~ type, space = "free") +
  theme_minimal()
p
