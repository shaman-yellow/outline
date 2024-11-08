#############
{
    library(BBmisc)
    library(Seurat)
    library(SingleR)
    library(ggpubr)
    library(dplyr)
    library(clustree)
    #remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
    library(DoubletFinder)
    library(clusterProfiler)
    library(org.Hs.eg.db)
    library(enrichplot)
    library(stringi)	# 处理表格数据的包
    library(GOplot)
    library(stringr)
    library(rlang)
    library(dplyr)
    library(cowplot)
    library(ggplot2)
    library(ggrepel)
    library(msigdbr)
    library(fgsea)
    library(limma)
    library(edgeR)
    library(statmod)
    library(ggVolcano)
    library(SingleR)
    library(GOplot)
    library(dplyr)
    library(tidyverse)
    library(biomaRt)
    library(NMF) # 加NMF包
    library(AUCell)
}
options(future.globals.maxSize = 100000 * 1024^2) # set 50G RAM
#################################
#####code##############
##################################
####GO.plot############
run_circle_enrichment <- function(data = NULL,
                                  DEGs = NULL,
                                  dir_save = NULL,
                                  type = 'GO', # GO/KEGG
                                  height = 10,
                                  width = 10, 
                                  dpi = 300,
                                  pic_type = 'png',
                                  ...){
    if(! dir.exists(dir_save)){dir.create(dir_save, recursive = T)}
    
    if(type == 'GO'){
        top_res <- data %>% dplyr::select(c('ONTOLOGY','ID', 'Description', 'geneID', 'p.adjust'))
        names(top_res) <- c("Category", "ID","Term","Genes","adj_pval")
        top_res$Genes <- gsub("/", ',', top_res$Genes)
        
        gene_enrich <- lapply(top_res$Term, function(t){
            gene_list <- top_res %>% 
                dplyr::filter(Term == t) %>% 
                dplyr::select(names(.)[4]) %>% 
                pull(names(.)[1])
            genes <- stringr::str_split(gene_list, ",")[[1]]
            out_res <- data.frame(genes)
            out_res
        }) %>% do.call(rbind, .)
    }else if(type == 'KEGG'){
        top_res <- data %>% dplyr::select(c('ID', 'Description', 'geneID', 'p.adjust'))
        top_res$Category <- 'KEGG'
        names(top_res) <- c("ID","Term", "Genes","adj_pval", "Category")
        top_res$Genes <- gsub("/", ',', top_res$Genes)
        
        gene_enrich <- lapply(top_res$Term, function(t){
            gene_list <- top_res %>% 
                dplyr::filter(Term == t) %>% 
                dplyr::select(names(.)[3]) %>% 
                pull(names(.)[1])
            genes <- stringr::str_split(gene_list, ",")[[1]]
            out_res <- data.frame(genes)
            out_res
        }) %>% do.call(rbind, .)
    }
    
    names(DEGs) <- c('ID', 'logFC')
    DEGs <- DEGs %>% dplyr::filter(ID %in% unique(gene_enrich[,1]))
    
    # 圈图------
    circ <- circle_dat(top_res, DEGs)
    p <- GOCircle(circ, nsub = nrow(top_res), label.fontface = 'italic',table.legend = F) +
        theme_bw() +
        theme(legend.title = element_text(size = 20, face = 'italic'),
              legend.position = 'right',
              plot.background = element_blank(),
              panel.grid = element_blank(),
              panel.background = element_blank(),
              axis.title = element_blank(),
              axis.text = element_blank(),
              axis.ticks = element_blank(),
              panel.border = element_blank(),
              legend.background = element_blank(),
              legend.text = element_text(size = 15, face = 'italic'))
    ggsave(plot = p, device = "png", width = width, height = height,
           units = 'in', dpi = dpi, paste0(dir_save, "/", type, "_circle.png"))
    ggsave(plot = p, device = "pdf", width = width, height = height,
           units = 'in', dpi = dpi, paste0(dir_save, "/", type, "_circle.pdf"))
    
    # 和弦图------
    chord <- chord_dat(circ, DEGs, top_res$Term)
    p <- GOChord(chord, space = 0.02, gene.order = 'logFC', 
                 gene.space = 0.25, gene.size = 5) +
        theme(legend.title = element_text(size = 20, face = 'italic'),
              legend.text = element_text(size = 15, face = 'italic'),
              aspect.ratio = 1) 
    p$guides$size$title <- type
    p$guides$size$ncol <- 2
    
    ggsave(plot = p, device = "png", width = width, height = height,
           units = 'in', dpi = dpi, paste0(dir_save, "/", type, "_chord.png"))
    ggsave(plot = p, device = "pdf", width = width, height = height,
           units = 'in', dpi = dpi, paste0(dir_save, "/", type, "_chord.pdf"))
}
###################theme##############
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
#处理后有73种差异还比较明显的颜色，基本够用
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
theme_type<-theme(axis.line = element_blank(),
                  plot.title = element_text(hjust = .5),
                  panel.border = element_rect(size = 1,colour = 'black',fill = NA)) 
theme_type.plot<-#theme_bw()+ #?w?i?????????F
    #labs(fill="Site")+
    theme(#legend.position="none",
        #axis.text.x=element_text(angle=90,hjust = 1,colour="black",family="Times",size=12), #????ux??????x???????I?????????????Ίp?x???15?x?C???????????1(hjust = 1)?C?????????Times?召???20
        #axis.text.y=element_text(family="Times",size=12,face="plain"), #????uy??????x???????I?????ƁC???̑召?C????????????plain
        #axis.title.y=element_text(family="Times",size = 12,face="plain"), #????uy??????????I???̑???
        plot.title = element_text(size=12,face="bold",hjust = 0.5),
        #panel.border = element_blank(),axis.line = element_line(colour = "black",size=1), #??????????U?[?I?D?F?C????x=0????ay=0????��e?????(size=1)
        #legend.text=element_text(face="italic", family="Times", colour="black",  #????u??????I?q???????I???̑???
        #                         size=16),
        #legend.title=element_text(face="italic", family="Times", colour="black", #????u??????I??????????I???̑???
        #                          size=18),
        #axis.text=element_text(size=10),
        #axis.title=element_text(size=15),		
        panel.grid.major = element_blank(),   #?s?????㤊i???
        panel.grid.minor = element_blank())  #?s?????㤊i???
