
你说的肿瘤菌和肠道菌的问题，我问了方案的人了，他说没有其他数据了，只能用这个肠道菌。
那我也管不了了，只能例行。
所以，你可以为我准备函数了。
我希望数据筹备的函数与正式分析的函数应该是完全分开的。
数据应该有两套需要准备的吧？，这个应该也要分开。总之，各个模块的功能要独立，各行其事，方便流程控制。

我分析的肿瘤是 NPC。关键基因是bulk + 单细胞筛选的。这部分你应该不需要管吧？
请帮我实现函数！


忽略本地数据，以 opengwas 为主。
此外，我对于 MR 分析到底些什么数据不太清楚。
我有我面前分析的方案，公司提供的，请帮我分析一下。

暴露因素：关键基因表达量（全血 / 组织水平的顺式 eQTL 数据，来自 GTEx、eQTLGen 数据库）；结局因素： 瘤内菌群高低负荷（有关GM的数据来自MiBioGen（www.mibiogen.org）的GWAS数据集，该数据集包括来自11个国家24个队列的总共 18,340 名参与者的全基因组基因型数据和16S粪便微生物群数据，针对16S rRNA基因的可变区V4、V3–V4和V1–V2 来描述微生物组成并进行分类。经过16S微生物组数据处理，最终鉴定出211个类群，涉及131属、35科、20目、16纲、9门。）；工具变量筛选针对每个暴露因素，筛选满足以下条件的 SNPs 作为工具变量（IVs）：与暴露因素显著相关（P<5×10^-8）；连锁不平衡（LD）筛选：r²<0.01，距离> 1000kb；排除与结局因素、混杂因素（如年龄、性别、吸烟、饮酒）相关的 SNPs（P<1×10^-5）；若 IVs 数量不足，放宽至 P<1×10^-6，确保 IVs 数量≥3。




我这里有公司的代码。但在我看来，写得就是一坨屎，乱七八糟。
请按照我的要求来整理代码，将分析与可视化彻底分离。
我目前仅需要主分析流程。关键输入必须参数化。最终以提供函数为主。
此外，忽略公司代码中的 readRDS 或者 read.csv 等读取数据以及保存数据的部分，
这部分应该由我自己来筹备，你需要帮我整理出核心输入以及输出。
此外，剔除这个代码中毫无必要使用的 R 包。例如，clusterProfiler 使用的 bitr，
因为 bitr 更核心的工具应该是其他的包里的函数。


代码风格：

1. 不写 library, require 等加载包，而是要显式写名包来源！——但是，ggplot2 不用写！
2. 不要用管道符号！！！
3. 代码中的注释要用英文！！！
4. 对于任意 interger 参数，要显式写明是 1L 2L 这种！！！
5. 尽可能简洁！用 apply 家族 (apply, sapply 等等都行)，而不是 for 循环！
6. 逗号、等号等地方，一定要保留空格！！！
7. 请让代码的间距相对美观，例如，data.frame(x, y) 这种参数较少、总长度较短的 call，中间没有必要换行；
   而长度较长的 call，参数逗号后需要换行。总之，保持让代码在一定宽度，不要故意换行或不换行。
   还有，不要一行代码后空一行——这样太稀疏了，我看下来的时候，要不停地换页，这没必要。
   可以在实现完一个功能模块后再加空行。
8. 函数命名标准，所有函数以 . 开头，表示并不是用户级的函数。如果是分析数据，请以动词开头，例如 run。
   如果是可视化函数，请以 plot 开头。而函数的后缀，假如涉及了某些很特殊的结构为输入，即，非 data.frame list vector
   等类型的数据为主输入，则需要以 class 为后缀。示例：.plot_feature_with_seurat。


以下是公司代码：


# 载入库
library(gwasglue)
library(TwoSampleMR)
library(ggsci)
library(ggplot2)
library(doParallel) 
library(clusterProfiler)
library(plinkbinr)
library(data.table)
library(dplyr)
library(stringr)
library(MRPRESSO)


#### 参数设置与基因读取 ####
outcome_name <- "NAFLD" # 结局名称
# No <- 'ieu-a-965'# ？数据编号 这个暂未理解
pval_threshold <- 5e-08 # p值阈值
r2 <- 0.001 # r² 值
kb <- 10 # kb 值，疑似以k为单位
# kb <- 10000 # kb 值
rda_name<- paste0(paste(pval_threshold,r2,kb,sep = '_'),".RData")
print(rda_name)
# [1] "5e-08_0.001_10.RData"
gene <- read.csv(file.path(ORIGINAL_DIR, "02_intersectionGenes/00.intersection_genes.csv"))$Intersection_Genes
length(gene)

