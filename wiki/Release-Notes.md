# Release Notes

This page tracks user-visible changes for ATHA releases.

## v2.2.0 (2026-04-01)

### Added
- Install simulation mode via `atha install --plan <pkg>` with dependency and size preview for official packages.
- Timeline mode via `atha history --timeline` for chronological operation review.

### Changed
- Strengthened README value positioning around safety, transparency, and auditability.
- Updated command documentation for plan and timeline workflows.

## v2.1.0 (2026-04-01)

### Added
- New command: atha history for local operation timeline.
- Dry-run mode for install, remove, and update commands.
- Install planning summary before package changes.

### Changed
- Added confirmation and safer execution flow for package operations.
- Expanded command and reviewer-facing documentation.

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
