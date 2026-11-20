#!/usr/bin/env bash

# Step 13: Download SILVA 144 pretrained taxonomic classifier

set -euo pipefail

classifier="SILVA_144_SSURef_NR99_uniform_classifier_full-length.qza"

url="https://www.arb-silva.de/fileadmin/silva_databases/current/QIIME2/2026.7/SSU/full-length/uniform/${classifier}"

echo "Downloading SILVA 144 classifier..."

wget -c "$url"

echo
echo "Verifying downloaded classifier..."

# Confirm that the file is a ZIP archive
if ! unzip -tq "$classifier" >/dev/null; then
    echo "ERROR: Downloaded file is not a valid ZIP archive."
    exit 1
fi

# Confirm that QIIME 2 recognizes the classifier
qiime tools peek "$classifier"

echo
echo "SILVA classifier download and verification completed."
