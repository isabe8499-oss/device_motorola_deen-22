#!/usr/bin/env bash
# Stage a separately built Deen kernel into the legacy prebuilt path expected
# by this LineageOS device tree. Run from any directory after build.sh finishes.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEVICE_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
ANDROID_TOP="$(cd -- "${DEVICE_DIR}/../../.." && pwd)"
KERNEL_SRC="${1:-${ANDROID_TOP}/kernel/motorola/msm8953}"
KERNEL_IMAGE="${KERNEL_SRC}/out/arch/arm64/boot/Image.gz-dtb"
KERNEL_HEADERS="${KERNEL_SRC}/out/arch/arm64/boot/usr"
KERNEL_CONFIG="${KERNEL_SRC}/out/.config"
DEST="${ANDROID_TOP}/device/motorola/deen-kernel"

if [[ ! -s "${KERNEL_IMAGE}" ]]; then
    echo "ERROR: missing kernel image: ${KERNEL_IMAGE}" >&2
    exit 1
fi

if [[ ! -s "${KERNEL_CONFIG}" ]]; then
    echo "ERROR: missing generated kernel config: ${KERNEL_CONFIG}" >&2
    exit 1
fi

for option in CONFIG_KSU=y CONFIG_KSU_SUSFS=y CONFIG_KSU_SUSFS_SUS_PATH=y CONFIG_KSU_SUSFS_SUS_MOUNT=y CONFIG_KSU_SUSFS_SUS_KSTAT=y CONFIG_KSU_SUSFS_SUS_MAP=y CONFIG_KSU_SUSFS_OPEN_REDIRECT=y CONFIG_NOMOUNT=y CONFIG_KEYS=y; do
    if ! grep -qx "${option}" "${KERNEL_CONFIG}"; then
        echo "ERROR: required kernel feature is not enabled: ${option}" >&2
        exit 1
    fi
done

if [[ ! -d "${KERNEL_HEADERS}/include" ]]; then
    echo "ERROR: exported kernel headers not found under ${KERNEL_HEADERS}/include." >&2
    echo "Build the kernel with header export enabled before staging." >&2
    exit 1
fi

mkdir -p "${DEST}/kernel-headers"
install -m 0644 "${KERNEL_IMAGE}" "${DEST}/Image.gz-dtb"
cp -a "${KERNEL_HEADERS}/." "${DEST}/kernel-headers/"

test -s "${DEST}/Image.gz-dtb"
test -d "${DEST}/kernel-headers/include"

echo "Staged kernel image: ${DEST}/Image.gz-dtb"
echo "Staged exported headers: ${DEST}/kernel-headers"
echo "Verified enabled features: SUSFS 2.3.0 core/options, OPEN_REDIRECT, NoMount, BakaSU/KSU"
sha256sum "${DEST}/Image.gz-dtb"
echo "NOTE: This stages files for the ROM build; it does not validate boot compatibility."
