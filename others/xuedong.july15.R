## ^start_________________________ 
## ---------------------------------------------------------------------- 
## ---------------------------------------------------------------------- 
## [introduction] Run MCnebual basic workflow.
initialize_mcnebula(".")
collate_structure()
build_classes_tree_list()
collate_ppcp(min_possess = 10, max_possess_pct = 0.1)
generate_parent_nebula(rm_parent_isolate_nodes = T)
generate_child_nebulae()
visualize_parent_nebula(layout = "kk", width = 20, height = 17)
## ---------------------------------------------------------------------- 
## [introduction] The parent-nebula shows the superclass of compounds in dataset (Fig. \@ref(fig:parentnebula)).
## @figure 

# ```{r parentnebula, echo = F, fig.cap = "parent-nebula", fig.width = 15, fig.height = 15}
# show_png("parent_nebula/parent_nebula.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
visualize_child_nebulae(layout = "fr", width = 10, height = 14, nodes_size_range = c(2, 4))
file.rename("mcnebula_results/child_nebulae.svg", "mcnebula_results/initial.child_nebulae.svg")
## ---------------------------------------------------------------------- 
## [introduction] The child-nebulae shows the overall abundant classes and compound distribution for dataset (Fig. \@ref(fig:childnebulae)).
## @figure 

# ```{r childnebulae, echo = F, fig.cap = "child-nebulae", fig.width = 15, fig.height = 15}
# show_png("initial.child_nebulae.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Metadata for all sample... (Table 1).
quant.file <- "../july8.csv"
meta.df <- data.table::fread(quant.file) %>% 
  colnames(.) %>% 
  .[grepl("\\.mzML", .)] %>% 
  stringr::str_extract(., "^.*mzML") %>% 
  unique() %>%
  data.frame(file = .) %>% 
  dplyr::mutate(sample = stringr::str_extract(file, "^.*(?=\\.mzML)"),
                group = stringr::str_extract(sample, "^[A-Z]|KB"),
                time = stringr::str_extract(sample, "(?<=-)[0-9]{1,}(?=h|H|min)"),
                .time = stringr::str_extract(sample, "(?<=-)[0-9]{1,}.*$"),
                time = as.numeric(time),
                time = ifelse(grepl("min", sample), time / 60, time),
                time = round(time, 2),
                subgroup = paste0(group, "_", time),
                subgroup.pattern = paste0(group, ".*", .time),
                subgroup.pattern = gsub("NA", "", subgroup.pattern)
                ) %>% 
  dplyr::arrange(group, time) %>% 
  dplyr::as_tibble()
## ---------------------------------------------------------------------- 
## @tbl

# ```{r meta, echo = F}
# dplyr::as_tibble(meta.df) %>% 
#   head(n = 50) %>%
#   knitr::kable(format = "latex", booktabs = T, caption = "metadata")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Format quantification table for each group (Table 2).
meta.df.sub <- dplyr::select(meta.df, group, subgroup, subgroup.pattern) %>% 
  dplyr::distinct(subgroup, .keep_all = T)
meta.group <- meta.df.sub$subgroup.pattern
names(meta.group) <- meta.df.sub$subgroup
stat <- format_quant_table(quant.file, meta.group = meta.group)
## ---------------------------------------------------------------------- 
## @tbl

# ```{r quant, echo = F}
# dplyr::as_tibble(stat[1:10, 1:10]) %>% 
#   knitr::kable(format = "latex", booktabs = T, caption = "mean level (peak area) of feature in each group")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Set color palette for each group.
base.color <- data.table::data.table(
  from = c("grey80", "plum", "LightSkyBlue"),
  to = c("grey80", "purple", "DarkBlue")
)
meta.df.sub <- by_group_as_list(meta.df.sub, "group") %>% 
  mapply(., base.color$from, base.color$to,
         SIMPLIFY = F,
         FUN = function(df, from, to){
           df <- dplyr::mutate(df, color = colorRampPalette(c(from, to))(nrow(df)))
           return(df)
         }) %>% 
  data.table::rbindlist()
