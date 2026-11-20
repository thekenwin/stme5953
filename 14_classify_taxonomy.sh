#!/usr/bin/env bash

# Step 14: Classify 16S ASVs using SILVA 144

set -euo pipefail

echo "Classifying ASVs using SILVA 144..."

qiime feature-classifier classify-sklearn \
    --i-reads dada2_rep_set.qza \
    --i-classifier SILVA_144_SSURef_NR99_uniform_classifier_full-length.qza \
    --o-classification silva_taxonomy.qza

echo
echo "Taxonomic classification completed."

qiime tools peek silva_taxonomy.qza
