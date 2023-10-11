
- 基因注释：
    - `ensembl_gene_id`: ensembl 数据库基因 ID
    - `ensembl_transcript_id`: ensembl 数据库转录因子 ID
    - `entrezgene_id`: entrez 数据库基因 ID
    - `hgnc_symbol`: 基因名（人类，hgnc symbol）
    - `refseq_mrna`: NCBI 参考序列数据库的 mRNA 参考序列 refseq ID
    - `chromosome_name`: 染色体名称
    - `start_position`: 起始位置
    - `end_position`: 结束位置
    - `description`: 基因介绍
- 统计值
    - `logFC`: 倍率变换，log~2~(Fold change)，Fold change 为两组基因表达值的商，例如，Group.A vs Group.B，则 A/B. (Estimate of the log2-fold-change corresponding to the effect or contrast)
    - `AveExpr`: average log2-expression for the probe (Gene) over all arrays (Sample) and channels
    - `t`: moderated t-statistics.
    - `P.Value`: two-sided p-values corresponding to the t-statistics.
    - `adj.P.Val`: adjusted p-value
    - `B`: log-odds that the gene is differentially expressed

