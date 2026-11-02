# Motorola One (deen) — Community Handoff

This file records the project state and the evidence available so another maintainer can continue the work without having to reconstruct the entire chat history.

**Last status audit:** 2026-11-01  
**Device codename:** `deen`  
**ROM target:** LineageOS 19.1 / Android 12.1  
**Kernel target:** Linux 4.19.325, arm64, Qualcomm MSM8953 family

## Project repositories

| Component | Repository | Branch |
|---|---|---|
| Device tree and ROM workflow | [device_motorola_deen-22](https://github.com/isabe8499-oss/device_motorola_deen-22) | `lineage-19.1` |
| Kernel | [kernel_motorola_msm8953-22](https://github.com/isabe8499-oss/kernel_motorola_msm8953-22) | `bakasu-susfs23-deen` |
| Vendor files | [vendor_motorola_deen](https://github.com/Vhmit/vendor_motorola_deen) | `lineage-19.1` |

The ROM workflow uses the LineageOS `lineage-19.1` manifest and a local manifest for the three repositories above. The exact pinned paths and build commands are documented in [ROM_BUILD.md](ROM_BUILD.md).

## Verified kernel artifact

A successful kernel workflow run produced the artifact below:

- [Kernel workflow run 40820488471](https://github.com/isabe8499-oss/kernel_motorola_msm8953-22/actions/runs/40820488471)
- Artifact name: `deen-susfs23`
- Flashable ZIP inside the artifact: `DeenRev-deen-KSU-20261029-0457.zip`
- SHA-256 of the flashable ZIP: `7082e70dd13971383a212feef7237cb465e05ff93a814c38819000e8cd3b0688`
- SHA-256 of the outer workflow artifact archive: `744289c6a26865929588111280beb3eab8401507ba0d72d072355504d525d569`

Build metadata recorded with that kernel:

```text
kernel_version=4.19.325
kernel_source_commit=1f71757e3deb804698c5c827c54a0a46b603f24c
bakasu_commit=d5e9e025b8b49155f8014684d64c91742b465f65
susfs_version=v2.3.0
nomount_version=22
```

The ROM workflow validates kernel version, source commit, generated config, SUSFS header, and NoMount header before staging the kernel. The project maintainer has also reported that KPM, SUSFS, BakaSU, and NoMount are functioning together on the device after the required KPM setup. Treat this as a device-side maintainer report, not as a substitute for independent testing on other Deen variants.

## Full ROM status — not yet released

**There is no verified full LineageOS 19.1 ROM ZIP or ROM SHA-256 recorded here yet. Do not mistake the kernel ZIP above for a complete ROM package.**

The most recent attempt audited for this handoff was [ROM workflow run 41325836217 (#33)](https://github.com/isabe8499-oss/device_motorola_deen-22/actions/runs/41325836217). It stopped before source synchronization because the hosted runner returned:

```text
modprobe: FATAL: Module zram not found
in directory /lib/modules/6.8.0-1070-azure
```

This proves that the runner image did not provide a loadable zram module. It does **not** prove an Android/Soong out-of-memory failure. The preceding disk-space action had configured 8 GiB of disk swap. The workflow has been adjusted so zram is optional and its absence no longer aborts the job; Soong and ROM build parallelism remain limited to one. The next run must verify this correction before any claim about Soong or ROM compilation can be made.

Earlier attempt #32 reached the Soong bootstrap stage, but the runner ended with that step still marked in progress and its logs unavailable. Its exact termination cause remains unconfirmed.

## How to continue

1. Open the [Actions page](https://github.com/isabe8499-oss/device_motorola_deen-22/actions/workflows/build.yml) in the device repository.
2. Select the `lineage-19.1` branch and run **Build LineageOS 19.1 for Motorola One Deen**.
3. Confirm the optional zram step succeeds or emits a warning while retaining the disk swap.
4. Record the result of source sync, Soong bootstrap, and the ROM compilation as separate milestones.
5. Only call the ROM build successful when the workflow uploads a full ROM ZIP and a matching `SHA256SUMS.txt`.
6. Before distributing a release, independently inspect the ZIP, test installation and boot on the intended device variant, and document known hardware limitations and recovery instructions.

Build capacity is a real constraint. The workflow checks two separate filesystems before syncing and requires at least 70 GiB free on each and 190 GiB combined. These disk checks do not increase physical RAM. See [ROM_BUILD.md](ROM_BUILD.md) for the complete build layout and commands.

## What a useful bug report should include

- Exact device variant and codename (`deen` or other variant; do not assume they are interchangeable).
- ROM repository commit and workflow run URL.
- Kernel ZIP name and SHA-256, plus the kernel metadata above.
- Exact step that failed and the complete relevant log or uploaded diagnostic artifact.
- Whether the failure happened during sync, Soong bootstrap, ROM compilation, installation, first boot, or runtime.
- For device failures: recovery method, relevant logcat/dmesg excerpts, and a clear reproduction sequence.

Remove personal identifiers, account tokens, serial numbers, and other private data from logs before publishing them.

## Release and safety boundary

A successful compiler exit is not proof that the ROM boots or that every peripheral works. Test on the actual device, keep a known-good recovery/boot path, and make a complete backup before flashing. Do not advertise Play Integrity certification, bootloader-state spoofing, or compatibility that has not been independently verified.

Preserve upstream project notices and licenses when redistributing source or binaries. Contributions should include reproducible steps, exact source revisions, and test evidence.
