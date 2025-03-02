
## codes
test <- mcn_5features

## the previous steps
test1 <- filter_structure(test)
test1 <- create_reference(test1)
test1 <- filter_formula(test1, by_reference = T)
test1 <- create_stardust_classes(test1)
test1 <- create_features_annotation(test1)
test1 <- cross_filter_stardust(test1, 2, 1)
test1 <- create_nebula_index(test1)
test1 <- compute_spectral_similarity(test1)
test1 <- create_child_nebulae(test1, 0.01)

## function to generate default parameters
create_child_layouts()
## default parameters
create_child_layouts()(test1)

test1 <- create_child_layouts(test1)
## see results (a object for 'ggraph' package to visualization)
lapply(
  layout_ggraph(child_nebulae(test1)),
  tibble::as_tibble
)
