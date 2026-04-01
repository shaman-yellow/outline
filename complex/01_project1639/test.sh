
# curl 'https://rnasysu.com/encori/api/miRNATarget/?assembly=hg38&geneType=mRNA&miRNA=hsa-miR-152-3p&clipExpNum=5&degraExpNum=1&pancancerNum=10&programNum=5&program=None&target=all&cellType=all' > test.txt

curl 'https://rnasysu.com/encori/api/miRNATarget/?assembly=hg38&geneType=lncRNA&miRNA=hsa-miR-152-3p&interNum=1&expNum=1&cellType=all' > test.txt

wget "https://rnasysu.com/encori/api/miRNATarget/?assembly=hg38&geneType=lncRNA&miRNA=hsa-miR-9-5p&interNum=1&expNum=1&cellType=all"

ssh remote
cdproject

cp ./remote/GraphBAN_MARKERS/smiles_for_admet.txt -t .
obabel ./smiles_for_admet.txt -ocan -O test.smi

sed -i 's/ORIGINAL_DIR, "\/data\/nas1\/huanglichuang_OD\/project\/01_project1639\//ORIGINAL_DIR, "/g' *.r
