
path <- fxlsx("./order_material/Ssb1VSCCl4_KEGG_enrichment_Gene.xlsx")
path <- select(path, -Description)
path <- rename(path, Symbol = Gene_name, Description = pathway_name)

n <- 10L
target <- "ECM-receptor interaction"
shift <- .2

data <- dplyr::summarize(dplyr::group_by(path, Description, pvalue),
  count = length(Symbol),
  GeneRatio = length(Symbol) / length(unique(path$Symbol)))
data <- arrange(data, pvalue)
data <- head(data, n = n)
data <- mutate(dplyr::ungroup(data), path.p = nrow(data):1)

edges <- distinct(path, Symbol, Description, log2fc = `log2(fc)`)
edges <- filter(edges, Description %in% !!target)

nodes <- tidyr::gather(edges, type, name, -log2fc)
nodes <- split(nodes, ~type)
nodes$Symbol <- arrange(nodes$Symbol, log2fc)
nodes$Symbol <- mutate(
  nodes$Symbol, x = -max(data$GeneRatio) * (1 + shift),
  y = seq(1, n, length.out = length(name))
)
nodes$Description <- distinct(nodes$Description, type, name)
nodes$Description <- mutate(
  nodes$Description, x = 0L - shift * max(data$GeneRatio),
  y = data$path.p[ match(name, data$Description) ]
)
nodes <- data.table::rbindlist(nodes, fill = T)
nodes <- relocate(nodes, name)

graph <- fast_layout(edges, select(nodes, x, y), nodes = select(nodes, -x, -y))

p <- ggraph(graph) +
  geom_edge_bend(aes(x = x, y = y, width = abs(log2fc)),
    color = "grey92", strength = .3) +
  geom_node_label(
    data = filter(nodes, type == "Symbol"),
    aes(label = name, x = x, y = y, fill = log2fc),
    hjust = 1) +
  ## enrichment
  geom_segment(data = data,
    aes(x = 0, xend = GeneRatio, y = path.p, yend = path.p, color = pvalue)) +
  geom_point(data = data,
    aes(x = GeneRatio, y = path.p, color = pvalue, size = count)) +
  geom_text(data = data,
    aes(x = - shift * max(GeneRatio) / 2, y = path.p, label = Description),
    hjust = 1, size = 4) +
  geom_vline(xintercept = 0L, linetype = 4) +
  labs(x = "", y = "", edge_width = "|log2(FC)|") +
  theme_minimal() +
  theme(axis.text.y = element_blank()) +
  scale_fill_gradient2(low = "#3182BDFF", high = "#A73030FF") +
  scale_color_gradientn(colours = rev(c("lightyellow", "red", "darkred"))) +
  scale_x_continuous(breaks = round(seq(0, max(data$GeneRatio), length.out = 4), 3),
    limits = c(-max(data$GeneRatio) * (1 + shift) * 1.2, max(data$GeneRatio)))
p <- wrap(p, 8, 7)

autosv(p, "enrichment")