#### 加载结局数据 ####
outcome_path <- file.path(ORIGINAL_DIR, '00_rawdata/03_GCST90054782/outcome.RData')
print(outcome_path)
if(!exists('outcome_dat')){
  if(file.exists(outcome_path)){
    print("load...")
    load(outcome_path)
  }else{
    print("outcome_data not found")
  }
} else {
  print("outcome_dat exists")
}
outcome_data <- outcome_dat
#### 暴露因素GWAS数据集筛选 ####
id<-bitr(gene,fromType = "SYMBOL",
         toType = c("ENSEMBL" ),
         OrgDb = 'org.Hs.eg.db')

gene[!gene %in% id$SYMBOL]

id$GWAS<-paste('eqtl','a',id$ENSEMBL,sep='-')
write.csv(id,file.path(output, "00.id.csv"),row.names = F)

list_gene <- read.table("/data/nas2/database/MR/eQTL_vcf/eQTL_list")
ids<-id[id$GWAS %in% list_gene$V1,]$GWAS
length(ids)
# [1] 21
id[!id$GWAS %in% ids,]
# SYMBOL         ENSEMBL                   GWAS
# 4     CRP ENSG00000132693 eqtl-a-ENSG00000132693
# 8    SAA4 ENSG00000148965 eqtl-a-ENSG00000148965
# 12   SOD2 ENSG00000291237 eqtl-a-ENSG00000291237
# 14   APOB ENSG00000084674 eqtl-a-ENSG00000084674
# 19    TNF ENSG00000228978 eqtl-a-ENSG00000228978
# 20    TNF ENSG00000204490 eqtl-a-ENSG00000204490
# 21    TNF ENSG00000223952 eqtl-a-ENSG00000223952
# 22    TNF ENSG00000228849 eqtl-a-ENSG00000228849
# 23    TNF ENSG00000228321 eqtl-a-ENSG00000228321
# 24    TNF ENSG00000230108 eqtl-a-ENSG00000230108
# 25    TNF ENSG00000206439 eqtl-a-ENSG00000206439

#### 工具变量筛选与MR分析 ####
dat_res <- list()
expo_res <- list()
all_res<-list()
clumping_res <- list()
options(timeout = 100000)

i <- 1
for (i in 1:length(ids)){
  print(paste0(i," for ",length(ids)))
  expos_vcf = paste0('/data/nas2/database/MR/eQTL_vcf/',ids[i],'.vcf.gz')
  vcf1 <- VariantAnnotation::readVcf(expos_vcf)
  suppressWarnings(exposure_dat <- gwasvcf_to_TwoSampleMR(vcf1,type = "exposure"))
  exposure_dat$id.exposure = ids[i]
  exp_data <- exposure_dat
  # rows_to_keep <- !(exp_data$SNP %in% c("rs4802601"))
  # exp_data <- exp_data[rows_to_keep, ]
  
  temp_dat <- exp_data[exp_data$pval.exposure<pval_threshold,]
  if (nrow(temp_dat) == 0) {next}
  
  temp_dat$id <- temp_dat$id.exposure
  temp_dat$rsid <- temp_dat$SNP
  temp_dat$pval <- temp_dat$pval.exposure
  
  exp_dat <- ld_clump(temp_dat,
                      plink_bin = get_plink_exe(),
                      bfile = '/data/nas2/database/MR/g1000_eur/g1000_eur' ,
                      clump_kb =kb, clump_r2 = r2)
  
  outcome_dat<- subset(outcome_data,outcome_data$SNP %in% exp_dat$SNP)
  
  if (nrow(outcome_dat) == 0) {next}
  dat <- harmonise_data(exposure_dat =exp_dat,outcome_dat = outcome_dat)
  
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    res=mr(dat, method_list = c("mr_egger_regression",
                                "mr_ivw_mre"))
  } else{
    res=mr(dat, method_list = c("mr_egger_regression",
                                "mr_ivw_fe"))
  }
  expo_res[[ids[i]]] <- exp_dat
  dat_res[[ids[i]]] <- dat
  tmp_run<- tryCatch({result <- generate_odds_ratios(mr_res = res)},error = function(e){print(e)})
  if(inherits(tmp_run,'error'))next
  all_res[[ids[i]]]<-result
  
  clumping = mutate(dat,R=get_r_from_bsen(dat$beta.exposure, dat$se.exposure, dat$samplesize.exposure))
  clumping = mutate(clumping,F=(samplesize.exposure-2)*((R*R)/(1-R*R)))
  clumping_res[[ids[i]]] <- clumping
  
}

