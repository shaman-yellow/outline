## mcnebula run
## ---------------------------------------------------------------------- 
source("~/operation/superstart.R")
# load_all("~/MCnebula/R")
# load_all("~/extra/R")
initialize_mcnebula(".")
collate_structure()
build_classes_tree_list()
collate_ppcp(min_possess = 10, max_possess_pct = 0.07, filter_via_struc_score = NA)
generate_parent_nebula(rm_parent_isolate_nodes = T)
## ---------------------------------------------------------------------- 
generate_child_nebulae()
visualize_parent_nebula()
visualize_child_nebulae(width = 15, height = 20, nodes_size_range = c(2, 4))
## ---------------------------------------------------------------------- 
## Aminopyrimidines and derivatives
stat <- ratio_df <- data.table::fread("~/Downloads/shangzha0609.csv") %>% 
  dplyr::select(-2, -3) %>%
  dplyr::select(1:9) %>%
  dplyr::rename(.id = 1)
# stat <- format_quant_table("../sahngzha0609.csv", 
#                            meta.group = c(blank = "KB", ref = "HB", raw = "RCQ", pro = "PCQ"))
## ------------------------------------- 
color <- readxl::read_xlsx("~/Downloads/color.xlsx") 
color <- dplyr::mutate(color, Color = paste0("#", Color))
palette_stat <- color$Color
names(palette_stat) <- color$Group
## ---------------------------------------------------------------------- 
nodes_mark <- data.frame(
                         .id = c(
                                 "Others"
                                 ),
                         mark = c(
                                  "Others"
                         )
)
palette <- c(Others = "#D9D9D9")
## ---------------------------------------------------------------------- 
tmp_anno <- function(nebula_name, nebula_index = .MCn.nebula_index){
  annotate_child_nebulae(
    ## string, i.e. class name in nebula-index
    nebula_name = nebula_name,
    nebula_index = nebula_index,
    layout = "fr",
    ## a table to mark color of nodes
    nodes_mark = nodes_mark,
    plot_nodes_id = T,
    plot_structure = T,
    plot_ppcp = T,
    ## manually define the color of nodes
    palette = palette,
    ## feature quantification table
    ratio_df = stat,
    ## A vector of the hex color with names or not
    palette_stat = palette_stat,
    ## control nodes size in child-nebula, zoom in or zoom out globally.
    global.node.size = 0.8,
    ## the args of `ggplot::theme`
    theme_args = list(
      panel.background = element_rect(),
      panel.grid = element_line()
    ),
    return_plot = F
  )
}
## ---------------------------------------------------------------------- 
target_index <- method_summarize_target_index("Amino acids, peptides, and analogues")
hq.structure <- dplyr::filter(.MCn.structure_set, tanimotoSimilarity >= 0.4)
hq.target_index <- dplyr::filter(target_index, .id %in% hq.structure$.id)
## ---------------------------------------------------------------------- 
## re compute similarity
spec.path <- method_target_spec_compare("Amino acids, peptides, and analogues",
                                        hq.target_index,
                                        edge_filter = 0.5)
## ---------------------------------------------------------------------- 
call_fun_mc.space("generate_parent_nebula",
                  list(write_output = F, edges_file = spec.path),
                  clear_start = T,
                  clear_end = F)
## ---------------------------------------------------------------------- 
test <- call_fun_mc.space("generate_child_nebulae",
                          list(nebula_index = hq.target_index),
                          clear_start = F,
                          clear_end = F)
## ------------------------------------- 
hq.amino <- dplyr::filter(hq.structure, .id %in% hq.target_index$.id)
vis_via_molconvert(hq.amino$smiles, hq.amino$.id)
## ------------------------------------- 
call_fun_mc.space("tmp_anno",
                  list(nebula_name = "Amino acids, peptides, and analogues",
                       nebula_index = hq.target_index),
                  clear_start = F,
                  clear_end = F)

