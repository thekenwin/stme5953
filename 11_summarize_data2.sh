#!/usr/bin/env bash

# Step 11: Summarize DADA2 denoising statistics

set -euo pipefail

qiime metadata tabulate \
    --m-input-file dada2_stats.qza \
    --o-visualization dada2_stats.qzv

echo
echo "DADA2 statistics visualization generated: dada2_stats.qzv"
