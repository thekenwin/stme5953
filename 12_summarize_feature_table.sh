#!/usr/bin/env bash

# Step 12: Summarize DADA2 feature table

set -euo pipefail

qiime feature-table summarize \
    --i-table dada2_table.qza \
    --m-metadata-file metadata.tsv \
    --o-feature-frequencies dada2_feature_frequencies.qza \
    --o-sample-frequencies dada2_sample_frequencies.qza \
    --o-summary dada2_table.qzv

echo
echo "DADA2 feature table summary generated: dada2_table.qzv"
