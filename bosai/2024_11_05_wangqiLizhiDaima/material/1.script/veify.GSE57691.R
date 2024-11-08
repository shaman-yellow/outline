####验证集
GSE57691<-read.table("F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\RNA\\GSE57691_series_matrix.txt",
                comment.char="!",       #comment.char="!" 意思是！后面的内容不要读取
                stringsAsFactors=F,
                header=T)

#library(AnnoProbe)
#ids=idmap('GPL10558',type = 'soft')
#probe2gene <- ids
GPL10558<-GEOquery::getGEO(filename = "F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\0.data\\RNA\\GSE57691_family.soft.gz")
fData<-fData(GPL10558[[1]])
id_probe <- GPL10558@gpls$GPL10558@dataTable@table
probe2gene<-id_probe[which(id_probe$Species=="Homo sapiens"),c(1,13)]
probe2gene<-probe2gene[which(probe2gene$Symbol!="---" & probe2gene$Symbol !=""),]
ids2 <- probe2gene
table(table(unique(ids2$Symbol)))#30907 ,30907个基因
exp.GSE57691<-merge(ids2,GSE57691,by.x="ID",by.y = "ID_REF",all.x = T)
exp.GSE57691<-exp.GSE57691[,-1]
exp.GSE57691<- aggregate(.~Symbol,exp.GSE57691, mean)  ##把重复的Symbol取平均值
row.names(exp.GSE57691) <- exp.GSE57691$Symbol#把行名命名为SYMBOL
exp.GSE57691<- subset(exp.GSE57691, select = -1)  #删除Symbol列（一般是第一列）
qx <- as.numeric(quantile(exp.GSE57691, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))
LogC <- (qx[5] > 100) ||
    (qx[6]-qx[1] > 50 && qx[2] > 0) ||
    (qx[2] > 0 && qx[2] < 1 && qx[4] > 1 && qx[4] < 2)
qx;LogC

GSE57691<-exp.GSE57691[,c(50:68)]
group.GSE57691<-rep(c("AS","Control"),c(9,10))
design <- model.matrix(~0+factor(group.GSE57691))
colnames(design) <- levels(factor(group.GSE57691))
rownames(design) <- colnames(GSE57691)

contrast.matrix <- makeContrasts(AS-Control,levels = design)
fit <- lmFit(GSE57691,design) #非线性最小二乘法
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)#用经验贝叶斯调整t-test中方差的部分
DEG.GSE57691<- topTable(fit2, coef = 1,n = Inf,sort.by="logFC")
DEG.GSE57691<- na.omit(DEG.GSE57691)
DEG.GSE57691$Genes<-rownames(DEG.GSE57691)
DEG.GSE57691$regulate <- ifelse(DEG.GSE57691$adj.P.Val> 0.05, "unchanged",
                                 ifelse(DEG.GSE57691$logFC > 0.585, "up-regulated",
                                        ifelse(DEG.GSE57691$logFC < -0.585, "down-regulated", "unchanged")))

p3.3<-ggvolcano(data = DEG.GSE57691,x = "logFC",y = "P.Value",output = FALSE,label = "Genes",label_number = 0,
                # log2FC_cut = 0.5,
                fills = c("#00A087FF", "#999999", "#DC0000FF"),
                colors = c("#00A087FF", "#999999", "#DC0000FF"),
                x_lab = "log2FC",
                y_lab = "-Log10P.Value",
                legend_position = "UL") #标签位置为up right
ggsave(p3.3,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE57691.DEG.pdf",width=6,height=5)
ggsave(p3.3,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE57691.DEG.png",width=6,height=5,dpi = 300)
table(DEG.GSE57691$regulate )
save(GSE57691,ids2,DEG.GSE57691,exp.GSE57691,file="F:\\project_wq\\project-bio\\BSZD240817-苏剑瑶\\2.result\\1.DEG\\GSE57691.exp.DEG.rdata")



DEG.GSE57691[intersect(geneset,DEG.GSE57691[which(DEG.GSE57691$regulate!="unchanged"),"Genes"]),]
DEG.GSE57691[geneset,]

VerifyExpGroup<-as.data.frame(t(GSE57691[GeneList,c(1:14)]))
group.GSE57691<-rep(c("AS","Control"),c(9,5))
VerifyExpGroup$group<-group.GSE57691
VerifyExpGroup$group<-ifelse(VerifyExpGroup$group=="AS",1,0)

library(pROC)
pdf("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Verify_ROC.pdf",width=5,height=5)
LegendText <-c()
for (Num in 1:length(GeneList)){
    Gene <- GeneList[Num]
    color <- colors[Num]
    RocValue <- roc(VerifyExpGroup[,"group"],VerifyExpGroup[,Gene])
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


######verify set exp#####
VerifyExpGroup1<-as.data.frame(t(GSE57691[GeneList,c(1:14)]))
group.GSE57691<-rep(c("AS","Control"),c(9,5))
VerifyExpGroup1$group<-group.GSE57691
dat1 = gather(VerifyExpGroup1,Cell_type,Proportion,-group )

e1 <- ggplot(dat1,aes(x=Cell_type,y=Proportion),palette = "jco", add = "jitter")+
    geom_boxplot(aes(fill=group),position=position_dodge(0.5),width=0.6)+
    labs(x = "", y = "Expression of Genes")+
    scale_fill_manual(values = c("#00A087FF", "#DC0000FF")#c("#FF165D","#6639A6")
    )+theme_zg()
e1 = e1 + stat_compare_means(aes(group = group),label = "p.signif")
e1     
ggsave("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.expression.pdf",e1,width=5,height=5)
ggsave("F:/project_wq/project-bio/BSZD240817-苏剑瑶/2.result/06.Candidate/Train_ROC.expression.png",e1,width=5,height=5,dpi=300)