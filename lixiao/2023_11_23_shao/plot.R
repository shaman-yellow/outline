
path <- fxlsx("./order_material/Ssb1VSCCl4_KEGG_enrichment_Gene.xlsx")
path <- select(path, -Description)
path <- rename(path, Symbol = Gene_name, Description = pathway_name)

n <- 10L
target <- c("ECM-receptor interaction", "Focal adhesion")[2]
shift <- .2

data <- dplyr::summarize(dplyr::group_by(path, Description, pvalue),
  count = length(Symbol),
  GeneRatio = length(Symbol) / length(unique(path$Symbol)))
data <- dplyr::arrange(data, pvalue)
data <- head(data, n = n)
data <- dplyr::mutate(dplyr::ungroup(data), path.p = nrow(data):1)

edges <- dplyr::distinct(path, Symbol, Description, log2fc = log2.fc.)
edges <- dplyr::filter(edges, Description %in% !!target)

nodes <- tidyr::gather(edges, type, name, -log2fc)
nodes <- split(nodes, ~type)
nodes$Symbol <- dplyr::arrange(nodes$Symbol, log2fc)
nodes$Symbol <- dplyr::distinct(nodes$Symbol)
nodes$Symbol <- dplyr::mutate(
  nodes$Symbol, x = -max(data$GeneRatio) * (1 + shift),
  y = seq(1, n, length.out = length(name))
)
nodes$Description <- dplyr::distinct(nodes$Description, type, name)
nodes$Description <- dplyr::mutate(
  nodes$Description, x = 0L - shift * max(data$GeneRatio),
  y = data$path.p[ match(name, data$Description) ]
)
nodes <- data.table::rbindlist(nodes, fill = T)
nodes <- dplyr::relocate(nodes, name)

graph <- fast_layout(edges, dplyr::select(nodes, x, y), nodes = dplyr::select(nodes, -x, -y))

p <- ggraph(graph) +
  geom_edge_diagonal(aes(x = x, y = y, width = abs(log2fc), edge_color = node2.name),
    strength = 1, flipped = T, alpha = .3) +
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
  labs(x = "", y = "", edge_width = "|log2(FC)|",
    color = "P-value", size = "Count", fill = "Log2(FC)",
    edge_color = "Highlight Pathway") +
  theme_minimal() +
  theme(axis.text.y = element_blank()) +
  scale_edge_color_manual(values = color_set()) +
  scale_fill_gradient2(low = "#3182BDFF", high = "#A73030FF") +
  scale_color_gradientn(colours = rev(c("lightyellow", "red", "darkred"))) +
  scale_x_continuous(breaks = round(seq(0, max(data$GeneRatio), length.out = 4), 3),
    limits = c(-max(data$GeneRatio) * (1 + shift) * 1.2, max(data$GeneRatio)))
p <- wrap(p, 12, 11)

autosv(p, "enrichment")

ge <- readRDS("~/disk_sdb1/2023_09_27_dualdisease/gse.3.rds")

fun <- function(data) {
  split_lapply_rbind(data, ~ ID,
    function(x) {
      symbol <- x$geneName_list[[ 1 ]]
      x <- dplyr::select(x, -dplyr::contains("_list"))
      x <- dplyr::slice(x, rep(1, length(!!symbol)))
      x <- dplyr::mutate(x, Symbol = !!symbol)
      return(x)
    })
}

names(ge@object) <- c("symbol", "entrezgene_id")

plot_highlight_enrich(ge@tables$step1$table_kegg, "hsa03010", object(ge)$symbol)

