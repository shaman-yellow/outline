

dir.create(dir <- "kegg")
interested_pathway <- c("hsa04390", "hsa04371")
files <- lapply(interested_pathway,
  function(x) {
    file <- paste0(dir, "/", x, ".kgml")
    KEGGgraph::retrieveKGML(x, "hsa", destfile = file)
    file
  })

data <- lapply(files,
  function(file) {
    obj <- KEGGgraph::parseKGML2Graph(file)
  })


for (i in interested_pathway) {
  mapkG <- parseKGML2Graph(paste0(i, "_kgml"), expandGenes = TRUE, genesOnly = TRUE)
  mapkNodes <- nodes(mapkG)
  mapkEdges <- edges(mapkG)
  mapkEdges <- mapkEdges[sapply(mapkEdges, length) > 0]
  res <- lapply(1:length(mapkEdges), function(t) {
    name <- names(mapkEdges)[t]
    len <- length(mapkEdges[[t]])
    do.call(rbind, lapply(1:len, function(n) {
      c(name, mapkEdges[[t]][n])
    }))
  })
  result <- data.frame(do.call(rbind, res))
  write.table(result, "edges.txt", sep = "\t", row.names = F, col.names = F, quote = F, append = T)
  write.table(mapkNodes, "nodes.txt", sep = "\t", row.names = F, col.names = F, quote = F, append = T)
}

