# Deen LineageOS 19.1 + Linux 4.19.325 integration

## Current source pins

- Device tree: `isabe8499-oss/device_motorola_deen-22`, branch `lineage-19.1`
- Vendor tree: `Vhmit/vendor_motorola_deen`, branch `lineage-19.1`
- Kernel tree: `isabe8499-oss/kernel_motorola_msm8953-22`, branch `bakasu-susfs23-deen`
- Kernel target: Linux 4.19.325, ARM64, MSM8953 / Deen
- Kernel features checked by preflight: NoMount v22 and SUSFS 2.3.0 build inputs

## Important limitation

The preflight workflow verifies repository references, expected files, configuration markers, and static device-tree settings. It does **not** build the full Android ROM, prove that every kernel config option survives `olddefconfig`, verify DTB/DTBO compatibility, or prove that the resulting boot image starts on physical hardware.

## Kernel image integration

The device tree currently expects:

- Kernel image: `device/motorola/deen-kernel/Image.gz-dtb`
- Exported kernel headers: `device/motorola/deen-kernel/kernel-headers/`

The kernel workflow exports UAPI headers to `out/arch/arm64/boot/usr`. After building the selected kernel branch, run the staging helper from the Android source checkout:

```bash
bash device/motorola/deen/scripts/stage-kernel.sh kernel/motorola/msm8953
```

The helper checks that both the image and exported headers exist before copying them. If the Android checkout uses a different path for the device tree or kernel checkout, pass the actual kernel source path as the helper's first argument.

Before running a full ROM build, confirm:

1. `kernel/motorola/msm8953` is checked out at `bakasu-susfs23-deen`.
2. The kernel build has completed and produced `out/arch/arm64/boot/Image.gz-dtb`.
3. `headers_install` completed and exported headers to `out/arch/arm64/boot/usr`.
4. The staged image is present at the path consumed by `device.mk`.
5. The resulting `boot.img` has the expected header version, page size, offsets, and device DTB/DTBO arrangement.

## Build identity / fingerprint

The product file no longer forces the Android 10 stock `BUILD_FINGERPRINT` and `PRIVATE_BUILD_DESC` onto the Android 12 product. The LineageOS build system should generate the ROM's build identity. Keep vendor build properties tied to the actual vendor firmware unless a specific compatibility issue justifies a change. Do not copy a fingerprint from an unrelated device.

## Validation sequence

1. Run the device-tree preflight workflow.
2. Build the kernel separately and inspect its build log and artifact.
3. Stage the kernel image and headers into the Android tree.
4. Build `lineage_deen-userdebug` using the matching LineageOS 19.1 manifest and vendor tree.
5. Inspect the generated `boot.img`, `vendor_boot.img` if applicable, and ROM package before flashing.
6. Test with a recovery path available and retain a known-good boot image.
7. Verify boot, display, touch, telephony, Wi-Fi, Bluetooth, audio, cameras, charging, fingerprint sensor, SELinux enforcing state, and runtime SUSFS/NoMount behavior.

A successful preflight is not a substitute for the full build or on-device tests.
