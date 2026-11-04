# Deen ROM CI diagnostics

- Run: 41770234180 (attempt 1)
- Stage: soong-bootstrap
- UTC: 2026-11-04T04:11:42Z
- Workflow commit: e15253729a6a237fa343632aeaffd9e1ca91ed94
- Runner: GitHub Actions 1000000956 / ubuntu22

## Memory and swap
               total        used        free      shared  buff/cache   available
Mem:            15Gi       636Mi       235Mi        32Mi        14Gi        14Gi
Swap:          8.0Gi       100Mi       7.9Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 100.3M   -2

## Memory pressure
some avg10=1.11 avg60=5.79 avg300=4.33 total=24320043
full avg10=0.98 avg60=4.81 avg300=3.46 total=20203825

## Cgroup memory counters

## Disk
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  3.2G  98% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  3.2G  98% /

## Output directory usage
32K	/home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out

## Largest processes (RSS KiB)
    PID    PPID STAT COMMAND           RSS
   1817    1814 Sl   provjobd2916622 105884
   1986    1968 Sl   Runner.Worker   87020
    747       1 Ss   php-fpm8.1      45852
    204       1 SLsl multipathd      44268
    797       1 Ssl  containerd      39160
   1968    1801 Sl   Runner.Listener 33652
   1216     790 Sl   python3         28356
    935       1 Ssl  dockerd         23708
    790       1 Ss   python3         23740
    762       1 Ssl  snapd           21436
    894       1 Sl   mono            19672
   2692       1 Ssl  packagekitd     18724
   1010     747 S    php-fpm8.1      17952
   1034     747 S    php-fpm8.1      17952
    745       1 Ss   networkd-dispat 17528
    163       1 S<s  systemd-journal 17588
    505       1 Ss   systemd-resolve 13640
      1       0 Ss   systemd         13244
  40134   40121 Dl   go              11132

## Kernel OOM messages (may be restricted on hosted runners)

## Soong output markers
Not present: /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/build.ninja
Not present: /home/runner/work/device_motorola_deen-22/device_motorola_deen-22/android-out/soong/soong_build

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
Bootstrap log: /home/runner/work/_temp/lineage-bootstrap.log
Resource log: /home/runner/work/_temp/lineage-bootstrap-resource.log
Runner CPUs: 4
Configured Go parallelism: GOMAXPROCS=1; Make/Ninja parallelism: 1
=== Resource snapshot 2026-11-04T04:11:41Z ===
               total        used        free      shared  buff/cache   available
Mem:            15Gi       627Mi       290Mi        31Mi        14Gi        14Gi
Swap:          8.0Gi       100Mi       7.9Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 100.5M   -2
some avg10=1.36 avg60=5.99 avg300=4.36 total=24318885
full avg10=1.20 avg60=4.97 avg300=3.48 total=20203036
--- cgroup memory ---
--- kernel OOM evidence ---
--- largest processes (RSS KiB) ---
    PID    PPID COMMAND           RSS
   1817    1814 provjobd2916622 105848
   1986    1968 Runner.Worker   86148
    747       1 php-fpm8.1      45852
    204       1 multipathd      44268
    797       1 containerd      39160
   1968    1801 Runner.Listener 33652
   1216     790 python3         28356
    935       1 dockerd         23708
    790       1 python3         23740
    762       1 snapd           21436
    894       1 mono            19672
   2692       1 packagekitd     18724
   1010     747 php-fpm8.1      17952
   1034     747 php-fpm8.1      17952
    745       1 networkd-dispat 17528
    163       1 systemd-journal 17588
    505       1 systemd-resolve 13640
      1       0 systemd         13244
    902       1 systemd          9516
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  3.2G  98% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  3.2G  98% /
===== Phase 1/2: environment setup and Soong bootstrap =====
