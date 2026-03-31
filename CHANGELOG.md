# Changelog

All notable changes to this project are documented in this file.

## [2.0.3] - 2026-03-31

### Fixed
- Fixed ANSI color rendering in help output so escape codes are displayed correctly.
- Improved logging fallback to avoid permission errors when `/tmp/atha.log` is not writable.

### Changed
- Updated installer and package metadata for release `v2.0.3`.
- Synced AUR package metadata to `2.0.3-1`.

## [2.0.2] - 2026-03-31

### Fixed
- Stabilized update flow and sudo validation handling.
- Added line-ending guard for shell scripts to prevent CRLF parsing issues.

### Changed
- Improved documentation for installation and command usage.

## [2.0.1] - 2026-03-31

### Changed
- Locked package source to tagged release archives for reproducible builds.
- Updated package metadata for stable release distribution.

## [2.0.0] - 2026-03-31

### Added
- Modular command architecture with shared libraries.
- New commands: `search`, `update`, `list`, `info`, `doctor`.
- Logging utilities and consistent CLI output helpers.
- AUR fallback installation flow.

### Changed
- Improved command dispatcher and help output.
- Strengthened command validation and operational checks.
