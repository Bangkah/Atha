# User Feedback Loop

This page defines how ATHA collects, evaluates, and integrates user feedback. 

## Purpose

ATHA is maintained as a safety and workflow layer for `pacman`. The feedback loop ensures that future updates, bug fixes, and feature additions are driven by real user workflows and solid technical evidence.

## Loop Stages

1. **Capture**
   - Collect feedback from GitHub issues, AUR package comments, and direct user reports.
2. **Reproduce**
   - Replicate the issue using the provided commands and environment details.
   - Confirm expected behavior versus actual behavior.
3. **Classify**
   - **Safety:** Risks to system stability, unintended package changes, or confirmation flow bypasses.
   - **Transparency:** Unclear output, missing `--plan` details, or weak status signaling.
   - **Auditability:** Missing history entries, weak traceability, or corrupted logs.
4. **Prioritize**
   - **High:** Data/system risk, failed core package operations, broken critical commands (e.g., `update` failing).
   - **Medium:** Degraded UX, confusing output, non-blocking workflow defects.
   - **Low:** Wording, text formatting, or minor documentation gaps.
5. **Ship**
   - Implement focused fixes in small, iterative releases.
   - Document changes comprehensively in the [Release Notes](Release-Notes.md).
   - Validate the fix against the original reproduction steps.

## Feedback Submission Template

When reporting an issue or requesting a feature, please include the following details to speed up the reproduction phase:

- **ATHA version** (Check the header of `atha --help`)
- **Command used**
- **Expected behavior**
- **Actual behavior**
- **Full relevant output or error**
- **Environment details** (OS, shell, terminal)

**Example:**
```text
Version: ATHA v2.2.3
Command: atha install --plan vim
Expected: Dependency impact and download size preview
Actual: Missing download size section for official packages
Output: <paste terminal output here>
Environment: Garuda Linux, bash 5.2, Alacritty

```

## Feedback Channels

* **GitHub Issues:** [github.com/Bangkah/Atha/issues](https://github.com/Bangkah/Atha/issues)
* **AUR Package Comments:** [aur.archlinux.org/packages/atha](https://aur.archlinux.org/packages/atha)

## Maintainer Response Policy

* Keep responses technical, concise, and respectful.
* Confirm the reproduction status before suggesting workarounds.
* Provide an ETA only when the scope of the fix is fully understood.
* Close the feedback loop or issue with a direct reference to the release version once shipped.

