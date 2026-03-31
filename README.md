# ATHA

Lightweight package manager wrapper for Arch Linux.

ATHA provides a cleaner CLI experience for common package tasks while still using the Arch toolchain (`pacman`, `makepkg`, AUR git repos).

## Features

- Clean command set: `install`, `remove`, `search`, `update`, `list`, `info`, `doctor`
- Automatic source detection for install:
	- Official repository via `pacman`
	- AUR fallback via `git clone` + `makepkg -si`
- Colored and consistent CLI output
- Basic operation logging to `/tmp/atha.log`

## Requirements

- Arch Linux
- `bash`
- `pacman`
- `sudo`
- `git` (for AUR installs)
- `makepkg` (for AUR builds)

## Install

From AUR:

```bash
yay -S atha
```

Via curl:

```bash
curl -fsSL https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

Via wget:

```bash
wget -qO- https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

## Usage

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

## Examples

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

- `atha install` skips packages that are already installed.
- If package is not found in official repo, ATHA tries AUR automatically.
- `atha list all` shows the first 50 repository entries.
- `atha doctor` exits with non-zero status if dependencies are missing.

## Logs

ATHA writes basic logs to:

```text
/tmp/atha.log
```

## Troubleshooting

- `pacman: command not found`
	- Run ATHA only on Arch Linux.
- `Permission denied (publickey)` when publishing AUR package
	- Add your correct SSH public key in AUR Account settings.
- `sudo` prompt keeps appearing
	- This is expected for privileged operations like install, remove, and update.

## License

MIT
