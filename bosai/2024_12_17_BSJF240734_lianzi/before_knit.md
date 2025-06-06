---
title: 
bibliography: '`r system.file("extdata", "library.bib", package = "utils.tool")`'
csl: '`r system.file("extdata", "nature.csl", package = "utils.tool")`'
reference-section-title: "Reference"
output:
  custom_docx_document2:
    reference_docx: '`r system.file("extdata", "bosai.docx", package = "utils.tool")`'
---


```{r include = F, eval = F}
info <- items(start = td("20241204"), end = td("20241220"), finish = td("20241217"),
  id = "BSJF240734", client = "林波", inst = "浙江省人民医院",
  type = "生信分析",
  title = "清心莲子饮网络药理学分析",
  save = ".items_analysis.rds"
)
show.ic(info)

order_publish.bosai("analysis.Rmd", "analysis_out.Rmd")
idname <- formatName.bosai("./analysis_out.docx")
order_packaging("./analysis_out.docx", idname = idname, external_file = NULL)
```

```{r include = F}
#| setup
if (!requireNamespace("utils.tool"))
  devtools::load_all("~/utils.tool/")
autor_preset()
## the package are available at <https://github.com/shaman-yellow/utils.tool>
## if you want to run codes of this Rmarkdown,
## please install the package `utils.tool` and other related packages (run
## install.R)
options(savedir = list(figs = "Figure+Table", tabs = "Figure+Table"))
```

```{r eval = T, echo = F, results = "asis"}
set_cover.bosai(info)
```

```{r eval = T, echo = F, results = "asis"}
set_index()
```

# 分析流程 {#abstract}

```{r}
dic(di("差异表达基因"),
  di("慢性肾病"),
  di("占位符")
)

```

1. 通过网络药理学筛选出清心莲子饮和CKD的共同靶点
2. 根据上一步靶点的相关信号通路与铁死亡相关信号通路进行通路富集

```{r}
#| route
route <- as_network(
  list(
    "Herbs:BATMAN-TCM",
    "BATMAN-TCM:Compounds, Kown_targets, Predicted_targets",
    "Kown_targets, Predicted_targets:Targets",
    "Targets:Common_targets",
    "Disease:CKD",
    "CKD:GeneCards",
    "GeneCards:Disease_Targets",
    "Disease_Targets, Targets:Common_targets",
    "Common_targets:Network_pharmacology",
    "Network_pharmacology:Related_targets",
    "Related_targets, Ferroptosis:Ferr_targets",
    "Ferr_targets:Enrichment"
    ), "sugiyama"
)
p.route <- flowChart(route, 1.1, 1)
wrap(p.route)
```

```{r eval = T, echo = F, results = "asis"}
#| Unnamed-1
autor(wrap(p.route))
```

# 材料和方法 {#introduction}

```{r eval = T, echo = F, results = "asis"}
collate_details("meth")
```

# 分析结果 {#workflow}

## BATMAN 网络药理学 (QINGXIN)

`r snap(bat.qingxin, 1)`
`r snap(bat.qingxin, 2)`

`r ref("Intersection-of-herbs-compounds")` 
`r ref("Intersection-of-herbs-all-targets")` 

```{r}
herbs <- c("莲子", "麦冬", "黄芩", "地骨皮", "人参", "车前子", "甘草", "赤芍", "黄芪")
#' @meth {get_meth(bat.qingxin)}

bat.qingxin <- job_batman(herbs)
bat.qingxin$herbs_info %<>% dplyr::distinct(Chinese.Name, .keep_all = T)
bat.qingxin <- step1(bat.qingxin, F, F, F)
bat.qingxin <- step2(bat.qingxin)
bat.qingxin <- step3(bat.qingxin)

bat.qingxin@plots$step3$p.herbs_compounds
bat.qingxin@plots$step3$p.herbs_targets
```


```{r eval = T, echo = F, results = "asis"}
#| Intersection-of-herbs-compounds
autor(bat.qingxin@plots$step3$p.herbs_compounds)
```


