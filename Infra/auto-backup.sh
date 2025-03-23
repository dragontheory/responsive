#!/bin/bash
echo "[Auto-Backup] Starting GitHub + Google Drive backup..."
./infra/backup-to-github.sh
./infra/backup-to-gdrive.sh
echo "[Auto-Backup] All backups completed."
