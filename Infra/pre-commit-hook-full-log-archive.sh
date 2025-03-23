#!/bin/bash
timestamp=$(date +"%Y%m%d-%H%M")
target="snapshots/D7460N-$timestamp"
logdir="snapshots/logs"
logfile="$logdir/$(date +%Y-%m-%d).log"

echo "Creating snapshot at $target..."
mkdir -p snapshots "$logdir"
cp -r . "$target"
rm -rf "$target/.git" "$target/snapshots" 2>/dev/null

SNAPSHOT_LIMIT=${SNAPSHOT_LIMIT:-10}
snapshots=( $(ls -1dt snapshots/D7460N-* 2>/dev/null) )
total_snapshots=${#snapshots[@]}
pruned=""

if [ "$total_snapshots" -gt "$SNAPSHOT_LIMIT" ]; then
  echo "Pruning old snapshots (limit: $SNAPSHOT_LIMIT)..."
  to_prune=( "${snapshots[@]:$SNAPSHOT_LIMIT}" )
  for snap in "${to_prune[@]}"; do
    echo " - Removing: $snap"
    rm -rf "$snap"
    pruned+="Removed: $snap\n"
  done
fi

file_count=$(find "$target" -type f | wc -l)
total_size=$(du -sh "$target" | cut -f1)
summary="\n[Snapshot @ $timestamp]\nCreated: $target\nFiles: $file_count\nSize: $total_size\n$pruned---\n"

echo -e "$summary" >> "$logfile"
month_archive="snapshots/archive-$(date +%Y-%m).zip"
find "$logdir" -name "*.log" ! -newermt "$(date +%Y-%m-01)" -exec zip -mj "$month_archive" {} +
