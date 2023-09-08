
mkdir elprep_output_bam
mkdir elprep_tmp
mkdir elprep_res

for i in `ls elprep`
do
  name=${i%%.*}
  echo $name
  conda run -n base elprep sfm elprep/$i elprep_output_bam/${name}_elprep.bam \
    --mark-duplicates --mark-optical-duplicates elprep_tmp/${name}.metrics \
    --sorting-order coordinate \
    --bqsr elprep_tmp/${name}.recal \
    --known-sites resources_broad_hg38_v0_1000G_phase1.snps.high_confidence.hg38.elsites,resources_broad_hg38_v0_Mills_and_1000G_gold_standard.indels.hg38.elsites \
    --reference hg38.elfasta \
    --haplotypecaller elprep_res/${name}.vcf.gz
done

for i in `ls elprep_res/*.vcf.gz`
do
  name=${i%%.*}
  echo $name
  conda run -n base bcftools index $i
done

conda run -n base bcftools merge `ls elprep_res/22*.vcf.gz` -O z -o all.vcf.gz
scp all.vcf.gz local:/home/echo/disk_sdb5/08_17/

