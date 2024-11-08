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
    library(WGCNA)
    library(consensus)
    library(CIBERSORT)
    library(ConsensusClusterPlus)
}
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
theme_zg <- function(..., bg='white'){
    require(grid)
    theme_classic(...) +
        theme(rect=element_rect(fill=bg),
              plot.margin=unit(rep(0.5,4), 'lines'),
              #panel.background=element_rect(fill='transparent',color='black'),
              panel.border=element_rect(fill='transparent', color='transparent'),
              panel.grid=element_blank(),#去网格线
              axis.line = element_line(colour = "black"),
              #axis.title.x = element_blank(),#去x轴标签
              axis.title.y=element_text(face = "bold",size = 14),#y轴标签加粗及字体大小
              axis.title.x=element_text(face = "bold",size = 14),#X轴标签加粗及字体大小     
              axis.text.y = element_text(face = "bold",size = 12),#y坐标轴刻度标签加粗
              axis.text.x = element_text(face = "bold",size = 10, vjust = 1, hjust = 1, angle = 45),#x坐标轴刻度标签加粗 
              axis.ticks = element_line(color='black'),
              # axis.ticks.margin = unit(0.8,"lines"),
              legend.title=element_blank(),
              #legend.position=c(0.9, 0.9),#图例在绘图区域的位置
              #legend.direction = "horizontal",
              legend.text = element_text(face = "bold",size = 12)#,
              #legend.background = element_rect( linetype="solid",colour ="black")
        )
}
####苏剑瑶
######GSE100927
exprSet.GSE100927<- read.table("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\RNA\\GSE100927_series_matrix.txt",
                               comment.char="!",       #comment.char="!" 意思是！后面的内容不要读取
                               stringsAsFactors=F,
                               header=T)
class(exprSet.GSE100927)##查看数据类型

######GPL 平台探针
#GPL571<-GEOquery::getGEO(filename = "F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\RNA\\GSE100927_family.soft.gz")
#fData<-fData(GPL[[1]])
#id_probe <- GPL571@gpls$GPL571@dataTable@table
library(AnnoProbe)
ids=idmap('GPL17077',type = 'soft')
probe2gene <- ids
#probe2gene <- id_probe[,c(1,11)]
#probe2gene<-probe2gene[which(probe2gene$GENE_SYMBOL!=""),]
#probe2gene$symbol=trimws(str_split(probe2gene$`Gene Symbol`,'//',simplify = T)[,1]) ###需要拆分数据情况
probe2gene<-probe2gene[which(probe2gene$symbol!="---" & probe2gene$symbol !=""),]
ids2 <- probe2gene
table(table(unique(ids2$symbol)))#30907 ,30907个基因

GSE100927<-merge(ids2,exprSet.GSE100927,by.x="ID",by.y = "ID_REF",all.x = T)
#GSE100927<-GSE100927[which(GSE100927$GENE_SYMBOL !="---" &GSE100927$GENE_SYMBOL !=""),]
GSE100927<-GSE100927[,-1]
GSE100927<- aggregate(.~symbol,GSE100927, mean)  ##把重复的Symbol取平均值
row.names(GSE100927) <- GSE100927$symbol#把行名命名为SYMBOL
GSE100927<- subset(GSE100927, select = -1)  #删除Symbol列（一般是第一列）
qx <- as.numeric(quantile(GSE100927, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))
LogC <- (qx[5] > 100) ||
    (qx[6]-qx[1] > 50 && qx[2] > 0) ||
    (qx[2] > 0 && qx[2] < 1 && qx[4] > 1 && qx[4] < 2)
qx;LogC
#####筛选劲动脉样本
sample<-read.csv("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\RNA\\GSE100927_series_matrix.sample.csv",header = F)
sample<-t(sample)
table(sample[,2])
sample1<-sample[which(sample[,2]=="Atherosclerotic carotid artery"|sample[,2]=="Control carotid artery"),]
sample2<-sample1[order(sample1[,2]),]
table(sample2[,2])

exp.GSE100927<-GSE100927[,sample2[,1]]
group.GSE100927<-rep(c("AS","Control"),c(29,12))
design <- model.matrix(~0+factor(group.GSE100927))
colnames(design) <- levels(factor(group.GSE100927))
rownames(design) <- colnames(exp.GSE100927)

contrast.matrix <- makeContrasts(AS-Control,levels = design)
fit <- lmFit(exp.GSE100927,design) #非线性最小二乘法
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)#用经验贝叶斯调整t-test中方差的部分
DEG.GSE100927<- topTable(fit2, coef = 1,n = Inf,sort.by="logFC")
DEG.GSE100927<- na.omit(DEG.GSE100927)
DEG.GSE100927$Genes<-rownames(DEG.GSE100927)
DEG.GSE100927$regulate <- ifelse(DEG.GSE100927$adj.P.Val> 0.05, "unchanged",
                                 ifelse(DEG.GSE100927$logFC > 0.585, "up-regulated",
                                        ifelse(DEG.GSE100927$logFC < -0.585, "down-regulated", "unchanged")))

p3.2<-ggvolcano(data = DEG.GSE100927,x = "logFC",y = "P.Value",output = FALSE,label = "Genes",label_number = 0,
                # log2FC_cut = 0.5,
                fills = c("#00A087FF", "#999999", "#DC0000FF"),
                colors = c("#00A087FF", "#999999", "#DC0000FF"),
                x_lab = "log2FC",
                y_lab = "-Log10P.Value",
                legend_position = "UL") #标签位置为up right
