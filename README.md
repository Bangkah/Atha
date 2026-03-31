# ATHA - Lightweight Package Manager Wrapper for Arch Linux

[![AUR version](https://img.shields.io/aur/version/atha)](https://aur.archlinux.org/packages/atha)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

ATHA is a simple and fast Arch Linux package manager wrapper built on top of pacman.
It helps with daily package operations through a cleaner CLI while keeping native Arch behavior.

Keywords: Arch Linux, AUR helper, pacman wrapper, package manager CLI, yay alternative.

## Why ATHA

- Minimal command surface for daily package tasks.
- Official repo + AUR install flow in one command.
- Consistent CLI output with status icons and color.
- Built-in health check command for environment validation.

## Features

- Command set: install, remove, search, update, list, info, doctor.
- Automatic install source detection:
  - Official repositories via pacman.
  - AUR fallback via git clone + makepkg -si.
- Progress output and basic operation logging.
- Helpful validation for missing dependencies and invalid usage.

## Requirements

- Arch Linux
- bash
- pacman
- sudo
- git (for AUR installs)
- makepkg (for AUR builds)

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

## Command Reference

```bash
atha install <pkg> [pkg2 ...]
atha remove <pkg> [pkg2 ...]
atha search <keyword>
atha update
atha list [installed|all]
atha info <pkg>
atha doctor
atha --help
```

## Usage Examples

```bash
atha install vim
atha install wget curl
atha remove nano
atha search python
atha list installed
atha info bash
atha doctor
atha update
```

## Behavior Notes

- atha install skips packages that are already installed.
- If a package is not found in official repositories, ATHA tries AUR automatically.
- atha list all shows a limited result set for readability.
- atha doctor returns non-zero exit code if required dependencies are missing.

## Logs

ATHA writes logs to:

- /tmp/atha.log when writable.
- Fallback: $XDG_CACHE_HOME/atha/atha.log or ~/.cache/atha/atha.log.

## Troubleshooting

- pacman: command not found
  - Run ATHA on Arch Linux.
- Permission denied (publickey) while publishing AUR
  - Add the correct SSH public key in your AUR account settings.
- Frequent sudo prompts
  - Normal for privileged actions such as install, remove, and update.

## Project Links

- AUR: https://aur.archlinux.org/packages/atha
- GitHub: https://github.com/Bangkah/Atha

## License

MIT
