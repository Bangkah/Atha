# Release Notes

This page tracks user-visible changes for ATHA releases.

Latest release announcement: [v3.0.0](https://www.google.com/search?q=Release-Announcement-v3.0.0.md)

## v3.0.0 (2026-08-29)

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

## v2.2.3 (2026-04-01)

### Added

* Clearer decision-analysis sections for `--plan` across install, remove, and update.
* Stronger history audit utilities with summary and action/status filtering.

### Changed

* Enforced behavioral split between `--plan` and `--dry-run` to reduce overlap and improve reviewer clarity.
* Refined help and command documentation for consistency and operational readability.

### Packaging

* AUR release synchronized to `2.2.3-1`.

## v2.2.2 (2026-04-01)

### Fixed

* Fixed installed command dispatching so packaged `atha` correctly executes scripts from `/usr/lib/atha/commands`.
* Removed a regression where installed builds attempted to run non-existent paths under `/usr/sbin/commands`.

## v2.2.1 (2026-04-01)

### Added

* Enhanced install planning output with dependency simulation, source grouping, and total download estimate.
* Added history filters and summary mode (`--action`, `--status`, `--summary`) for stronger audit workflows.
* Expanded doctor intelligence checks for path writability, pacman lock state, and DNS reachability.

### Changed

* Standardized plan and dry-run output across install, remove, and update commands.
* Improved command preview consistency for safer package operations.

## v2.2.0 (2026-04-01)

### Added

* Install simulation mode via `atha install --plan <pkg>` with dependency and size preview for official packages.
* Timeline mode via `atha history --timeline` for chronological operation review.

### Changed

* Strengthened README value positioning around safety, transparency, and auditability.
* Updated command documentation for plan and timeline workflows.

## v2.1.0 (2026-04-01)

### Added

* New command: atha history for local operation timeline.
* Dry-run mode for install, remove, and update commands.
* Install planning summary before package changes.

### Changed

* Added confirmation and safer execution flow for package operations.
* Expanded command and reviewer-facing documentation.

## v2.0.3 (2026-03-31)

### Fixed

* Fixed ANSI color rendering in help output.
* Improved logging fallback when /tmp/atha.log is not writable.

### Changed

* Updated installer and package metadata for v2.0.3.
* Synced AUR package metadata to 2.0.3-1.

## v2.0.2 (2026-03-31)

### Fixed

* Stabilized update flow and sudo validation handling.
* Added line-ending guard for shell scripts.

### Changed

* Improved installation and command documentation.

## v2.0.1 (2026-03-31)

### Changed

* Locked package source to tagged release archives.
* Updated package metadata for reproducible builds.

## v2.0.0 (2026-03-31)

### Added

* Modular command architecture with shared libraries.
* New commands: search, update, list, info, doctor.
* Logging utilities and consistent CLI output helpers.
* AUR fallback installation flow.

### Changed

* Improved command dispatcher and help output.
* Strengthened command validation and operational checks.

## Upgrade Guidance

* Users installing from AUR should run `yay -Syu atha`.
* Maintainers should ensure `.SRCINFO` is updated whenever `PKGBUILD` changes.