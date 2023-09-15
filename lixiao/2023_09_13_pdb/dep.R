
as <- list_attrs(pd$mart)

pd <- new_pdb()
pd <- via_symbol(pd, "Pik3r1", 5)

r3dmol(
  viewer_spec = m_viewer_spec(
    cartoonQuality = 10, # 图形质量
    lowerZoomLimit = 50, # 缩放下限
    upperZoomLimit = 350 # 缩放上限
  )
) %>%
  # 添加模型
  m_add_model(data = pdb_6zsl, format = "pdb") %>%  
  # 模型缩放到整体
  m_zoom_to() %>%
  # 设置 Cartoon 样式，并且颜色为绿色
  m_set_style(style = m_style_cartoon(color = '#00cc96')) %>% 
  # 设置 beta-折叠为蓝紫色
  m_set_style(sel = m_sel(ss = 's'),                 
              style = m_style_cartoon(color = '#636efa', arrows = TRUE)) %>% 
  # 设置 alpha-螺旋为橙色
  m_set_style(sel = m_sel(ss = 'h'),
              style = m_style_cartoon(color = '#ff7f0e')) %>%
  # 初始角度按Y轴旋转90度
  m_rotate(angle = 90, axis = 'y') %>%
  # 旋转动画
  m_spin()

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
