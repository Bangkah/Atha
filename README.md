# ATHA

![ATHA Logo](assets/branding/atha-logo.svg)

[![AUR version](https://img.shields.io/aur/version/atha)](https://aur.archlinux.org/packages/atha)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

ATHA is a lightweight package manager wrapper for Arch Linux, built on top of pacman.
It provides a clean command interface for daily package operations while preserving native Arch behavior.

ATHA positioning:

- Safety and workflow layer for pacman.
- Focused on safety, transparency, and auditability.
- Not a replacement for pacman or yay.

## Why ATHA Exists

ATHA was created to simplify daily package operations while keeping full control of Arch Linux behavior.

- Reduces command complexity for common workflows.
- Improves readability with consistent output and clear status messages.
- Adds a predictable workflow with planning, validation, and history.

## Problems ATHA Solves

- Package actions often run as black-box operations for everyday users.
- It is difficult to review what will happen before install.
- Native command history is not tailored for package-operation auditing.

## Core Pillars

1. Safety
  - Dry-run mode for install, remove, and update.
  - Confirmation layer before package-changing operations.
2. Transparency
  - Install planning before execution.
  - Dependency and size simulation with `atha install --plan <pkg>`.
3. Auditability
  - Structured operation history via `atha history`.
  - Timeline view via `atha history --timeline`.

## Overview

ATHA is designed for users who want a simple, focused CLI without replacing the Arch toolchain.

- Uses pacman for official repositories.
- Falls back to AUR build flow when a package is not found in official repos.
- Keeps command usage minimal and predictable.
- Includes built-in environment checks through doctor command.

## Features

- Core commands: install, remove, search, update, list, info, doctor, history.
- Automatic source detection:
  - Official repositories via pacman.
  - AUR fallback via git clone and makepkg -si.
- Execution planning before installation (official, AUR, or skip).
- Plan mode with dependency simulation for official packages.
- Dry-run mode for install, remove, and update.
- Confirmation layer for package-changing actions.
- Consistent colored output and progress indicator.
- Input validation and actionable error messages.
- Operation history tracking for traceability and review.

## What Makes ATHA Different

ATHA is not only a command alias wrapper. It adds workflow-level behavior around pacman.

- Install planning that previews source and action per package before execution.
- Install simulation tree preview with `--plan`.
- Built-in dry-run safety for install, remove, and update operations.
- Local operation history through `atha history` for auditability.
- Chronological timeline view through `atha history --timeline`.
- Unified command interface with strict validation and readable output.
- Built-in system validation with atha doctor.

## Feature Comparison

| Feature | pacman | yay | ATHA |
| --- | --- | --- | --- |
| Dry-run on workflow commands | No | Limited | Yes |
| Install planning preview | No | Limited | Yes |
| Plan mode with dependency simulation | No | No | Yes |
| Operation history timeline | No | No | Yes |
| Safety confirmation layer | Limited | Limited | Yes |

## Requirements

- Arch Linux
- bash
- pacman
- sudo
- git (required for AUR fallback installs)
- makepkg (required for AUR fallback builds)

## Installation

### AUR (recommended)

```bash
yay -S atha
```

### One-line install (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

### One-line install (wget)

```bash
wget -qO- https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

## Quick Start

```bash
atha install vim
atha search python
atha list installed
atha info bash
atha doctor
atha history --limit 20
atha update
```

## Command Reference

```bash
atha install <pkg> [pkg2 ...]
atha install --plan <pkg> [pkg2 ...]
atha remove <pkg> [pkg2 ...]
atha search <keyword>
atha update [--dry-run]
atha list [installed|all]
atha info <pkg>
atha doctor
atha history [--limit N] [--full|--timeline]
atha --help
```

Options on modifying commands:

- --dry-run: preview without changing system
- --plan: preview dependencies and planned install actions
- --yes: skip confirmation prompts when supported

## Operational Behavior

- install skips packages that are already installed.
- install automatically tries AUR if package is missing in official repositories.
- install prints an execution plan before running.
- remove prompts for confirmation unless --yes is used.
- update supports dry-run preview mode.
- list all output is intentionally limited for readability.
- doctor exits with non-zero status when required dependencies are missing.
- history stores operation timeline in user state directory.

## Logging

ATHA writes logs to:

- /tmp/atha.log when writable
- fallback: $XDG_CACHE_HOME/atha/atha.log or ~/.cache/atha/atha.log

ATHA stores operation history at:

- $XDG_STATE_HOME/atha/history.log or ~/.local/state/atha/history.log

## Troubleshooting

- pacman: command not found
  - ATHA must run on Arch Linux.
- Permission denied (publickey) while publishing to AUR
  - Add the correct SSH public key in your AUR account settings.
- Frequent sudo prompts
  - Expected for privileged operations such as install, remove, and update.

## User Feedback Loop

ATHA is maintained with a practical feedback loop so improvements are based on real usage, not assumptions.

1. Use ATHA in daily package workflows.
2. Report issues with reproducible steps and command output.
3. Classify feedback into safety, transparency, or auditability.
4. Ship focused fixes in small releases with clear changelog entries.
5. Verify improvements with the same user scenarios.

When reporting feedback, include:

- ATHA version (`atha --help` header)
- Command used
- Expected behavior
- Actual behavior
- Relevant output/error message

Feedback channels:

- GitHub Issues: https://github.com/Bangkah/Atha/issues
- AUR package comments: https://aur.archlinux.org/packages/atha

## Documentation

- Wiki Home: [wiki/Home.md](wiki/Home.md)
- Release Announcement (v2.2.0): [wiki/Release-Announcement-v2.2.0.md](wiki/Release-Announcement-v2.2.0.md)
- Installation Guide: [wiki/Installation.md](wiki/Installation.md)
- Commands Guide: [wiki/Commands.md](wiki/Commands.md)
- Troubleshooting Guide: [wiki/Troubleshooting.md](wiki/Troubleshooting.md)
- Release Notes: [wiki/Release-Notes.md](wiki/Release-Notes.md)
- Brand Guidelines: [wiki/Brand-Guidelines.md](wiki/Brand-Guidelines.md)
- AUR Reviewer Response: [wiki/AUR-Reviewer-Response.md](wiki/AUR-Reviewer-Response.md)
- User Feedback Loop: [wiki/User-Feedback-Loop.md](wiki/User-Feedback-Loop.md)

## Project Links

- AUR: https://aur.archlinux.org/packages/atha
- GitHub: https://github.com/Bangkah/Atha

## Branding Assets

- Full logo (SVG): [assets/branding/atha-logo.svg](assets/branding/atha-logo.svg)
- Full logo dark (SVG): [assets/branding/atha-logo-dark.svg](assets/branding/atha-logo-dark.svg)
- Full logo light (SVG): [assets/branding/atha-logo-light.svg](assets/branding/atha-logo-light.svg)
- Icon mark (SVG): [assets/branding/atha-mark.svg](assets/branding/atha-mark.svg)
- Avatar (SVG): [assets/branding/atha-avatar.svg](assets/branding/atha-avatar.svg)
- Favicon (SVG): [assets/branding/atha-favicon.svg](assets/branding/atha-favicon.svg)
- Social banner (SVG): [assets/branding/atha-banner.svg](assets/branding/atha-banner.svg)

Optional PNG export on Arch Linux:

```bash
sudo pacman -S librsvg
rsvg-convert -h 512 -w 512 assets/branding/atha-mark.svg > assets/branding/atha-mark-512.png
rsvg-convert -h 512 -w 512 assets/branding/atha-avatar.svg > assets/branding/atha-avatar-512.png
rsvg-convert -h 630 -w 1200 assets/branding/atha-banner.svg > assets/branding/atha-banner-1200x630.png
```

## License

MIT License. See [LICENSE](LICENSE).