###绘制堆叠图 X轴文字旋转90度
theme_type.1<-theme_bw()+ #?w?i?????????F
    #labs(fill="Site")+
    theme(#legend.position="none",
        axis.text.x=element_text(angle=90,hjust = 1,colour="black",family="Times",size=12), #????ux??????x???????I?????????????Ίp?x???15?x?C???????????1(hjust = 1)?C?????????Times?召???20
        axis.text.y=element_text(family="Times",colour="black",size=12,face="plain"), #????uy??????x???????I?????ƁC???̑召?C????????????plain
        axis.title.y=element_text(family="Times",colour="black",size = 12,face="plain"), #????uy??????????I???̑???
        plot.title = element_text(family="Times",colour="black",size=12,face="bold",hjust = 0.5),
        panel.border = element_blank(),axis.line = element_line(colour = "black",size=1), #??????????U?[?I?D?F?C????x=0????ay=0????��e?????(size=1)
        legend.text=element_text(face="italic", family="Times", colour="black",  #????u??????I?q???????I???̑???
                                 size=16),
        legend.title=element_text(face="italic", family="Times", colour="black", #????u??????I??????????I???̑???
                                  size=18),
        axis.text=element_text(size=10),
        axis.title=element_text(size=15),		
        panel.grid.major = element_blank(),   #?s?????㤊i???
        panel.grid.minor = element_blank())  #?s?????㤊i???
###绘制堆叠图 X轴文字不旋转
theme_type.2<-theme_bw()+ #?w?i?????????F
    #labs(fill="Site")+
    theme(#legend.position="none",
        axis.text.x=element_text(angle=0,hjust = 1,colour="black",family="Times",size=12), #????ux??????x???????I?????????????Ίp?x???15?x?C???????????1(hjust = 1)?C?????????Times?召???20
        axis.text.y=element_text(family="Times",colour="black",size=12), #????uy??????x???????I?????ƁC???̑召?C????????????plain
        axis.title.y=element_text(family="Times",colour="black",size = 12,face="plain"), #????uy??????????I???̑???
        plot.title = element_text(family="Times",colour="black",size=12,face="bold",hjust = 0.5),
        panel.border = element_blank(),axis.line = element_line(colour = "black",size=1), #??????????U?[?I?D?F?C????x=0????ay=0????��e?????(size=1)
        legend.text=element_text(face="italic", family="Times", colour="black",  #????u??????I?q???????I???̑???
                                 size=16),
        legend.title=element_text(face="italic", family="Times", colour="black", #????u??????I??????????I???̑???
                                  size=18),
        axis.text=element_text(size=12),
        axis.title=element_text(size=12),		
        panel.grid.major = element_blank(),   #?s?????㤊i???
        panel.grid.minor = element_blank())  #?s?????㤊i???
#######scRNA DKD

#mainDir<-"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA"
#dir1<-"2.result/"
#if  (!file.exists(dir1)){ 
#    dir.create(file.path(mainDir, dir1))
#}
mainDir<-"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA"
setwd(mainDir)
dir1<-"1.QualityControl/"
if  (!file.exists(dir1)){ 
    dir.create(file.path(mainDir, dir1))
}
dir1<-"8.filter.data/"
if  (!file.exists(dir1)){ 
    dir.create(file.path(mainDir, dir1))
}
dir1<-"9.merge.data/"
if  (!file.exists(dir1)){ 
    dir.create(file.path(mainDir, dir1))
}
source(file = "F:/Rscript/function/Plot_colorPaletters.R")
source(file = "F:/Rscript/function/doubletDetect.R")

#"E:\data\GSE131882_RAW"
s.genes <- cc.genes$s.genes
g2m.genes <- cc.genes$g2m.genes
names<-list.files("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\scRNA")
Sample.list<-list()
ensembl <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                   dataset = "hsapiens_gene_ensembl",#人类
                   host = "https://www.ensembl.org")
