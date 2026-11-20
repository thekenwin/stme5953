#!/usr/bin/env bash

# Step 15: Generate taxonomic abundance bar plots

set -euo pipefail

echo "Generating taxonomic abundance bar plots..."

qiime taxa barplot \
    --i-table dada2_table.qza \
    --i-taxonomy silva_taxonomy.qza \
    --m-metadata-file metadata.tsv \
    --o-visualization taxa_barplot.qzv

echo
echo "Taxonomic abundance bar plots completed."

qiime tools peek taxa_barplot.qzv