## ------------------------------------- 
palette_stat <- meta.df.sub$color
names(palette_stat) <- meta.df.sub$subgroup
## ---------------------------------------------------------------------- 
## [introduction] ... are marked in child-nebulae.
nodes_mark <- data.frame(
  .id = c("Others"),
  mark = c("Others")
)
palette <- c(Others = "#D9D9D9")
## ---------------------------------------------------------------------- 
## [introduction] A function of visualization of child-nebula was defined for reproducibly use.
tmp_anno <- function(nebula_name, nebula_index = .MCn.nebula_index){
  annotate_child_nebulae(
    ## string, i.e. class name in nebula-index
    nebula_name = nebula_name,
    nebula_index = nebula_index,
    layout = "fr",
    ## a table to mark color of nodes
    nodes_mark = nodes_mark,
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
## [introduction] The child-nebula of 'Steroids and steroid derivatives' was visualized.
nebula_name <- "Steroids and steroid derivatives"
lac.index <- dplyr::filter(.MCn.nebula_index, name == nebula_name)
hq.lac <- dplyr::filter(.MCn.structure_set, .id %in% lac.index$.id)
vis_via_molconvert(hq.lac$smiles, hq.lac$.id)
tmp_anno(nebula_name)
file.rename("mcnebula_results/Steroids and steroid derivatives_graph.svg", "mcnebula_results/steroid.svg")
## ---------------------------------------------------------------------- 
## [introduction] Figure \@ref(fig:iri) show 'Steroids and steroid derivatives'...
## @figure 

# ```{r iri, echo = F, fig.cap = "child-nebula of `Steroids and steroid derivatives`", fig.width = 15, fig.height = 15}
# show_png("steroid.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
## The package could found at: <https://github.com/Cao-lab-zcmu/utils_tool>
devtools::load_all("~/utils_tool")
## ---------------------------------------------------------------------- 
## [introduction] ## Differential analysis
## [introduction] 
## [introduction] Limma [@gentleman_limma_2005-1] is generally used for gene differential expression analysis.
## [introduction] Here, we use several statistical functions in limma to analyze the difference of compound level between
diff.metadata <- dplyr::filter(meta.df, !grepl("KB", group))
quant <- format_quant_table(quant.file, get_raw_level = T,
                            meta.group = meta.group) %>%
  data.frame(check.names = F) %>%
  .[, diff.metadata$sample] %>% 
  apply(2,
        function(vec){
          log2(vec + 1)
        }) %>% 
  scale(scale = F)
rownames(quant) <- stat$.id
## ---------------------------------------------------------------------- 
## [introduction] Analysis pattern of time series (Fig. \@ref(fig:timeSeries))...
## @figure 

# ```{r timeSeries, echo = F, fig.cap = "Analysis pattern of time series"}
# file <- system.file("extdata", "group_time.png", package = "utils.tool")
# png <- png::readPNG(file)
# grid::grid.raster(png)
# ```

## ---------------------------------------------------------------------- 
## [introduction] Set design matrix.
## group 
group <- diff.metadata$group
time <- diff.metadata$time
## design matrix
design <- model.matrix(~ 0 + group + group:time)
colnames(design) <- gsub("group", "", colnames(design))
colnames(design) <- gsub(":", "_", colnames(design))
## ---------------------------------------------------------------------- 
## [introduction] Use `limma::lmFit` to fit data with linear regression model
fit <- limma::lmFit(quant, design)
ebayes.con.fit <- limma::eBayes(fit)
## ---------------------------------------------------------------------- 
## ========== Run block ========== 
## [introduction] The results (Table 3):
top <- limma::topTable(ebayes.con.fit, adjust="BH", number = 30) %>% 
  dplyr::mutate(.id = rownames(.)) %>% 
  dplyr::relocate(.id) %>% 
  dplyr::as_tibble()
## save the results
all.results <- limma::topTable(ebayes.con.fit, adjust="BH", number = Inf) %>% 
  dplyr::mutate(.id = rownames(.)) %>% 
  dplyr::relocate(.id) %>% 
  dplyr::as_tibble()
write_tsv(all.results, "Statistic_reults.tsv")
## ---------------------------------------------------------------------- 
## @tbl

# ```{r lmfit, echo = F}
# top %>% 
#   knitr::kable(format = "latex", booktabs = T, caption = "linear regression and statistic results of compounds level")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Marking the top compounds in child-nebulae:
nodes_mark <- data.table::data.table(.id = top$.id, mark = "topN") %>% 
  dplyr::bind_rows(nodes_mark)
palette <- c(palette, topN = "yellow")
class.sig <- dplyr::filter(.MCn.nebula_index, .id %in% top$.id)$name %>% 
  unique()
tmp.nebula_index <- dplyr::filter(.MCn.nebula_index, name %in% class.sig)
generate_child_nebulae(nebula_index = tmp.nebula_index)
visualize_child_nebulae(
  layout = "fr",
  nodes_mark = nodes_mark,
  palette = palette,
  remove_legend_lab = T,
  legend_fill = T,
  legend_position = "bottom",
  nodes_stroke = 0,
  edges_color = "#D9D9D9",
  width = 14,
  height = 17
  # nodes_size_range = c(2, 4)
)
file.rename("mcnebula_results/child_nebulae.svg", "mcnebula_results/topN.child_nebulae.svg")
## ---------------------------------------------------------------------- 
## [introduction] Figure \@ref(fig:marknebula)
## @figure 

# ```{r marknebula, echo = F, fig.cap = "Top compouunds in child-nebulae", fig.width = 15, fig.height = 15}
# show_png("topN.child_nebulae.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
## EIC plot
metadata <- dplyr::select(meta.df, sample, subgroup) %>% 
  dplyr::rename(group = subgroup) %>% 
  dplyr::distinct(group, .keep_all = T)
stack_ms1(idset = top$.id,
          metadata = metadata,
          quant.path = quant.file,
          mzml.path = "../mzml/",
          palette = palette_stat,
          width = 25,
          height = 22
)
file.rename("mcnebula_results/EIC.svg", "mcnebula_results/topN.EIC.svg")
## ms/ms plot
topN.struc <- dplyr::filter(.MCn.structure_set, .id %in% top$.id)
vis_via_molconvert(topN.struc$smiles, topN.struc$.id)
stack_ms2(idset = top$.id, width = 25, height = 22)
file.rename("mcnebula_results/mirror.ms2.svg", "mcnebula_results/topN.mirror.ms2.svg")
## ---------------------------------------------------------------------- 
## [introduction] Figure \@ref(fig:topeic)...
## @figure 

# ```{r topeic, echo = F, fig.cap = "EIC of Top compounds", fig.width = 15, fig.height = 15}
# show_png("topN.EIC.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Figure \@ref(fig:topms2)...
## @figure 

# ```{r topms2, echo = F, fig.cap = "MS/MS spectrum of Top N compounds", fig.width = 15, fig.height = 15}
# show_png("topN.mirror.ms2.svg", "3000x")
# ```

## ---------------------------------------------------------------------- 
## [introduction] Export compound identification table...
## [introduction] The script could find in <https://github.com/Cao-lab-zcmu/metabo_stat/tree/master/mcnebula_cell_validation>
source("~/outline/mcnebula_cell_validation/get_real_class.R")
source("~/outline/mcnebula_cell_validation/export.step0_manual.select.class.R")
mz_rt <- format_quant_table(quant.file, get_raw_level = T,
                            meta.group = meta.group) %>%
  dplyr::select(1:3)  
source("~/outline/mcnebula_cell_validation/export.step1_class.R")
source("~/outline/mcnebula_cell_validation/export.step1.5_iupacname.R")
source("~/outline/mcnebula_cell_validation/export.step2_name.diff.vari.R")
source("~/outline/mcnebula_cell_validation/export.step3_format.R")
## ------------------------------------- 
library(Hmisc)
library(gt)
## ------------------------------------- 
mu.export.dominant <- export.dominant[, -ncol(export.dominant)] %>% 
  merge(all.results[, c(".id", "P.Value", "adj.P.Val")], by.x = "id", by.y = ".id", all.x = T, sort = F) %>% 
  dplyr::relocate(No, name) %>% 
  dplyr::mutate(
                # logFC = round(logFC, 1),
                P.Value = round(P.Value, 4),
                adj.P.Val = round(adj.P.Val, 4))
## compounds table
df <- dplyr::rename(mu.export.dominant,
                    info = Classification,
                    `ID` = `id`,
                    `Q.Value (FDR)` = `adj.P.Val`)
## pdf output
gt_table <- pretty_table(df,
                         title = "Compounds summary",
                         subtitle = "LC-MS in negative ion mode",
                         footnote = "Compounds listed in table were identified from herbal dataset. These compounds are grouped by classes. As compounds not only belong to one class and also belong to its parent classes, for this case, the compounds are preferentially grouped for subtile classes.",
                         default = F)
write_tsv(df, "mcnebula_results/coumpound_summary.tsv")
## ---------------------------------------------------------------------- 
## $start_________________________ 
