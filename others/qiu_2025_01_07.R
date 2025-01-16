
name <- load("./drug_protein_result.dat")
apz <- head(apz, n = 20)

drug_targets <- lapply(apz, unlist)
db_pep <- unique(unlist(drug_targets, use.names = F))
# All render as AAstring.
db_string <- lapply(db_pep, Biostrings::AAString)
db_string

drug_idx <- lapply(apz, function(x) {
  which(db_pep %in% x)
})

all_drug_pairs <- combn(names(drug_idx), 2, simplify = FALSE)

## use integer, instead of character.
all_drug_pairs_idx <- pbapply::pblapply(all_drug_pairs, cl = 1, function(pair) {
  data.table::CJ(drug_idx[[ pair[1] ]], drug_idx[[ pair[2] ]])
})

all_drug_pairs_idx <- data.table::rbindlist(all_drug_pairs_idx, idcol = "index")
all_drug_pairs_idx

## sort the each row
all_drug_pairs_idx <- all_drug_pairs_idx[ , .(
  V1 = pmin(V1, V2), V2 = pmax(V1, V2), index = index
) ]

## deduplicated.
all_pep_pairs <- dplyr::distinct(all_drug_pairs_idx, V1, V2)
all_pep_pairs

# future::plan(multisession, workers = 5)
# future.apply::future_apply ?
all_scores <- pbapply::pbapply(all_pep_pairs, 1, simplify = FALSE,
  function(var) {
    Biostrings::pairwiseAlignment(
      db_string[[ var[1] ]], db_string[[ var[2] ]],
      type = "local", substitutionMatrix = "BLOSUM62", scoreOnly = TRUE
      )
  })
all_scores <- unlist(all_scores)
all_pep_pairs$scores <- all_scores
all_pep_pairs

self_pep_scores <- vapply(db_string, 
  function(x) {
    Biostrings::pairwiseAlignment(x, x,
      type = "local", substitutionMatrix = "BLOSUM62", scoreOnly = TRUE
    )
  }, double(1))
self_pep_scores

# ...
all_drug_pairs_idx <- data.table::merge.data.table(
  all_drug_pairs_idx, all_pep_pairs, by = c("V1", "V2")
)
all_drug_pairs_idx

# ==========================================================================
# normalization
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

all_drug_pairs_idx

# get self comparison score.
all_drug_pairs_idx$V1_self_score <- self_pep_scores[all_drug_pairs_idx$V1]
all_drug_pairs_idx$V2_self_score <- self_pep_scores[all_drug_pairs_idx$V2]

# normalization
all_drug_pairs_idx <- all_drug_pairs_idx[ , .(
  index = index,
  similarity = scores / ((V1_self_score + V2_self_score) / 2)
)]
all_drug_pairs_idx <- dplyr::filter(all_drug_pairs_idx, similarity != 1)
all_drug_pairs_idx

all_drug_pairs_idx <- all_drug_pairs_idx[, .(similarity = sum(similarity)), by = index]
all_drug_pairs_idx <- dplyr::mutate(
  all_drug_pairs_idx, similarity = similarity / max(similarity)
)
all_drug_pairs_idx

all_drug_pairs_names <- data.frame(
  index = seq_along(all_drug_pairs),
  drug1 = vapply(all_drug_pairs, function(x) x[1], character(1)),
  drug2 = vapply(all_drug_pairs, function(x) x[2], character(1))
)
all_drug_pairs_names

all_drug_pairs <- merge(all_drug_pairs_names, all_drug_pairs_idx, by = "index")
tibble::as_tibble(all_drug_pairs)
