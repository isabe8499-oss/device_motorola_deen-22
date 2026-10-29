#!/usr/bin/env bash
# Build LineageOS 19.1 for Motorola One (deen) from an initialized Android tree.
# Run from the Android source root: bash device/motorola/deen/scripts/build-lineage19.sh
set -euo pipefail

ANDROID_TOP="$(pwd -P)"
DEVICE_DIR="${ANDROID_TOP}/device/motorola/deen"
KERNEL_DIR="${ANDROID_TOP}/kernel/motorola/msm8953"
STAGED_DIR="${ANDROID_TOP}/device/motorola/deen-kernel"
EXPECTED_DEVICE_BRANCH="lineage-19.1"
EXPECTED_KERNEL_BRANCH="bakasu-susfs23-deen"

fail() { echo "ERROR: $*" >&2; exit 1; }

[[ -f "${ANDROID_TOP}/build/envsetup.sh" ]] || fail "Run this from the Android source root (build/envsetup.sh not found)."
[[ -f "${DEVICE_DIR}/lineage_deen.mk" ]] || fail "Device tree not found at ${DEVICE_DIR}."
[[ -d "${KERNEL_DIR}/.git" ]] || fail "Kernel source checkout not found at ${KERNEL_DIR}."
[[ -s "${STAGED_DIR}/Image.gz-dtb" ]] || fail "Staged kernel image missing: ${STAGED_DIR}/Image.gz-dtb."
[[ -d "${STAGED_DIR}/kernel-headers/include" ]] || fail "Staged exported kernel headers missing."

device_branch="$(git -C "${DEVICE_DIR}" branch --show-current)"
kernel_branch="$(git -C "${KERNEL_DIR}" branch --show-current)"
[[ "${device_branch}" == "${EXPECTED_DEVICE_BRANCH}" ]] || fail "Device branch is '${device_branch}', expected '${EXPECTED_DEVICE_BRANCH}'."
[[ "${kernel_branch}" == "${EXPECTED_KERNEL_BRANCH}" ]] || fail "Kernel branch is '${kernel_branch}', expected '${EXPECTED_KERNEL_BRANCH}'."

kernel_version="$(make -s -C "${KERNEL_DIR}" kernelversion)"
[[ "${kernel_version}" == "4.19.325" ]] || fail "Kernel source reports ${kernel_version}; expected 4.19.325."

for option in CONFIG_KSU=y CONFIG_KSU_SUSFS=y CONFIG_KSU_SUSFS_OPEN_REDIRECT=y CONFIG_NOMOUNT=y; do
    grep -qx "${option}" "${KERNEL_DIR}/out/.config" || fail "Kernel config missing ${option}; build the pinned kernel first."
done

echo "Android source root: ${ANDROID_TOP}"
echo "Device branch: ${device_branch} ($(git -C "${DEVICE_DIR}" rev-parse --short HEAD))"
echo "Kernel branch: ${kernel_branch} ($(git -C "${KERNEL_DIR}" rev-parse --short HEAD))"
echo "Kernel version: ${kernel_version}"
sha256sum "${STAGED_DIR}/Image.gz-dtb"
echo "Preparing LineageOS product lineage_deen-userdebug..."

# shellcheck disable=SC1091
source "${ANDROID_TOP}/build/envsetup.sh"
lunch lineage_deen-userdebug
mka bacon

OUT_DIR="${ANDROID_TOP}/out/target/product/deen"
echo "ROM build command completed. Inspect output at: ${OUT_DIR}"
find "${OUT_DIR}" -maxdepth 1 -type f \( -name '*lineage*.zip' -o -name 'boot.img' -o -name 'vendor_boot.img' -o -name 'dtbo.img' \) -printf '%f %s bytes\n' 2>/dev/null || true
