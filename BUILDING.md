# Building LineageOS 19.1 for Motorola One (deen)

This tree is a starting point for a **source build**, not a tested ROM release. No successful full Android build or device boot has been claimed.

## Repositories pinned for this project

- Device tree: `isabe8499-oss/device_motorola_deen-22`, branch `lineage-19.1`
- Kernel: `isabe8499-oss/kernel_motorola_msm8953-22`, branch `bakasu-susfs23-deen`
- Vendor tree: `Vhmit/vendor_motorola_deen`, branch `lineage-19.1`

## 1. Prepare LineageOS source

Use a Linux build machine with ample RAM and disk space. A full Android source checkout and output tree are much larger than a normal GitHub-hosted runner's available workspace; do not assume a standard hosted Actions runner can complete a ROM build.

```bash
mkdir -p ~/android/lineage-deen
cd ~/android/lineage-deen
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs
mkdir -p .repo/local_manifests
cat > .repo/local_manifests/deen.xml <<'EOF'
<manifest>
  <remote name="github-user" fetch="https://github.com/" />
  <project name="isabe8499-oss/device_motorola_deen-22"
           path="device/motorola/deen"
           remote="github-user"
           revision="lineage-19.1" />
  <project name="isabe8499-oss/kernel_motorola_msm8953-22"
           path="kernel/motorola/msm8953"
           remote="github-user"
           revision="bakasu-susfs23-deen" />
</manifest>
EOF
repo sync -c --no-clone-bundle --no-tags -j"$(nproc --all)"
```

The device tree's `lineage.dependencies` declares the vendor tree. The `github-user` remote in the local manifest lets the dependency resolver reach the owner-qualified GitHub repository.

Then initialize the build environment and request the device configuration:

```bash
source build/envsetup.sh
breakfast deen
```

Confirm that `vendor/motorola/deen` exists after dependency resolution. If it does not, stop and resolve the manifest/dependency issue rather than trying to build with missing proprietary files.

## 2. Build and stage the custom kernel

The device configuration expects a **prebuilt** `Image.gz-dtb` at `device/motorola/deen-kernel/Image.gz-dtb` and exported headers under `device/motorola/deen-kernel/kernel-headers`. The helper added to this tree stages those outputs from the kernel build directory.

```bash
cd kernel/motorola/msm8953
bash -n build.sh
# This branch applies the pinned SUSFS 2.3.0 patches and enables NoMount v2.2.0.
# -ksu enables BakaSU + SUSFS; the "y" answer exports UAPI headers.
printf 'y\n' | ./build.sh deen -ksu
cd ~/android/lineage-deen
bash device/motorola/deen/scripts/stage-kernel.sh kernel/motorola/msm8953
```

The `y` answer requests exported kernel headers. If you need BakaSU/KernelSU and SUSFS together, first correct and validate the kernel build configuration so the selected build does not silently disable a required feature. Verify the resulting kernel config and image before staging.

## 3. Build the ROM

Only after the device tree, vendor tree, and staged kernel are present:

```bash
cd ~/android/lineage-deen
source build/envsetup.sh
lunch lineage_deen-userdebug
mka bacon
```

This is the expected build invocation for the product definition, not a claim that the current source combination already compiles. Resolve the first real build error before making speculative changes to device properties or the Android 10 build fingerprint.

## Current validation boundary

The workflow `.github/workflows/deen-lineage19-preflight.yml` checks device identifiers, boot-image metadata, shell syntax, vendor branch availability, Linux 4.19.325, the NoMount configuration, and the SUSFS patch/configuration inputs. It is a **preflight check only**; it does not compile Android, validate proprietary ABI compatibility, or prove that the device boots.

Before flashing any image, verify partition layout, boot image/DTB packaging, vendor interfaces, SELinux denials, kernel modules and runtime logs. Keep a known-good boot/recovery image available.
