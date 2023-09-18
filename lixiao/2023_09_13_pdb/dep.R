
devtools::load_all("~/touchPDB", export_all = F)

syms <- c("ERBB4", "Pik3r1", "AHR", "TP53")
pd <- new_pdb()
pd <- via_symbol(pd, syms)
anno(pd, syms)



obj <- vis(pd, "Pik3r1")

require(r3dmol)

obj <- r3dmol(viewer_spec = m_viewer_spec(cartoonQuality = 10,
    lowerZoomLimit = 50, upperZoomLimit = 350))
obj <- m_add_model(obj, data = pdb_6zsl, format = "pdb")
obj <- m_zoom_to(obj)
obj <- m_set_style(obj, style = m_style_cartoon(color = '#00cc96'))
obj <- m_set_style(obj, sel = m_sel(ss = 's'),                 
  style = m_style_cartoon(color = '#636efa', arrows = TRUE))
obj <- m_set_style(obj, sel = m_sel(ss = 'h'),
  style = m_style_cartoon(color = '#ff7f0e'))
obj <- m_rotate(obj, angle = 90, axis = 'y')
obj <- m_spin(obj)

ids <- c("P22682", "P47941")
query = list("accession_id" = ids)
df <-  queryup::query_uniprot(query = query)

UniProt.ws::mapUniProt(
  from = "Gene_Name",
  to = "UniProtKB-Swiss-Prot",
  columns = c("accession", "id", "mass"),
  query = list(taxId = 9606, ids = 'pik3r1')
)

query <- list(gene_exact = c("Pik3r1"), reviewed = "true", organism_id = "9606")
df <- queryup::query_uniprot(query, columns = c("gene_names", "id", "mass"))

library(XML)
cc <- RCurl::getURL("https://rest.uniprot.org/uniprotkb/Q15303.xml")

.get_needed(cc)

x <- XML::xmlParse(cc, useInternalNodes = F)
x1 <- x$doc$children$uniprot$children$entry$children
x2 <- x1[ names(x1) == "feature" ]
y <- x1[ names(x1) == "dbReference" ]

res <- lapply(x2,
  function(x) {
    xmlGetAttr(x, "type") %in% c("active site", "binding site")
  })
x2 <- x2[ unlist(res) ]

lapply(x2)
