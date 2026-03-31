# User Feedback Loop

This page defines how ATHA collects, evaluates, and ships user feedback.

## Purpose

ATHA is maintained as a safety and workflow layer for pacman. The feedback loop ensures updates are driven by real user workflows and technical evidence.

## Loop Stages

1. Capture
- Collect feedback from GitHub issues, AUR comments, and direct user reports.

2. Reproduce
- Reproduce the issue using the same commands and environment details.
- Confirm expected behavior versus actual behavior.

3. Classify
- Safety: risks, unintended package changes, confirmation flow problems.
- Transparency: unclear output, missing plan details, weak status signaling.
- Auditability: missing history entries, weak traceability, unclear logs.

4. Prioritize
- High: data/system risk, failed package operations, broken critical command.
- Medium: degraded UX, confusing output, non-blocking workflow defects.
- Low: wording, formatting, minor documentation gaps.

5. Ship
- Implement focused fixes in small releases.
- Document changes in [Release Notes](Release-Notes.md).
- Validate with the original reproduction steps.

## Feedback Submission Template

When reporting an issue, include the following:

- ATHA version (`atha --help` header)
- Command used
- Expected behavior
- Actual behavior
- Full relevant output or error
- Environment details (Arch version, shell, terminal)

Example:

```text
Version: ATHA v2.2.0
Command: atha install --plan vim
Expected: dependency and size preview
Actual: missing size section
Output: <paste output>
Environment: Arch Linux, bash 5.x, Alacritty
```

## Feedback Channels

- GitHub Issues: https://github.com/Bangkah/Atha/issues
- AUR package comments: https://aur.archlinux.org/packages/atha

## Maintainer Response Policy

- Keep responses technical, concise, and respectful.
- Confirm reproduction status first.
- Provide ETA only when scope is understood.
- Close feedback with release reference once shipped.
