#!/usr/bin/env bash

# Step 1: Install QIIME 2

set -euo pipefail

ENV_NAME="rachis-qiime2-2026.10"

ENV_URL="https://raw.githubusercontent.com/qiime2/distributions/refs/heads/dev/2026.10/qiime2/released/rachis-qiime2-linux-64-conda.yml"

echo "========================================"
echo "Installing QIIME 2"
echo "Environment: ${ENV_NAME}"
echo "========================================"

# Verify Conda is available
command -v conda >/dev/null || {
    echo "ERROR: Conda is not installed."
    exit 1
}

# Avoid overwriting an existing environment
if conda env list | awk '{print $1}' | grep -Fxq "$ENV_NAME"; then
    echo "Environment ${ENV_NAME} already exists."
    exit 1
fi

# Create a dedicated QIIME 2 environment
conda env create \
    --name "$ENV_NAME" \
    --file "$ENV_URL"

echo
echo "QIIME 2 environment installation completed."
echo "Activate using:"
echo "conda activate ${ENV_NAME}"
