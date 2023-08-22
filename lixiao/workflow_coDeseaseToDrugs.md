
# From deseases (related to each others) to drug

Bioinformatics and Network Pharmacology Identify the Therapeutic Role and
Potential Mechanism of Melatonin in AD and Rosacea

## Different expression genes

Use `limma` to get DEGs

> `clusterProfiler` enrichment
> Use `STRINGdb` to get PPI networks
> Calculate MCC score of proteins to get Hubgenes (`cal_mcc`)

Find  Overlapped DEGs

## Enrichment: general

For overlap DEGs
Enrichment by `clusterProfiler` or `FELLA` ...
or `Metascape`

> (CLI: <https://metascape.org/gp/index.html#/menu/msbio>):

- Pathway 
- Desease
- TF enrichment

## Enrichment: TFs regulated network

> Website of TRRUST: <https://www.grnpedia.org/trrust/>

Use `Metascape` to get network of TFs

## Get predicted drugs target the overlap genes

> API for DGIbd database: <https://dgidb.org/api>

Predicted drug for both disease treatment.

> Sankey plot for Desease, Drugs, and Genes.

> Upset plot of overlapping genes or TFs (`ggupset`)

## Analysis of potential drug

Website to get potential target of drugs:

- TCMSP: <http://www.tcmip.cn/ETCM/>
- TargetNet: <http://targetnet.scbdd.com/home/download/>
- SwissTargetPrediction: <http://www.swisstargetprediction.ch/download.php>

Get the target, the Use `STRINGdb` to get Protein interation networks,
`cal_mcc` get hubgenes

## Molecular docking use AutoDock Vina

Use in Python Interface...


