
export KNEADDATA_DB_HUMAN_GENOME=/data/hlc/biobakery_workflows_databases/kneaddata_db_human_genome
export STRAINPHLAN_DB_REFERENCE=/data/hlc/biobakery_workflows_databases/strainphlan_db_reference
export STRAINPHLAN_DB_MARKERS=/data/hlc/biobakery_workflows_databases/strainphlan_db_markers

biobakery_workflows wmgx --input . --output res --bypass-quality-control --threads 28
