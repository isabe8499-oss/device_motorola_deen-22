# Motorola One Deen — LineageOS 19.1 + kernel 4.19.325

This device tree targets `deen` / Qualcomm `msm8953` and LineageOS 19.1 (Android 12).
The dependency manifest pins:

- Device tree: this repository, branch `lineage-19.1`
- Vendor blobs: `Vhmit/vendor_motorola_deen`, branch `lineage-19.1`
- Kernel source: `isabe8499-oss/kernel_motorola_msm8953-22`, branch `bakasu-susfs23-deen`

The kernel branch is Linux 4.19.325 and includes the build-time SUSFS 2.3.0 patches plus NoMount v22. SUSFS is applied by the kernel build script when the BakaSU/KSU build option is selected; the presence of patch files alone is not proof that a built image contains the features.

## Build and stage the kernel

Run these commands from the Android source root after initializing LineageOS 19.1 and resolving the device dependencies:

```bash
source build/envsetup.sh
breakfast deen
repo sync -c --no-clone-bundle --no-tags
```

Build the kernel in its checked-out source directory. The build script downloads/uses its Clang 18 toolchain and asks whether to upload the flashable ZIP; answer **N**:

```bash
cd kernel/motorola/msm8953
printf 'n\n' | ./build.sh deen -ksu -z
make -j"$(nproc --all)" O=out ARCH=arm64 LLVM=1 LLVM_IAS=1 HOSTCFLAGS=-fcommon INSTALL_HDR_PATH="$PWD/out/arch/arm64/boot/usr" headers_install
cd ../../..
bash device/motorola/deen/scripts/stage-kernel.sh "$PWD/kernel/motorola/msm8953"
```

The staging helper refuses to copy the image unless the generated `out/.config` has BakaSU/KSU, SUSFS path/mount/kstat/map, SUSFS open redirect, NoMount and `KEYS` enabled, and exported headers exist. It places the files at the prebuilt paths already expected by `device.mk` and `BoardConfig.mk`.

## Build the ROM

```bash
source build/envsetup.sh
lunch lineage_deen-userdebug
mka bacon
```

The full Android build is intentionally not run by the lightweight preflight workflow. A complete LineageOS build needs a large source checkout, substantial disk space and RAM; a standard GitHub-hosted runner is generally not suitable for the entire Android build. Use a suitably provisioned build host or a self-hosted Actions runner.

## Validation status and limits

- The GitHub Actions kernel build has succeeded for the pinned kernel branch, including its feature-config checks and exported headers.
- The device-tree preflight validates device identity, boot-image metadata, dependencies and the existence of kernel feature sources/configuration.
- The preflight does **not** prove that the full ROM compiles, that the kernel boots on the phone, or that Wi-Fi, camera, telephony, encryption, SELinux and suspend work at runtime. Those require a full ROM build and device testing.
- The stock Android 10 fingerprint in `lineage_deen.mk` is left unchanged for now. It should only be changed after checking the vendor blobs and runtime compatibility properties; changing it blindly can break proprietary services.
- The legacy boot image settings (header v1, `Image.gz-dtb`, offsets and partition sizes) are preserved pending boot-image and device validation.