save.image(file.path(output, rda_name))

load(file.path(output, rda_name))

#### 结果整理与保存 ####
all_result<- do.call(rbind,all_res) # 合并所有基因的 MR 分析结果
all_result <- all_result[all_result$nsnp > 2,]
all_result$id.outcome <- outcome_name
write.csv(all_result, file.path(output, "01.all.result.csv"),row.names = F)

clumping_result<- do.call(rbind,clumping_res)
clumping_result<- clumping_result[!is.na(clumping_result$F),]
F10<- clumping_result[clumping_result$F>10,]
F10<- unique(F10$id.exposure)

all_result_ivw<- all_result[grepl('Inverse variance weighted',all_result$method),]
tmp<- unique(all_result_ivw[all_result_ivw$pval <0.05,]$id.exposure)
all_result_ivw<- all_result[all_result$id.exposure %in% tmp,]

all_result_1<- merge(all_result_ivw,id,by.x='id.exposure',by.y='GWAS')

results<- all_result_1[all_result_1$id.exposure %in% F10,]
write.csv(results, file.path(output, "02.result.csv"),row.names = F)

showdf <- results[results$method == "Inverse variance weighted (fixed effects)",
                  c("SYMBOL","nsnp","pval","or","or_lci95","or_uci95")]
showdf <- showdf %>%
  mutate(
    or = signif(or, digits = 4),
    or_lci95 = signif(or_lci95, digits = 4),
    or_uci95 = signif(or_uci95, digits = 4),
    `or(or_lci95-or_uci95)` = paste0(or, "(", or_lci95, "-", or_uci95, ")")
  )
selected_df <- showdf[, c(1, 2, 3, 7)]
selected_df
# SYMBOL nsnp         pval or(or_lci95-or_uci95)
# 2      MPO   86 1.569973e-11 0.9417(0.9254-0.9583)
# 4   SCARB1   17 2.239240e-09 0.8797(0.8435-0.9175)
# 6    PTGS2   45 2.013823e-15     1.142(1.105-1.18)
# 8     GGT1   24 7.868824e-08 0.8253(0.7694-0.8852)
# 10     IL6   12 2.824512e-04 0.7826(0.6857-0.8933)
# 12 SELENOW   25 3.404019e-09 0.8951(0.8628-0.9286)
# 14 ALOX15B   25 1.261516e-02 0.9257(0.8712-0.9836)
# 16     TNF   82 4.635011e-02 0.9638(0.9294-0.9994)


out_result<- results

#### 异质性、多效性和方向性检验 ####
names(dat_res)

dat_all_gene <- dat_res[unique(out_result$id.exposure)]

heterogeneity_result <- data.frame()
pleiotropy_result <- data.frame()
out_result <- data.frame()

for (i in c(1:length(dat_all_gene))) {
  dat <- dat_all_gene[[i]]
  dat$id.outcome <- outcome_name
  # 为当前数据添加结局样本量列
  dat$samplesize.outcome <- 377998
  sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
  print(paste0(i,":",sy))
  # 异质性检验
  het <- mr_heterogeneity(dat)
  het$SYMBOL <- sy
  # 多效性检验
  ple <- mr_pleiotropy_test(dat)
  ple$SYMBOL <- sy
  # 对当前数据进行方向性检验
  out <- directionality_test(dat)
  out$SYMBOL <- sy
  
  if(is.na(out$steiger_pval) & out$correct_causal_direction =='TRUE'){ out$steiger_pval <- 0}
  
  heterogeneity_result<-rbind(heterogeneity_result,het) 
  pleiotropy_result <- rbind(pleiotropy_result,ple) 
  out_result <- rbind(out_result,out)
}

write.csv(heterogeneity_result,file = file.path(output, '03.heterogeneity.csv'),row.names=F)
write.csv(pleiotropy_result,file = file.path(output, '04.pleiotropy.csv'),row.names=F)
write.csv(out_result,file = file.path(output, '05.Steiger.csv'),row.names=F)

