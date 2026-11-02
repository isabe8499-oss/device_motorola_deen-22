# Deen ROM CI diagnostics

- Run: 41392459065 (attempt 1)
- Stage: soong-bootstrap
- UTC: 2026-11-02T05:29:08Z
- Workflow commit: d6513a2d96524c617560e4efd9d2a033e84dd289
- Runner: GitHub Actions 1000000953 / ubuntu22

## Memory and swap
               total        used        free      shared  buff/cache   available
Mem:            15Gi       6.1Gi       255Mi        35Mi       9.3Gi       9.2Gi
Swap:          8.0Gi       170Mi       7.8Gi
NAME      TYPE      SIZE USED PRIO
/dev/dm-0 partition   8G 170M   -2

## Memory pressure
some avg10=0.74 avg60=1.00 avg300=7.50 total=84065348
full avg10=0.51 avg60=0.80 avg300=6.25 total=69511015

## Cgroup memory counters

## Disk
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.5G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.5G  99% /

## Largest processes (RSS KiB)
    PID    PPID STAT COMMAND           RSS
  43290   43287 RNl  soong_build     5559672
  40717   40712 Sl   soong_ui        227060
   1990    1970 Sl   Runner.Worker   105776
   1835    1832 Sl   provjobd2761510 97676
   1970    1819 Sl   Runner.Listener 49680
    206       1 SLsl multipathd      44288
    768       1 Ss   php-fpm8.1      22480
    887       1 Sl   mono            18836
   2710       1 Ssl  packagekitd     18628
    778       1 Ssl  snapd           18068
   1261     786 Sl   python3         18032
    764       1 Ss   networkd-dispat 16844
    791       1 Ssl  containerd      16176
    971       1 Ssl  dockerd         16076
    162       1 S<s  systemd-journal 15684
    786       1 Ss   python3         13284
    514       1 Ss   systemd-resolve 13620
      1       0 Ss   systemd         13292
   1112     768 S    php-fpm8.1      10396

## Kernel OOM messages (may be restricted on hosted runners)

## Soong output markers
Not present: /home/runner/work/_temp/android/out/soong/build.ninja
Not present: /home/runner/work/_temp/android/out/soong/soong_build
2026-11-02 05:26:09.3593580160 0 .soong.kati_enabled
2026-11-02 05:26:35.2350807960 3128 dexpreopt.config
2026-11-02 05:26:35.2440807110 14500 soong.variables
2026-11-02 05:26:35.9880735000 15946 soong.environment.available

## ccache
Summary:
  Hits:               0 /    0
    Direct:           0 /    0
    Preprocessed:     0 /    0
  Misses:             0
    Direct:           0
    Preprocessed:     0
Primary storage:
  Hits:               0 /    0
  Misses:             0
  Cache size (GB): 0.00 / 8.00 (0.00 %)

Use the -v/--verbose option for more details.

