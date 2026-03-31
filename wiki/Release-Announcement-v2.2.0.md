# ATHA v2.2.0 Release Announcement

Date: 2026-04-01

ATHA v2.2.0 is now available.

This release focuses on project identity and measurable workflow value on top of pacman, with improvements around safety, transparency, and auditability.

## Highlights

- Install plan mode: `atha install --plan <pkg>`
  - Simulates install path and shows dependency and size preview for official packages.
- History timeline view: `atha history --timeline`
  - Shows chronological package operation events.
- Documentation and positioning updates
  - Clear project identity as a safety and workflow layer for pacman.

## Why This Release Matters

ATHA is not intended to replace pacman or yay.

ATHA provides a workflow layer that improves:

- Safety: dry-run and confirmation support.
- Transparency: planning and previews before changes.
- Auditability: operation history and timeline output.

## Upgrade

AUR users:

```bash
yay -Syu atha
```

Verify:

```bash
atha --help
atha install --plan vim
atha history --timeline
```

## Notes for Maintainers

- Package metadata and source tags are aligned for reproducible releases.
- Keep `.SRCINFO` in sync whenever `PKGBUILD` is updated.

## Feedback

Project feedback and technical suggestions are welcome.

- Repository: https://github.com/Bangkah/Atha
- AUR: https://aur.archlinux.org/packages/atha
