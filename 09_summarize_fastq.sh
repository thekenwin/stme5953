#!/usr/bin/env bash

# Step 9: Summarize targeted 16S rRNA sequencing quality

set -euo pipefail

qiime demux summarize \
    --i-data 16s.qza \
    --o-visualization 16s_summary.qzv

echo
echo "QIIME 2 sequencing summary generated: 16s_summary.qzv"