# 筛选出多效性检验 p 值大于 0.05 的行
tmp_id.exposure<- pleiotropy_result[pleiotropy_result$pval>0.05,]$id.exposure
# 根据筛选出的 id.exposure 筛选方向性检验结果
tmp_out<- out_result[out_result$id.exposure %in% tmp_id.exposure,]
# 进一步筛选出Steiger 检验 p 值小于 0.05且因果方向判断为正确的方向性检验数据
tmp_out_id <- tmp_out[tmp_out$steiger_pval<0.05 & tmp_out$correct_causal_direction =="TRUE",]
write.csv(tmp_out_id,file = file.path(output, "06.choose.csv"),row.names = F)

#### 可视化 ####
# num_dir <- file.path(output, "PLOT")
# if (! dir.exists(num_dir)){
#   dir.create(num_dir)
# }
# setwd(num_dir)
num_dir2 <- file.path(output, "PLOT_all")
if (! dir.exists(num_dir2)){
  dir.create(num_dir2)
}
setwd(num_dir2)

scatter<-function(i){
  num_dir <- "01_scatter/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('scatter')
  pa <- mr_scatter_plot(dat,mr_results = mr(dat))[[1]]
  p1 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    xlab(paste0('SNP effect on ',dat$exposure[1]))+
    ylab(paste0('SNP effect on ',dat$outcome[1]))+
    ggtitle(paste0('MR of ',sy))+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'top',
          axis.title.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=18,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".scatter.pdf"), p1, width = 6,h = 6)
  ggsave(paste0(num_dir,i,".",sy,".scatter.png"), p1, width = 6,h = 6)
}

forest<-function(i){
  num_dir <- "02_forest/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('forest')
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    method = "mr_ivw_mre"
  } else{
    method ="mr_ivw_fe"
  }
  res_single <- mr_singlesnp(dat,all_method = method)
  pa <- mr_forest_plot(res_single)[[1]]
  p2 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0('MR effect size for ',sy,' on ',dat$id.outcome[1]))+
    ylab('')+
    xlab('')+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'none',
          axis.title.x =element_text(size=13,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=13,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=13,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".forest.pdf"), p2, width = 7,h = nrow(dat)*0.10+3.5)
  ggsave(paste0(num_dir,i,".",sy,".forest.png"), p2, width = 7,h = nrow(dat)*0.10+3.5)
}

funnel<- function(i){
  num_dir <- "03_funnel/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('funnel')
  res_single <- mr_singlesnp(dat,all_method = c("mr_ivw"))
  pa <- mr_funnel_plot(singlesnp_results = res_single )[[1]]
  p3 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0('MR of ',sy))+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'top',
          axis.title.x =element_text(size=15,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=12,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=15,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=18,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".funnel.pdf"), p3, width = 5,h = 5)
  ggsave(paste0(num_dir,i,".",sy,".funnel.png"), p3, width = 5,h = 5)
}

leaveoneout<-function(i){
  num_dir <- '04_leaveoneout/'
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('leaveoneout')
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    single <- mr_leaveoneout(dat,method = mr_ivw_mre)
    
  } else{
    single <- mr_leaveoneout(dat,method = mr_ivw_fe)
    
  }
  
  pa <- mr_leaveoneout_plot(single)[[1]]
  p4 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0("MR leave","-" ,"one","-", "out sensitivity analysis for\n ",sy, " on ", dat$id.outcome[1]))+
    xlab('')+
    ylab('')+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'none',
          axis.title.x =element_text(size=14,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=12,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=14,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black',hjust=0.5),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=13,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".leaveoneout.pdf"), p4, width = 7,h = nrow(dat)*0.10+3.5)
  ggsave(paste0(num_dir,i,".",sy,".leaveoneout.png"), p4, width = 7,h = nrow(dat)*0.10+3.5)
}

name2 <- unique(out_result$id.exposure) # 使用未筛选前的结果，即绘制所有暴露因素（未进行异质性检验等）

for (i in 1:length(name2)) {
  eqtl <- name2[i]
  dat <- dat_all_gene[[eqtl]]
  dat$id.outcome <- outcome_name
  sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
  if (length(sy) == 0) {next}
  scatter(i)
  forest(i)
  funnel(i)
  leaveoneout(i)
}

# name3 <- unique(tmp_out_id$id.exposure) # 使用筛选后的结果

