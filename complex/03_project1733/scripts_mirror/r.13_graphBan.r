# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/03_project1733"
output <- file.path(ORIGINAL_DIR, "13_graphBan")
if (!dir.exists(output)) {
  dir.create(output, recursive = TRUE)
}
setwd(ORIGINAL_DIR)

.libPaths(c('/data/nas2/software/miniconda3/envs/public_R/lib/R/library/', '/data/nas1/huanglichuang_OD/conda/envs/extra_pkgs/lib/R/library/'))

myPkg <- "./union/union.utils"
if (!dir.exists(myPkg)) {
  stop('Can not found package: ', myPkg)
}
devtools::load_all(myPkg)
load_unions()
setup.huibang()

# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

fea.markers <- load_feature()

gb.markers <- asjob_gBan(fea.markers)
gb.markers <- step1(gb.markers, db = "drugbank")

gb.markers <- step2(gb.markers)
gb.markers <- step3(gb.markers)
clear(gb.markers)

# gb.markers <- readRDS("./rds_jobSave/gb.markers.3.rds")

# load results file
gb.markers <- step4(
  gb.markers, "graphBan_res_", cutoff = .7, method_keep = "all"
)
clear(gb.markers)

gb.markers <- step5(gb.markers, "./GraphBAN_MARKERS/res_admet.csv")
gb.markers <- step6(
  gb.markers, skip = TRUE
)
gb.markers <- step7(gb.markers)
clear(gb.markers)


# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_counting_in_directory(output)

#| OVERTURE
output_with_counting_number({
  notshow(gb.markers@params$info_compounds)
  notshow(gb.markers@params$split_by_genes)
  notshow(gb.markers@tables$step7$t.final_candidates)
  gb.markers@tables$step7$t.final_candidates_mutate
  notshow(gb.markers@params$admet)
  notshow(gb.markers@params$admet_filter)
})




# ==========================================================================
# FIELD: checkout
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# NOTE: 下方代码是以上分析代码中解析出来的，目前只解析一层，没有递归解析
# 递归的话代码会变得非常多，而且会很乱。目前应该够了，method 内部大多都是普通 function
# 查看起来比较方便，可以在加载了我的 R 包后直接输入后查看本体。
# 
# 下方的代码，我在定义的上方写明了在上方哪个分析代码用到了这个本体，
# 希望对您有所帮助


