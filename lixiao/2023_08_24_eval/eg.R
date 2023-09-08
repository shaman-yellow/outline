

cdRun("wget -O eg/sample-metadata.tsv ",
  "https://docs.qiime2.org/2021.11/data/tutorials/moving-pictures-usage/",
  "sample-metadata.tsv")

meta <- ftibble("./eg/sample-metadata.tsv")

cdRun("wget ",
  "-O './eg/emp-single-end-sequences.zip' ",
  "'https://docs.qiime2.org/2021.11/data/tutorials/moving-pictures-usage/emp-single-end-sequences.zip'")

cdRun(" unzip -d ./eg/emp-single-end-sequences ./eg/emp-single-end-sequences.zip")

## another format
cdRun("wget -O eg/casava-18-paired-end-demultiplexed.zip ",
  "https://data.qiime2.org/2023.7/tutorials/importing/",
  "casava-18-paired-end-demultiplexed.zip"
)