# for (i in 1:length(name3)) {
#   eqtl <- name3[i]
#   dat <- dat_all_gene[[eqtl]]
#   dat$id.outcome <- outcome_name
#   sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
#   if (length(sy) == 0) {next}
#   scatter(i)
#   forest(i)
#   funnel(i)
#   leaveoneout(i)
# }







我这里有公司的代码。但在我看来，写得就是一坨屎，乱七八糟。
请按照我的要求来整理代码，将分析与可视化彻底分离。
我目前仅需要主分析流程。关键输入必须参数化。最终以提供函数为主。
此外，忽略公司代码中的 readRDS 或者 read.csv 等读取数据以及保存数据的部分，
这部分应该由我自己来筹备，你需要帮我整理出核心输入以及输出。
此外，剔除这个代码中毫无必要使用的 R 包。例如，clusterProfiler 使用的 bitr，
因为 bitr 更核心的工具应该是其他的包里的函数。


代码风格：

1. 不写 library, require 等加载包，而是要显式写名包来源！——但是，ggplot2 不用写！
2. 不要用管道符号！！！
3. 代码中的注释要用英文！！！
4. 对于任意 interger 参数，要显式写明是 1L 2L 这种！！！
5. 尽可能简洁！用 apply 家族 (apply, sapply 等等都行)，而不是 for 循环！
6. 逗号、等号等地方，一定要保留空格！！！
7. 请让代码的间距相对美观，例如，data.frame(x, y) 这种参数较少、总长度较短的 call，中间没有必要换行；
   而长度较长的 call，参数逗号后需要换行。总之，保持让代码在一定宽度，不要故意换行或不换行。
   还有，不要一行代码后空一行——这样太稀疏了，我看下来的时候，要不停地换页，这没必要。
   可以在实现完一个功能模块后再加空行。
8. 函数命名标准，所有函数以 . 开头，表示并不是用户级的函数。如果是分析数据，请以动词开头，例如 run。
   如果是可视化函数，请以 plot 开头。而函数的后缀，假如涉及了某些很特殊的结构为输入，即，非 data.frame list vector
   等类型的数据为主输入，则需要以 class 为后缀。示例：.plot_feature_with_seurat。


以下是公司代码：


# 载入库
library(gwasglue)
library(TwoSampleMR)
library(ggsci)
library(ggplot2)
library(doParallel) 
library(clusterProfiler)
library(plinkbinr)
library(data.table)
library(dplyr)
library(stringr)
library(MRPRESSO)


#### 参数设置与基因读取 ####
outcome_name <- "NAFLD" # 结局名称
# No <- 'ieu-a-965'# ？数据编号 这个暂未理解
pval_threshold <- 5e-08 # p值阈值
r2 <- 0.001 # r² 值
kb <- 10 # kb 值，疑似以k为单位
# kb <- 10000 # kb 值
rda_name<- paste0(paste(pval_threshold,r2,kb,sep = '_'),".RData")
print(rda_name)
# [1] "5e-08_0.001_10.RData"
gene <- read.csv(file.path(ORIGINAL_DIR, "02_intersectionGenes/00.intersection_genes.csv"))$Intersection_Genes
length(gene)

#### 加载结局数据 ####
outcome_path <- file.path(ORIGINAL_DIR, '00_rawdata/03_GCST90054782/outcome.RData')
print(outcome_path)
if(!exists('outcome_dat')){
  if(file.exists(outcome_path)){
    print("load...")
    load(outcome_path)
  }else{
    print("outcome_data not found")
  }
} else {
  print("outcome_dat exists")
}
outcome_data <- outcome_dat
#### 暴露因素GWAS数据集筛选 ####
id<-bitr(gene,fromType = "SYMBOL",
         toType = c("ENSEMBL" ),
         OrgDb = 'org.Hs.eg.db')

gene[!gene %in% id$SYMBOL]

id$GWAS<-paste('eqtl','a',id$ENSEMBL,sep='-')
write.csv(id,file.path(output, "00.id.csv"),row.names = F)

