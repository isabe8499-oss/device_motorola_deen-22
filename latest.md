# Deen ROM CI diagnostics

- Run: 41840161584 (attempt 1)
- Stage: soong-bootstrap
- UTC: 2026-11-04T13:56:22Z
- Workflow commit: 457a5cc0383d38e237edf6d5c93c2ca9bae5819b
- Runner: GitHub Actions 1000000957 / ubuntu22

## Memory and swap
               total        used        free      shared  buff/cache   available
Mem:            15Gi       549Mi       294Mi        32Mi        14Gi        14Gi
Swap:          8.0Gi       144Mi       7.9Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 144.5M   -2

## Memory pressure
some avg10=6.06 avg60=11.25 avg300=5.24 total=24717677
full avg10=5.92 avg60=10.54 avg300=4.83 total=22818690

## Cgroup memory counters

## Disk
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/mapper/buildvg-buildlv ext4   95G   70G   25G  74% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  142G  3.8G  98% /
/dev/mapper/buildvg-buildlv ext4   95G   70G   25G  74% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  142G  3.8G  98% /

## Output directory usage
4.0K	/home/runner/work/_temp/android-out

## Largest processes (RSS KiB)
    PID    PPID STAT COMMAND           RSS
   1674    1671 Sl   provjobd7326334 104092
   1816    1797 Sl   Runner.Worker   91216
   1797    1658 Sl   Runner.Listener 52012
    203       1 SLsl multipathd      44240
    645       1 Ssl  containerd      28644
    620       1 Ssl  snapd           19260
    801       1 Sl   mono            18956
   1332     644 Sl   python3         18008
    596       1 Ss   php-fpm8.1      17112
    593       1 Ss   networkd-dispat 17244
    752       1 Ssl  dockerd         16012
   2555       1 Ssl  packagekitd     16136
    162       1 S<s  systemd-journal 15392
    644       1 Ss   python3         14460
    437       1 Ss   systemd-resolve 13924
      1       0 Ss   systemd         13392
    815       1 Ss   systemd          9916
    698       1 Ss   sshd             9028
    435       1 Ss   systemd-network  8428

## Kernel OOM messages (may be restricted on hosted runners)

## Soong output markers
Not present: /home/runner/work/_temp/android-out/soong/build.ninja
Not present: /home/runner/work/_temp/android-out/soong/soong_build

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
  Cache size (GB): 0.00 / 2.00 (0.00 %)

Use the -v/--verbose option for more details.

## Last 70 lines of /home/runner/work/_temp/lineage-bootstrap.log
Bootstrap log: /home/runner/work/_temp/lineage-bootstrap.log
Resource log: /home/runner/work/_temp/lineage-bootstrap-resource.log
Runner CPUs: 4
Configured Go parallelism: GOMAXPROCS=1; Make/Ninja parallelism: 1
=== Resource snapshot 2026-11-04T13:56:22Z ===
               total        used        free      shared  buff/cache   available
Mem:            15Gi       532Mi       204Mi        32Mi        14Gi        14Gi
Swap:          8.0Gi       143Mi       7.9Gi
NAME      TYPE      SIZE USED PRIO
/dev/dm-0 partition   8G 143M   -2
some avg10=6.06 avg60=11.25 avg300=5.24 total=24705249
full avg10=5.92 avg60=10.54 avg300=4.83 total=22806517
--- cgroup memory ---
--- kernel OOM evidence ---
--- largest processes (RSS KiB) ---
    PID    PPID COMMAND           RSS
   1674    1671 provjobd7326334 104088
   1816    1797 Runner.Worker   91188
   1797    1658 Runner.Listener 52012
    203       1 multipathd      44240
    645       1 containerd      30464
    620       1 snapd           19260
    801       1 mono            18956
   1332     644 python3         18428
    596       1 php-fpm8.1      17720
    593       1 networkd-dispat 17244
    752       1 dockerd         16008
   2555       1 packagekitd     16136
    644       1 python3         15480
    162       1 systemd-journal 15392
    437       1 systemd-resolve 13924
      1       0 systemd         13392
    815       1 systemd          9916
    698       1 sshd             9024
    435       1 systemd-network  8428
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/mapper/buildvg-buildlv ext4   95G   70G   25G  74% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/mapper/buildvg-buildlv ext4   95G   70G   25G  74% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  142G  3.8G  98% /
/dev/root                   ext4  146G  142G  3.8G  98% /
===== Phase 1/2: environment setup and Soong bootstrap =====
