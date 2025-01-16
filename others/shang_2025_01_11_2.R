
## need pacakges
packages <- c(
  "data.table", "dplyr", "circlize",
  "ComplexHeatmap", "grid", "gridBase"
)

quant <- data.table::fread("~/Downloads/COquant.csv")

data <- dplyr::select(quant, dplyr::where(is.double))
data <- data.frame(data, row.names = quant$Name)
# Normalization
data <- scale(log2(data + 1), TRUE, FALSE)

# `sector` and classes names
split <- as.factor(quant$Class)

# funciton color
rangeMax <- ceiling(max(abs(range(data))))
range_colorRamp <- c(-rangeMax, 0, rangeMax)
col_fun <- circlize::colorRamp2(range_colorRamp, c("blue", "white", "red"))

# color for classes group
col_shiny <- c("#9EDAE5", "#DBDB8D", "#F7B6D2", "#C49C94", "#C5B0D5", "#FF9896",
  "#98DF8A", "#FFBB78", "#AEC7E8", "#17BECF", "#BCBD22", "#7F7F7F",
  "#E377C2", "#8C564B", "#9467BD", "#D62728", "#2CA02C", "#FF7F0E",
  "#1F77B4", "#FED439", "#709AE1", "#D2AF81", "#FD7446", "#D5E4A2",
  "#197EC0", "#F05C3B", "#46732E", "#71D0F5", "#370335", "#075149",
  "#C80813", "#91331F", "#1A9993", "#FD8CC1", "#FF0000", "#FF9900",
  "#FFCC00", "#00FF00", "#6699FF", "#CC33FF")
if (length(col_shiny) < length(levels(split))) {
  stop('length(col_shiny) < length(levels(split)), not enough colors.')
}
col_group <- col_shiny[seq_along(levels(split))]
names(col_group) <- levels(split)

# Legends
legend_group <- ComplexHeatmap::Legend(
  title = "Classes", at = names(col_group),
  legend_gp = grid::gpar(fill = col_group)
)
legend_scale <- ComplexHeatmap::Legend(
  title = "Compound Level", col_fun = col_fun
)
all_legends <- ComplexHeatmap::packLegend(
  legend_group, legend_scale
)

setdev(8, 6)
# or:
# pdf("my_plot.pdf", 8, 6)

circle_size <- grid::unit(1, "snpc")
grid::pushViewport(
  grid::viewport(
    x = 0, y = 0.5, width = circle_size,
    height = circle_size, just = c("left", "center")
  )
)
par(omi = gridBase::gridOMI(), new = TRUE)

# plot circle
circlize::circos.clear()
circlize::circos.heatmap(
  data, split = split, col = col_fun, dend.side = "outside"
)
circlize::circos.heatmap(
  as.character(split), col = col_group, track.height = .05
)
grid::upViewport()
# draw legends
ComplexHeatmap::draw(all_legends, x = circle_size, just = "left")

# dev.off()