for(i in 1:length(names)){
    
    #counts.1<-readRDS(paste0("E:\\data\\GSE131882_RAW\\",names[i]))
    counts.1<-read.table(paste0("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\scRNA\\",names[i]),header=T,sep="\t",row.names=1)
    ###Preliminary filtration >>Create  SeuratObject
    #counts<-counts.1$readcount$exon$all
    ###转化mRNA表达矩阵
    
    
    #feature_info <- getBM(attributes = c("gene_biotype", "hgnc_symbol","ensembl_gene_id"), 
    #                      filters = "ensembl_gene_id", values = rownames(counts), 
    #                      mart = ensembl)
    
    #mRNA<-feature_info[which(feature_info$gene_biotype=="protein_coding"|feature_info$gene_biotype=="lncRNA"|feature_info$gene_biotype=="snRNA"),c("hgnc_symbol","ensembl_gene_id")]#
    #counts1<-merge(mRNA,counts,by.x="ensembl_gene_id",by.y="row.names",all.x=T)
    #counts1<-counts[which(counts$sample %in% mRNA),]
    #counts1<-counts1[which(counts1$hgnc_symbol !=""),]
    #counts1<-counts1[,-1]
    #counts2 <- aggregate(.~hgnc_symbol,counts1, max) 
    #rownames(counts2)<-counts2[,1]
   # counts2<-counts2[,-1]
    #save(counts2,file=paste0("F:\\project_wq\\project-bio\\BSJF230314-金娟2\\scRNA\\1.data\\",names[i],".rdata"))
    name<-trimws(str_split(names[i],'_',simplify = T)[,1])
    Data.1<- CreateSeuratObject(counts = counts.1,
                                project = name,
                                min.cells = 3,
                                min.features = 200)###conventional criteria
    Data.1<-RenameCells(Data.1,add.cell.id=name)
    #### Mitochondrial gene ratio
    Data.1[["percent.mt"]] <- PercentageFeatureSet(Data.1 , pattern = "^MT-")
    #### HB gene ratio
    HB.genes <- c("HBA1","HBA2","HBB","HBD","HBE1","HBG1","HBG2","HBM","HBQ1","HBZ")
    HB_m <- match(HB.genes, rownames(Data.1@assays$RNA)) 
    HB.genes <- rownames(Data.1@assays$RNA)[HB_m] 
    HB.genes <- HB.genes[!is.na(HB.genes)] 
    Data.1[["percent.HB"]]<-PercentageFeatureSet(Data.1, features=HB.genes) 
    # 将每个细胞每个UMI的基因数目添加到元数据中
    Data.1$log10GenesPerUMI <- log10(Data.1$nFeature_RNA) / log10(Data.1$nCount_RNA)
    cellnum.raw<-ncol(Data.1)
    mean.count.raw<-mean(Data.1$nCount_RNA)
    mean.feature.raw<-mean(Data.1$nFeature_RNA)
    #Draw a statistical graph of the number of genes/count number/proportion of mitochondrial genes
    pdf(file = paste0("1.QualityControl/",names[i],".count.feature.mt.pdf"))
    p1 <-VlnPlot(Data.1 , features = c("nFeature_RNA", "nCount_RNA", "percent.mt","percent.HB"), ncol = 4)
    print(p1)
    dev.off()
    pdf(file = paste0("1.QualityControl/",names[i],".count.feature.mt.FeatureScatter.pdf"),width=12)
    p2 <- FeatureScatter(Data.1 , feature1 = "nCount_RNA", feature2 = "percent.mt")
    p3 <- FeatureScatter(Data.1 , feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
    print(p2+p3)
    dev.off()
    pdf(file = paste0("1.QualityControl/",names[i],".count.feature.mt.density.pdf"),width=12)
    p4 <-ggdensity(Data.1 @meta.data, x = "nCount_RNA", title = names[i])
    p5 <-ggdensity(Data.1 @meta.data, x = "nFeature_RNA", title = names[i])
    p6 <-ggdensity(Data.1 @meta.data, x = "percent.mt", title = names[i])
    print(p4+p5+p6)
    dev.off()
    
    ## Detect the resolution parameters of each sample cluster. After the parameters are determined, you can block them without executing [test]
    set.resolutions <- seq(0.5, 2, by = 0.1)
    
    
    #var1 = as.numeric(readline(paste0(names[i]," Enter nFeature_RNA.low number(default:200): "))); ###default:200
    #var2 = as.numeric(readline(paste0(names[i]," Enter nFeature_RNA.top number(default:6000) : "))); ###default:60 00
    #var3 = as.numeric(readline(paste0(names[i]," Enter percent.mt number(default:10) : ")));       ###default:10
    #var4 = as.numeric(readline(paste0(names[i]," Enter nCount_RNA number(default:1000) : ")));       ###default:1000 
    var1 =200
    var2 =6000
    var3 =10
    var4 =1000
    var5 =3
    #### Data filtration
    Data.1.pro <- subset(Data.1 , subset = nFeature_RNA > var1 & nFeature_RNA < var2 & percent.mt < var3 & nCount_RNA > var4 &percent.HB < var5) 
    Data.1.pro <- NormalizeData(Data.1.pro, verbose = TRUE)
    Data.1.pro <- CellCycleScoring(Data.1.pro, g2m.features=g2m.genes, s.features=s.genes)
    Data.1.pro <- SCTransform(Data.1.pro, vars.to.regress = c("S.Score","G2M.Score", "percent.mt"), verbose = FALSE)
    Data.1.pro <- RunPCA(Data.1.pro, npcs = 100, verbose = FALSE)
    pdf(file = paste0("1.QualityControl/",names[i],".ElbowPlot.pdf"))
    p7 <-ElbowPlot(object = Data.1.pro, ndims = 100) 
    print(p7)
    dev.off()
    
    #var5 = as.numeric(readline(paste0(names[i]," Enter ndims number(default:50) : "))); ###default:50
    var5=50
    Data.1.pro  <- FindNeighbors(object = Data.1.pro , dims = 1:var5, verbose = FALSE)
    Data.1.pro  <- FindClusters(object = Data.1.pro , resolution = set.resolutions, verbose = FALSE) 
    pdf(file = paste0("1.QualityControl/",names[i],".Resolutions.UMAP.pdf"))
    clustree(Data.1.pro)
    Data.1.pro  <- RunUMAP(Data.1.pro , dims = 1:var5)### RunTSNE
    Data.1.res <- sapply(set.resolutions, function(x){
        p8 <- DimPlot(object = Data.1.pro, reduction = 'umap',label = TRUE, group.by = paste0("SCT_snn_res.", x))
        print(p8)
    })
    dev.off()
    
    #### remove doublet
    #var6 = readline(paste0(names[i],"Enter SCT_snn_res number : "));  ##eg:0.3,0.6,0.7,1.2
    var6 = 1.0
    pdf(file = paste0("1.QualityControl/",names[i],".doublet.pdf"))
    DoubletRate = ncol(Data.1.pro)*8*1e-6
    Data.1.pro1 <- doubletDetect(Seurat.object = Data.1.pro, PCs = 1:var5, doublet.rate = DoubletRate, annotation = paste0("SCT_snn_res.",var6), sct = T) #7893 ~8000
    dev.off()
    saveRDS(Data.1.pro1, file = paste0("8.filter.data/",names[i],".control.filter.rds"))
    pdf(file = paste0("1.QualityControl/",names[i],".doublet.umap.pdf"))
    p9 <-DimPlot(object = Data.1.pro1, reduction = 'umap', group.by = "Doublet")
    print(p9)
    dev.off()
    
    Data.1.pro2 <- subset(Data.1.pro1, subset = Doublet == "Singlet") 
    saveRDS(Data.1.pro2, file = paste0("8.filter.data/",names[i],".doublet.filter.rds"))
    cellnum.filter<-ncol(Data.1.pro2)
    mean.count.filter<-mean(Data.1.pro2$nCount_RNA)
    mean.feature.filter<-mean(Data.1.pro2$nFeature_RNA)
    
    DefaultAssay(Data.1.pro2) <- "SCT"
    Sample.list[[names[i]]]= Data.1.pro2
    print(paste0(names[i]," is finished"))
}

#for(i in 1:length(names)){
#    Data.1.pro2 <- readRDS(file = paste0("8.filter.data/",names[i],".doublet.filter.rds"))
#    #colnames(Data.1.pro2)<-paste0(colnames(Data.1.pro2),"_",i)
   
#    name<-trimws(str_split(names[i],'_',simplify = T)[,1])
#    #DefaultAssay(Data.1.pro2) <- "RNA"
#   Sample.list[[name]]= Data.1.pro2
#    print(paste0(names[i]," is finished"))
#}
saveRDS(Sample.list, file = "9.merge.data/Sample.list.SCT.rds")

integ_features <- SelectIntegrationFeatures(object.list = Sample.list, 
                                            nfeatures = 3000) 
# 准备好SCT列表对象进行聚合
split_seurat <- PrepSCTIntegration(object.list = Sample.list, 
                                   anchor.features = integ_features)
# 寻找最佳伙伴 —— 需要一定时间运行
integ_anchors <- FindIntegrationAnchors(object.list = split_seurat, 
                                        normalization.method = "SCT", 
                                        anchor.features = integ_features)
# 跨条件聚合
seurat_integrated <- IntegrateData(anchorset = integ_anchors, 
                                   normalization.method = "SCT")

# 保存聚合的R对象
saveRDS(seurat_integrated, file = "9.merge.data/Sample.list.SCT.3000.rds")

# 运行PCA
seurat_integrated <- RunPCA(object = seurat_integrated)

# 绘制PCA
#PCAPlot(seurat_integrated,split.by = "sample")  
# 运行UMAP
seurat_integrated <- RunUMAP(seurat_integrated, 
                             dims = 1:40,
                             reduction = "pca")
saveRDS(seurat_integrated, file = "9.merge.data/seurat_integrated.rds")

DimPlot(seurat_integrated)

load("H:\\20240705\\H\\cellmark\\SingleR\\SingleR_ref\\ref_Human_all.RData")
clusters=seurat_integrated@meta.data$seurat_clusters
data<-GetAssayData(seurat_integrated,slot="data")
refdata<-ref_Human_all
cell_singleR <- SingleR(test = data, ref = refdata, labels = refdata$label.fine, 
                        method = "cluster", clusters = clusters, 
                        assay.type.test = "logcounts", assay.type.ref = "logcounts")
celltype = data.frame(ClusterID=rownames(cell_singleR), celltype=cell_singleR$labels, stringsAsFactors = FALSE)
#celltype1 = data.frame(ClusterID=rownames(cell_singleR), celltype=cell_singleR$labels, stringsAsFactors = FALSE)
head(celltype)
celltype$celltype_singleR<-celltype$celltype
celltype[c(2,4,8,16),2]<-"Myeloid"
###write.csv(celltype,file="celltype_res0.2_singleR.csv")
#CD45pos@meta.data %>%  inner_join(celltype, by = "seurat_clusters")
###addmetadata
seurat_integrated@meta.data$celltype_SingleR = "NA"
for(i in 1:nrow(celltype)){
    seurat_integrated@meta.data[which(seurat_integrated@meta.data$seurat_clusters == celltype$ClusterID[i]),'celltype_SingleR'] <- celltype$celltype[i]
}

set.resolutions <- seq(0.2, 1.2, by = 0.1)
seurat_integrated <- FindNeighbors(seurat_integrated, dims = 1:40, verbose = T)
seurat_integrated<- FindClusters(object = seurat_integrated, resolution = set.resolutions, verbose = T) 
clustree(seurat_integrated)
seurat_integrated<- FindClusters(object = seurat_integrated, resolution = 0.6, verbose = T) 
markers<-list(
   # PCT=c("CUBN","LRP2","SLC34A1","SLC5A2","ALDOB"),
    #CFH=c("CFH"),
    #LOH=c("SLC12A1"),
   # DCT=c("SLC12A3","SLC12A2","SLC8A1"),
    #CD_PC=c("AQP2"),
   # CD_ICA_ICB=c("AQP6","SLC26A4","ATP6V0D2","KIT"),
   # PODO=c("NPHS1","HPHS2"),
    # NK=c("FGFBP2", "CX3CR1", "GNLY", "NKG7"),##"FCGR3A",
    #B_cell=c("CD19", "CD79A","MS4A1")
    B_cell=c("CD79A", "CD79B", "MS4A1", "CD19"),##B+plasma
    Endothelial=c("PECAM1","CD31","CD34","VWF"),##endothelial
    #Epithelilal=c("EPCAM","KRT5","KRT14","TP63","KRT8","KRT18","KRT19"),###epithelial  ,"AR","DPP4"
    Fibroblast=c("FGF7","DCN","COL1A2","COL1A1"),  ###fibroblast
    Mast_cell=c("TPSAB1","TPSB2","FCER1A","MS4A2"),##MAST #KIT
    Plasma_cell=c("JCHAIN","MZB1","IGHG1"),
   # Myeloid=c("CD14","FCGR3A","S100A9","CST3","LYZ"),###Myeloid
    Macrophage=c("CD163","CD68","MRC1","MARCO"),
    Monocyte=c("FCN1", "CD14", "S100A8","FCGR3A","ITGAM"),##, "VCAN"
    # Luminal=c("KRT8","KRT18","KRT19","AR","DPP4"),##luminal
    # Basal=c("KRT5","KRT14","TP63"),###basal/intemediate
    Pericyte=c("RGS5", "MCAM" , "ACTA2"),
    T_NK_cell=c("PTPRC","CD3E","CD4","CD8A","CD8B", "GNLY", "NKG7")##T/NK
)
markers1<-list(
    
    B_cell=c("CD79A", "MS4A1", "CD19"),##B+plasma
    Endothelial=c("PECAM1","VWF"),##endothelial
    #Epithelilal=c("EPCAM","KRT5","KRT14","TP63","KRT8","KRT18","KRT19"),###epithelial  ,"AR","DPP4"
    Fibroblast=c("FGF7","DCN"),  ###fibroblast
    Mast_cell=c("TPSAB1","TPSB2"),##MAST #KIT
    Plasma_cell=c("JCHAIN","MZB1","IGHG1"),
    # Myeloid=c("CD14","FCGR3A","S100A9","CST3","LYZ"),###Myeloid
    Macrophage=c("CD163","CD68","MRC1"),
    Monocyte=c("FCN1", "S100A8"),##, "VCAN"
    # Luminal=c("KRT8","KRT18","KRT19","AR","DPP4"),##luminal
    # Basal=c("KRT5","KRT14","TP63"),###basal/intemediate
    Pericyte=c("RGS5", "MCAM" , "ACTA2"),
    T_NK_cell=c("CD3E","GNLY", "NKG7")##T/NK
)
DefaultAssay(seurat_integrated)<-"RNA"
#P1.6<-DotPlot(seurat_integrated,features =markers,group.by = "celltype_SingleR",col.min = 0,col.max = 1,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
#    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=12))+ylab("")
P1.6<-DotPlot(seurat_integrated,features =markers,group.by = "seurat_clusters",col.min = 0,col.max = 1,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=12))+ylab("")
ggsave(P1.6,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\celltype.marker.pdf",width = 16,height=4)
ggsave(P1.6,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\celltype.marker.png",width = 16,height=4,dpi = 300)
DEG<-FindAllMarkers(seurat_integrated,only.pos = F)
DEGTOP1<-DEG %>% group_by(cluster) %>% top_n(avg_log2FC,n=1)

###细胞定义
Idents(seurat_integrated) <- 'seurat_clusters'
celltype1=data.frame(Idents(seurat_integrated))[,1]
celltype1 <- plyr::revalue(as.character(celltype1),
                           c("0" = 'Macrophage',
                             "1" = 'Pericyte',
                             "2" = 'Pericyte',
                             "3" = 'Fibroblast',
                             "4" = 'Pericyte',
                             "5" = 'T_NK_cells',
                             "6" = 'Endothelial',
                             "7" = 'Monocyte',
                             "8" = 'Pericyte',
                             "9" = 'Endothelial',#CD8_Tem
                             "10" = 'Endothelial',
                             "11" = 'B_cells',
                             "12" = 'Mast_cells',
                             "13" = 'T_NK_cells',
                             "14" = 'Plasma_cells'
                             
                             
                           ))
seurat_integrated@meta.data$celltype<- celltype1
DimPlot(seurat_integrated,label=T)  
P1.1<-DimPlot(seurat_integrated,reduction = "umap",group.by = "celltype", label = T,label.size = 4,label.color = "black",label.box = T,
              pt.size = 0.2,cols = col_vector[1:20],repel = T) + 
    tidydr::theme_dr(xlength = 0.2, 
                     ylength = 0.2,
                     arrow = arrow(length = unit(0.15, "inches"),type = "closed")) +theme_type.plot+ggtitle("Cell Type")+NoLegend()
ggsave(P1.1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Dimplot.Celltype.pdf",width=5,height=5)
ggsave(P1.1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Dimplot.Celltype.png",width=5,height=5,dpi=300)
P1.7<-DotPlot(seurat_integrated,features =markers1,group.by = "celltype",col.min = 0,col.max = 1,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=10))+ylab("")
ggsave(P1.7,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\celltype.marker.celltype1.pdf",width = 14,height=5)
ggsave(P1.7,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\celltype.marker.celltype1.png",width = 14,height=5,dpi = 300)

cell.prop<-as.data.frame(prop.table(table(seurat_integrated$orig.ident, seurat_integrated$celltype)))
colnames(cell.prop)<-c("sample","celltype","proportion")
P1.4<-ggplot(cell.prop,aes(sample,proportion,fill=celltype))+
    #geom_histogram(stat="identity",position="fill",fill=col.1)
    geom_bar(stat="identity",position="fill")+
    scale_fill_manual(values=col_vector[1:10])+
    ggtitle("")+
    coord_flip()+ ###XY轴反转
    xlab("Sample")+ylab("Proportion")+
    theme(axis.ticks.length=unit(0.5,'cm'))+
    guides(fill=guide_legend(title=NULL))+theme_type.2+theme_type+theme(legend.position= "top")
ggsave(P1.4,file=paste0("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Sample.Celltype.Proportion.Barplot.pdf"),width=9,height=6)
ggsave(P1.4,file=paste0("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Sample.Celltype.Proportion.Barplot.png"),width=9,height=6,dpi=300)

FeaturePlot(seurat_integrated,features = c("TSPAN4","IL1B","TSPAN2","TSPAN7","WNT11","PDGFD","TSPAN15","TSPAN17"),min.cutoff = 0,max.cutoff = 3,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=12))+ylab("")


P1.2<-VlnPlot(seurat_integrated,features = c("TSPAN4","IL1B","TSPAN2","TSPAN7","WNT11","PDGFD"),group.by = "celltype",cols = col_vector[1:20],pt.size = 0)
ggsave(P1.2,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Vlnplot.DEG.pdf",width=8,height=5)
ggsave(P1.2,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\2.annotation\\Vlnplot.Deg.png",width=8,height=5,dpi=300)

Genes<-read.table("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\genemania-genes.txt",header=T,sep="\t")
Genes1<-Genes$Symbol
seurat_integrated<-AddModuleScore(seurat_integrated,features = list(Genes1),ctrl=100,names="Genes_Score")
colnames(seurat_integrated@meta.data)[48] <- 'Genes_Score'
FeaturePlot(seurat_integrated,features  = "Genes_Score")
VlnPlot(seurat_integrated,group.by = "celltype",features = "Ferrset_AUCell")

###cellchat
###cellchat
library(CellChat)
#3. 创建一个Cell Chat对象
cellchat <- createCellChat(object=seurat_integrated,group.by = "celltype")
group_size <- as.numeric(table(cellchat@idents))#查看每个cluster有多少个细胞
# 4. 导入配体受体数据库
CellChatDB <- CellChatDB.human#包含interaction、complex、cofactor和geneInfo这四个dataframe
#查看可以选择的侧面
unique(CellChatDB$interaction$annotation)

#选择“Secreted Signaling”进行后续细胞互作分析
CellChatDB.use <- subsetDB(CellChatDB, search = "Secreted Signaling")
cellchat@DB <- CellChatDB.use
#5. 预处理
#对表达数据进行预处理，用于细胞间的通信分析。
#首先在一个细胞组中识别过表达的配体或受体，然后将基因表达数据投射到PPI网络上。如果配体或受体过表达，则识别过表达配体和受体之间的相互作用。

# 在矩阵的所有的基因中提取signaling gene，结果保存在data.signaling(13714个基因，过滤完只有270个)
cellchat <- subsetData(cellchat)
#future::plan("multiprocess",workers = 4)

#相当于seurat的FindMarkers,找每个细胞群中高表达的配体受体
cellchat <- identifyOverExpressedGenes(cellchat)
#寻找在cellchatdb中高表达的受配体对
cellchat <- identifyOverExpressedInteractions(cellchat)
#上一步运行的结果储存在cellchat@LR$LRsig

#找到受配体关系后，projectData将受配体对的表达值投射到PPI上，来对@dat.signaling中的表达值进行矫正。结果保存在@data.project
cellchat <- projectData(cellchat,PPI.human)
#```

# 6. 推断细胞通讯网络

#通过为每个相互作用分配一个概率值并进行置换检验来推断生物意义上的细胞-细胞通信。

## Step 1: 推断配体-受体水平细胞通讯网络
#通过计算与每个信号通路相关的所有配体-受体相关作用的通信概率来推断信号通路水平上的通信概率。
#```{r,message=FALSE,warning=FALSE}
#根据表达值推测细胞互作的概率
cellchat <- computeCommunProb(cellchat, raw.use = FALSE,population.size = TRUE)
#如果不想用上一步PPI矫正的结果，raw.use=TRUE

#过滤某些只有几个细胞的cellgroup
cellchat <- filterCommunication(cellchat,min.cells = 10)

df.net <- subsetCommunication(cellchat)
write.csv(df.net,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\net_lr.csv")
#```
#net_lr.csv (配体-受体水平细胞通讯网络)如下所示：
#![Caption for the picture.](C:/Users/user/Desktop/scRNA-seq/data/cellchat_net_lr.png)

## Step 2: 推断信号通路水平的细胞通讯网络
#（结果储存在@netP下面，有一个概率值和对应的pval）
#我们可以通过计算链路的数量或汇总通信概率来计算细胞间的聚合通信网络。
#```{r,message=FALSE,warning=FALSE}
cellchat <- computeCommunProbPathway(cellchat)
df.netp <- subsetCommunication(cellchat,slot.name = 'netP')
write.csv(df.netp,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\net_pathway.csv")
#```

#net_pathway.csv (信号通路水平的细胞通讯网络)如下所示：
#![Caption for the picture.](C:/Users/user/Desktop/scRNA-seq/data/cellchat_net_pathway.png)
#至此，统计分析部分依据完成。


# 7. 细胞互作关系展示

## 7.1 细胞互作数量与强度统计分析

### 所有细胞群总体观：
#```{r,message=FALSE,warning=FALSE}
#统计细胞和细胞间通信的数量（有多少个配体-受体对）和强度（概率）
cellchat <- aggregateNet(cellchat)
#计算每种细胞各有多少个
groupsize <- as.numeric(table(cellchat@idents))
pdf("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\aggregateNet.pdf")
par(mfrow=c(1,2),xpd = TRUE)
netVisual_circle(cellchat@net$count,vertex.weight = groupsize,weight.scale = T,label.edge = F,title.name = "Number of interactions")
netVisual_circle(cellchat@net$weight,vertex.weight = group_size,weight.scale = T,label.edge = F,title.name = "Interaction weights/strength")
dev.off()
#```

#左图：外周各种颜色圆圈的大小表示细胞的数量。发出箭头的细胞表达配体，箭头指向的细胞表达受体。
#右图：互作的概率/强度值（强度就是概率值相加）

### 检查每种细胞发出的信号

#每个细胞如何跟别的细胞互作（number of interaction图）
#```{r,message=FALSE,warning=FALSE,fig.height=8,fig.width=8}
mat <- cellchat@net$count #绘制number of interaction图
#mat <- cellchat@net$weight #如果想展示互作的强度/概率图
par(mfrow=c(3,3),xpd=TRUE)
for (i in 1:nrow(mat)) {
    mat2 <- matrix(0,nrow = nrow(mat),ncol = ncol(mat),dimnames = dimnames(mat))
    mat2[i, ] <- mat[i, ]
    netVisual_circle(mat2,vertex.weight = groupsize,weight.scale = T,arrow.width = 0.2,arrow.size = 0.1,edge.weight.max = max(mat),title.name = rownames(mat)[i])
}
#```

### 每个细胞如何跟别的细胞互作（互作的强度/概率图）
#```{r,message=FALSE,warning=FALSE,fig.height=8,fig.width=8}
mat <- cellchat@net$weight
par(mfrow=c(3,3),xpd=TRUE)
for (i in 1:nrow(mat)) {
    mat2 <- matrix(0,nrow = nrow(mat),ncol = ncol(mat),dimnames = dimnames(mat))
    mat2[i, ] <- mat[i, ]
    netVisual_circle(mat2,vertex.weight = groupsize,weight.scale = T,arrow.width = 0.2,arrow.size = 0.1,edge.weight.max = max(mat),title.name = rownames(mat)[i])
}
#```

save(cellchat,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\cellchat.rdata")
## 7.2 单个信号通路或配体-受体介导的细胞互作可视化

#⚠️有层次图、网络图、和线图、热图可选。不同的展示方式，传递的信息相同。

### 比如在前面的功能富集分析或case control的比较中找到了一些信号通路差异，就可以进一步在细胞水平上验证。
#```{r,message=FALSE,warning=FALSE}
#查看都有哪些信号通路
cellchat@netP$pathways

#选择其中一个信号通路，比如SPP1
pathways.show <- c("SPP1")
#```

### 层次图（Hierarchy plot）
#```{r,message=FALSE,warning=FALSE,fig.height=6,fig.width=8}
#查看有集中细胞类型
levels(cellchat@idents)
#选择靶细胞的cluster，如淋系细胞在cluster1，2，4，6中
vertex.receiver = c(1,2,4,6)
netVisual_aggregate(cellchat,signaling = pathways.show,vertex.receiver = vertex.receiver,layout = "hierarchy")
#```

#在层次图中，实心圆和空心圆分别表示源和目标。圆的大小与每个细胞组的细胞数成比例。线越粗，互作信号越强。
#左图中间的target是我们选定的靶细胞。
#右图是选中的靶细胞之外的另外一组放在中间看互作关系。

### 网络图（Circle Plot）
#```{r,message=FALSE,warning=FALSE,fig.height=5,fig.width=5}
par(mfrow = c(1,1))
netVisual_aggregate(cellchat,signaling = pathways.show,layout = "circle")
#```

### 和弦图（Chord Plot）
#```{r,message=FALSE,warning=FALSE,fig.height=10,fig.width=10}
par(mfrow = c(1,1))
netVisual_aggregate(cellchat,signaling = pathways.show,layout = "chord")
#```

### 热图（Heatmap）
#```{r,message=FALSE,warning=FALSE,fig.height=5,fig.width=8}
par(mfrow = c(1,1))
netVisual_heatmap(cellchat,signaling = pathways.show, color.heatmap = "Reds")
#```



## 7.3 配体-受体层级的可视化（计算各个ligand-receptor pair对信号通路的贡献）
#```{r,message=FALSE,warning=FALSE,fig.height=5,fig.width=5}
#计算配体受体对选定信号通路的贡献值（在这里就是查看哪条信号通路对SPP1贡献最大）
netAnalysis_contribution(cellchat,signaling = pathways.show)

#提取对SPP1有贡献的所有配体受体
pairLR.SPP1 <- extractEnrichedLR(cellchat,signaling = pathways.show,geneLR.return = FALSE)
#```

### 层次图（Hierarchy plot
#```{r,message=FALSE,warning=FALSE,fig.height=5,fig.width=8}
#提取对这个通路贡献最大的配体受体对来展示（也可以选择其他的配体受体对）
###for循环输出所有互作对结果
LR.show <- pairLR.SPP1[8,]
vertex.receiver = c(6,16,18)
netVisual_individual(cellchat,signaling = pathways.show,pairLR.use = LR.show,vertex.receiver = vertex.receiver,layout = "hierarchy")
#```

### 网络图（Circle Plot)
#```{r,message=FALSE,warning=FALSE,fig.height=5,fig.width=5}
par(mfrow = c(1,1))
netVisual_individual(cellchat,signaling = pathways.show,pairLR.use = LR.show,layout = "circle")
#```

### 和弦图（Chord Plot）
#```{r,message=FALSE,warning=FALSE,fig.height=10,fig.width=10}
par(mfrow = c(1,1))
netVisual_individual(cellchat,signaling = pathways.show,pairLR.use = LR.show,layout = "chord")
#```

## 7.4 自动（批量）保存每个信号通路的互作结果
#```{r,message=FALSE,warning=FALSE,eval=FALSE}
#将所有信号通路找出来
pathways.show.all <- cellchat@netP$pathways
levels(cellchat@idents)
vertex.receiver = c(1,2,4,6)#不画层次图就不需要这一步
dir.create("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\\\all_pathways_com_circle")#创建文件夹保存批量画图结果
setwd("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\all_pathways_com_circle")
for (i in 1:length(pathways.show.all)) {
    # visualize communication network associated with both signaling pathway and individual L-R pair
    netVisual(cellchat,signaling = pathways.show.all[i],out.format = c("pdf"),
              vertex.receiver = vertex.receiver,layout = "circle")#绘制网络图
    # comoute and visualize the contribution of each ligand-receptor pair to the overall signaling pathway
    gg <- netAnalysis_contribution(cellchat,signaling = pathways.show.all[i])
    ggsave(filename = paste0(pathways.show.all[i],"_L-R_contribution.pdf"),
           plot = gg,width = 5,height = 2.5,units = "in",dpi = 300)}
setwd("../..")
#```

## 7.5 多个配体-受体介导的细胞互作关系可视化

### 气泡图（全部配体受体）
#```{r,message=FALSE,warning=FALSE,fig.height=8,fig.width=12}
#展示所有的显著性受配体对
levels(cellchat@idents)
#需要指定受体细胞和配体细胞
p = netVisual_bubble(cellchat,sources.use = c(4,6),font.size=15,
                     targets.use = c(1:length(levels(cellchat@idents))),remove.isolate = FALSE)
p
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\Macro.monocyte_bubble.pdf",p,width = 16,height = 22)#DCT
#```
#p = netVisual_bubble(cellchat,sources.use = c(15:16),font.size=15,
#                    targets.use = c(1:20),remove.isolate = FALSE)
#p
#ggsave("4.cellchat\\PCT_bubble.pdf",p,width = 12,height = 22)#PCT
#p = netVisual_bubble(cellchat,sources.use = c(17:19),font.size=15,
#                     targets.use = c(1:20),remove.isolate = FALSE)
#p
#ggsave("4.cellchat\\PEC_bubble.pdf",p,width = 18,height = 24)#PEC


### 气泡图（指定配体受体）
#```{r,message=FALSE,warning=FALSE}
#比如指定CCL和CXCL这两个信号通路
p =netVisual_bubble(cellchat,sources.use = c(4,6), 
                 targets.use = c(1:length(levels(cellchat@idents))),
                 signaling = c("BMP","IGF","EGF"),
                 remove.isolate = FALSE)
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\Macro.monocyte_BMP_IGF_bubble.pdf",p,width = 8,height = 8)
p =netVisual_bubble(cellchat,sources.use = c(4,6), 
                    targets.use = c(1:length(levels(cellchat@idents))),
                    signaling = c("EGF"),
                    remove.isolate = FALSE)
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\Macro.monocyte_EGF_bubble.pdf",p,width = 8,height = 8)
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\Macro.monocyte_EGF_bubble.png",p,width = 8,height = 8,dpi=300)
#```

### 参与某条信号通路(如SPP1)的所有基因在细胞群中的表达情况展示(小提琴图/气泡图)
#```{r,message=FALSE,warning=FALSE,fig.height=8,fig.width=8}
#小提琴图
p = plotGeneExpression(cellchat,signaling = c("BMP","IGF"))
p
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\BMP_IGF_GeneExpression_vln.pdf",p,width = 7,height = 8)
#气泡图
p = plotGeneExpression(cellchat,signaling = c("IGF"),type = "dot",color.use = col_vector)
p
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\IGF_GeneExpression_dot.pdf",p,width = 7,height = 8)

p = plotGeneExpression(cellchat,signaling = c("EGF"),type = "dot",color.use = col_vector)
p
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\EGF_GeneExpression_dot.pdf",p,width = 7,height = 8)
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\EGF_GeneExpression_dot.png",p,width = 7,height = 8,dpi = 300)


# 8. 通讯网络系统分析（可信度有待考虑）
#通讯网络系统分析使用了三种算法：社会网络分析、NMF分析和流行学习与分类
#⚠️ 不同的算法计算出来的结果可能相互矛盾，需要结合生物学知识加以判断

## 8.1 社会网络分析（通讯网络中的角色识别）

#计算网络中心性权重
pathways.show="IGF"
cellchat <- netAnalysis_computeCentrality(cellchat,slot.name = "netP")
netAnalysis_signalingRole_network(cellchat,signaling = pathways.show,width = 8,height = 2.5,font.size = 10)


#通过计算每个细胞群的网络中心性指标，识别每类细胞在信号通路中的角色（发送者/接收者/调节者/影响者）
pdf(file="4.cellchat\\SPP1_signalingRole_network.pdf",width = 8,height = 6)
netAnalysis_signalingRole_network(cellchat,signaling = pathways.show,
                                  width = 15,height = 6,font.size = 10,font.size.title = 25)

dev.off()

#识别信号的信号流模式

ht1 <- netAnalysis_signalingRole_heatmap(cellchat,pattern = "outgoing",width = 18,height = 20,font.size = 12,font.size.title = 25)
ht2 <- netAnalysis_signalingRole_heatmap(cellchat,pattern = "incoming",width = 18,height = 20,font.size = 12,font.size.title = 25)
p <- ht1 + ht2
pdf(file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\singnal_in_out.pdf",width =20,height = 12)
png(file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\singnal_in_out.png",width =2000,height = 1200,res=120)
p
dev.off()
save(cellchat,file = "F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\4.cellchat\\cellchat.rdata")
levels(cellchat@idents)[c(6,16,18)]

save(seurat_integrated, file = "F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\scRNA\\9.merge.data/seurat_integrated.rdata")






###############submyeloid##########################
sub_meyloid<-subset(seurat_integrated,subset=celltype=="Myeloid")
sub_meyloid<-NormalizeData(sub_meyloid,normalization.method = "LogNormalize", scale.factor = 1e4)
sub_meyloid <- SCTransform(sub_meyloid, vars.to.regress = c("S.Score","G2M.Score", "percent.mt"), verbose = FALSE)
#sub_meyloid <- RunPCA(sub_meyloid, npcs = 100, verbose = FALSE)
DefaultAssay(sub_meyloid)<-"integrated"
all.genes<-rownames(sub_meyloid)
#sub_meyloid<-ScaleData(sub_meyloid,features=all.genes)
sub_meyloid<- RunPCA(object = sub_meyloid, features = VariableFeatures(object = sub_meyloid),npcs = 50, verbose = FALSE)
ElbowPlot(object = sub_meyloid,ndims = 50, reduction = "pca")+ theme(axis.text = element_text(size=10))
sub_meyloid <- RunUMAP(object = sub_meyloid, reduction = "pca", dims = 1:50)
sub_meyloid <- FindNeighbors(object = sub_meyloid, reduction = "pca", dims = 1:50)
sub_meyloid <- FindClusters(sub_meyloid, resolution = 0.8)
sub_meyloid <- FindClusters(sub_meyloid, resolution = 1.2)
sub_meyloid <- FindClusters(sub_meyloid, resolution = 1)
DimPlot(sub_meyloid,label=T,reduction = "umap")

clusters=sub_meyloid@meta.data$seurat_clusters
data<-GetAssayData(sub_meyloid,slot="data")
refdata<-ref_Human_all
cell_singleR <- SingleR(test = data, ref = refdata, labels = refdata$label.fine, 
                        method = "cluster", clusters = clusters, 
                        assay.type.test = "logcounts", assay.type.ref = "logcounts")
celltype = data.frame(ClusterID=rownames(cell_singleR), celltype=cell_singleR$labels, stringsAsFactors = FALSE)

DefaultAssay(sub_meyloid)<-"RNA"
VlnPlot(sub_meyloid,features = c("TSPAN4","IL1B","TSPAN2","TSPAN7","WNT11","PDGFD"),cols = col_vector[1:20],pt.size = 0)
markers_mye<-list(
    Macrophage=c("CD163","CD68"),
    Monocyte=c("CD14","FCGR3A","ITGAM"),
    DC=c("HLA-DQB2","HLA-DPB1","BIRC3")
  
)
P1.8<-DotPlot(sub_meyloid,features =markers_mye,group.by = "seurat_clusters",col.min = 0,col.max = 1,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=12))+ylab("")

FeaturePlot(sub_meyloid,features = c("TSPAN4","IL1B","TSPAN2","TSPAN7","WNT11","PDGFD","TSPAN15","TSPAN17"),min.cutoff = 0,max.cutoff = 3,cols = c("lightgrey", "red"))+theme_type.plot+theme_type+
    theme(axis.text.x=element_text(angle=45,hjust = 1,colour="black",family="Times",size=12))+ylab("")


DEG.mye<-FindAllMarkers(sub_meyloid)

top<-DEG.mye %>% group_by(cluster) %>% top_n(n=3,avg_log2FC)


Idents(sub_meyloid) <- 'seurat_clusters'
celltype2=data.frame(Idents(sub_meyloid))[,1]
celltype2 <- plyr::revalue(as.character(celltype2),
                           c("0" = 'Macrophage_CCL18',
                             "1" = 'Macrophage_HES1',
                             "2" = 'Macrophage_F13A1',
                             "3" = 'Monocyte_CCL4',
                             "4" = 'Macrophage_CCL2',
                             "5" = 'Monocyte_AREG',
                             "6" = 'Monocyte_FCER1A',
                             "7" = 'Macrophage_FCGBP',
                             "8" = 'Macrophage_IFI27',
                             "9" = 'Monocyte_S100A8'
                           ))
sub_meyloid@meta.data$celltype_sub<- celltype2