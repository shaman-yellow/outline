
ssh remote
cd /data/hlc
mkdir 08_17_wes
cd 08_17_wes

# scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.elsites .
# scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.elsites .
# scp local:/home/echo/outline/lixiao/hg38.elfasta .
scp -r local:/home/echo/disk_sdb5/08_17/elprep .
scp local:/home/echo/outline/lixiao/hg38.fa .
scp local:/home/echo/outline/lixiao/hg38.fa.* .
scp local:/home/echo/outline/lixiao/hg38.dict .
scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.vcf .
scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.vcf.idx .
scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.vcf .
scp local:/home/echo/outline/lixiao/resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.vcf.idx .

mkdir bqsr
mkdir bqsr_table

for i in `ls elprep`
do
  name=${i%%.*}
  ~/operation/gatk4/gatk BaseRecalibrator \
    -I elprep/$i \
    -R hg38.fa \
    -known-sites resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.vcf \
    -known-sites resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.vcf \
    -O bqsr_table/${name}.table
  ~/operation/gatk4/gatk ApplyBQSR \
    --bqsr-recal-file bqsr_table/${name}.table \
    -R hg38.fa \
    -I elprep/$i \
    -O bqsr/$name.bam
  echo "Job finished of $name"
done



