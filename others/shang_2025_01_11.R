
library(circlize)
set.seed(123)
mat1 <- rbind(
  cbind(
    matrix(rnorm(50 * 5, mean = 1), nr = 50),
    matrix(rnorm(50 * 5, mean = -1), nr = 50)
  ),
  cbind(
    matrix(rnorm(50 * 5, mean = -1), nr = 50),
    matrix(rnorm(50 * 5, mean = 1), nr = 50)
  )
)
rownames(mat1) <- paste0("R", 1:100)
colnames(mat1) <- paste0("C", 1:10)
mat1 <- mat1[sample(100, 100), ] # randomly permute rows
split <- sample(letters[1:5], 100, replace = TRUE)
split <- factor(split, levels = letters[1:5])
col_fun1 = colorRamp2(c(-2, 0, 2), c("blue", "white", "red"))

classes <- paste0("Class_", unique(split))
names(classes) <- unique(split)

circos.clear()
circos.heatmap(mat1, split = split, col = col_fun1)
# circos.trackPlotRegion
circos.track(
  ylim = range(rowMeans(mat1)), bg.col = "#FF8080",
  panel.fun = function(x, y) {
    circos.text(
      CELL_META$xcenter, CELL_META$ycenter,
      classes[CELL_META$sector.index],
      facing = "bending.inside", col = "white", cex = 2
    )
  }
)
