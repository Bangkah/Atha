# ATHA

![ATHA Logo](assets/branding/atha-logo.svg)

[![AUR version](https://img.shields.io/aur/version/atha)](https://aur.archlinux.org/packages/atha)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

ATHA is a safety and workflow layer for pacman on Arch Linux.

It is designed to improve package-operation safety, decision transparency, and operational auditability while preserving native Arch behavior.

## Project Identity

ATHA is not a pacman replacement and not a yay clone.

ATHA focuses on:

- safer package workflows before execution
- clearer operational decisions and execution previews
- local history for post-operation auditing

## Core Pillars

1. Safety
- Execution simulation with dry-run mode
- Confirmation layer for package-changing operations

2. Transparency
- Decision analysis with plan mode
- Source selection visibility (official, AUR, skip)
- Transaction simulation for install planning

3. Auditability
- Structured local history
- Timeline and summary views
- Action and status filtering

## Why ATHA Exists

Daily package operations are often too opaque for routine use.

ATHA addresses this by making package workflows explicit before execution, traceable afterward, and consistent across commands.

## Feature Comparison

| Feature | pacman | yay | ATHA |
| --- | --- | --- | --- |
| Workflow-level dry-run | No | Limited | Yes |
| Decision plan mode | No | Limited | Yes |
| Plan explanation layer | No | No | Yes |
| Install transaction simulation | No | No | Yes |
| Local operation timeline | No | No | Yes |
| History summary and filters | No | No | Yes |
| Built-in environment doctor | No | No | Yes |

## Requirements

- Arch Linux
- bash
- pacman
- sudo
- git (for AUR fallback)
- makepkg and base-devel (for AUR builds)

## Installation

### AUR (recommended)

```bash
yay -S atha
```

### One-line installer (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

### One-line installer (wget)

```bash
wget -qO- https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

## Quick Start

```bash
atha doctor
atha install --plan vim
atha install --dry-run vim
atha update --plan
atha history --timeline --limit 20
```

## Command Reference

```bash
atha install [--plan|--dry-run] [--yes] <pkg> [pkg2 ...]
atha remove [--plan|--dry-run] [--yes] <pkg> [pkg2 ...]
atha search <keyword>
atha update [--plan|--dry-run]
atha list [installed|all]
atha info <pkg>
atha doctor
atha history [--limit N] [--full|--timeline|--summary] [--action NAME] [--status NAME]
atha --help
```

Mode definitions:

- plan: decision analysis (what will happen and why)
- dry-run: execution simulation (what would run)
- yes: skip confirmation prompts when supported

## Operational Notes

- install skips packages that are already installed
- install falls back to AUR when package is not in official repositories
- remove skips packages that are not installed
- update plan and dry-run are non-destructive checks
- doctor exits non-zero when required dependencies are missing
- list all output is intentionally limited for readability

## Logs and History Paths

Logs:

- primary: /tmp/atha.log
- fallback: $XDG_CACHE_HOME/atha/atha.log
- fallback: ~/.cache/atha/atha.log

History:

- $XDG_STATE_HOME/atha/history.log
- ~/.local/state/atha/history.log

## Documentation

- Wiki Home: [wiki/Home.md](wiki/Home.md)
- Installation Guide: [wiki/Installation.md](wiki/Installation.md)
- Command Reference: [wiki/Commands.md](wiki/Commands.md)
- Troubleshooting: [wiki/Troubleshooting.md](wiki/Troubleshooting.md)
- Release Notes: [wiki/Release-Notes.md](wiki/Release-Notes.md)
- Release Announcement (v2.2.3): [wiki/Release-Announcement-v2.2.3.md](wiki/Release-Announcement-v2.2.3.md)
- Brand Guidelines: [wiki/Brand-Guidelines.md](wiki/Brand-Guidelines.md)
- User Feedback Loop: [wiki/User-Feedback-Loop.md](wiki/User-Feedback-Loop.md)
- AUR Reviewer Response: [wiki/AUR-Reviewer-Response.md](wiki/AUR-Reviewer-Response.md)

## Project Links

- GitHub: https://github.com/Bangkah/Atha
- AUR Package: https://aur.archlinux.org/packages/atha
- Issue Tracker: https://github.com/Bangkah/Atha/issues

## Branding Assets

- Full logo: [assets/branding/atha-logo.svg](assets/branding/atha-logo.svg)
- Full logo (dark): [assets/branding/atha-logo-dark.svg](assets/branding/atha-logo-dark.svg)
- Full logo (light): [assets/branding/atha-logo-light.svg](assets/branding/atha-logo-light.svg)
- Mark/icon: [assets/branding/atha-mark.svg](assets/branding/atha-mark.svg)
- Avatar: [assets/branding/atha-avatar.svg](assets/branding/atha-avatar.svg)
- Favicon: [assets/branding/atha-favicon.svg](assets/branding/atha-favicon.svg)
- Social banner: [assets/branding/atha-banner.svg](assets/branding/atha-banner.svg)

Optional PNG export on Arch Linux:

```bash
sudo pacman -S librsvg
rsvg-convert -h 512 -w 512 assets/branding/atha-mark.svg > assets/branding/atha-mark-512.png
rsvg-convert -h 512 -w 512 assets/branding/atha-avatar.svg > assets/branding/atha-avatar-512.png
rsvg-convert -h 630 -w 1200 assets/branding/atha-banner.svg > assets/branding/atha-banner-1200x630.png
```

## License

MIT License. See [LICENSE](LICENSE).
