#!/usr/bin/env bash

# Step 1: Install QIIME 2
# Platforms: Linux/WSL2, macOS Intel, macOS Apple Silicon

set -euo pipefail

ENV_NAME="rachis-qiime2-2026.10"

BASE_URL="https://raw.githubusercontent.com/qiime2/distributions/refs/heads/dev/2026.10/qiime2/released"

OS="$(uname -s)"
ARCH="$(uname -m)"
APPLE_SILICON=false

echo "========================================"
echo "Installing QIIME 2"
echo "Environment: ${ENV_NAME}"
echo "Operating system: ${OS}"
echo "Architecture: ${ARCH}"
echo "========================================"

# Verify Conda is available

command -v conda >/dev/null 2>&1 || {
    echo "ERROR: Conda is not installed or not on PATH."
    exit 1
}

# Detect operating system and architecture

case "${OS}-${ARCH}" in

    Linux-x86_64)
        PLATFORM="linux-64"
        ;;

    Darwin-x86_64)
        PLATFORM="osx-64"
        ;;

    Darwin-arm64)
        PLATFORM="osx-64"
        APPLE_SILICON=true
        ;;

    *)
        echo "ERROR: Unsupported platform: ${OS}-${ARCH}"
        exit 1
        ;;
esac

ENV_URL="${BASE_URL}/rachis-qiime2-${PLATFORM}-conda.yml"

echo "QIIME 2 platform: ${PLATFORM}"
echo "Environment file: ${ENV_URL}"

# Prevent overwriting an existing environment

if conda env list | awk '{print $1}' | grep -Fxq "${ENV_NAME}"; then
    echo "Environment ${ENV_NAME} already exists."
    exit 1
fi

# Apple Silicon requires Rosetta 2

if [[ "${APPLE_SILICON}" == true ]]; then

    if ! /usr/bin/arch -x86_64 /usr/bin/true >/dev/null 2>&1; then
        echo "Rosetta 2 is required for QIIME 2."
        echo "Install it using:"
        echo "softwareupdate --install-rosetta --agree-to-license"
        exit 1
    fi

    echo "Installing QIIME 2 using Rosetta 2 compatibility."

    CONDA_SUBDIR=osx-64 conda env create \
        --name "${ENV_NAME}" \
        --file "${ENV_URL}"

else

    conda env create \
        --name "${ENV_NAME}" \
        --file "${ENV_URL}"

fi

# Configure Apple Silicon environment to use osx-64

if [[ "${APPLE_SILICON}" == true ]]; then

    conda config \
        --prefix "$(conda info --base)/envs/${ENV_NAME}" \
        --set subdir osx-64

fi

echo
echo "QIIME 2 environment installation completed."
echo "Activate using:"
echo "conda activate ${ENV_NAME}"
echo
echo "Verify using:"
echo "qiime info"