list_gene <- read.table("/data/nas2/database/MR/eQTL_vcf/eQTL_list")
ids<-id[id$GWAS %in% list_gene$V1,]$GWAS
length(ids)
# [1] 21
id[!id$GWAS %in% ids,]
# SYMBOL         ENSEMBL                   GWAS
# 4     CRP ENSG00000132693 eqtl-a-ENSG00000132693
# 8    SAA4 ENSG00000148965 eqtl-a-ENSG00000148965
# 12   SOD2 ENSG00000291237 eqtl-a-ENSG00000291237
# 14   APOB ENSG00000084674 eqtl-a-ENSG00000084674
# 19    TNF ENSG00000228978 eqtl-a-ENSG00000228978
# 20    TNF ENSG00000204490 eqtl-a-ENSG00000204490
# 21    TNF ENSG00000223952 eqtl-a-ENSG00000223952
# 22    TNF ENSG00000228849 eqtl-a-ENSG00000228849
# 23    TNF ENSG00000228321 eqtl-a-ENSG00000228321
# 24    TNF ENSG00000230108 eqtl-a-ENSG00000230108
# 25    TNF ENSG00000206439 eqtl-a-ENSG00000206439

#### 工具变量筛选与MR分析 ####
dat_res <- list()
expo_res <- list()
all_res<-list()
clumping_res <- list()
options(timeout = 100000)

i <- 1
for (i in 1:length(ids)){
  print(paste0(i," for ",length(ids)))
  expos_vcf = paste0('/data/nas2/database/MR/eQTL_vcf/',ids[i],'.vcf.gz')
  vcf1 <- VariantAnnotation::readVcf(expos_vcf)
  suppressWarnings(exposure_dat <- gwasvcf_to_TwoSampleMR(vcf1,type = "exposure"))
  exposure_dat$id.exposure = ids[i]
  exp_data <- exposure_dat
  # rows_to_keep <- !(exp_data$SNP %in% c("rs4802601"))
  # exp_data <- exp_data[rows_to_keep, ]
  
  temp_dat <- exp_data[exp_data$pval.exposure<pval_threshold,]
  if (nrow(temp_dat) == 0) {next}
  
  temp_dat$id <- temp_dat$id.exposure
  temp_dat$rsid <- temp_dat$SNP
  temp_dat$pval <- temp_dat$pval.exposure
  
  exp_dat <- ld_clump(temp_dat,
                      plink_bin = get_plink_exe(),
                      bfile = '/data/nas2/database/MR/g1000_eur/g1000_eur' ,
                      clump_kb =kb, clump_r2 = r2)
  
  outcome_dat<- subset(outcome_data,outcome_data$SNP %in% exp_dat$SNP)
  
  if (nrow(outcome_dat) == 0) {next}
  dat <- harmonise_data(exposure_dat =exp_dat,outcome_dat = outcome_dat)
  
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    res=mr(dat, method_list = c("mr_egger_regression",
                                "mr_ivw_mre"))
  } else{
    res=mr(dat, method_list = c("mr_egger_regression",
                                "mr_ivw_fe"))
  }
  expo_res[[ids[i]]] <- exp_dat
  dat_res[[ids[i]]] <- dat
  tmp_run<- tryCatch({result <- generate_odds_ratios(mr_res = res)},error = function(e){print(e)})
  if(inherits(tmp_run,'error'))next
  all_res[[ids[i]]]<-result
  
  clumping = mutate(dat,R=get_r_from_bsen(dat$beta.exposure, dat$se.exposure, dat$samplesize.exposure))
  clumping = mutate(clumping,F=(samplesize.exposure-2)*((R*R)/(1-R*R)))
  clumping_res[[ids[i]]] <- clumping
  
}

save.image(file.path(output, rda_name))

load(file.path(output, rda_name))

#### 结果整理与保存 ####
all_result<- do.call(rbind,all_res) # 合并所有基因的 MR 分析结果
all_result <- all_result[all_result$nsnp > 2,]
all_result$id.outcome <- outcome_name
write.csv(all_result, file.path(output, "01.all.result.csv"),row.names = F)

clumping_result<- do.call(rbind,clumping_res)
clumping_result<- clumping_result[!is.na(clumping_result$F),]
F10<- clumping_result[clumping_result$F>10,]
F10<- unique(F10$id.exposure)

all_result_ivw<- all_result[grepl('Inverse variance weighted',all_result$method),]
tmp<- unique(all_result_ivw[all_result_ivw$pval <0.05,]$id.exposure)
all_result_ivw<- all_result[all_result$id.exposure %in% tmp,]

all_result_1<- merge(all_result_ivw,id,by.x='id.exposure',by.y='GWAS')

results<- all_result_1[all_result_1$id.exposure %in% F10,]
write.csv(results, file.path(output, "02.result.csv"),row.names = F)

showdf <- results[results$method == "Inverse variance weighted (fixed effects)",
                  c("SYMBOL","nsnp","pval","or","or_lci95","or_uci95")]
