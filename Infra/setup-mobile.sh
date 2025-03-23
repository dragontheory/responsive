#!/bin/bash

ZIPFILE="D7460N-Responsive-Main-Final.zip"
TARGET_DIR="responsive-main"

if [ ! -f "$ZIPFILE" ]; then
  echo "ERROR: $ZIPFILE not found in current directory."
  exit 1
fi

echo "Unzipping $ZIPFILE..."
unzip -o "$ZIPFILE" -d .

cd "$TARGET_DIR" || exit 1

echo "Moving Git hook into place..."
mkdir -p .git/hooks
cp infra/pre-commit-hook-full-log-archive.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

chmod +x infra/backup-to-*.sh infra/auto-backup.sh

if [ ! -d ".git" ]; then
  echo "No Git repository found. Initializing..."
  git init
  git config user.name >/dev/null || git config user.name "D7460N Auto"
  git config user.email >/dev/null || git config user.email "d7460n@example.com"
  read -p "Enter GitHub remote URL (or leave blank to skip): " REMOTE_URL
  if [ ! -z "$REMOTE_URL" ]; then
    git remote add origin "$REMOTE_URL"
    echo "Remote set: $REMOTE_URL"
  fi
fi

echo "Committing automation setup..."
git add infra/ .git/hooks/pre-commit GOOGLE_DRIVE_SETUP.md
git commit -m "Integrate automation and backup scripts"
git push || echo "Push skipped or failed"

echo "Setup complete!"
