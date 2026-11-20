#!/usr/bin/env bash

# Step 10: Denoise targeted 16S rRNA sequences using DADA2

set -euo pipefail

qiime dada2 denoise-single \
    --i-demultiplexed-seqs 16s.qza \
    --p-trunc-len 150 \
    --o-table dada2_table.qza \
    --o-representative-sequences dada2_rep_set.qza \
    --o-denoising-stats dada2_stats.qza \
    --o-base-transition-stats dada2_base_transition_stats.qza

echo
echo "DADA2 denoising completed."
