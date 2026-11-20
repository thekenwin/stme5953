#!/usr/bin/env bash

# Step 8: Import targeted 16S rRNA FASTQ files into QIIME 2

set -euo pipefail

qiime tools import \
    --type 'SampleData[SequencesWithQuality]' \
    --input-path manifest.tsv \
    --output-path 16s.qza \
    --input-format SingleEndFastqManifestPhred33V2

echo
echo "QIIME 2 FASTQ import completed."