if (FALSE) {
    # gb.markers <- asjob_gBan(fea.markers)
    setMethod(f = "asjob_gBan", signature = c(x = "feature"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            fea <- resolve_feature_snapAdd_onExit("x", x)
            x <- .job_gBan(object = fea)
            x <- methodAdd(x, "为进一步挖掘筛选得到的关键基因在临床转化中的潜在应用价值，基于 GraphBAN 模型开展药物预测分析。该分析旨在从分子靶点层面连接疾病相关基因与可干预药物之间的桥梁，识别可能影响疾病发生发展的药物分子，为后续机制研究及药物重定位提供理论依据，并为精准治疗策略的制定提供潜在靶点与候选干预方案。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step1(gb.markers, db = "drugbank")
    setMethod(f = "step1", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x, dir_save = paste0("GraphBAN_", x@sig), 
            db = c("batman", "zinc", "cmnpd", "dgidb", "drugbank"), 
            batman = FALSE, zinc = FALSE, cmnpd = FALSE, dgidb = FALSE, 
            drugbank = FALSE, file_dgidb = NULL, file_batman_compounds_info = getOption("file_batman_compounds_info"), 
            recode = NULL) 
        {
            step_message("Got amino acid sequence and drug smiles.")
            x$dir_save <- dir_save
            genes <- object(x)
            if (!is.null(recode)) {
                if (!all(names(recode) %in% genes)) {
                    stop("!all(names(recode) %in% genes).")
                }
                genes <- dplyr::recode(genes, !!!recode)
            }
            fun_getseq <- function(...) {
                mart <- new_biomart("hsa")
                get_seq.pro(genes, mart)
            }
            x$seqs <- expect_local_data("tmp", "seq", fun_getseq, 
                list(genes))
            if (!is.null(recode)) {
                recode <- setNames(names(recode), unname(recode))
                if (!all(names(recode) %in% x$seqs$data$hgnc_symbol)) {
                    stop("!all(names(recode) %in% x$seqs$data$hgnc_symbol).")
                }
                x$seqs$data <- dplyr::mutate(x$seqs$data, hgnc_symbol = dplyr::recode(hgnc_symbol, 
                    !!!recode))
            }
            x$file_seqs <- union.publish:::write(x$seqs$fasta, name = "peptide", 
                dir = dir_save, max = NULL)
            x <- methodAdd(x, "以 `biomaRt` ⟦pkgInfo('biomaRt')⟧ 获取多肽序列 (先以 Symbol 获取 'ensembl_peptide_id' 以及 'transcript_is_canonical'，从而选择经典转录本的 'ensembl_peptide_id' 获取多肽序列) 。")
            x$smiles_compounds <- list()
            db <- match.arg(db)
            assign(db, TRUE)
            if (batman) {
                if (is.null(file_batman_compounds_info)) {
                    stop("is.null(file_batman_compounds_info).")
                }
                if (!file.exists(file_batman_compounds_info)) {
                    stop("!file.exists(file_batman_compounds_info).")
                }
                data_batman <- ftibble(file_batman_compounds_info)
                if (!any(colnames(data_batman) == "SMILES")) {
                    stop("!any(colnames(data_batman) == \"SMILES\").")
                }
                x$smiles_compounds$data_batman <- dplyr::distinct(data_batman, 
                    smiles = SMILES)
                x <- methodAdd(x, "获取 BATMAN-TCM (<http://bionet.ncpsb.org.cn/batman-tcm>) 化合物 SMILES 结构式。")
            }
            if (zinc) {
                data_zinc <- ftibble(get_url_data("zinc.csv", "https://raw.githubusercontent.com/aspuru-guzik-group/chemical_vae/master/models/zinc_properties/250k_rndm_zinc_drugs_clean_3.csv", 
                    "zinc", fun_decompress = NULL))
                data_zinc <- dplyr::mutate(data_zinc, smiles = sub("\n$", 
                    "", smiles))
                x$smiles_compounds$data_zinc <- data_zinc
                x <- methodAdd(x, "获取 ZINC-250k 小分子库 (<https://www.kaggle.com/datasets/basu369victor/zinc250k>) 的化合物 SMILES 结构式。")
            }
            if (cmnpd) {
                data_cmnpd <- ftibble(get_url_data("cmnpd.tsv", "https://www.cmnpd.org/cmnpd/supplement/Downloads/CMNPD_1.0_calc_prop.tsv", 
                    "cmnpd", fun_decompress = NULL))
                x$smiles_compounds$data_cmnpd <- dplyr::distinct(data_cmnpd, 
                    smiles = SMILES)
                x <- methodAdd(x, "获取 CMNPD 数据库 (<https://www.cmnpd.org>) 的化合物 SMILES 结构式。")
            }
            if (drugbank) {
                data_drugbank <- ftibble(pg("db_drugbank"))
                x$smiles_compounds$data_drugbank <- dplyr::distinct(data_drugbank, 
                    smiles = SMILES)
                x <- methodAdd(x, "获取 Drugbank 数据库 (<https://go.drugbank.com/>) 的化合物 SMILES 结构式。")
            }
            if (dgidb) {
                if (!is.null(file_dgidb)) {
                    data_dgidb <- ftibble(file_dgidb)
                    data_dgidb <- dplyr::select(data_dgidb, gene, 
                      drug)
                }
                else {
                    data_dgidb <- ftibble(get_url_data("interactions.tsv", 
                      "https://dgidb.org/data/2024-Dec/interactions.tsv", 
                      "dgidb", fun_decompress = NULL))
                    data_dgidb <- dplyr::select(data_dgidb, gene = gene_claim_name, 
                      drug = drug_claim_name)
                }
                expect_package("PubChemR", "3.0.0")
                drugs <- s(unique(data_dgidb$drug), "^CHEMBL:", "")
                ndrugs <- length(unique(drugs))
                cli::cli_alert_info("PubChemR::get_cids")
                cids <- expect_local_data("tmp", "pubchemr_cids", 
                    PubChemR::get_cids, list(identifier = drugs, 
                      namespace = "name"))
                cids <- PubChemR::CIDs(cids)
                data_dgidb <- map(data_dgidb, "drug", cids, "Name", 
                    "CID", col = "CID")
                data_dgidb <- dplyr::filter(data_dgidb, !is.na(data_dgidb$CID))
                smiles <- get_smiles_batch(unique(data_dgidb$CID))
                data_dgidb <- map(data_dgidb, "CID", smiles, "CID", 
                    "SMILES", col = "SMILES")
                x$data_dgidb <- data_dgidb
                x$smiles_compounds$data_dgidb <- dplyr::distinct(data_dgidb, 
                    smiles = SMILES)
                x <- methodAdd(x, "以 DGIdb 数据库 (<https://www.cmnpd.org>) 初步预测与输入基因存在相互作用的候选药物化合物。共计得到 {nrow(ndrugs)} 条记录。剔除无法从 PubChemR 搜索到对应化合物信息记录的条目。余下 {nrow(data_dgidb)} 条记录，按各基因统计为: {try_snap(data_dgidb, 'gene', 'drug')}。")
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step2(gb.markers)
    setMethod(f = "step2", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x, cl = 10, mem = 1000, w.cutoff = 1000, 
            rerun = FALSE, filter_by = c("rcdk", "rdkit")) 
        {
            step_message("Filter drugs.")
            compounds <- unique(unlist(lapply(x$smiles_compounds, 
                function(x) x$smiles)))
            filter_by <- match.arg(filter_by)
            if (filter_by == "rdkit") {
                x$info_compounds <- expect_local_data("tmp", "compounds_weight_rdkit", 
                    inBatches_get_compounds_weight.rdkit, list(smiles_list = compounds), 
                    rerun = rerun)
                x <- methodAdd(x, "以 RDKit 过滤无法解析的分子结构，剔除分子量 &gt; {w.cutoff}，含重金属 (以原子序号大于钙为条件过滤) 的化合物，生成标准化 SMILES。")
            }
            else if (filter_by == "rcdk") {
                x$info_compounds <- expect_local_data("tmp", "compounds_weight", 
                    inBatches_get_compounds_weight.rcdk, list(smiles_list = compounds, 
                      mem = mem, cl = cl), ignore = "cl", rerun = rerun)
                x <- methodAdd(x, "以 R 包 `rcdk` ⟦pkgInfo('rcdk')⟧ 过滤无法解析的分子结构，剔除分子量 &gt; {w.cutoff}，含重金属 (以原子序号大于钙为条件过滤) 的化合物。")
            }
            input_compounds <- dplyr::filter(x$info_compounds, MolecularWeight < 
                w.cutoff, !HasHeavyMetal)
            input_compounds <- dplyr::distinct(input_compounds, smiles)
            x$input_compounds <- dplyr::mutate(input_compounds, id = seq_len(nrow(input_compounds)), 
                .before = 1)
            combn <- expand.grid(x$input_compounds$id, x$seqs$data$hgnc_symbol)
            combn <- dplyr::rename(combn, id = 1, hgnc_symbol = 2)
            combn <- Reduce(merge, list(combn, x$input_compounds, 
                x$seqs$data))
            combn <- dplyr::mutate(combn, Y = 1)
            combn <- dplyr::relocate(combn, hgnc_symbol, id, SMILES = smiles, 
                Protein = peptide, Y)
            if (!is.null(x$data_dgidb)) {
                layout <- dplyr::select(x$data_dgidb, gene, SMILES)
                combn <- merge(combn, layout, by.x = c("hgnc_symbol", 
                    "SMILES"), by.y = c("gene", "SMILES"))
            }
            x$file_combn <- file.path(x$dir_save, "graphBan_input.csv")
            write.csv(combn, x$file_combn, row.names = FALSE)
            x$combn <- combn
            x <- snapAdd(x, "从数据库获取到的化合物共 {length(compounds)} 个。经过滤后得到 {nrow(input_compounds)} 个唯一化合物。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step3(gb.markers)
    setMethod(f = "step3", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            step_message("Do nothing")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(gb.markers)
    setMethod(f = "clear", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = rlang::expr_text(substitute(x, parent.frame(1))), 
            path_jobSave = getOption("path_jobSave", "."), path_lite = file.path(path_jobSave, 
                "lite"), expr_lite = NULL, allow_qs = TRUE, nthreads = 5) 
        {
            dir.create(path_jobSave, FALSE)
            filename <- paste0(name, ".", x@step, suffix, ".rds")
            if (save) {
                file <- file.path(path_jobSave, filename)
                if (allow_qs && object.size(x) > 5e+08) {
                    fileQs <- paste0(tools::file_path_sans_ext(file), 
                      ".qs")
                    message(glue::glue("Too large object ('{obj.size(x)}' > 478.6 Mb), use `qs::qsave`"))
                    message("Save qs: ", fileQs)
                    qs::qsave(x, fileQs, nthreads = nthreads)
                }
                else {
                    message("Save RDS: ", file)
                    saveRDS(x, file)
                }
            }
            object(x) <- NULL
            dir.create(path_lite, FALSE)
            if (!is.null(expr_lite)) {
                if (!is.expression(expr_lite)) {
                    stop("!is.expression(expr_lite).")
                }
                eval(expr_lite)
            }
            if (lite) {
                file <- file.path(path_lite, filename)
                message("Save RDS: ", file)
                saveRDS(x, file)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step4(gb.markers, "graphBan_res_", cutoff = 0.7, 
    #     method_keep = "all")
    setMethod(f = "step4", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x, pattern = "graphBan_res_", cutoff = 0.95, 
            reRead = FALSE, method_keep = c("all", "respective")) 
        {
            step_message("Collate results.")
            method_keep <- match.arg(method_keep)
            files_res <- list.files(x$dir_save, pattern, full.names = TRUE)
            if (!length(files_res)) {
                stop("length(files_res), no results file found.")
            }
            res <- pbapply::pblapply(files_res, function(file) {
                res <- expect_local_data("tmp", "gbanResRead", ftibble, 
                    list(files = file, select = "pred", fill = TRUE), 
                    rerun = reRead)
                if (nrow(res) != nrow(x$combn)) {
                    stop("nrow(res) != nrow(x$combn).")
                }
                whichKeep <- which(res$pred > cutoff)
                res <- dplyr::bind_cols(res[whichKeep, ], x$combn[whichKeep, 
                    ])
                return(res)
            })
            names(res) <- s(s(basename(files_res), pattern, ""), 
                "\\..*$", "")
            res <- dplyr::bind_rows(res, .id = "model")
            x$res_graphBan <- res
            split_by_genes <- split(res, res$hgnc_symbol)
            x <- methodAdd(x, "基于 GraphBAN（Graph-Based Attention Network）的CPI（化合物-蛋白质相互作用）预测框架，结合 BindingDB、BioSNAP 和 KIBA 等公开药物–靶点互作数据集构建基础图网络，用于模型训练与验证，输出每对“化合物-蛋白质”组合的相互作用概率，筛选药物与靶点互作概率大于 {cutoff} 的化合物。")
            snap_each <- vapply(names(split_by_genes), FUN.VALUE = character(1), 
                function(gene) {
                    data <- split_by_genes[[gene]]
                    each <- vapply(split(data, data[["model"]]), 
                      nrow, integer(1))
                    snaps <- glue::glue("以数据库 {names(each)} 训练的模型中得到 {each} 个唯一化合物")
                    glue::glue("基因 {gene} 在{bind(snaps)}。")
                })
            snap_each <- bind(snap_each, co = "")
            x <- snapAdd(x, "经 GraphBAN (BindingDB, BioSNAP, KIBA 模型) 预测，筛选药物与靶点互作概率大于 {cutoff} 的化合物，{snap_each}")
            p.common <- new_venn(lst = lapply(split_by_genes, function(x) x$SMILES))
            p.common <- set_lab_legend(p.common, glue::glue("{x@sig} intersection of drugs for gene predicted by graphBan"), 
                glue::glue("各基因 graphBan 预测的候选药物交集|||不同颜色圆圈代表不同数据集，中间重叠部分表示同时存在多个集合中。"))
            x <- plotsAdd(x, p.common)
            ins <- p.common$ins
            if (!length(ins)) {
                message(glue::glue("No common target drugs"))
            }
            if (method_keep == "all") {
                x$smiles_keep <- ins
                x$split_by_genes <- lapply(split_by_genes, function(x) x[x$SMILES %in% 
                    ins, ])
                s.ins <- glue::glue("共同作用于各靶点({bind(names(split_by_genes))})的药物有 {length(ins)} 个")
                x <- snapAdd(x, "{s.ins}。以这 {length(ins)} 个化合物用于后续评估。")
            }
            else if (method_keep == "respective") {
                if (!length(ins)) {
                    x <- snapAdd(x, "未发现能够共同作用于所有靶点的化合物。")
                }
                x$smiles_keep <- unique(res$SMILES)
                x <- snapAdd(x, "将这总共 {length(x$smiles_keep)} 个化合物用于后续评估。")
                s.ins <- ""
                x$split_by_genes <- split_by_genes
            }
            x$smiles_from_gban <- x$smiles_keep
            x$file_smiles_for_admet <- file.path(x$dir_save, "smiles_for_admet.txt")
            writeLines(x$smiles_keep, x$file_smiles_for_admet)
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(gb.markers)
    setMethod(f = "clear", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = rlang::expr_text(substitute(x, parent.frame(1))), 
            path_jobSave = getOption("path_jobSave", "."), path_lite = file.path(path_jobSave, 
                "lite"), expr_lite = NULL, allow_qs = TRUE, nthreads = 5) 
        {
            dir.create(path_jobSave, FALSE)
            filename <- paste0(name, ".", x@step, suffix, ".rds")
            if (save) {
                file <- file.path(path_jobSave, filename)
                if (allow_qs && object.size(x) > 5e+08) {
                    fileQs <- paste0(tools::file_path_sans_ext(file), 
                      ".qs")
                    message(glue::glue("Too large object ('{obj.size(x)}' > 478.6 Mb), use `qs::qsave`"))
                    message("Save qs: ", fileQs)
                    qs::qsave(x, fileQs, nthreads = nthreads)
                }
                else {
                    message("Save RDS: ", file)
                    saveRDS(x, file)
                }
            }
            object(x) <- NULL
            dir.create(path_lite, FALSE)
            if (!is.null(expr_lite)) {
                if (!is.expression(expr_lite)) {
                    stop("!is.expression(expr_lite).")
                }
                eval(expr_lite)
            }
            if (lite) {
                file <- file.path(path_lite, filename)
                message("Save RDS: ", file)
                saveRDS(x, file)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step5(gb.markers, "./GraphBAN_MARKERS/res_admet.csv")
    setMethod(f = "step5", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x, file_admet = NULL, cutoff = 0.7, skip = FALSE) 
        {
            step_message("ADMET ...")
            if (skip) {
                return(x)
            }
            smiles <- x$smiles_from_gban
            if (is.null(file_admet)) {
                stop("is.null(file_admet).")
            }
            x$admet <- admet <- ftibble(file_admet)
            if (nrow(admet) != length(smiles)) {
                stop("nrow(admet) != length(smiles).")
            }
            x$admet_filter <- admet <- dplyr::filter(admet, caco2 > 
                -5.15, hia < cutoff, PPB < 90, DILI < cutoff, Ames < 
                cutoff, dplyr::if_all(tidyselect::matches("CYP.*inh"), 
                ~.x < cutoff))
            t.candidate_admet <- dplyr::select(admet, SMILES = raw_smiles, 
                caco2, hia, PPB, DILI, Ames, dplyr::starts_with("CYP"))
            t.candidate_admet <- set_lab_legend(t.candidate_admet, 
                glue::glue("{x@sig} drug candidates from ADMETlab"), 
                glue::glue("ADMETlab 评估药性后保留的候选药物"))
            x <- tablesAdd(x, t.candidate_admet)
            x$smiles_keep <- x$smiles_from_admet <- admet$raw_smiles
            x$file_smiles_for_swiss <- file.path(x$dir_save, "smiles_for_swiss.txt")
            writeLines(x$smiles_keep, x$file_smiles_for_swiss)
            message(glue::glue("After filtered by admet: {nrow(admet)}"))
            x <- methodAdd(x, "以 ADMETlab 3.0 (https://admetlab3.scbdd.com/server/screening) 对交集化合物开展系统性 ADMET 分析，评估其药代动力学特征 (caco2 &gt; -5.15, hia &lt; {cutoff}, PPB &lt; 90, DILI &lt; {cutoff}, Ames &lt; {cutoff}, All CYP inhibitor &lt; {cutoff}) (参考 <https://admetlab3.scbdd.com/explanation/#/>) ")
            x <- snapAdd(x, "以 ADMETlab 评估其药物特性后，获得 {nrow(admet)} 个化合物。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step6(gb.markers, skip = TRUE)
    setMethod(f = "step6", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x, file_swiss = NULL, n_pass = 4, method = "linpinski", 
            skip = FALSE) 
        {
            step_message("swissADME.")
            if (skip) {
                return(x)
            }
            if (is.null(file_swiss)) {
                stop("is.null(file_swiss)")
            }
            swissAdme <- ftibble(file_swiss)
            if (nrow(swissAdme) != length(x$smiles_from_admet)) {
                stop("nrow(swissAdme) != x$smiles_from_admet.")
            }
            swissAdme <- dplyr::mutate(swissAdme, raw_smiles = x$smiles_from_admet, 
                .after = 1)
            colnames(swissAdme) <- formal_name(colnames(swissAdme))
            x$swissAdme <- swissAdme
            x <- methodAdd(x, "利用 SwissADME 平台 (<http://www.swissadme.ch/>) 评估核心候选化合物的成药性。")
            if (method == "linpinski") {
                prins <- list(quote(MW < 500), quote(X_H_bond_acceptors < 
                    10), quote(X_H_bond_donors <= 5), quote(Consensus_Log_P <= 
                    4.15), quote(TPSA < 140))
                passes <- lapply(prins, function(prin) {
                    dplyr::filter(swissAdme, !!prin)$raw_smiles
                })
                res <- table(unlist(passes))
                x$smiles_keep <- x$smiles_from_swiss <- names(res)[res > 
                    n_pass]
                t.candidate_swissAdme <- dplyr::filter(swissAdme, 
                    raw_smiles %in% !!x$smiles_keep)
                t.candidate_swissAdme <- dplyr::select(t.candidate_swissAdme, 
                    SMILES = raw_smiles, MW, HBA = X_H_bond_acceptors, 
                    HBD = X_H_bond_donors, LogP = Consensus_Log_P, 
                    TPSA)
                t.candidate_swissAdme <- set_lab_legend(t.candidate_swissAdme, 
                    glue::glue("{x@sig} drug candidates from swissAdme"), 
                    glue::glue("SwissADME 评估药性后保留的候选药物"))
                x <- tablesAdd(x, t.candidate_swissAdme)
                x <- methodAdd(x, "计算分子量 (MW)、氢键受体 (HBA) 数量、氢键供体 (HBD) 数量、LogP 值、拓扑极性表面积 (TPSA)，依据 Lipinski 五法则筛选 (标准：MW &lt; 500、HBA &lt; 10、HBD ≤ 5、LogP ≤ 4.15、TPSA &lt; 140 A²)。违反条目 ≤ {5-n_pass} 条的化合物判定为具有良好口服生物利用度及成药潜力。")
            }
            x <- snapAdd(x, "以 SwissADME 评估其药物特性后，余下 {length(x$smiles_keep)} 个化合物。")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # gb.markers <- step7(gb.markers)
    setMethod(f = "step7", signature = c(x = "job_gBan"), definition = function (x, 
        ...) 
    {
        .local <- function (x) 
        {
            expect_package("PubChemR", "3.0.0")
            smiles <- x$smiles_keep
            cids <- expect_local_data("tmp", "pubchemr_cids", PubChemR::get_cids, 
                list(identifier = smiles, namespace = "smiles"))
            x$cids <- cids <- e(PubChemR::CIDs(cids))
            numNotGot <- sum(cids$CID == 0)
            message(glue::glue("Not got: {numNotGot}"))
            cids <- dplyr::filter(cids, CID != 0)
            x <- snapAdd(x, "以 R 包 `PubChemR` ⟦pkgInfo('PubChemR')⟧ 从 PubChem 数据库 (<https://pubchem.ncbi.nlm.nih.gov/>) 检索化合物信息。将 PubChem 有记录条目的化合物视为候选药物 (n = {nrow(cids)})，并获取其对应化合物名。")
            synos <- try_get_syn(cids$CID)
            x$synos <- map(synos, "CID", cids, "CID", "SMILES", col = "SMILES")
            alls <- list(x$synos, x@tables$step6$t.candidate_swissAdme, 
                x@tables$step5$t.candidate_admet)
            alls <- alls[!vapply(alls, is.null, logical(1))]
            if (length(alls) > 1) {
                t.final_candidates <- Reduce(merge, alls)
                t.final_candidates <- set_lab_legend(t.final_candidates, 
                    glue::glue("{x@sig} Candidate drugs retained after all evaluation"), 
                    glue::glue("经过药物特性评估后保留的候选药物"))
                t.final_candidates <- dplyr::relocate(dplyr::select(t.final_candidates, 
                    -SMILES), Synonym, CID)
                t.final_candidates <- dplyr::mutate(t.final_candidates, 
                    dplyr::across(dplyr::where(is.numeric), function(x) signif(x, 
                      2)))
                tdata <- t(dplyr::select(t.final_candidates, -Synonym, 
                    -CID))
                colnames(tdata) <- glue::glue("C{seq_len(nrow(t.final_candidates))}")
                tdata <- as_tibble(tdata, idcol = "Index")
                tdata <- dplyr::mutate(tdata, dplyr::across(dplyr::where(is.double), 
                    function(x) round(x, 2)))
                footer <- bind(glue::glue("{colnames(tdata)[-1]}: {t.final_candidates$Synonym}"), 
                    co = "\n")
                t.final_candidates_mutate <- set_lab_legend(tdata, 
                    glue::glue("{x@sig} Candidate drugs retained after all evaluation transposition"), 
                    glue::glue("经过药物特性评估后保留的候选药物|||列名称对应为以下化合物:\n{footer}"))
                x <- tablesAdd(x, t.final_candidates_mutate)
            }
            else {
                t.final_candidates <- alls[[1]]
            }
            x <- tablesAdd(x, t.final_candidates)
            feature(x) <- as_feature(x$synos$Synonym, "候选药物", 
                nature = "compounds")
            return(x)
        }
        .local(x, ...)
    })
    
    
    # clear(gb.markers)
    setMethod(f = "clear", signature = c(x = "job"), definition = function (x, 
        ...) 
    {
        .local <- function (x, save = TRUE, lite = TRUE, suffix = NULL, 
            name = rlang::expr_text(substitute(x, parent.frame(1))), 
            path_jobSave = getOption("path_jobSave", "."), path_lite = file.path(path_jobSave, 
                "lite"), expr_lite = NULL, allow_qs = TRUE, nthreads = 5) 
        {
            dir.create(path_jobSave, FALSE)
            filename <- paste0(name, ".", x@step, suffix, ".rds")
            if (save) {
                file <- file.path(path_jobSave, filename)
                if (allow_qs && object.size(x) > 5e+08) {
                    fileQs <- paste0(tools::file_path_sans_ext(file), 
                      ".qs")
                    message(glue::glue("Too large object ('{obj.size(x)}' > 478.6 Mb), use `qs::qsave`"))
                    message("Save qs: ", fileQs)
                    qs::qsave(x, fileQs, nthreads = nthreads)
                }
                else {
                    message("Save RDS: ", file)
                    saveRDS(x, file)
                }
            }
            object(x) <- NULL
            dir.create(path_lite, FALSE)
            if (!is.null(expr_lite)) {
                if (!is.expression(expr_lite)) {
                    stop("!is.expression(expr_lite).")
                }
                eval(expr_lite)
            }
            if (lite) {
                file <- file.path(path_lite, filename)
                message("Save RDS: ", file)
                saveRDS(x, file)
            }
            return(x)
        }
        .local(x, ...)
    })
    
    
}

