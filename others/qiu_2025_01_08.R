
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
## add self comparison
all_drug_pairs <- c(
  all_drug_pairs, lapply(names(drug_idx), function(x) c(x, x))
)

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

# ...
all_drug_pairs_idx <- data.table::merge.data.table(
  all_drug_pairs_idx, all_pep_pairs, by = c("V1", "V2")
)
all_drug_pairs_idx

# ==========================================================================
# normalization
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

all_drug_pairs_idx <- all_drug_pairs_idx[, .(sum_score = sum(scores)), by = index]
all_drug_pairs_idx

all_drug_pairs_names <- data.frame(
  index = seq_along(all_drug_pairs),
  drug1 = vapply(all_drug_pairs, function(x) x[1], character(1)),
  drug2 = vapply(all_drug_pairs, function(x) x[2], character(1))
)
all_drug_pairs_names

all_drug_pairs <- merge(all_drug_pairs_names, all_drug_pairs_idx, by = "index")
tibble::as_tibble(all_drug_pairs)

drug_self_compares <- dplyr::filter(all_drug_pairs, drug1 == drug2)
drug_self_compares <- dplyr::select(
  drug_self_compares, self = drug1, self_score = sum_score
)
drug_self_compares

drug_mutual_compares <- dplyr::filter(all_drug_pairs, drug1 != drug2)
drug_mutual_compares

drug_mutual_compares <- merge(
  drug_mutual_compares, drug_self_compares, by.x = "drug1", 
  by.y = "self", all.x = TRUE
)
drug_mutual_compares <- merge(
  drug_mutual_compares, drug_self_compares, by.x = "drug2", 
  by.y = "self", all.x = TRUE
)
drug_mutual_compares

drug_mutual_compares <- dplyr::mutate(
  drug_mutual_compares, similarity = sum_score / ((self_score.x + self_score.y) / 2)
)
res <- tibble::as_tibble(drug_mutual_compares)
range(res$similarity)

maybeError <- dplyr::filter(res, similarity == 1)
maybeError
drug_idx[ names(drug_idx) %in% unlist(maybeError[, 1:2]) ]

# $Cetuximab
# [1] 1 2 3 4 5
#
# $`Dornase alfa`
# [1] 1 2 3 4 5
#
# $`Peginterferon alfa-2a`
# [1] 15 16 17
#
# $`Interferon alfa-n3`
# [1] 15 16 17
#

