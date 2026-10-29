# Full ROM build: Motorola One (deen)

This procedure builds the complete LineageOS 19.1 ROM, not just the kernel or static device-tree checks.

## Pinned source repositories

- Manifest: `https://github.com/LineageOS/android.git`, branch `lineage-19.1`
- Device tree: `https://github.com/isabe8499-oss/device_motorola_deen-22.git`, branch `lineage-19.1`
- Vendor tree: `https://github.com/Vhmit/vendor_motorola_deen.git`, branch `lineage-19.1`
- Kernel: `https://github.com/isabe8499-oss/kernel_motorola_msm8953-22.git`, branch `bakasu-susfs23-deen`

## Host capacity

Use a Linux x86-64 build host with ample RAM and at least 200 GB of free disk space (more is safer). Standard hosted CI runners generally do not provide a dependable amount of disk space for a full Android source sync plus build output; do not start a full build on a runner until free disk space is verified.

Install the Android/LineageOS host dependencies from the LineageOS build documentation, and install Google's `repo` tool.

## Initialize and sync the source tree

From a clean directory with `repo` installed:

```bash
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs
mkdir -p .repo/local_manifests
cat > .repo/local_manifests/deen.xml <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote name="deen-github" fetch="https://github.com/" />
  <project name="isabe8499-oss/device_motorola_deen-22" path="device/motorola/deen" remote="deen-github" revision="lineage-19.1" />
  <project name="Vhmit/vendor_motorola_deen" path="vendor/motorola/deen" remote="deen-github" revision="lineage-19.1" />
  <project name="isabe8499-oss/kernel_motorola_msm8953-22" path="kernel/motorola/msm8953" remote="deen-github" revision="bakasu-susfs23-deen" />
</manifest>
XML
repo sync -c --force-sync --no-clone-bundle --no-tags -j"$(nproc --all)"
```

The local manifest defines a separate `deen-github` remote so the owner/repository names resolve to the intended GitHub forks rather than being interpreted relative to LineageOS's default remote. Verify that these three project paths and revisions match the pins above before building.

## Build and stage the kernel

Build the kernel using the repository's documented workflow/script so its generated `out/.config`, `Image.gz-dtb`, and exported UAPI headers are from the same source revision. Then stage the image and headers using the device-tree helper:

```bash
bash device/motorola/deen/scripts/stage-kernel.sh kernel/motorola/msm8953
```

The helper rejects missing kernel outputs and checks required BakaSU/KSU, SUSFS 2.3.0, OPEN_REDIRECT, and NoMount v22 configuration markers.

## Build the full ROM

From the Android source root:

```bash
bash device/motorola/deen/scripts/build-lineage19.sh
```

The script checks source branches, kernel version, staged image/headers, and key kernel config flags before invoking `lunch lineage_deen-userdebug` and `mka bacon`.

## Validation boundary

A successful build must produce a ROM ZIP under `out/target/product/deen`. Before flashing, inspect the package contents and boot image metadata, retain a known-good boot/recovery path, and verify hardware functions on the actual phone. Build success alone does not prove bootability, full hardware functionality, or Play Integrity certification.
