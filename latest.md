# Deen ROM CI diagnostics

- Run: 41392459065 (attempt 1)
- Stage: soong-bootstrap
- UTC: 2026-11-02T05:26:06Z
- Workflow commit: d6513a2d96524c617560e4efd9d2a033e84dd289
- Runner: GitHub Actions 1000000953 / ubuntu22

## Memory and swap
               total        used        free      shared  buff/cache   available
Mem:            15Gi       603Mi       238Mi        33Mi        14Gi        14Gi
Swap:          8.0Gi       157Mi       7.8Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 157.3M   -2

## Memory pressure
some avg10=2.79 avg60=13.07 avg300=13.84 total=83327183
full avg10=2.69 avg60=11.49 avg300=11.56 total=68863706

## Cgroup memory counters

## Disk
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  3.2G  98% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  3.2G  98% /

## Largest processes (RSS KiB)
    PID    PPID STAT COMMAND           RSS
   1835    1832 Sl   provjobd2761510 99748
   1990    1970 Sl   Runner.Worker   86500
    206       1 SLsl multipathd      44288
   1970    1819 Sl   Runner.Listener 39940
    791       1 Ssl  containerd      38840
    768       1 Ss   php-fpm8.1      35236
   1261     786 Sl   python3         25840
    971       1 Ssl  dockerd         25216
    778       1 Ssl  snapd           23868
    786       1 Ss   python3         21664
    887       1 Sl   mono            18848
   2710       1 Ssl  packagekitd     19012
    764       1 Ss   networkd-dispat 17576
   1111     768 S    php-fpm8.1      16604
   1112     768 S    php-fpm8.1      16604
    162       1 S<s  systemd-journal 15920
    514       1 Ss   systemd-resolve 13652
      1       0 Ss   systemd         13336
  40139   40126 Dl   go              10828

## Kernel OOM messages (may be restricted on hosted runners)

## Soong output markers
Not present: /home/runner/work/_temp/android/out/soong/build.ninja
Not present: /home/runner/work/_temp/android/out/soong/soong_build

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
=== Resource snapshot 2026-11-02T05:26:06Z ===
               total        used        free      shared  buff/cache   available
Mem:            15Gi       597Mi       291Mi        33Mi        14Gi        14Gi
Swap:          8.0Gi       158Mi       7.8Gi
NAME      TYPE      SIZE   USED PRIO
/dev/dm-0 partition   8G 158.6M   -2
some avg10=2.79 avg60=13.07 avg300=13.84 total=83323517
full avg10=2.69 avg60=11.49 avg300=11.56 total=68861000
--- cgroup memory ---
--- kernel OOM evidence ---
--- largest processes (RSS KiB) ---
    PID    PPID COMMAND           RSS
   1835    1832 provjobd2761510 99744
   1990    1970 Runner.Worker   84744
    206       1 multipathd      44288
   1970    1819 Runner.Listener 39940
    791       1 containerd      38840
    768       1 php-fpm8.1      35236
   1261     786 python3         25840
    971       1 dockerd         25216
    778       1 snapd           23868
    786       1 python3         21664
    887       1 mono            18848
   2710       1 packagekitd     19012
    764       1 networkd-dispat 17576
   1111     768 php-fpm8.1      16604
   1112     768 php-fpm8.1      16604
    162       1 systemd-journal 15920
    514       1 systemd-resolve 13652
      1       0 systemd         13336
    910       1 systemd         10084
--- storage ---
Filesystem                  Type  Size  Used Avail Use% Mounted on
/dev/root                   ext4  146G  143G  3.2G  98% /
/dev/mapper/buildvg-buildlv ext4   95G   23G   72G  24% /home/runner/work/device_motorola_deen-22/device_motorola_deen-22
/dev/root                   ext4  146G  143G  3.2G  98% /
===== Phase 1/2: environment setup and Soong bootstrap =====
