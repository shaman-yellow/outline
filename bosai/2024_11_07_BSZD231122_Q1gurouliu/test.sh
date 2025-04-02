#!/bin/bash

cd ~/seurat_OS
~/software/miniconda3/bin/conda run -n r4-base Rscript -e "{
    x <- readRDS('~/seurat_OS/srn.os.rds')
}
{
    print('test')
}
{
    saveRDS(x, '~/seurat_OS/srn.os.rds')
}"



#!/bin/bash

cd ~/seurat_OS
~/software/miniconda3/bin/conda run -n r4-base Rscript -e "{
    x <- readRDS('~/seurat_OS/srn.os.rds')
}
{
    print('test')
    print(\"1\")
}
{
    saveRDS(x, '~/seurat_OS/srn.os.rds')
}"



