wget -O /dev/stdout 'https://dec2021.archive.ensembl.org/biomart/martservice?query=<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query><Query virtualSchemaName = "default" uniqueRows = "1" count = "0" datasetConfigVersion = "0.6" header="1" formatter = "TSV" requestid= "biomaRt"> <Dataset name = "mmusculus_gene_ensembl"><Attribute name = "mgi_symbol"/><Filter name = "mgi_symbol" value = "mt-Co1,Alb,Cyp27a1" /></Dataset><Dataset name = "hsapiens_gene_ensembl" ><Attribute name = "hgnc_symbol"/></Dataset></Query>'
