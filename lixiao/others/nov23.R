
data <- fxlsx("./Ssb1VSCCl4_Gene_differential_expression.xlsx")

edge <- relocate(data, Gene_ID, pathway_name)

p <- ggplot(data) +
  geom_point(aes(x = reorder(Description, GeneRatio),
      y = GeneRatio, size = Count, fill = p.adjust),
    shape = 21, stroke = 0, color = "transparent") +
  scale_fill_gradient(high = "yellow", low = "red") +
  scale_size(range = c(4, 6)) +
  labs(x = "", y = "Gene Ratio") +
  guides(size = guide_legend(override.aes = list(color = "grey70", stroke = 1))) +
  coord_flip() +
  ylim(zoRange(data$GeneRatio, 1.3)) +
  theme_minimal()

