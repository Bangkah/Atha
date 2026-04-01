# Installation

This guide covers all supported installation methods for ATHA on Arch Linux.

## Requirements

- Arch Linux
- bash
- pacman
- sudo
- tar
- one of: git, curl, or wget
- makepkg (required for AUR fallback builds)

## Recommended Method (AUR)

Install ATHA using your preferred AUR helper:

```bash
yay -S atha
```

Note:
- Do not run AUR helpers as root.

## One-Line Installer (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

## One-Line Installer (wget)

```bash
wget -qO- https://raw.githubusercontent.com/Bangkah/Atha/main/install.sh | bash
```

## Verify Installation

```bash
atha --help
atha doctor
```

Expected result:
- `atha --help` prints the command reference.
- `atha doctor` reports whether required system dependencies are available.
- `atha install --plan vim` shows decision analysis output.

## Update ATHA

If ATHA was installed via AUR:

```bash
yay -Syu atha
```

## Uninstall ATHA

```bash
sudo pacman -Rns atha
```

## Notes

- AUR package metadata may take a few minutes to refresh after maintainer pushes.
- For security, review installer scripts before running one-line commands in production environments.
