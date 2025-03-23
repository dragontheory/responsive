# D7460N Responsive Main — Automation Integrated

This project is a fully integrated, modular, standards-based HTML/CSS architecture designed for maintainable, scalable, and accessible UI with zero framework dependencies.

## Features

- Modular folder structure using separation of concerns
- CSS-first architecture with `:has()`, custom tags, accessibility baked in
- Git pre-commit hook to auto-snapshot project state
- Automated backup to GitHub and Google Drive
- Mobile-ready setup via `setup-mobile.sh`

## Folder Structure

```
responsive-main/
├── infra/
│   ├── pre-commit-hook-full-log-archive.sh
│   ├── backup-to-github.sh
│   ├── backup-to-gdrive.sh
│   ├── auto-backup.sh
│   └── setup-mobile.sh
├── GOOGLE_DRIVE_SETUP.md
├── .gitignore
└── README.md
```

## Quick Start

1. Clone or unzip project.
2. Run `infra/setup-mobile.sh`
3. Follow prompts to set up Git and remotes.

## Backups

- Snapshots go in `/snapshots`
- Logs are saved in `/snapshots/logs`
- Monthly log archives saved as ZIP
- Backups pushed to:
  - GitHub repo (`d7460n-snapshots`)
  - Google Drive via `rclone`

## Git Hook

Auto-snapshots on commit:
- `infra/pre-commit-hook-full-log-archive.sh`
- Keeps last 10 snapshots
- Logs each commit with file count, size, deleted snapshots
