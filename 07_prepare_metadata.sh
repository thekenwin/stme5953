#!/usr/bin/env bash

# Step 7: Prepare sample metadata and FASTQ manifest for QIIME 2

set -euo pipefail

# Define samples and experimental groups
accessions=(
    ERR162918
    ERR162920
    ERR162922
    ERR162934
    ERR162936
    ERR162938
)

samples=(
    C8
    C9
    C10
    V5
    V6
    V7
)

groups=(
    Crohns
    Crohns
    Crohns
    Healthy
    Healthy
    Healthy
)

# Get absolute path to current directory
data_dir="$(pwd -P)"

# Output files
metadata="metadata.tsv"
manifest="manifest.tsv"

# Write TSV headers
printf "sample-id\tGroup\n" > "$metadata"
printf "sample-id\tabsolute-filepath\n" > "$manifest"

# Generate metadata and manifest
for i in "${!accessions[@]}"
do
    accession="${accessions[$i]}"
    sample="${samples[$i]}"
    group="${groups[$i]}"

    fastq="${data_dir}/${accession}.fastq.gz"

    # Verify FASTQ file exists
    if [[ ! -f "$fastq" ]]; then
        echo "ERROR: FASTQ file not found: $fastq"
        exit 1
    fi

    # Write sample metadata
    printf "%s\t%s\n" \
        "$sample" "$group" >> "$metadata"

    # Write FASTQ manifest
    printf "%s\t%s\n" \
        "$sample" "$fastq" >> "$manifest"

done

echo "Sample metadata generated: $metadata"
echo "FASTQ manifest generated: $manifest"
