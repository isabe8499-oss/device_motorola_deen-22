# Deen ROM CI diagnostics

- Run: 41770234180 (attempt 1)
- Stage: soong-bootstrap
- UTC: 2026-11-04T04:14:43Z
- Workflow commit: e15253729a6a237fa343632aeaffd9e1ca91ed94
- Runner: GitHub Actions 1000000956 / ubuntu22

## Memory and swap
               total        used        free      shared  buff/cache   available
Mem:            15Gi       5.9Gi       297Mi        36Mi       9.4Gi       9.3Gi
Swap:          8.0Gi       118Mi       7.9Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 118.8M   -2

## Memory pressure
some avg10=6.99 avg60=2.50 avg300=2.85 total=26374000
full avg10=6.19 avg60=2.19 avg300=2.33 total=22047410

## Cgroup memory counters

## Disk
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.5G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.5G  99% /

## Output directory usage
667M	/home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out

## Largest processes (RSS KiB)
    PID    PPID STAT COMMAND           RSS
  43269   43266 RNl  soong_build     5393016
  40707   40702 Sl   soong_ui        164076
   1817    1814 Sl   provjobd2916622 104584
   1986    1968 Sl   Runner.Worker   90144
   1968    1801 Sl   Runner.Listener 47648
    204       1 SLsl multipathd      44268
    747       1 Ss   php-fpm8.1      32064
   1216     790 Sl   python3         19732
    935       1 Ssl  dockerd         19336
    894       1 Sl   mono            18260
   2692       1 Ssl  packagekitd     18464
    762       1 Ssl  snapd           16580
    745       1 Ss   networkd-dispat 16764
    797       1 Ssl  containerd      17028
    163       1 S<s  systemd-journal 16500
    790       1 Ss   python3         15696
   1034     747 S    php-fpm8.1      15188
   1010     747 S    php-fpm8.1      15128
    505       1 Ss   systemd-resolve 13624

## Kernel OOM messages (may be restricted on hosted runners)

## Soong output markers
Not present: /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/build.ninja
Not present: /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/soong_build
2026-11-04 04:11:44.9627228400 0 .soong.kati_enabled
2026-11-04 04:12:04.5578432570 3202 dexpreopt.config
2026-11-04 04:12:04.5698433300 14584 soong.variables
2026-11-04 04:12:05.3138479130 16701 soong.environment.available

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
/dev/root                   ext4  146G  143G  2.8G  99% /
[ 84% 213/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/aidl-soong-rules/test/test
[ 84% 214/252] test android/soong/aidl
[ 85% 215/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/aidl-soong-rules/pkg/android/soong/aidl.a
[ 85% 216/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/gki-soong-rules/test/android/soong/gki.a
[ 86% 217/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/gki-soong-rules/test/test.a
[ 86% 218/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/gki-soong-rules/test/test
[ 86% 219/252] test android/soong/gki
[ 87% 220/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/gki-soong-rules/pkg/android/soong/gki.a
[ 87% 221/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-art/pkg/android/soong/art.a
[ 88% 222/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-bp2build/test/android/soong/bp2build.a
[ 88% 223/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-bp2build/test/test.a
[ 88% 224/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-bp2build/test/test
[ 89% 225/252] test android/soong/bp2build
[ 89% 226/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-bp2build/pkg/android/soong/bp2build.a
[ 90% 227/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sdk/test/android/soong/sdk.a
[ 90% 228/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sdk/test/test.a
[ 90% 229/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sdk/test/test
[ 91% 230/252] test android/soong/sdk
[ 91% 231/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sdk/pkg/android/soong/sdk.a
[ 92% 232/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-suite-harness/pkg/android/soong/tradefed/suite_harness.a
[ 92% 233/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sysprop/test/android/soong/sysprop.a
[ 92% 234/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sysprop/test/test.a
[ 93% 235/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sysprop/test/test
[ 93% 236/252] test android/soong/sysprop
[ 94% 237/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-sysprop/pkg/android/soong/sysprop.a
[ 94% 238/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-selinux/pkg/android/soong/selinux.a
[ 94% 239/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-wayland-protocol-codegen/pkg/android/soong/external/wayland-protocol.a
[ 95% 240/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-xml/test/android/soong/xml.a
[ 95% 241/252] gotestmain /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-xml/test/test.go
[ 96% 242/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-xml/test/test.a
[ 96% 243/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-xml/test/test
[ 96% 244/252] test android/soong/xml
::notice::Soong bootstrap resource monitor at 2026-11-04T04:14:12Z
[ 97% 245/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong-xml/pkg/android/soong/xml.a
    762       1 snapd           23276
    894       1 mono            19672
   2692       1 packagekitd     18724
   1010     747 php-fpm8.1      17952
   1034     747 php-fpm8.1      17952
    745       1 networkd-dispat 17528
    163       1 systemd-journal 17588
    505       1 systemd-resolve 13640
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.7G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.7G  99% /
[ 97% 246/252] create /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong_build/gen/plugin.go
[ 98% 247/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/vintf-compatibility-matrix-soong-rules/pkg/android/soong/vintf-compatibility-matrix.a
[ 98% 248/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/xsdc-soong-rules/pkg/android/soong/xsdc.a
[ 98% 249/252] compile /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong_build/obj/soong_build.a
[ 99% 250/252] link /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/soong_build/obj/a.out
[ 99% 251/252] cp /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/.bootstrap/bin/soong_build
::notice::Soong bootstrap resource monitor at 2026-11-04T04:14:42Z
    762       1 snapd           16580
    745       1 networkd-dispat 16764
    797       1 containerd      17028
    163       1 systemd-journal 16500
    790       1 python3         15696
   1034     747 php-fpm8.1      15188
   1010     747 php-fpm8.1      15128
    505       1 systemd-resolve 13624
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  2.5G  99% /
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   24G   72G  25% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  2.5G  99% /