showdf <- showdf %>%
  mutate(
    or = signif(or, digits = 4),
    or_lci95 = signif(or_lci95, digits = 4),
    or_uci95 = signif(or_uci95, digits = 4),
    `or(or_lci95-or_uci95)` = paste0(or, "(", or_lci95, "-", or_uci95, ")")
  )
selected_df <- showdf[, c(1, 2, 3, 7)]
selected_df
# SYMBOL nsnp         pval or(or_lci95-or_uci95)
# 2      MPO   86 1.569973e-11 0.9417(0.9254-0.9583)
# 4   SCARB1   17 2.239240e-09 0.8797(0.8435-0.9175)
# 6    PTGS2   45 2.013823e-15     1.142(1.105-1.18)
# 8     GGT1   24 7.868824e-08 0.8253(0.7694-0.8852)
# 10     IL6   12 2.824512e-04 0.7826(0.6857-0.8933)
# 12 SELENOW   25 3.404019e-09 0.8951(0.8628-0.9286)
# 14 ALOX15B   25 1.261516e-02 0.9257(0.8712-0.9836)
# 16     TNF   82 4.635011e-02 0.9638(0.9294-0.9994)


out_result<- results

#### 异质性、多效性和方向性检验 ####
names(dat_res)

dat_all_gene <- dat_res[unique(out_result$id.exposure)]

heterogeneity_result <- data.frame()
pleiotropy_result <- data.frame()
out_result <- data.frame()

for (i in c(1:length(dat_all_gene))) {
  dat <- dat_all_gene[[i]]
  dat$id.outcome <- outcome_name
  # 为当前数据添加结局样本量列
  dat$samplesize.outcome <- 377998
  sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
  print(paste0(i,":",sy))
  # 异质性检验
  het <- mr_heterogeneity(dat)
  het$SYMBOL <- sy
  # 多效性检验
  ple <- mr_pleiotropy_test(dat)
  ple$SYMBOL <- sy
  # 对当前数据进行方向性检验
  out <- directionality_test(dat)
  out$SYMBOL <- sy
  
  if(is.na(out$steiger_pval) & out$correct_causal_direction =='TRUE'){ out$steiger_pval <- 0}
  
  heterogeneity_result<-rbind(heterogeneity_result,het) 
  pleiotropy_result <- rbind(pleiotropy_result,ple) 
  out_result <- rbind(out_result,out)
}

write.csv(heterogeneity_result,file = file.path(output, '03.heterogeneity.csv'),row.names=F)
write.csv(pleiotropy_result,file = file.path(output, '04.pleiotropy.csv'),row.names=F)
write.csv(out_result,file = file.path(output, '05.Steiger.csv'),row.names=F)

# 筛选出多效性检验 p 值大于 0.05 的行
tmp_id.exposure<- pleiotropy_result[pleiotropy_result$pval>0.05,]$id.exposure
# 根据筛选出的 id.exposure 筛选方向性检验结果
tmp_out<- out_result[out_result$id.exposure %in% tmp_id.exposure,]
# 进一步筛选出Steiger 检验 p 值小于 0.05且因果方向判断为正确的方向性检验数据
tmp_out_id <- tmp_out[tmp_out$steiger_pval<0.05 & tmp_out$correct_causal_direction =="TRUE",]
write.csv(tmp_out_id,file = file.path(output, "06.choose.csv"),row.names = F)

#### 可视化 ####
# num_dir <- file.path(output, "PLOT")
# if (! dir.exists(num_dir)){
#   dir.create(num_dir)
# }
# setwd(num_dir)
num_dir2 <- file.path(output, "PLOT_all")
if (! dir.exists(num_dir2)){
  dir.create(num_dir2)
}
setwd(num_dir2)

scatter<-function(i){
  num_dir <- "01_scatter/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('scatter')
  pa <- mr_scatter_plot(dat,mr_results = mr(dat))[[1]]
  p1 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    xlab(paste0('SNP effect on ',dat$exposure[1]))+
    ylab(paste0('SNP effect on ',dat$outcome[1]))+
    ggtitle(paste0('MR of ',sy))+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'top',
          axis.title.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=18,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".scatter.pdf"), p1, width = 6,h = 6)
  ggsave(paste0(num_dir,i,".",sy,".scatter.png"), p1, width = 6,h = 6)
}

