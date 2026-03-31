# Release Notes

This page tracks user-visible changes for ATHA releases.

## v2.0.3 (2026-03-31)

### Fixed
- Fixed ANSI color rendering in help output.
- Improved logging fallback when /tmp/atha.log is not writable.

### Changed
- Updated installer and package metadata for v2.0.3.
- Synced AUR package metadata to 2.0.3-1.

## v2.0.2 (2026-03-31)

### Fixed
- Stabilized update flow and sudo validation handling.
- Added line-ending guard for shell scripts.

### Changed
- Improved installation and command documentation.

## v2.0.1 (2026-03-31)

### Changed
- Locked package source to tagged release archives.
- Updated package metadata for reproducible builds.

## v2.0.0 (2026-03-31)

### Added
- Modular command architecture with shared libraries.
- New commands: search, update, list, info, doctor.
- Logging utilities and consistent CLI output helpers.
- AUR fallback installation flow.

### Changed
- Improved command dispatcher and help output.
- Strengthened command validation and operational checks.

## Upgrade Guidance

- Users installing from AUR should run `yay -Syu atha`.
- Maintainers should ensure `.SRCINFO` is updated whenever `PKGBUILD` changes.
