# ATHA v2.2.3 Release Announcement

Date: 2026-04-01

ATHA v2.2.3 is now available.

This release focuses on command semantics clarity, stable UX, and stronger reviewer-facing differentiation between planning and simulation workflows.

## Highlights

- Strong separation of planning and simulation modes
  - `--plan` now emphasizes decision analysis (what and why)
  - `--dry-run` now emphasizes execution preview (what would run)
- Improved command consistency across install, remove, and update
- Expanded history audit capabilities
  - summary views
  - action/status filters
- Documentation refresh for professional release communication

## Why This Release Matters

ATHA is positioned as a safety and workflow layer for pacman.

This release reinforces that identity by making decision transparency explicit and reducing ambiguity between analysis and simulation modes.

## Upgrade

AUR users:

```bash
yay -Syu atha
```

Verify:

```bash
atha --help
atha install --plan vim
atha install --dry-run vim
atha history --summary --limit 10
atha doctor
```

## Maintainer Notes

- Keep `PKGBUILD` and `.SRCINFO` synchronized on every release.
- Prefer tagged source archives for reproducible package builds.

## Feedback

Technical feedback is welcome and appreciated.

- Repository: https://github.com/Bangkah/Atha
- AUR: https://aur.archlinux.org/packages/atha
