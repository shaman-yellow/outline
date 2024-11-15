
我们使用 {R.Version()$version.string} (https://www.r-project.org/) 对 scRNA 数据进行二次分析。我们使用 Seurat R 包进行数据质量控制 (QC) 和下游分析。依据 <{x@info}> 为指导对单细胞数据预处理与整合。具体的，一个细胞至少应有 {min.features} 个基因，并且基因数量小于 {max.features}。建议线粒体基因的比例小于 {max.percent.mt}%。根据上述条件，获得用于下游分析的高质量细胞。使用 Seurat::SCTransform 函数对数据标准化。随后，以 Seurat::SelectIntegrationFeatures (返还{nfeatures}个基因) 和 Seurat::PrepSCTIntegration 选择用于整合多重数据集的基因。

以 Seurat::FindIntegrationAnchors，和 Seurat::IntegrateData 整合多个数据集，并 PCA 降维。

在 1-{max(dims)} PC 维度下，以 Seurat::FindNeighbors 构建 Nearest-neighbor Graph。随后在 {resolution} 分辨率下，以 Seurat::FindClusters 函数识别细胞群并 以 Seurat::RunUMAP 进行 UMAP 聚类。

以 Seurat::FindAllMarkers (LogFC 阈值 {logfc.threshold}; 最小检出率 {min.pct}) 为所有细胞群寻找 Markers。

