#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d-%H%M")
ZIPFILE="snapshots-backup-$TIMESTAMP.zip"
REPO_URL="git@github.com:your-username/d7460n-snapshots.git"
WORKDIR=".backup-github-tmp"

echo "Zipping current snapshots..."
zip -r "$ZIPFILE" snapshots/

echo "Preparing temp Git repo..."
rm -rf "$WORKDIR"
mkdir "$WORKDIR"
cd "$WORKDIR"
git init
git remote add origin "$REPO_URL"
git checkout -b backups

cp ../"$ZIPFILE" .
git add "$ZIPFILE"
git commit -m "Snapshot backup $TIMESTAMP"
git push origin backups

cd ..
rm -rf "$WORKDIR"
echo "Backed up to GitHub repo: $REPO_URL"
