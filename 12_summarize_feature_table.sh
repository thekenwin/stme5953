#!/usr/bin/env bash

# Step 12: Summarize DADA2 feature table

set -euo pipefail

qiime feature-table summarize \
    --i-table dada2_table.qza \
    --m-sample-metadata-file metadata.tsv \
    --o-visualization dada2_table.qzv

echo
echo "DADA2 feature table summary generated: dada2_table.qzv"
