# ==========================================================================
# FIELD: setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

rm(list = ls()); gc()
ORIGINAL_DIR <- "/data/nas1/huanglichuang_OD/project/02_job0259"
output <- file.path(ORIGINAL_DIR, "18_dynamics")
if (!dir.exists(output)) {
  dir.create(output, recursive = TRUE)
}
setwd(ORIGINAL_DIR)

.libPaths(c('/data/nas2/software/miniconda3/envs/public_R/lib/R/library/', '/data/nas1/huanglichuang_OD/conda/envs/extra_pkgs/lib/R/library/'))

myPkg <- "./utils.tool"
if (!dir.exists(myPkg)) {
  stop('Can not found package: ', myPkg)
}
devtools::load_all(myPkg)
setup.huibang()

# ==========================================================================
# FIELD: analysis
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# ==========================================================================
# FIELD: output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# ==========================================================================
# FIELD: checkout
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# NOTE: 下方代码是以上分析代码中自动解析出来的
# 大部分都不是 function, 而是 methods
# 如果你对 S4 不熟悉，可以参考 Seurat 的那些方法，例如 Seurat::FindMarkers
# Seurat 的方法大都是 methods，即范型方法
# 
# 假如下面还有哪个内部方法让你不清楚，你可以先加载 'utils.tool' 这个 R 包，
# 然后通过运行 `selectMethod` 来查看函数本体
# 前提是你需要知道 method 应用的对象是什么'类'，
# 例如：
# selectMethod(step1, 'job_seurat5n')
# selectMethod(step1, class(.job_seurat5n()))
# 
# 我只解析了我的代码的第一层，堆在下面，因为内部还有用到很多自定义的函数
# 全部解析出来的话，就没完没了了……
# 如果需要我全部解析出来……那我估计要把整个 R 包的代码都堆进每个脚本了……
# 
# 审核的老师应该不需要在下方代码中写注释提问吧？
# 如果写了，可能会被我这边自动同步给直接覆盖掉
# 
# 最后，下方的代码，我在定义的上方写明了在上方哪个分析代码用到了这个本体，
# 希望对您有所帮助