ggsave(p3.2,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE100927.DEG.pdf",width=6,height=5)
ggsave(p3.2,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE100927.DEG.png",width=6,height=5,dpi = 300)
table(DEG.GSE100927$regulate )
write.csv(DEG.GSE100927,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\DEG.GSE100927.csv",row.names=F,quote=F)
save(GSE100927,ids2,DEG.GSE100927,exp.GSE100927,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE100927.exp.DEG.rdata")
library(ggrepel)
p <- ggplot(DEG.GSE100927,aes(logFC,-log10( P.Value)))+
    # 横向水平参考线：
    geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "#999999",size=0.75)+
    # 纵向垂直参考线：
    geom_vline(xintercept = c(-.585,.585), linetype = "dashed", color = "#999999",size=0.75)+
    geom_point(aes(size=-log10( P.Value), color=-log10( P.Value)))+
    scale_color_gradientn(values = seq(0,1,0.2),
                          colors =
                              c("#39489f","#39bbec","#f9ed36","#f38466","#b81f25")
    )+
    # 指定散点大小渐变模式：连续型变量
    scale_size_continuous(range = c(0.1,1))+
    theme_bw()+
    theme(legend.text=element_text(size=9),
          legend.title = element_text(size = 12),
          axis.text = element_text(size = 13),
          axis.title = element_text(size = 15),
          axis.ticks.length = unit(-0.25, 'cm'))+
    # 调整主题和图例位置：
    theme(panel.grid = element_blank(),
          legend.position = c(0.03,0.99),
          legend.justification = c(0,1)
    )+
    guides(col = guide_colorbar(),size = "none")+
    #geom_text_repel(data = Res3, aes(x = log2FoldChange,y = -log10(pvalue), label = gene),size =3,max.overlaps = 10,col="black")+
    geom_text_repel(data = DEG.GSE100927[genes_inter[c(2,4)],], aes(logFC,-log10( P.Value), label = Genes),size =5,max.overlaps = 10,col="red")+
    geom_text_repel(data = DEG.GSE100927[genes_inter[c(1,3,5,6)],], aes(logFC,-log10( P.Value), label = Genes),size =5,max.overlaps = 10,col="blue")
ggsave(p,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE100927.DEG.mig.pdf",width=8,height=7)
ggsave(p,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE100927.DEG.mig.png",width=8,height=7,dpi = 300)


#迁移体基因集 28中有23个
geneset<-c("TSPAN1","TSPAN2","TSPAN3","TSPAN4","TSPAN5","TSPAN6","TSPAN7","TSPAN9","TSPAN13",
           "TSPAN18","TSPAN25","TSPAN26","TSPAN27",
           "ITGA1","ITGA3","ITGA5","ITGB1", ###Membrane markers
           "NDST1","EOGT","PIGK","CPQ",###Protein markers
           "ROCK1","TGFB2","IL1B","PDGFD","CXCL12","WNT8A","WNT11")###Regulator and Signaling molecules
genes_inter<-intersect(geneset,DEG.GSE100927[which(DEG.GSE100927$regulate!="unchanged"),"Genes"])
DEG.GSE100927[genes_inter,]
mydata1<-list(Migrasomes=geneset,
             DEG=DEG.GSE100927[which(DEG.GSE100927$regulate!="unchanged"),"Genes"])

p4 <- ggvenn(mydata1,show_percentage = T,show_elements = F,label_sep = ",",
             digits = 1,stroke_color = "white",
             text_color = "black",text_size = 4,set_name_size = 5,
             fill_color = c("#6639A6","#FF165D"),#"#4DAF4A",  
             set_name_color = c("#6639A6","#FF165D"))#,"#4DAF4A""#FF8C00", 

ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG/Migrasomes.pdf",width=6,height=6,onefile=FALSE,p4)
ggsave("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG/Migrasomes.png",width=6,height=6,p4,dpi = 300)
Genes<-read.table("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\genemania-genes.txt",header=T,sep="\t")
Genes1<-Genes$Symbol

###GO KEGG
entrezIDs=mget(Genes1, org.Hs.egSYMBOL2EG, ifnotfound=NA)	# 找出基因对应的ID
entrezIDs=as.character(entrezIDs)
#entrezIDs[grep("c",entrezIDs)]<-221938###unique_gene
GO.genemania=enrichGO(gene = entrezIDs,
                OrgDb = org.Hs.eg.db, # 参考基因组
                pvalueCutoff =1,	# P值阈值
                qvalueCutoff = 1,	# qvalue是P值的校正值
                ont="all",	# 主要的分为三种，三个层面来阐述基因功能，生物学过程（BP），细胞组分（CC），分子功能（MF）
                readable =T)	# 是否将基因ID转换为基因名

GO.genemania1<-as.data.frame(GO.genemania)
GO.genemania1$type<-"genemania"
table(GO.genemania1[which(GO.genemania1$p.adjust<0.05),"ONTOLOGY"])
GO.genemania2<-GO.genemania1[which(GO.genemania1$p.adjust<0.05),]
write.csv(GO.genemania2,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\4.enrichment\\RNA\\GO.MIG.csv",row.names=F,quote=F)
index1<-which(GO.genemania2$Count=="5")

index3<-grep("^macrophage migration",GO.genemania2$Description)
indexall<-c(index1,index3)
GO.genemania3<-GO.genemania2[indexall,]
GO.genemania3<-GO.genemania3[order(GO.genemania3$pvalue),]
indexall1<-c( "GO:0005178", "GO:0097529" ,"GO:0050900" ,"GO:0005925" ,"GO:0030055" ,"GO:1905517")
GO.genemania4<-GO.genemania2[indexall1,]
Genes.table<-Genes[,c(1,3)]
run_circle_enrichment(
    data = GO.genemania4,
    DEGs = Genes.table,
    dir_save = 'F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\4.enrichment\\RNA',
    type = 'GO', # GO/KEGG
    height = 12,
    width = 20,
    dpi = 300,
    pic_type = 'png')

KEGG.genemania <- enrichKEGG(gene = entrezIDs, #需要分析的基因的EntrezID
                       organism = "hsa",  #人
                       pvalueCutoff =0.05, #设置pvalue界值
                       qvalueCutoff = 1) #设置qvalue界值(FDR校正后的p值）
KEGG.genemania3 <- setReadable(KEGG.genemania ,"org.Hs.eg.db","ENTREZID")
KEGG.genemania1<-as.data.frame(KEGG.genemania3)
write.csv(KEGG.genemania1,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\4.enrichment\\RNA\\KEGG.MIG.csv",row.names=F,quote=F)
KEGG.genemania2<-KEGG.genemania1[which(KEGG.genemania1$Description %in%c("Hematopoietic cell lineage","MAPK signaling pathway","Fluid shear stress and atherosclerosis","Necroptosis")),]
run_circle_enrichment(
    data = KEGG.genemania2,
    DEGs = Genes.table,
    dir_save = 'F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\4.enrichment\\RNA',
    type = 'KEGG', # GO/KEGG
    height = 12,
    width = 20,
    dpi = 300,
    pic_type = 'png')

###consensus
setwd("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result")
consensus.GSE100927<-exp.GSE100927[,c(1:29)]

###consensus cluster
intersection_matrix.GSE100927<-as.matrix((consensus.GSE100927[intersect(rownames(consensus.GSE100927),Genes1),]))

#expM_sc1 = expM_sc[,-grep("N$",colnames(expM_sc))]
#intersection_matrix.GSE100927<-as.matrix(expM_sc1[genes_B,])


#intersection_geneExp
##标准化
STAD_tumor = sweep(intersection_matrix.GSE100927, 1, apply(intersection_matrix.GSE100927, 1, median, na.rm = T))
#STAD_tumor =intersection_matrix.GSE100927
#########sample ConsensusClusterPlus#############

title=tempdir()
results = ConsensusClusterPlus(STAD_tumor, maxK = 6, reps = 1000, pItem = 0.8, pFeature =1, 
                               title = "3.untitled_consensus_cluster",
                               clusterAlg = c("km",'hc')[1], 
                               distance = c("euclidean","pearson", 'pam')[2], 
                               seed = 1063,
                               tmyPal=NULL, writeTable=T, plot = "pdf")


## end fraction

############样品一致性 (item-consensus)
icl = calcICL(results, title = "6.consensus_cluster", plot = "pdf")

dim(icl[["clusterConsensus"]])
icl[["clusterConsensus"]][1:5,]


dim(icl[["itemConsensus"]])
icl[["itemConsensus"]][1:5,]

###提取cluster2结果
annCol <- data.frame(results = paste0("Cluster",
                                      results[[2]][['consensusClass']]),
                     row.names = colnames(intersection_matrix.GSE100927))


###tsne分析
# 将数据框中字符型数据转化为数值型
#intersection_tumor <- lapply(as.matrix(intersection_matrix.GSE100927), as.numeric)
#rownames(intersection_tumor) <- rownames(intersection_matrix.GSE100927)
#colnames(intersection_tumor) <- colnames(tumor_matrix)

intersection_tumor = na.omit(intersection_matrix.GSE100927)
intersection_tumor <- as.matrix(intersection_tumor)

library(Rtsne)

tSNE_res<- Rtsne(t(intersection_tumor), dims= 2, perplexity= 4, verbose= F, max_iter= 500, check_duplicates= F) 

tsne<- data.frame(tSNE1 = tSNE_res[["Y"]][,1], tSNE2= tSNE_res[["Y"]][,2], cluster = annCol$results) 

P1.9<-ggplot(tsne, aes(x= tSNE1, y= tSNE2, color= cluster)) + 
    geom_point(size= 4.5, alpha= 0.5) + 
    stat_ellipse(level= 0.85, show.legend = F) + theme_type+
    tidydr::theme_dr(xlength = 0.2, 
                     ylength = 0.2,
                     arrow = arrow(length = unit(0.15, "inches"),type = "closed"))+
    theme(legend.position= "top")
ggsave(P1.9,file="3.untitled_consensus_cluster\\Sample.Consensus.Cluster.Tsne.pdf",width=4,height=4)
ggsave(P1.9,file="3.untitled_consensus_cluster\\Sample.Consensus.Cluster.Tsne.png",width=4,height=4,dpi=300)
save(STAD_tumor,results,tSNE_res,tsne,annCol,file="3.untitled_consensus_cluster\\3.1.GSE160269.Consensus.rdata")



#######差异分析 limma########
exp<-as.matrix(consensus.GSE100927)
group<-annCol$results

design <- model.matrix(~0+factor(group))
colnames(design) <- levels(factor(group))
rownames(design) <- colnames(exp)

contrast.matrix <- makeContrasts(Cluster2-Cluster1,levels = design)
fit <- lmFit(exp,design) #非线性最小二乘法
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)#用经验贝叶斯调整t-test中方差的部分
DEG <- topTable(fit2, coef = 1,n = Inf,sort.by="logFC")
DEG <- na.omit(DEG)
DEG$Genes<-rownames(DEG)
DEG$regulate <- ifelse(DEG$adj.P.Val > 0.05, "unchanged",
                       ifelse(DEG$logFC > 0.585, "Cluster2-up-regulated",
                              ifelse(DEG$logFC < -0.585, "Cluster1-up-regulated", "unchanged")))
DEG$regulate <- ifelse(DEG$adj.P.Val > 0.05, "unchanged",
                       ifelse(DEG$logFC > 0.585, "up-regulated",
                              ifelse(DEG$logFC < -0.585, "down-regulated", "unchanged")))
p3.3<-ggvolcano(data = DEG,x = "logFC",y = "adj.P.Val",output = FALSE,label = "Genes",label_number = 0,
                log2FC_cut = 0.585,
                fills = c("#00A087FF", "#999999", "#DC0000FF"),
                colors = c("#00A087FF", "#999999", "#DC0000FF"),
                x_lab = "log2FC",
                y_lab = "-Log10adj.P.Value",
                legend_position = "UL") +ggtitle("Cluster1-Cluster2")+theme(plot.title = element_text(size=25,colour ="black",hjust=0.5))#标签位置为up right
ggsave(p3.3,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\ggvolcano.cluster1.cluster2.pdf",width = 6,height = 5)
ggsave(p3.3,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\ggvolcano.cluster1.cluster2.png",width = 6,height = 5,dpi=300)
write.csv(DEG,"F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\DEG.cluster1.cluster2.csv",row.names=F,quote=F)
table(DEG$regulate)
save(DEG,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\DEG.rdata")

intersect(geneset,DEG[which(DEG$regulate!="unchanged"),"Genes"])

####GO KEGG 
Cluster2_up<-DEG[which(DEG$regulate=="up-regulated"),"Genes"]
entrezIDs=mget(Cluster2_up, org.Hs.egSYMBOL2EG, ifnotfound=NA)	# 找出基因对应的ID
entrezIDs=as.character(entrezIDs)
#entrezIDs[grep("c",entrezIDs)]<-221938###unique_gene
GO.res=enrichGO(gene = entrezIDs,
                OrgDb = org.Hs.eg.db, # 参考基因组
                pvalueCutoff =1,	# P值阈值
                qvalueCutoff = 1,	# qvalue是P值的校正值
                ont="all",	# 主要的分为三种，三个层面来阐述基因功能，生物学过程（BP），细胞组分（CC），分子功能（MF）
                readable =T)	# 是否将基因ID转换为基因名

GO.res1<-as.data.frame(GO.res)
GO.res1$celltype<-"cluster2.up"
table(GO.res1[which(GO.res1$p.adjust<0.05),"ONTOLOGY"])
GO.res2<-GO.res1[which(GO.res1$p.adjust<0.05),]
write.csv(GO.res2,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\enrichment\\cluster1\\GO.Cluster2_up.csv",row.names=F,quote=F)
##c("GO:0090130","GO:0010631","GO:0043542","GO:0001667","GO:0030111","GO:0001837")
GO.res3<-GO.res2[c("GO:0090130","GO:0010631","GO:0043542","GO:0001667","GO:0030111","GO:0001837"),]
DEG.cluster2.up<-DEG[which(DEG$regulate=="up-regulated"),c("Genes","logFC")]
run_circle_enrichment(
    data = GO.res3,
    DEGs = DEG.cluster2.up,
    dir_save = 'F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\enrichment\\cluster2',
    type = 'GO', # GO/KEGG
    height = 12,
    width = 20,
    dpi = 300,
    pic_type = 'png')

Cluster1_up<-DEG[which(DEG$regulate=="down-regulated"),"Genes"]
entrezIDs=mget(Cluster1_up, org.Hs.egSYMBOL2EG, ifnotfound=NA)	# 找出基因对应的ID
entrezIDs=as.character(entrezIDs)
#entrezIDs[grep("c",entrezIDs)]<-221938###unique_gene
GO.res.c1=enrichGO(gene = entrezIDs,
                OrgDb = org.Hs.eg.db, # 参考基因组
                pvalueCutoff =1,	# P值阈值
                qvalueCutoff = 1,	# qvalue是P值的校正值
                ont="all",	# 主要的分为三种，三个层面来阐述基因功能，生物学过程（BP），细胞组分（CC），分子功能（MF）
                readable =T)	# 是否将基因ID转换为基因名

GO.res1.c1<-as.data.frame(GO.res.c1)
GO.res1.c1$celltype<-"cluster1.up"
table(GO.res1.c1[which(GO.res1.c1$p.adjust<0.05),"ONTOLOGY"])
GO.res2.c1<-GO.res1.c1[which(GO.res1.c1$p.adjust<0.05),]
write.csv(GO.res2.c1,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\enrichment\\cluster1\\GO.Cluster1_up.csv",row.names=F,quote=F)
##c("GO:0006869","GO:0006631","GO:0015914","GO:1903725")
GO.res3.c1<-GO.res2.c1[c("GO:0006869","GO:0006631","GO:0015914","GO:1903725"),]
DEG.cluster1.up<-DEG[which(DEG$regulate=="down-regulated"),c("Genes","logFC")]
DEG.cluster1.up$logFC<-DEG.cluster1.up$logFC*(-1)
run_circle_enrichment(
    data = GO.res3.c1,
    DEGs = DEG.cluster1.up,
    dir_save = 'F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\enrichment\\cluster1',
    type = 'GO', # GO/KEGG
    height = 12,
    width = 20,
    dpi = 300,
    pic_type = 'png')

KEGG.res <- enrichKEGG(gene = entrezIDs, #需要分析的基因的EntrezID
                 organism = "hsa",  #人
                 pvalueCutoff =0.5, #设置pvalue界值
                 qvalueCutoff = 0.5) #设置qvalue界值(FDR校正后的p值）
KEGG.res1<-as.data.frame(KEGG.res)


save(GO.res,GO.res1,KEGG.res,KEGG.res1,file=paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\cluster2.up.GO.KEGG.result.rdata"))
#Cluster2_down<-DEG[which(DEG$regulate=="down-regulated"),"Genes"]
#entrezIDs=mget(Cluster1_down, org.Hs.egSYMBOL2EG, ifnotfound=NA)	# 找出基因对应的ID
#entrezIDs=as.character(entrezIDs)
#entrezIDs[grep("c",entrezIDs)]<-221938###unique_gene
#GO.res.down=enrichGO(gene = entrezIDs,
#                OrgDb = org.Hs.eg.db, # 参考基因组
#                pvalueCutoff =1,	# P值阈值
#                qvalueCutoff = 1,	# qvalue是P值的校正值
#                ont="all",	# 主要的分为三种，三个层面来阐述基因功能，生物学过程（BP），细胞组分（CC），分子功能（MF）
#                readable =T)	# 是否将基因ID转换为基因名
#save(GO.res.down,file=paste0("4.enrichment\\cluster1.down.GO.result.rdata"))
#GO.res1.down<-as.data.frame(GO.res.down)
#GO.res1.down$celltype<-"cluster1.down"
#table(GO.res1.down[which(GO.res1.down$p.adjust<0.05),"ONTOLOGY"])
#GO.res2.down<-GO.res1[which(GO.res1.down$p.adjust<0.05),]

#KEGG.res.down <- enrichKEGG(gene = entrezIDs, #需要分析的基因的EntrezID
#                       organism = "hsa",  #人
#                       pvalueCutoff =0.5, #设置pvalue界值
#                       qvalueCutoff = 0.5) #设置qvalue界值(FDR校正后的p值）
#KEGG.res1.down<-as.data.frame(KEGG.res.down)
bubble_plot2 <- 
    ggplot(GO.res1[c(1:10),], aes(x = Count, y = reorder(Description, Count), size = Count, color = pvalue)) +
    scale_size(range = c(5, 8)) +
    # scale_color_manual(col = COL2('PiYG'))+
    scale_colour_gradientn(colours = terrain.colors(10))+
    geom_col(alpha = 0.8,width = 0.1,size=0.1)+
    geom_point() +
    labs(title = "", x = "Count", y = "") +
    #geom_text(aes(label=`P value`),size=2.5,nudge_x = c(rep(0.3,22)))+
    theme_minimal()
ggsave(bubble_plot2,file = paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\KEGG_top.pdf"),width=8,height=6)
ggsave(bubble_plot2,file = paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\KEGG_top.png"),width=8,height=6,dpi=300)

####3DEG GSEA
DEG1<-DEG[order(DEG$logFC,decreasing = T),]
library(msigdbr)
library(fgsea)

gene_entrezid <- bitr(geneID = DEG1$Genes
                      , fromType = "SYMBOL" # 从symbol
                      , toType = "ENTREZID" # 转成ENTREZID
                      , OrgDb = "org.Hs.eg.db"
)

gene_entrezid <- merge(gene_entrezid,DEG1,by.x = "SYMBOL", by.y = "Genes")
gene_entrezid1<-gene_entrezid[order(gene_entrezid$logFC,decreasing = T),]
genelist <- gene_entrezid1$logFC
names(genelist) <- gene_entrezid1$ENTREZID
genelist <- sort(genelist,decreasing = T)


fgsea_sets<-msigdbr(species = "Homo sapiens", category = "C2") %>% 
    dplyr::select(gs_name, entrez_gene)
index1<-c(grep("^WP_",fgsea_sets$gs_name),grep("^KEGG_",fgsea_sets$gs_name),grep("^REACTOME_",fgsea_sets$gs_name))
fgsea_sets1<-fgsea_sets[index1,]
set.seed(20240925)
save(genelist,fgsea_sets,fgsea_sets1,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.rdata")
gsea_res <- GSEA(genelist, 
                 TERM2GENE = fgsea_sets1,
                 minGSSize = 10,
                 maxGSSize = 500,
                 pvalueCutoff = 0.05,
                 pAdjustMethod = "BH",
                 seed = 456
)
## preparing geneSet collections...
## GSEA analysis...
## leading edge analysis...
## done...
gsea_res.matrix<-as.data.frame(gsea_res )
write.csv(gsea_res.matrix,"F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.result.C2.csv",quote = F)
#把entrezid变为symbol
#把entrezid变为symbol
gsea_res_symbol <- setReadable(gsea_res,"org.Hs.eg.db","ENTREZID")
for (i in 1:length(gsea_res.matrix$Description)) {
    library(gridExtra)
    
    # 选择4,5,6条通路
    x <- gsea_res_symbol
    geneSetID <- i
    
    # 提取NES，P值等信息
    pd <- x[geneSetID, c( "NES", "p.adjust")]#"pvalue",
    pd <- pd[order(rownames(pd), decreasing=FALSE),]
    for (j in seq_len(ncol(pd))) {pd[, j] <- format(pd[, j], digits = 4)}
    
    # 通过修改table的主题来修改表格细节
    tt <- ttheme_minimal(base_size = 12,
                         core=list(#bg_params = list(fill = NA, col=NA),
                             fg_params=list(col=c("#F8766D"))
                         )
    )
    
    tp <- tableGrob(pd,rows = NULL,theme = tt)
    
    # 修改表格每个格子的宽度和高度
    #tp$widths <- unit(rep(1.2,ncol(tp)), "cm")
    tp$heights <- unit(rep(0.8,nrow(tp)),"cm") # cell height
    
    
    
    p <- gseaplot2(gsea_res_symbol,geneSetID = i,
                   title = gsea_res_symbol$Description[i])
    
    p[[1]] <- p[[1]]+
        annotation_custom(tp,
                          xmin = 13000,
                          xmax = 18000,
                          #ymin = 0#,
                          # ymax = 0.8
        )+
        theme(plot.title = element_text(hjust = 0.5))
    
    ggsave(p,file=paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.C2\\",gsea_res_symbol$Description[i],".pdf"),width=8,height=6)
    ggsave(p,file=paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.C2\\",gsea_res_symbol$Description[i],".png"),width=8,height=6,dpi=300)
}
###hallmark
fgsea_sets<-msigdbr(species = "Homo sapiens", category = "H") %>% 
    dplyr::select(gs_name, entrez_gene)
set.seed(202409251)

gsea_res <- GSEA(genelist, 
                 TERM2GENE = fgsea_sets,
                 minGSSize = 10,
                 maxGSSize = 500,
                 pvalueCutoff = 0.05,
                 pAdjustMethod = "BH",
                 seed = 4567
)
save(gsea_res,genelist,fgsea_sets,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.Hallmark.rdata")
## preparing geneSet collections...
## GSEA analysis...
## leading edge analysis...
## done...
gsea_res_symbol <- setReadable(gsea_res,"org.Hs.eg.db","ENTREZID")
#gsea_res_up <- gsea_res_symbol %>% ###保留上调结果
#    arrange(desc(NES)) %>% 
#    slice(1:6)
gsea_res_up<-gsea_res[gsea_res$NES>0,asis=T] ###NES 上调
gsea_res.Hallmark<-as.data.frame(gsea_res_symbol )
write.csv(gsea_res.Hallmark,"F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.result.Hallmark.csv",quote = F)
###山脊图
ridgep <- ridgeplot(gsea_res_up,
                    showCategory = 20,
                    fill = "p.adjust",
                    core_enrichment = TRUE,
                    label_format = 100, #设置轴标签文字的每行字符数长度，过长则会自动换行。
                    orderBy = "NES",
                    decreasing = F) 

ggsave(ridgep,file = paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.Hallmark.ridgep_topup6.pdf"),width=12,height=6)
ggsave(ridgep,file = paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.Hallmark.ridgep_topup6.png"),width=12,height=6,dpi=300)

#把entrezid变为symbol
#把entrezid变为symbol
gsea_res_symbol <- setReadable(gsea_res,"org.Hs.eg.db","ENTREZID")
for (i in 1:length(gsea_res.matrix$Description)) {
    library(gridExtra)
    
    # 选择4,5,6条通路
    x <- gsea_res_symbol
    geneSetID <- i
    
    # 提取NES，P值等信息
    pd <- x[geneSetID, c( "NES", "p.adjust")]#"pvalue",
    pd <- pd[order(rownames(pd), decreasing=FALSE),]
    for (j in seq_len(ncol(pd))) {pd[, j] <- format(pd[, j], digits = 4)}
    
    # 通过修改table的主题来修改表格细节
    tt <- ttheme_minimal(base_size = 12,
                         core=list(#bg_params = list(fill = NA, col=NA),
                             fg_params=list(col=c("#F8766D"))
                         )
    )
    
    tp <- tableGrob(pd,rows = NULL,theme = tt)
    
    # 修改表格每个格子的宽度和高度
    #tp$widths <- unit(rep(1.2,ncol(tp)), "cm")
    tp$heights <- unit(rep(0.8,nrow(tp)),"cm") # cell height
    
    
    
    p <- gseaplot2(gsea_res_symbol,geneSetID = i,
                   title = gsea_res_symbol$Description[i])
    
    p[[1]] <- p[[1]]+
        annotation_custom(tp,
                          xmin = 13000,
                          xmax = 18000,
                          #ymin = 0#,
                          # ymax = 0.8
        )+
        theme(plot.title = element_text(hjust = 0.5))
    
    ggsave(p,file=paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.C2\\",gsea_res_symbol$Description[i],".pdf"),width=8,height=6)
    ggsave(p,file=paste0("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result\\3.untitled_consensus_cluster\\GSEA.C2\\",gsea_res_symbol$Description[i],".png"),width=8,height=6,dpi=300)
}


#####cerbsort#######
#TCGA.data<-read.csv("F:\\scRNA\\BSZD240201\\1.data\\TCGA_ESCA\\TCGA.ESCA.sample.exp.Tumor.filter.csv",row.names=1)####提取出有生存信息的95例ESCA样本

Tumor_exp<-consensus.GSE100927
#1 计算免疫细胞含量#######################
#开始计算免疫细胞的相关系数，STAD_normal_tumor.txt中行是基因，列是样本
#perm置换次数=1000，QN分位数归一化,如果是芯片设置为T，如果是测序就设置为F
result <- cibersort(sig_matrix = LM22, #sig_matrix是CIBERSOFT软件包的内置数据
                    mixture_file = Tumor_exp,  #待测样本的基因表达数据
                    perm = 200, #perm 参数表示是否使用随机排列法,perm置换次数=1000，
                    QN = F)  #  QN分位数归一化,如果是芯片设置为T，如果是测序就设置为F
ncol(result)#25列
Res_result <- as.data.frame(result)

###group
#rownames(risk.train)<-gsub("-",".",rownames(risk.train))
#合并分组信息#根据行名进行合并
#根据行名进行合并
#result1 <- merge(risk.train[,c("riskScore", "group")],Res_result,by="row.names")
#row.names(result1) <- result1[,1]
#result1 <- result1[,-c(1)]
Res_result$group<-annCol$results
#根据风险组排序
re1 <- Res_result[order(Res_result[,26],decreasing = F),]
#re1<-re1[,-1]
#colnames(re1)[1] <- "Type"
#table(re1$Type)
which(colSums(re1[,c(1:22)])==0)#B cells naive          NK cells resting Dendritic cells activated 
#re1 = subset(re1,re1$`P-value`<0.05)
re2 = re1[,c(1:22)] #去除最后3个指标:p,corrrelation,RESM #去除第一列分组信息

mypalette <- colorRampPalette(brewer.pal(8,"Set1"))
#提取数据，多行变成多列，要多学习‘tidyr’里面的三个函数
dat_cell <- re2 %>% as.data.frame() %>%
    rownames_to_column("Sample") %>%
    gather(key = Cell_type,value = Proportion,-Sample)
#提取数据
dat_group = gather(re1[,c(1:22,26)],Cell_type,Proportion,-group )
#合并分组
dat = cbind(dat_cell,dat_group$group)
colnames(dat)[4] <- "Type"  

dat<-dat[which(dat$Cell_type !="B cells naive"&dat$Cell_type !="NK cells resting"&dat$Cell_type !="Dendritic cells activated"),]
#--------------------------------------------------------
##2.2柱状图##############
#-------------------------------------
p1 <- ggplot(dat,aes(Sample,Proportion,fill = Cell_type)) +
    geom_bar(stat = "identity") +
    labs(fill = "Cell Type",x = "",y = "Estiamted Proportion") +
    theme_bw() +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.position = "bottom") +
    scale_y_continuous(expand = c(0.01,0)) +
    scale_fill_manual(values = mypalette(28))
ggsave(p1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\Sample.Proportion.cluster.pdf",width=12,height=9)
ggsave(p1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\Sample.Proportion.cluster.png",width=12,height=9)
#画分组bar

Var1 = re1$group#high risk & low risk的数量
Var2=c(1:length(row.names(re1))) #high risk & low risk长度，从1开始
annotation_col<- data.frame(Var1 = re1$group,
                            Var2=c(1:length(row.names(re1))),
                            value=1)
p2 <- ggplot(dat, aes(Var2, Var1),size=0.5)+
    geom_raster(data= annotation_col, aes(x=Var2,y =value,fill = Var1), )+ 
    labs(x = "", y = "")+
    theme_void()+
    theme(legend.position = "top", legend.title = element_blank())+
    scale_x_discrete(name="")+
    scale_fill_manual(labels=c("Cluster1","Cluster2"),
                      values =c("#00A087FF", "#DC0000FF"))+
    theme(plot.margin = margin(0, 0, 0, 0, "cm"))
p2
pdf('F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\ssGSEAhistogram_ImmuneGeme.pdf',height = 6,width = 12)
png('F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\ssGSEAhistogram_ImmuneGeme.png',height = 600,width = 1200,res = 120)
plot_grid(p2,p1,
          rel_heights = c(0.08,1),
          label_x=0,
          label_y=1,
          align = 'v',ncol = 1,greedy = F)
dev.off()
###cluster 免疫评分
e1 <- ggplot(dat,aes(x=Cell_type,y=Proportion),palette = "jco", add = "jitter")+
    geom_boxplot(aes(fill=Type),position=position_dodge(0.5),width=0.6)+
    labs(x = "Cell Type", y = "Estimated Proportion")+
    scale_fill_manual(values = c("#00A087FF", "#DC0000FF")#c("#FF165D","#6639A6")
    ) +theme_zg()
e1 = e1 + stat_compare_means(aes(group = Type),label = "p.signif")
e1
ggsave(e1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\cluster.immunoinfiltration.score.Risk.pdf",width=9,height=6)
ggsave(e1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\cluster.immunoinfiltration.score.Risk.png",width=9,height=6,dpi = 300)

save(result,annCol,consensus.GSE100927,dat,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\cerbsort.rdata")

##PPI#####
Cluster2_up<-DEG[which(DEG$regulate=="up-regulated"),"Genes"]
write.csv(Cluster2_up,"F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cluster2.up.genelist.11.csv")
##GeneMANIA
library(tidyverse)
library(clusterProfiler) # Y叔的包有没有，这个其实只是为了ID转换
library(org.Hs.eg.db)  小鼠的话，把Hs改成Mm
options(BioC_mirror="https://mirrors.westlake.edu.cn/bioconductor")
library(STRINGdb)
library(igraph)
library(ggraph)
# 创建STRINGdb对象
string_db <- STRINGdb$new( version="11", species=9606, 
                           score_threshold=400, input_directory="")
# Y叔的clusterProfiler将Gene Symbol转换为Entrez ID
gene <- Cluster2_up%>% bitr(fromType = "SYMBOL", 
                      toType = "ENTREZID", 
                      OrgDb = "org.Hs.eg.db", 
                      drop = T)
data_mapped <- gene %>% string_db$map(my_data_frame_id_col_names = "ENTREZID", 
                                      removeUnmappedRows = TRUE)
string_db$plot_network( data_mapped$STRING_id )

hit<-data_mapped$STRING_id
info <- string_db$get_interactions(hit)
# 转换stringID为Symbol，只取前两列和最后一列
links <- info %>%
    mutate(from = data_mapped[match(from, data_mapped$STRING_id), "SYMBOL"]) %>% 
    mutate(to = data_mapped[match(to, data_mapped$STRING_id), "SYMBOL"]) %>%  
    dplyr::select(from, to , last_col()) %>% 
    dplyr::rename(weight = combined_score)
# 节点数据
nodes <- links %>% { data.frame(gene = c(.$from, .$to)) } %>% distinct()
# 创建网络图
# 根据links和nodes创建
net <- igraph::graph_from_data_frame(d=links,vertices=nodes,directed = F)
# 添加一些参数信息用于后续绘图
# V和E是igraph包的函数，分别用于修改网络图的节点（nodes）和连线(links)
igraph::V(net)$deg <- igraph::degree(net) # 每个节点连接的节点数
igraph::V(net)$size <- igraph::degree(net)/5 #
igraph::E(net)$width <- igraph::E(net)$weight/10

# 使用ggraph绘图
# ggraph是基于ggplot2的包，语法和常规ggplot2类似
ggraph(net,layout = "kk")+
    geom_edge_fan(aes(edge_width=width), color = "lightblue", show.legend = F)+
    geom_node_point(aes(size=size), color="orange", alpha=0.7)+
    geom_node_text(aes(filter=deg>5, label=name), size = 5, repel = T)+
    scale_edge_width(range = c(0.2,1))+
    scale_size_continuous(range = c(1,10) )+
    guides(size=F)+
    theme_graph()




#######wgcna######

setwd("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\2.WGCNA\\")
wgcna.GSE100927<-t(exp.GSE100927[,c(1:29)])
res.ssgsea <- GSVA::gsva(as.matrix(exp.GSE100927[,c(1:29)]), list(Cluster2_up), method = "ssgsea", , min.sz = 5)
#res.ssgsea<-t(res.ssgsea)
#group.GSE100927<-rep(c("Normal","Tumor"),c(13,29))

#res.ssgsea<-as.data.frame(matrix(0,ncol=2,nrow=42))
#colnames(res.ssgsea)<-c("Tumor","Normal")
#rownames(res.ssgsea)<-rownames(wgcna.GSE100927)
#res.ssgsea[c(14:42),1]<-1
#res.ssgsea[c(1:13),2]<-1

# 检查缺失值太多的基因和样本
gsg = goodSamplesGenes(wgcna.GSE100927, verbose = 3);
gsg$allOK###不返回TRUE就直接运行下面代码
if(!gsg$allOK)
{
    #(可选)打印被删除的基因和样本名称:
    if(sum(!gsg$goodGenes)>0)
        printFlush(paste("Removinggenes:",paste(names(wgcna.GSE100927)[!gsg$goodGenes], collapse =",")));
    if(sum(!gsg$goodSamples)>0)
        printFlush(paste("Removingsamples:",paste(rownames(wgcna.GSE100927)[!gsg$goodSamples], collapse =",")));
    #删除不满足要求的基因和样本:
    wgcna.GSE100927 = wgcna.GSE100927[gsg$goodSamples, gsg$goodGenes]
}
##3.聚类做离群样本检测
sampleTree.GSE100927 = hclust(dist(wgcna.GSE100927), method ="average");
# dist()表示转为数值，method表示距离的计算方式，其他种类的详见百度
sizeGrWindow(12,9)
# 绘制样本树:打开一个尺寸为12 * 9英寸的图形输出窗口
# 可对窗口大小进行调整
# 如要保存可运行下面语句
# pdf(file="Plots/sampleClustering.pdf",width=12,height=9);
par(cex = 0.6)	# 控制图片中文字和点的大小
par(mar =c(0,4,2,0))	# 设置图形的边界，下，左，上，右的页边距
plot(sampleTree.GSE100927, main ="Sample clustering to detectoutliers",sub="", xlab="", cex.lab = 1.5,
     cex.axis= 1.5, cex.main = 2)
# 参数依次表示：sampleTree.GSE100927聚类树，图名，副标题颜色，坐标轴标签颜色，坐标轴刻度文字颜色，标题颜色
# 其实只要包括sampleTree.GSE100927和图名即可
###剔除离散样本
clust = cutreeStatic(sampleTree.GSE100927, cutHeight = 60, minSize = 10)
keepSamples = (clust==1)	# 将clust序号为1的放入keepSamples
wgcna.GSE100927 = wgcna.GSE100927[keepSamples, ]	
res.ssgsea=as.data.frame(res.ssgsea[,keepSamples])
colnames(res.ssgsea)<-"DEG_Mig"
#res.ssgsea<-t(as.data.frame(res.ssgsea))
#2.设置间隔
powers <- c(c(1:10), seq(from = 12, to=30, by=2)) 
dat <- as.data.frame((wgcna.GSE100927)) #注意倒置；
sft <- pickSoftThreshold(dat, powerVector = powers, verbose = 5) 

#3.画βvalue图,确定阈值
png("beta-value.png",width = 800,height = 600)
pdf("beta-value.pdf",width = 8,height = 6)
par(mfrow = c(1,2))
cex1 <- 0.95
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)",ylab="Scale Free Topology Model Fit,signed R^2",type="n",main = paste("Scale independence"))
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers,cex=cex1,col="red")
abline(h=0.9,col="red")
plot(sft$fitIndices[,1], sft$fitIndices[,5],xlab="Soft Threshold (power)",ylab="Mean Connectivity", type="n",main = paste("Mean connectivity"))
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1,col="red")
dev.off()

#4.构建共表达网络
#设置一下power和maxBlockSize两个数值，power就是上面得到的R^2达到0.9的数值6；
net.GSE100927 <- blockwiseModules(dat, power =9, maxBlockSize = 3325,
                                  TOMType ='unsigned', minModuleSize = 100,  #minModuleSize这个参数需要自己设置模块最小基因数
                                  reassignThreshold = 0.4,###相关性合并
                                  mergeCutHeight = 0.5,
                                  numericLabels = TRUE, pamRespectsDendro = FALSE,
                                  saveTOMs=TRUE, saveTOMFileBase = "drought",
                                  verbose = 3)

table(net.GSE100927$colors)
# 0    1   2   3   4
#2582 190 188 184 181

#5.绘制基因聚类和模块颜色组合
moduleLabels <- net.GSE100927$colors
moduleColors <- labels2colors(moduleLabels)
png("genes-modules.png",width = 800,height = 600)
pdf("genes-modules.pdf",width = 8,height = 6)
plotDendroAndColors(net.GSE100927$dendrograms[[1]], moduleColors[net.GSE100927$blockGenes[[1]]],
                    "Module colors",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05)
dev.off()

#1.导入临床信息
#res.ssgsea <- read.csv('GSE1456_clinical.csv',header = T)
#rownames(res.ssgsea) <- res.ssgsea$X
#res.ssgsea$low <- ifelse(grepl('ELSTON: 1',res.ssgsea$characteristics_ch1.7),1,0)
#res.ssgsea$high <- ifelse(grepl('0',res.ssgsea$low),1,0)
#res.ssgsea <- res.ssgsea[,-1:-2]
#res.ssgsea<-t(res.ssgsea)
#colnames(res.ssgsea)<-"High"
#2.模块与性状相关性
nGenes <- ncol(dat)
nSamples <- nrow(dat)
MEs0 <- moduleEigengenes(dat, moduleColors)$eigengenes  #获取eigengenes，用颜色标签计算ME值
MEs <- orderMEs(MEs0)  #不同颜色的模块的ME值矩 (样本vs模块)
moduleTraitCor <- cor(MEs, res.ssgsea , use = "p")  #计算每个模块和每个性状之间的相关性
moduleTraitPvalue <- corPvalueStudent(moduleTraitCor, nSamples)

# 可视化相关性和P值
textMatrix <- paste(signif(moduleTraitCor, 2), "\n(",
                    signif(moduleTraitPvalue, 1), ")", sep = "");
dim(textMatrix) <- dim(moduleTraitCor)
png("Module-trait-relationships.png",width = 1200,height = 1200, res= 120)
pdf("Module-trait-relationships.pdf",width = 12,height = 12)
par(mar = c(6, 8.5, 3, 3))
labeledHeatmap(Matrix = moduleTraitCor,
               xLabels = colnames(res.ssgsea),
               yLabels = names(MEs),
               ySymbols = names(MEs),
               colorLabels = FALSE,
               colors = greenWhiteRed(50),
               textMatrix = textMatrix,
               setStdMargins = FALSE,
               cex.text = 0.5,
               zlim = c(-1,1),
               main = paste("Module-trait relationships"))
dev.off()

#3.对模块里的具体基因分析
#跟ELSTON最相关的是blue模块
nSamples <- nrow(dat)
#计算MM值和GS值
modNames <- substring(names(MEs), 3) ##切割，从第三个字符开始保存
geneModuleMembership <- as.data.frame(cor(dat, MEs, use = "p")) #算出每个模块跟基因的Pearson相关系数矩阵
MMPvalue <- as.data.frame(corPvalueStudent(as.matrix(geneModuleMembership), nSamples)) #计算MM值对应的P值
names(geneModuleMembership) <- paste("MM", modNames, sep="")
names(MMPvalue) <- paste("p.MM", modNames, sep="")
geneTraitSignificance <- as.data.frame(cor(dat, res.ssgsea, use = "p")) #计算基因与每个性状的显著性（相关性）及pvalue值

GSPvalue <- as.data.frame(corPvalueStudent(as.matrix(geneTraitSignificance), nSamples))
names(geneTraitSignificance) <- paste("GS.", colnames(res.ssgsea), sep="")
names(GSPvalue) <- paste("p.GS.", colnames(res.ssgsea), sep="")
save(MMPvalue ,net.GSE100927,geneTraitSignificance,GSPvalue ,res.ssgsea,wgcna.GSE100927,dat,file="wgcna.rdata")###save data

module <- "red"
column <- match(module, modNames)  ##在所有模块中匹配选择的模块，返回所在的位置
red_moduleGenes <- names(net.GSE100927$colors)[which(moduleColors == module)]
MM <- abs(geneModuleMembership[red_moduleGenes, column])
GS <- abs(geneTraitSignificance[red_moduleGenes, 1])

#画图
png("Module_red_membership_gene_significance.png",width = 800,height = 600)
pdf("Module_red_membership_gene_significance.pdf",width = 8,height = 6)
par(mfrow = c(1,1)) 
verboseScatterplot(MM, GS,
                   xlab = paste("Module Membership in", module, "module"),
                   ylab = "Gene significance for Basal",
                   main = paste("Module membership vs. gene significance\n"),
                   cex.main = 1.2, cex.lab = 1.2, cex.axis = 1.2, col = module)
dev.off()

#提取HUB基因：MM > 0.8,GS > 0.2
red_hub <- red_moduleGenes[which(GS > 0.2 & MM > 0.8)]
length(red_hub)
save(red_moduleGenes,GS,MM,file="red_moduleGenes.rdata")


module <- "blue"
column <- match(module, modNames)  ##在所有模块中匹配选择的模块，返回所在的位置
blue_moduleGenes <- names(net.GSE100927$colors)[which(moduleColors == module)]
MM <- abs(geneModuleMembership[blue_moduleGenes, column])
GS <- abs(geneTraitSignificance[blue_moduleGenes, 1])

#画图
png("Module_blue_membership_gene_significance.png",width = 800,height = 600)
pdf("Module_blue_membership_gene_significance.pdf",width = 8,height = 6)
par(mfrow = c(1,1)) 
verboseScatterplot(MM, GS,
                   xlab = paste("Module Membership in", module, "module"),
                   ylab = "Gene significance for Basal",
                   main = paste("Module membership vs. gene significance\n"),
                   cex.main = 1.2, cex.lab = 1.2, cex.axis = 1.2, col = module)
dev.off()

#提取HUB基因：MM > 0.8,GS > 0.2
blue_hub <- blue_moduleGenes[which(GS > 0.2 & MM > 0.8)]
length(blue_hub)
save(blue_moduleGenes,GS,MM,file="blue_moduleGenes.rdata")

module <- "grey"
column <- match(module, modNames)  ##在所有模块中匹配选择的模块，返回所在的位置
grey_moduleGenes <- names(net.GSE100927$colors)[which(moduleColors == module)]
MM <- abs(geneModuleMembership[grey_moduleGenes, column])
GS <- abs(geneTraitSignificance[grey_moduleGenes, 1])

#画图
png("Module_grey_membership_gene_significance.png",width = 800,height = 600)
pdf("Module_grey_membership_gene_significance.pdf",width = 8,height = 6)
par(mfrow = c(1,1)) 
verboseScatterplot(MM, GS,
                   xlab = paste("Module Membership in", module, "module"),
                   ylab = "Gene significance for Basal",
                   main = paste("Module membership vs. gene significance\n"),
                   cex.main = 1.2, cex.lab = 1.2, cex.axis = 1.2, col = module)
dev.off()

#提取HUB基因：MM > 0.8,GS > 0.2
grey_hub <- grey_moduleGenes[which(GS > 0.2 & MM > 0.8)]
length(grey_hub)
save(grey_moduleGenes,GS,MM,file="grey_moduleGenes.rdata")


genes3<-intersect(genes_inter,c(blue_moduleGenes,grey_moduleGenes,red_moduleGenes))
#wgcna.genes<-c(blue_moduleGenes,grey_moduleGenes,red_moduleGenes)
wgcna.p<-c(blue_hub,grey_hub,red_hub)
DEG.p<-DEG.GSE100927[which(DEG.GSE100927$regulate!="unchanged"),"Genes"]

overlap<-intersect(wgcna.p,DEG.p)

####go overlap ####
entrezIDs=mget(overlap, org.Hs.egSYMBOL2EG, ifnotfound=NA)	# 找出基因对应的ID
entrezIDs=as.character(entrezIDs)
#entrezIDs[grep("c",entrezIDs)]<-221938###unique_gene
GO.overlap=enrichGO(gene = entrezIDs,
                OrgDb = org.Hs.eg.db, # 参考基因组
                pvalueCutoff =1,	# P值阈值
                qvalueCutoff = 1,	# qvalue是P值的校正值
                ont="all",	# 主要的分为三种，三个层面来阐述基因功能，生物学过程（BP），细胞组分（CC），分子功能（MF）
                readable =T)	# 是否将基因ID转换为基因名

GO.overlap1<-as.data.frame(GO.overlap)
#GO.overlap1$celltype<-"cluster1.up"
table(GO.overlap1[which(GO.overlap1$p.adjust<0.05),"ONTOLOGY"])
GO.overlap2<-GO.overlap1[which(GO.overlap1$p.adjust<0.05),]

KEGG.overlap <- enrichKEGG(gene = entrezIDs, #需要分析的基因的EntrezID
                       organism = "hsa",  #人
                       pvalueCutoff =0.5, #设置pvalue界值
                       qvalueCutoff = 0.5) #设置qvalue界值(FDR校正后的p值）
KEGG.overlap1<-as.data.frame(KEGG.overlap)
save(GO.overlap,GO.overlap1,KEGG.overlap,KEGG.overlap1,file=paste0("wgcna.DEG.GO.KEGG.overlap.rdata"))

###svm-rfe####
Genes1
exp.GSE100927.T<-as.data.frame(t(exp.GSE100927[Genes1,]))
group.GSE100927<-rep(c("AS","Control"),c(29,12))
exp.GSE100927.T$group<-group.GSE100927
set.seed(77)
# 加载库和包
setwd("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\5.machine")
if (!dir.exists("03.SVM")) {dir.create("03.SVM")}
library(tidyverse)
library(glmnet)
library(e1071)
library(caret)

source("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\msvmRFE.R")##放在当前目录下
exp.GSE100927.T$group <- ifelse(exp.GSE100927.T$group=="AS",1,0)
set.seed(20240926)
input <-data.frame(group=exp.GSE100927.T$group,exp.GSE100927.T[,1:26])##12代表纳入模型的基因数量

svmRFE(input, k=10, halve.above=100)
nfold = 10
nrows = nrow(input)
folds = rep(1:nfold, len=nrows)[sample(nrows)]
folds = lapply(1:nfold, function(x) which(folds == x))
results = lapply(folds, svmRFE.wrap, input, k=10, halve.above=100)
top.features = WriteFeatures(results, input, save=F)
write.table(top.features, file = "03.SVM/FeatureName_SVMRFE.csv",sep = ",",row.names = T,col.names = NA,quote = F)
featsweep = lapply(1:26, FeatSweep.wrap, results, input)
no.info = min(prop.table(table(input[,1])))
errors = sapply(featsweep, function(x) ifelse(is.null(x), NA, x$error))
pdf("03.SVM/SVM_RFE.pdf",width =10,height = 5)

par(mfrow=c(1,2))
PlotErrors(errors, no.info=no.info)
plotaccuracy(1-errors,no.info=no.info) #查看准确率
dev.off()

svmrfe_gene <- top.features[1:which.min(errors),]##选择svm筛选的基因数量

write.table(svmrfe_gene, file = "03.SVM/svmrfe_gene.csv",sep = ",",row.names = T,col.names = NA,quote = F)
save(featsweep,file="03.SVM/SVM_RFE.rdata")
##lasso
dir.create("03.Lasso")
data_lasso <- exp.GSE100927.T
library(glmnet)

set.seed(12345)
x<-as.matrix(data_lasso[,1:26]) #需要修改，选择因素
y <-data_lasso[,27]#结局
fit<-glmnet(x=x,y,family="binomial",alpha=1)
myfit <- cv.glmnet(x, y,nfolds = 10, family="binomial")

pdf("03.Lasso/model_lasso.pdf",width=10,height=5)
par(mfrow=c(1,2))
plot(fit, xvar="lambda")
plot(myfit)
title(main=paste("lambda.min=",round(myfit$lambda.min,4),";","lambda.1se=",round(myfit$lambda.1se,4),sep=""),cex.main=1.0)
dev.off()

##下面求出影响因子
coe <- coef(myfit, s = myfit$lambda.min)
act_index <- which(coe != 0)
act_coe <- coe[act_index]
lasso_gene<- row.names(coe)[act_index][-1]
Coe_gene <- data.frame(Gene=lasso_gene,
                       Coe=act_coe[-1])
write.table(Coe_gene, file = "03.Lasso/lasso_gene_result.csv",sep = ",",row.names = T,col.names = NA,quote = F)

dir.create("03.Machine learning")
lasso_gene_result <- read.table("03.Lasso/lasso_gene_result.csv",sep = ",",row.names = 1,check.names = F,stringsAsFactors = F,header = T)
svmrfe_gene <- read.table("03.SVM/svmrfe_gene.csv",sep = ",",row.names = 1,check.names = F,stringsAsFactors = F,header = T)

ML_Gene <- Reduce(intersect,list(lasso_gene_result$Gene[-1],svmrfe_gene$FeatureName))
write.table(ML_Gene, file = "03.Machine learning/ML_Gene.csv",sep = ",",row.names = T,col.names = NA,quote = F)


library(ggvenn)
mydata<-list(Lasso=lasso_gene_result$Gene[-1],
             SVMRFE=svmrfe_gene$FeatureName)

p1 <- ggvenn(mydata,show_percentage = T,show_elements = F,label_sep = ",",
             digits = 1,stroke_color = "white",
             text_color = "black",text_size = 4,set_name_size = 5,
             fill_color = c("#1E90FF", "#4DAF4A"),#"#4DAF4A",  
             set_name_color = c("#1E90FF", "#4DAF4A"))#,"#4DAF4A""#FF8C00", 
p1
ggsave("03.Machine learning/ML_Gene.pdf",width=6,height=6,onefile=FALSE,p1)

###ROC
library(pROC)
GeneList <- ML_Gene

colors <- brewer.pal(length(GeneList),'Paired')

#exp <- read.table("06.Candidate/exp_GSE37460.csv",sep = "\t",quote = "",row.names = 1,check.names = F,stringsAsFactors = F,header = T)
#TrianExpGroup <- as.data.frame(t(exp[GeneList,]))
#group <- read.table("06.Candidate/group_GSE37460.csv", sep = ",",row.names = 1,stringsAsFactors = F,check.names = F,header = T)
#identical(rownames(group),rownames(TrianExpGroup))
#TrianExpGroup$group <- group$group_list
TrianExpGroup<-as.data.frame(t(exp.GSE100927[GeneList,]))
group.GSE100927<-rep(c("AS","Control"),c(29,12))
TrianExpGroup$group<-group.GSE100927
TrianExpGroup$group<-ifelse(TrianExpGroup$group=="AS",1,0)

library(pROC)
pdf("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.pdf",width=5,height=5)
png("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.png",width=5,height=5,res=120)
LegendText <-c()
for (Num in 1:length(GeneList)){
    Gene <- GeneList[Num]
    color <- colors[Num]
    RocValue <- roc(TrianExpGroup[,"group"],TrianExpGroup[,Gene])
    LegendText <- c(LegendText,paste0(Gene,"  AUC=",round(RocValue$auc,3)))
    if (Num ==1 ){
        plot(RocValue,col=color,legacy.axes=T)
    }else{
        plot(RocValue,col=color,add=TRUE)
    }
}
legend(0.6,0.3,LegendText,
       x.intersp=1, y.intersp=0.8,lty= 1 ,lwd= 2,
       col=colors,bty = "n",seg.len=1,cex=1)
dev.off()

######train set exp#####
exp.roc<-as.data.frame(t(exp.GSE100927[c("TSPAN15","TSPAN17"),]))
group.GSE100927<-rep(c("AS","Control"),c(29,12))
exp.roc$group<-group.GSE100927
dat1 = gather(exp.roc,Cell_type,Proportion,-group )

e1 <- ggplot(dat1,aes(x=Cell_type,y=Proportion),palette = "jco", add = "jitter")+
    geom_boxplot(aes(fill=group),position=position_dodge(0.5),width=0.6)+
    labs(x = "", y = "Expression of Genes")+
    scale_fill_manual(values = c("#00A087FF", "#DC0000FF")#c("#FF165D","#6639A6")
    )+theme_zg()
e1 = e1 + stat_compare_means(aes(group = group),label = "p.signif")
e1     
ggsave("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.expression.pdf",e1,width=5,height=5)
ggsave("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.expression.png",e1,width=5,height=5,dpi=300)



save(exp.GSE100927.T,file="F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/MIG.exp.rdata")
library(ggstatsplot)

pdf("cor.pdf",width = 6,height = 5)

ggscaterstats(
    
    data = exp.GSE100927.T,
    
    x = TSPAN15,
    
    y = TSPAN17,
    
    type = "p",
    
    conf.level = 0.99,
    
    # marginal=F,
    
    messages = TRUE
    
)

dev.off()

##############AS control cerbsort#######
#exp.GSE100927<-GSE100927[,sample2[,1]]
group.GSE100927<-rep(c("AS","Normal"),c(29,12))
Tumor_exp<-exp.GSE100927
#1 计算免疫细胞含量#######################
#开始计算免疫细胞的相关系数，STAD_normal_tumor.txt中行是基因，列是样本
#perm置换次数=1000，QN分位数归一化,如果是芯片设置为T，如果是测序就设置为F
result <- cibersort(sig_matrix = LM22, #sig_matrix是CIBERSOFT软件包的内置数据
                    mixture_file = Tumor_exp,  #待测样本的基因表达数据
                    perm = 200, #perm 参数表示是否使用随机排列法,perm置换次数=1000，
                    QN = F)  #  QN分位数归一化,如果是芯片设置为T，如果是测序就设置为F
ncol(result)#25列
Res_result <- as.data.frame(result)

###group
#rownames(risk.train)<-gsub("-",".",rownames(risk.train))
#合并分组信息#根据行名进行合并
#根据行名进行合并
#result1 <- merge(risk.train[,c("riskScore", "group")],Res_result,by="row.names")
#row.names(result1) <- result1[,1]
#result1 <- result1[,-c(1)]
#Res_result$group<-annCol$results
Res_result$group<-group.GSE100927
#根据风险组排序
re1 <- Res_result[order(Res_result[,26],decreasing = F),]
#re1<-re1[,-1]
#colnames(re1)[1] <- "Type"
#table(re1$Type)
which(colSums(re1[,c(1:22)])==0)#B cells naive          NK cells resting Dendritic cells activated 
#re1 = subset(re1,re1$`P-value`<0.05)
re2 = re1[,c(1:22)] #去除最后3个指标:p,corrrelation,RESM #去除第一列分组信息

mypalette <- colorRampPalette(brewer.pal(8,"Set1"))
#提取数据，多行变成多列，要多学习‘tidyr’里面的三个函数
dat_cell <- re2 %>% as.data.frame() %>%
    rownames_to_column("Sample") %>%
    gather(key = Cell_type,value = Proportion,-Sample)
#提取数据
dat_group = gather(re1[,c(1:22,26)],Cell_type,Proportion,-group )
#合并分组
dat = cbind(dat_cell,dat_group$group)
colnames(dat)[4] <- "Type"  

dat<-dat[which(dat$Cell_type !="NK cells resting"),]
#--------------------------------------------------------
##2.2柱状图##############
#-------------------------------------
p1 <- ggplot(dat,aes(Sample,Proportion,fill = Cell_type)) +
    geom_bar(stat = "identity") +
    labs(fill = "Cell Type",x = "",y = "Estiamted Proportion") +
    theme_bw() +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.position = "bottom") +
    scale_y_continuous(expand = c(0.01,0)) +
    scale_fill_manual(values = mypalette(28))
ggsave(p1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\Sample.Proportion.AS.con.pdf",width=12,height=9)
ggsave(p1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\Sample.Proportion.AS.con.png",width=12,height=9)
#画分组bar

Var1 = re1$group#high risk & low risk的数量
Var2=c(1:length(row.names(re1))) #high risk & low risk长度，从1开始
annotation_col<- data.frame(Var1 = re1$group,
                            Var2=c(1:length(row.names(re1))),
                            value=1)
p2 <- ggplot(dat, aes(Var2, Var1),size=0.5)+
    geom_raster(data= annotation_col, aes(x=Var2,y =value,fill = Var1), )+ 
    labs(x = "", y = "")+
    theme_void()+
    theme(legend.position = "top", legend.title = element_blank())+
    scale_x_discrete(name="")+
    scale_fill_manual(labels=c("AS","Normal"),
                      values =c("#6639A6","#FF165D"))+
    theme(plot.margin = margin(0, 0, 0, 0, "cm"))
p2
pdf('F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\ssGSEAhistogram_ImmuneGemeAS.con.pdf',height = 6,width = 12)
png('F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\ssGSEAhistogram_ImmuneGemeAS.con.png',height = 600,width = 1200,res = 120)
plot_grid(p2,p1,
          rel_heights = c(0.08,1),
          label_x=0,
          label_y=1,
          align = 'v',ncol = 1,greedy = F)
dev.off()
###cluster 免疫评分
e1 <- ggplot(dat,aes(x=Cell_type,y=Proportion),palette = "jco", add = "jitter")+
    geom_boxplot(aes(fill=Type),position=position_dodge(0.5),width=0.6)+
    labs(x = "Cell Type", y = "Estimated Proportion")+
    scale_fill_manual(values = c("#6639A6","#FF165D")#c("#FF165D","#6639A6")
    ) +theme_zg()
e1 = e1 + stat_compare_means(aes(group = Type),label = "p.signif")
e1
ggsave(e1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\cluster.immunoinfiltration.score.AS.con.pdf",width=9,height=6)
ggsave(e1,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\cluster.immunoinfiltration.score.AS.con.png",width=9,height=6,dpi = 300)

#####
exp.roc
Res_result2<-merge(exp.roc[,c(1,2)],re2,by="row.names")
rownames(Res_result2)<-Res_result2[,1]
Res_result2<-Res_result2[,-1]

corr.result.immune<-cor(Res_result2,method = 'pearson') #先计算相关性系数
corr.p.immune<-ggcorrplot::cor_pmat(Res_result2) #再计算P值

corr.result.immune1<-corr.result.immune[c(3:24),c(1:2)]
corr.p.immune1<-corr.p.immune[c(3:24),c(1:2)]

corr.result.immune2<-corr.result.immune1 %>% as.data.frame() %>%
    rownames_to_column("immune") %>%
    gather(key = Gene,value = Correlation,-immune)
corr.p.immune2<-corr.p.immune1 %>% as.data.frame() %>%
    rownames_to_column("immune") %>%
    gather(key = Gene,value = Pvale,-immune)
corr.result.immune2$value<-corr.p.immune2$Pvale
corr.result.immune2<-na.omit(corr.result.immune2)
#corr.result.immune2$Gene<-factor(corr.result.immune2$Gene,levels=genes)
significance<-ifelse(corr.result.immune2$value>0.05,"p>0.05","p<0.05")
corr.result.immune2$`-log10(P)`<- -log10(corr.result.immune2$value)

e3<-ggplot(corr.result.immune2, aes(x = immune, y = Gene, shape=significance,color=significance,size =`-log10(P)`, fill = Correlation)) +
    geom_point() +
    scale_size(range = c(5, 8)) +scale_shape_manual(values = c(21,21))+
    
    scale_color_manual(values=c("black","white"))+
    scale_fill_gradientn(colours = terrain.colors(10))+
    #geom_col(alpha = 0.8,width = 0.1,size=0.1)+
    
    labs(title = "", x = "Celltypes", y = "Genes") +
    #geom_text(aes(label=`P value`),size=2.5,nudge_x = c(rep(0.3,22)))+
    theme_minimal()+theme_type+theme_type.cor
ggsave(e3,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\gene.immunescore.cor.pdf",width=9,height=6)
ggsave(e3,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\3.untitled_consensus_cluster\\cerbsort\\gene.immunescore.cor.png",width=9,height=6,dpi=300)
theme_type.cor<-#theme_bw()+ #?w?i?????????F
    #labs(fill="Site")+
    theme(#legend.position="none",
        axis.text.x=element_text(angle=45,hjust = 1,colour="black",size=12), #????ux??????x???????I?????????????Ίp?x???15?x?C???????????1(hjust = 1)?C?????????Times?召???20
        axis.text.y=element_text(colour="black",size=12,face="plain"), #????uy??????x???????I?????ƁC???̑召?C????????????plain
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
        panel.grid.minor = element_blank()) 
