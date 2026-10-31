# Full ROM build: Motorola One (deen)

This procedure builds the complete LineageOS 19.1 ROM, not just the kernel or static device-tree checks.

## Pinned source repositories

- Manifest: `https://github.com/LineageOS/android.git`, branch `lineage-19.1`
- Device tree: `https://github.com/isabe8499-oss/device_motorola_deen-22.git`, branch `lineage-19.1`
- Vendor tree: `https://github.com/Vhmit/vendor_motorola_deen.git`, branch `lineage-19.1`
- Kernel: `https://github.com/isabe8499-oss/kernel_motorola_msm8953-22.git`, branch `bakasu-susfs23-deen`

## Host capacity

Use a Linux x86-64 build host with ample RAM and at least 200 GB of free disk space (more is safer). The GitHub Actions workflow checks the usable space before syncing and uses two separate runner filesystems when available: the Android working tree/build output is placed under `RUNNER_TEMP/android`, while Repo's Git object database and metadata are bind-mounted at `GITHUB_WORKSPACE/.repo`. This allows the source tree and build output to use the runner's root filesystem while keeping Repo metadata and ccache on the workspace volume.

The workflow refuses to sync unless the two paths are on different filesystems, each has at least 70 GiB free, and their combined free space is at least 200 GiB. During the build it also checks the remaining space on both volumes. A runner with only one small workspace volume is not sufficient; use a larger runner or a self-hosted Linux x86-64 host in that case.

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

The existing successful kernel workflow is [run 40789837157](https://github.com/isabe8499-oss/kernel_motorola_msm8953-22/actions/runs/40789837157). Its artifact is currently named `deen-susfs23-12` and contains the built kernel image, generated config, and exported headers. The device-tree preflight now refuses to pass if the kernel branch HEAD has no matching successful, unexpired artifact.

You can download that artifact with GitHub CLI from a Linux build host:

```bash
gh run download 40789837157 \
  --repo isabe8499-oss/kernel_motorola_msm8953-22 \
  --name deen-susfs23-12 \
  --dir /tmp/deen-kernel-artifact
```

From the Android source root, copy the artifact's generated `out/` tree into the checked-out kernel source. Confirm the downloaded directory contains `out/arch/arm64/boot/Image.gz-dtb`, `out/.config`, and `out/arch/arm64/boot/usr/include` before copying:

```bash
rsync -a /tmp/deen-kernel-artifact/out/ kernel/motorola/msm8953/out/
```

If the downloaded artifact has a different directory layout, locate those three exact paths and copy them preserving the `out/` structure. Do not combine an image, config, and headers from different kernel workflow runs.

Then stage the image and headers into the legacy path expected by this device tree:

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
