#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d-%H%M")
ZIPFILE="snapshots-backup-$TIMESTAMP.zip"
echo "Zipping current snapshots..."
zip -r "$ZIPFILE" snapshots/
echo "Uploading to Google Drive..."
rclone copy "$ZIPFILE" gdrive:d7460n-snapshots
echo "Google Drive backup complete: $ZIPFILE"
