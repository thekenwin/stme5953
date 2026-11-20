#!/usr/bin/env bash

# Step 13: Download SILVA 144 pretrained taxonomic classifier

set -euo pipefail

classifier="SILVA_144_SSURef_NR99_uniform_classifier_full-length.qza"

url="https://www.arb-silva.de/current-release/QIIME2/2026.7/SSU/full-length/uniform/${classifier}"

echo "Downloading SILVA 144 classifier..."

wget -c "$url"

echo
echo "Classifier download completed."
