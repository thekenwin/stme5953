#!/usr/bin/env bash

# ============================================================
# Script: 00_install_miniconda.sh
# Purpose: Install Miniconda on WSL or macOS UNIX terminal
#
# Supported platforms:
#   - Ubuntu Linux / WSL2 (x86_64)
#   - macOS Intel (x86_64)
#   - macOS Apple Silicon (arm64)
# ============================================================

set -euo pipefail

DRY_RUN=false

case "${1:-}" in
    --dry-run)
        DRY_RUN=true
        ;;
    "")
        ;;
    *)
        echo "Usage: $0 [--dry-run]"
        exit 1
        ;;
esac

echo "========================================"
echo "Miniconda installation"
echo "========================================"

# ------------------------------------------------------------
# Step 1: Check for an existing Conda installation
# ------------------------------------------------------------

if command -v conda >/dev/null 2>&1; then
    echo "Conda is already installed."
    conda --version
    conda info --base

    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] Existing installation detected."
        echo "[DRY RUN] No changes will be made."
    else
        echo "Skipping Miniconda installation."
    fi

    exit 0
fi

# ------------------------------------------------------------
# Step 2: Identify operating system and architecture
# ------------------------------------------------------------

OS=$(uname -s)
ARCH=$(uname -m)

echo "Operating system: ${OS}"
echo "Architecture: ${ARCH}"

# ------------------------------------------------------------
# Step 3: Select the appropriate Miniconda installer
# ------------------------------------------------------------

case "${OS}-${ARCH}" in

    Linux-x86_64)
        INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
        ;;

    Darwin-x86_64)
        INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
        ;;

    Darwin-arm64)
        INSTALLER="Miniconda3-latest-MacOSX-arm64.sh"
        ;;

    *)
        echo "ERROR: Unsupported platform: ${OS}-${ARCH}"
        exit 1
        ;;

esac

# ------------------------------------------------------------
# Step 4: Download Miniconda
# ------------------------------------------------------------

URL="https://repo.anaconda.com/miniconda/${INSTALLER}"

if [[ "$DRY_RUN" == true ]]; then
    echo
    echo "[DRY RUN] Installer: ${INSTALLER}"
    echo "[DRY RUN] Download URL: ${URL}"
    echo "[DRY RUN] Installation directory: ${HOME}/miniconda3"
    echo "[DRY RUN] No files will be downloaded or modified."
    exit 0
fi

echo
echo "Downloading: ${INSTALLER}"

if command -v wget >/dev/null 2>&1; then
    wget -O "${INSTALLER}" "${URL}"
elif command -v curl >/dev/null 2>&1; then
    curl -fL "${URL}" -o "${INSTALLER}"
else
    echo "ERROR: Neither wget nor curl is available."
    exit 1
fi

# ------------------------------------------------------------
# Step 5: Install Miniconda
# ------------------------------------------------------------

INSTALL_DIR="${HOME}/miniconda3"

if [[ -e "${INSTALL_DIR}" ]]; then
    echo "ERROR: Installation directory already exists: ${INSTALL_DIR}"
    echo "No files have been overwritten."
    exit 1
fi

echo
echo "Installing Miniconda into:"
echo "${INSTALL_DIR}"

bash "${INSTALLER}" -b -p "${INSTALL_DIR}"

# ------------------------------------------------------------
# Step 6: Initialize Conda
# ------------------------------------------------------------

echo
echo "Initializing Conda..."

"${INSTALL_DIR}/bin/conda" init bash

# macOS defaults to Zsh
if [[ "${OS}" == "Darwin" ]]; then
    "${INSTALL_DIR}/bin/conda" init zsh
fi

# ------------------------------------------------------------
# Step 7: Verify installation
# ------------------------------------------------------------

echo
echo "========================================"
echo "Miniconda installation completed."
echo "========================================"

"${INSTALL_DIR}/bin/conda" --version

echo
echo "Close and reopen your terminal."
echo "Then verify the installation using:"
echo
echo "conda --version"
echo "conda info --base"
