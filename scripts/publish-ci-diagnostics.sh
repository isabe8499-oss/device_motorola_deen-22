#!/usr/bin/env bash
# Publish small, periodic build diagnostics to a dedicated Git branch.
# This survives abrupt loss of the hosted runner, unlike end-of-job artifacts.
set -Eeuo pipefail

stage="${1:-unknown}"
log_file="${2:-}"
: "${RUNNER_TEMP:?RUNNER_TEMP is required}"
: "${GITHUB_RUN_ID:?GITHUB_RUN_ID is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"

diag_root="$RUNNER_TEMP/deen-ci-diagnostics-repo"
remote_branch="ci-diagnostics/run-$GITHUB_RUN_ID"
android_top="${ANDROID_TOP:-$PWD}"
out_dir="${OUT_DIR:-$android_top/out}"
sleep_pid=""

if ! command -v gh >/dev/null 2>&1 || [[ -z "${GH_TOKEN:-}" ]]; then
  echo "::warning::GitHub CLI or GH_TOKEN unavailable; persistent diagnostics disabled."
  exit 0
fi

mkdir -p "$diag_root"
if [[ ! -d "$diag_root/.git" ]]; then
  git -C "$diag_root" init --quiet --initial-branch=diagnostics
  git -C "$diag_root" config user.name "github-actions[bot]"
  git -C "$diag_root" config user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git -C "$diag_root" remote add origin "https://github.com/$GITHUB_REPOSITORY.git"
fi

if ! gh auth setup-git >/dev/null 2>&1; then
  echo "::warning::Could not configure GitHub CLI credentials; persistent diagnostics disabled."
  exit 0
fi

publish_snapshot() {
  local report="$diag_root/latest.md"
  {
    echo "# Deen ROM CI diagnostics"
    echo
    echo "- Run: $GITHUB_RUN_ID (attempt ${GITHUB_RUN_ATTEMPT:-1})"
    echo "- Stage: $stage"
    echo "- UTC: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "- Workflow commit: ${GITHUB_SHA:-unknown}"
    echo "- Runner: ${RUNNER_NAME:-unknown} / ${ImageOS:-unknown}"
    echo
    echo "## Memory and swap"
    free -h 2>&1 || true
    swapon --show 2>&1 || true
    echo
    echo "## Memory pressure"
    cat /proc/pressure/memory 2>/dev/null || true
    echo
    echo "## Cgroup memory counters"
    for f in /sys/fs/cgroup/memory.current /sys/fs/cgroup/memory.max /sys/fs/cgroup/memory.events /sys/fs/cgroup/memory.swap.current /sys/fs/cgroup/memory.swap.max /sys/fs/cgroup/memory/memory.failcnt /sys/fs/cgroup/memory/memory.oom_control; do
      if [[ -r "$f" ]]; then
        echo "### $f"
        cat "$f" 2>/dev/null || true
      fi
    done
    echo
    echo "## Disk"
    df -hT "$android_top" "$out_dir" "${GITHUB_WORKSPACE:-$PWD}" / 2>&1 || true
    echo
    echo "## Output directory usage"
    du -sh "$out_dir" 2>&1 || true
    echo
    echo "## Largest processes (RSS KiB)"
    ps -eo pid,ppid,stat,comm,rss --sort=-rss 2>/dev/null | head -20 || true
    echo
    echo "## Kernel OOM messages (may be restricted on hosted runners)"
    dmesg -T 2>/dev/null | grep -Ei 'out of memory|oom-kill|killed process' | tail -20 || true
    echo
    echo "## Soong output markers"
    for f in "$out_dir/soong/build.ninja" "$out_dir/soong/soong_build"; do
      if [[ -e "$f" ]]; then
        stat -c '%n | %s bytes | modified %y' "$f" 2>/dev/null || true
      else
        echo "Not present: $f"
      fi
    done
    if [[ -d "$out_dir/soong" ]]; then
      find "$out_dir/soong" -maxdepth 1 -type f -printf '%TY-%Tm-%Td %TH:%TM:%TS %s %f\n' 2>/dev/null | sort | tail -20 || true
    fi
    echo
    if command -v ccache >/dev/null 2>&1; then
      echo "## ccache"
      ccache -s 2>&1 || true
      echo
    fi
    if [[ -n "$log_file" && -f "$log_file" ]]; then
      echo "## Last 70 lines of $log_file"
      tail -n 70 "$log_file" 2>/dev/null || true
    fi
  } > "$report"

  git -C "$diag_root" add latest.md
  if ! git -C "$diag_root" diff --cached --quiet; then
    git -C "$diag_root" commit --quiet -m "CI diagnostics: $stage run $GITHUB_RUN_ID"
  fi
  if ! git -C "$diag_root" push --quiet --force origin "HEAD:refs/heads/$remote_branch"; then
    echo "::warning::Could not push persistent diagnostics to $remote_branch; local snapshot retained."
    return 1
  fi
  echo "::notice::Persistent diagnostics updated: $GITHUB_REPOSITORY/tree/$remote_branch"
}

publish_snapshot || true

finish() {
  trap - TERM INT
  if [[ -n "$sleep_pid" ]]; then
    kill "$sleep_pid" 2>/dev/null || true
    wait "$sleep_pid" 2>/dev/null || true
  fi
  publish_snapshot || true
  exit 0
}
trap finish TERM INT

while true; do
  sleep 180 &
  sleep_pid=$!
  wait "$sleep_pid" || true
  sleep_pid=""
  publish_snapshot || true
done