```{r eval = T, echo = F, results = "asis"}
#| Intersection-of-herbs-all-targets
autor(bat.qingxin@plots$step3$p.herbs_targets)
```

## GeneCards 基因获取 (CKD)

`r snap(gn.ckd, 1)`

```{r}
#' @meth {get_meth(gn.ckd)}
gn.ckd <- job_genecard("Chronic kidney disease")
gn.ckd <- step1(gn.ckd, 3)
gn.ckd@tables$step1$t.genecards

```


```{r eval = T, echo = F, results = "asis"}
#| CKD-disease-related-targets-from-GeneCards
autor(gn.ckd@tables$step1$t.genecards)
```

## Network 疾病-成分-靶点 (QINGXIN)

```{r}
bat.qingxin <- map(bat.qingxin, list(gn.ckd@tables$step1$t.genecards$Symbol))
bat.qingxin@params$p.venn2dis$ins
character_bat.qingxin_ins <- bat.qingxin@params$p.venn2dis$ins
wrap(bat.qingxin@params$p.venn2dis, 6, 4)
wrap(bat.qingxin@params$p.pharm2dis, 12, 10)
```

```{r eval = T, echo = F, results = "asis"}
#| QINGXIN-network-pharmacology-with-disease
autor(wrap(bat.qingxin@params$p.pharm2dis, 12, 10))
```

```{r eval = T, echo = F, results = "asis"}
#| QINGXIN-Targets-intersect-with-targets-of-diseases
autor(wrap(bat.qingxin@params$p.venn2dis, 6, 4))
```


## FerrDb 铁死亡调控因子 (FERR)

`r snap(fe.ferr, 1)`

```{r}
#' @meth {get_meth(fe.ferr)}
fe.ferr <- job_fe()
fe.ferr <- step1(fe.ferr)
fe.ferr@plots$step1$p.ferroptosisRegulatorsDistribution
fe.ferr@tables$step1$t.ferroptosisRegulators
```

## FerrDb 与铁死亡相关基因的交集 (FERR)

```{r}
fe.ferr <- map(fe.ferr, list(character_bat.qingxin_ins))
fe.ferr$upset
```

```{r eval = T, echo = F, results = "asis"}
#| Intersection-of-Related-targets-with-Ferroptosis-all
autor(fe.ferr$upset)
```

## 富集分析 (COMMON)

```{r}
#' @meth {get_meth(en.common)}
en.common <- job_enrich(fe.ferr$upset$ins)
en.common <- step1(en.common)
en.common <- step2(en.common, "hsa04066")
en.common@plots$step2$p.pathviews$hsa04066
en.common@plots$step1$p.kegg$ids
en.common@plots$step1$p.go$ids
en.common@tables$step1$res.kegg$ids
wrap(en.common@plots$step1$p.go$ids, 8, 7)
```


```{r eval = T, echo = F, results = "asis"}
#| COMMON-KEGG-enrichment
autor(en.common@plots$step1$p.kegg$ids)
```


```{r eval = T, echo = F, results = "asis"}
#| COMMON-GO-enrichment
autor(wrap(en.common@plots$step1$p.go$ids, 8, 7))
```


```{r eval = T, echo = F, results = "asis"}
#| COMMON-KEGG-enrichment-data
autor(en.common@tables$step1$res.kegg$ids)
```


```{r eval = T, echo = F, results = "asis"}
#| COMMON-hsa04066-visualization
autor(en.common@plots$step2$p.pathviews$hsa04066)
```

# 总结 {#conclusion}

调控铁死亡的通路可能是 HIF-1 ，见`r ref("COMMON-hsa04066-visualization")` 。
其他可能的通路，见`r ref("COMMON-KEGG-enrichment-data")` 

```{r}
extract_anno("./order_material/BSJF240734-林波-生信分析-清心莲子饮网络药理学分析-2024.12.17-YRX批注 (1).docx"
cdRun("pandoc ./order_material/comment_reply.md -o Reply_闫姐.docx")


```

