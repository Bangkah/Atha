# Changelog

All notable changes to this project are documented in this file.

## [3.0.0] - 2026-08-29

### Added

* **AUR RPC API Fallback:** `search` and `info` commands now automatically query the AUR RPC API (via `curl` and `jq`) when packages are missing from official repositories.
* **Advanced List Filtering:** `list` command now supports specific category filters (`installed`, `explicit`, `aur`, `all`) and a dynamic `--limit` flag.
* **Automated Workflow Propagation:** The `--yes` flag now properly passes `--noconfirm` to `pacman` across `install`, `remove`, and `update` commands for uninterrupted execution.

### Changed

* **Safe Update Checks:** `update` now utilizes `checkupdates` (from `pacman-contrib`) to safely check for pending updates without syncing databases prematurely, eliminating partial upgrade risks.
* **Clean Orphan Removal:** `remove` now defaults to `pacman -Rns` under the hood to cleanly remove target packages along with unneeded orphaned dependencies and configuration files.

### Fixed

* Fixed a bug in `history` where the `--limit` flag would truncate log entries *before* applying `--action` or `--status` filters.
* Fixed `doctor` incorrectly creating dummy directories during path write-permission checks.

### Packaging

* Removed `base-devel` from PKGBUILD `depends` array in strict compliance with AUR packaging guidelines.
* AUR release synchronized to `3.0.0-1`.

## [2.2.3] - 2026-04-01

### Added

* Strengthened decision transparency for `--plan` with clearer reasoning-oriented sections in install, remove, and update workflows.
* Expanded history audit capabilities with summary and action/status filters for faster post-operation analysis.

### Changed

* Separated `--plan` (decision analysis) and `--dry-run` (execution simulation) UX across core commands to avoid feature overlap.
* Improved command help and documentation wording for plan/dry-run behavior consistency.

## [2.2.2] - 2026-04-01

### Fixed

* Fixed installed dispatcher path resolution so packaged binaries correctly load commands from `/usr/lib/atha/commands`.
* Resolved command execution failures where installed `atha` incorrectly tried to execute scripts from `/usr/sbin/commands`.

## [2.2.1] - 2026-04-01

### Added

* Enhanced install planning output with dependency simulation, source grouping, and total download estimate.
* Added history filters and summary mode via `atha history --action`, `--status`, and `--summary`.
* Expanded doctor checks with runtime path validation, lock-state check, and DNS reachability diagnostics.

### Changed

* Standardized dry-run and plan UX across install, remove, and update flows.
* Improved preview output consistency and non-destructive execution transparency.

## [2.2.0] - 2026-04-01

### Added

* Install simulation mode via `atha install --plan <pkg>` with dependency and size preview for official packages.
* Timeline output mode via `atha history --timeline` for chronological operation review.

### Changed

* Expanded value positioning in README with identity pillars and feature comparison.
* Updated command documentation to include new plan and timeline workflows.

## [2.1.0] - 2026-04-01

### Added

* New `history` command for viewing local operation timeline.
* Dry-run mode for `install`, `remove`, and `update` commands.
* Install planning summary before package operations.
* Reviewer response template in wiki for AUR communication.

### Changed

* Improved confirmation and safe execution flow for package-changing commands.
* Expanded README and wiki docs with value positioning and feature details.

## [2.0.3] - 2026-03-31

### Fixed

* Fixed ANSI color rendering in help output so escape codes are displayed correctly.
* Improved logging fallback to avoid permission errors when `/tmp/atha.log` is not writable.

### Changed

* Updated installer and package metadata for release `v2.0.3`.
* Synced AUR package metadata to `2.0.3-1`.

## [2.0.2] - 2026-03-31

### Fixed

* Stabilized update flow and sudo validation handling.
* Added line-ending guard for shell scripts to prevent CRLF parsing issues.

### Changed

* Improved documentation for installation and command usage.

## [2.0.1] - 2026-03-31

### Changed

* Locked package source to tagged release archives for reproducible builds.
* Updated package metadata for stable release distribution.

## [2.0.0] - 2026-03-31

### Added

* Modular command architecture with shared libraries.
* New commands: `search`, `update`, `list`, `info`, `doctor`.
* Logging utilities and consistent CLI output helpers.
* AUR fallback installation flow.

### Changed

* Improved command dispatcher and help output.
* Strengthened command validation and operational checks.