forest<-function(i){
  num_dir <- "02_forest/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('forest')
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    method = "mr_ivw_mre"
  } else{
    method ="mr_ivw_fe"
  }
  res_single <- mr_singlesnp(dat,all_method = method)
  pa <- mr_forest_plot(res_single)[[1]]
  p2 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0('MR effect size for ',sy,' on ',dat$id.outcome[1]))+
    ylab('')+
    xlab('')+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'none',
          axis.title.x =element_text(size=13,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=10,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=13,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=13,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".forest.pdf"), p2, width = 7,h = nrow(dat)*0.10+3.5)
  ggsave(paste0(num_dir,i,".",sy,".forest.png"), p2, width = 7,h = nrow(dat)*0.10+3.5)
}

funnel<- function(i){
  num_dir <- "03_funnel/"
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('funnel')
  res_single <- mr_singlesnp(dat,all_method = c("mr_ivw"))
  pa <- mr_funnel_plot(singlesnp_results = res_single )[[1]]
  p3 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0('MR of ',sy))+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'top',
          axis.title.x =element_text(size=15,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=12,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=15,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=18,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".funnel.pdf"), p3, width = 5,h = 5)
  ggsave(paste0(num_dir,i,".",sy,".funnel.png"), p3, width = 5,h = 5)
}

leaveoneout<-function(i){
  num_dir <- '04_leaveoneout/'
  if (! dir.exists(num_dir)){dir.create(num_dir)}
  print('leaveoneout')
  het <- mr_heterogeneity(dat)
  het_qvalue <- het[het$method == 'Inverse variance weighted',]$Q_pval
  if (is.null(het_qvalue)){next}
  if (het_qvalue<0.05) {
    single <- mr_leaveoneout(dat,method = mr_ivw_mre)
    
  } else{
    single <- mr_leaveoneout(dat,method = mr_ivw_fe)
    
  }
  
  pa <- mr_leaveoneout_plot(single)[[1]]
  p4 <- pa+
    scale_color_npg(palette = c("nrc"), alpha = 1)+
    theme_classic(base_size = 18)+
    ggtitle(paste0("MR leave","-" ,"one","-", "out sensitivity analysis for\n ",sy, " on ", dat$id.outcome[1]))+
    xlab('')+
    ylab('')+
    theme(panel.border = element_rect(size = 1,fill = 'transparent'),
          axis.ticks = element_line(size = 1),
          legend.position = 'none',
          axis.title.x =element_text(size=14,family = "Times", face = "bold",color='black'),
          axis.text.x =element_text(size=12,family = "Times", face = "bold",color='black'),
          axis.title.y =element_text(size=14,family = "Times", face = "bold",color='black'),
          axis.text.y = element_text(size=12,family = "Times", face = "bold",color='black'),
          legend.title = element_text(size=12,family = "Times", face = "bold",color='black',hjust=0.5),
          legend.text =  element_text(size=10,family = "Times", face = "bold",color='black'),
          legend.direction = 'horizontal',
          plot.title=element_text(size=13,family = "Times", face = "bold",hjust=0.5),)+
    update_geom_defaults("line", list(size = 5))
  if(i<10){ i<- paste0("0",i)}
  ggsave(paste0(num_dir,i,".",sy,".leaveoneout.pdf"), p4, width = 7,h = nrow(dat)*0.10+3.5)
  ggsave(paste0(num_dir,i,".",sy,".leaveoneout.png"), p4, width = 7,h = nrow(dat)*0.10+3.5)
}

name2 <- unique(out_result$id.exposure) # 使用未筛选前的结果，即绘制所有暴露因素（未进行异质性检验等）

for (i in 1:length(name2)) {
  eqtl <- name2[i]
  dat <- dat_all_gene[[eqtl]]
  dat$id.outcome <- outcome_name
  sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
  if (length(sy) == 0) {next}
  scatter(i)
  forest(i)
  funnel(i)
  leaveoneout(i)
}

# name3 <- unique(tmp_out_id$id.exposure) # 使用筛选后的结果

# for (i in 1:length(name3)) {
#   eqtl <- name3[i]
#   dat <- dat_all_gene[[eqtl]]
#   dat$id.outcome <- outcome_name
#   sy <- results$SYMBOL[results$id.exposure == dat$id.exposure[1]] %>% unique()
#   if (length(sy) == 0) {next}
#   scatter(i)
#   forest(i)
#   funnel(i)
#   leaveoneout(i)
# }