## Last 70 lines of /home/runner/work/_temp/lineage-bootstrap.log
[ 84% 212/252] compile out/soong/.bootstrap/aidl-soong-rules/test/test.a
[ 84% 213/252] link out/soong/.bootstrap/aidl-soong-rules/test/test
[ 84% 214/252] test android/soong/aidl
[ 85% 215/252] compile out/soong/.bootstrap/aidl-soong-rules/pkg/android/soong/aidl.a
[ 85% 216/252] compile out/soong/.bootstrap/gki-soong-rules/test/android/soong/gki.a
[ 86% 217/252] compile out/soong/.bootstrap/gki-soong-rules/test/test.a
[ 86% 218/252] link out/soong/.bootstrap/gki-soong-rules/test/test
[ 86% 219/252] test android/soong/gki
[ 87% 220/252] compile out/soong/.bootstrap/gki-soong-rules/pkg/android/soong/gki.a
[ 87% 221/252] compile out/soong/.bootstrap/soong-art/pkg/android/soong/art.a
[ 88% 222/252] compile out/soong/.bootstrap/soong-bp2build/test/android/soong/bp2build.a
[ 88% 223/252] compile out/soong/.bootstrap/soong-bp2build/test/test.a
[ 88% 224/252] link out/soong/.bootstrap/soong-bp2build/test/test
[ 89% 225/252] test android/soong/bp2build
[ 89% 226/252] compile out/soong/.bootstrap/soong-bp2build/pkg/android/soong/bp2build.a
[ 90% 227/252] compile out/soong/.bootstrap/soong-sdk/test/android/soong/sdk.a
[ 90% 228/252] compile out/soong/.bootstrap/soong-sdk/test/test.a
[ 90% 229/252] link out/soong/.bootstrap/soong-sdk/test/test
[ 91% 230/252] test android/soong/sdk
[ 91% 231/252] compile out/soong/.bootstrap/soong-sdk/pkg/android/soong/sdk.a
[ 92% 232/252] compile out/soong/.bootstrap/soong-suite-harness/pkg/android/soong/tradefed/suite_harness.a
[ 92% 233/252] compile out/soong/.bootstrap/soong-sysprop/test/android/soong/sysprop.a
[ 92% 234/252] compile out/soong/.bootstrap/soong-sysprop/test/test.a
[ 93% 235/252] link out/soong/.bootstrap/soong-sysprop/test/test
[ 93% 236/252] test android/soong/sysprop
[ 94% 237/252] compile out/soong/.bootstrap/soong-sysprop/pkg/android/soong/sysprop.a
[ 94% 238/252] compile out/soong/.bootstrap/soong-selinux/pkg/android/soong/selinux.a
[ 94% 239/252] compile out/soong/.bootstrap/soong-wayland-protocol-codegen/pkg/android/soong/external/wayland-protocol.a
[ 95% 240/252] compile out/soong/.bootstrap/soong-xml/test/android/soong/xml.a
[ 95% 241/252] gotestmain out/soong/.bootstrap/soong-xml/test/test.go
[ 96% 242/252] compile out/soong/.bootstrap/soong-xml/test/test.a
[ 96% 243/252] link out/soong/.bootstrap/soong-xml/test/test
[ 96% 244/252] test android/soong/xml
[ 97% 245/252] compile out/soong/.bootstrap/soong-xml/pkg/android/soong/xml.a
[ 97% 246/252] create out/soong/.bootstrap/soong_build/gen/plugin.go
::notice::Soong bootstrap resource monitor at 2026-11-02T05:28:36Z
    971       1 dockerd         18708
   2710       1 packagekitd     18816
    778       1 snapd           18068
    764       1 networkd-dispat 17016
    162       1 systemd-journal 15692
   1112     768 php-fpm8.1      14204
   1111     768 php-fpm8.1      14092
    514       1 systemd-resolve 13628
      1       0 systemd         13336
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.6G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.6G  99% /
[ 98% 247/252] compile out/soong/.bootstrap/vintf-compatibility-matrix-soong-rules/pkg/android/soong/vintf-compatibility-matrix.a
[ 98% 248/252] compile out/soong/.bootstrap/xsdc-soong-rules/pkg/android/soong/xsdc.a
[ 98% 249/252] compile out/soong/.bootstrap/soong_build/obj/soong_build.a
[ 99% 250/252] link out/soong/.bootstrap/soong_build/obj/a.out
[ 99% 251/252] cp out/soong/.bootstrap/bin/soong_build
::notice::Soong bootstrap resource monitor at 2026-11-02T05:29:06Z
   1261     786 python3         18032
    764       1 networkd-dispat 16844
    791       1 containerd      16176
    971       1 dockerd         16076
    162       1 systemd-journal 15684
    786       1 python3         13284
    514       1 systemd-resolve 13620
      1       0 systemd         13292
   1112     768 php-fpm8.1      10396
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.5G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.5G  99% /
