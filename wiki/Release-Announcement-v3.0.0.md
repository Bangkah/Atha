# ATHA v3.0.0 Release Announcement

We are thrilled to announce the official release of **ATHA v3.0.0**, a major milestone for our safety and workflow layer for `pacman` on Arch Linux.

This release represents a significant maturation of the codebase, focusing on enhanced AUR integration, smarter transaction safety, deeper auditability, and a completely polished user experience.

---

##  Whats New in v3.0.0

### 1. Robust AUR RPC API Fallback

Searching for packages or fetching metadata (`atha search` and `atha info`) is no longer limited to official repositories. v3.0.0 introduces seamless native integration with the **AUR RPC API** (via `curl` and `jq`), allowing you to discover, inspect, and transition to AUR packages effortlessly when they aren't found in sync databases.

### 2. Advanced List Filtering & Management

The `atha list` command has been completely overhauled to give you precise control over your system inventory:

* `atha list installed`: Lists all system packages.
* `atha list explicit`: Targets user-installed packages (`-Qe`).
* `atha list aur`: Isolates foreign/AUR packages (`-Qm`).
* `atha list all --limit N`: Safely previews repository packages with custom line constraints.

### 3. Safer System Updates with `checkupdates`

System upgrades via `atha update` now prioritize safety by integrating with `checkupdates` (from `pacman-contrib`). This ensures you can inspect pending updates without syncing databases prematurely, completely eliminating the risk of accidental partial upgrades.

### 4. Cleaner Deletions with Orphan Removal (`-Rns`)

Under the hood, `atha remove` has been upgraded to utilize `pacman -Rns` by default. This ensures that when you remove a package, any orphaned dependencies and leftover configuration files are cleanly purged alongside it, keeping your Arch system pristine.

### 5. Streamlined Automation (`--yes` support)

Automation scripts and power users rejoice: the `--yes` flag now properly propagates `--noconfirm` down to `pacman` across `install`, `remove`, and `update` commands, allowing for smooth, uninterrupted non-interactive execution when desired.

---

## Bug Fixes & Refinements

* **History Filtering Bug Fix:** Resolved an issue where using `--limit` would truncate history logs *before* applying `--action` or `--status` filters, ensuring accurate audit results.
* **Smart Doctor Diagnostics:** Fixed `atha doctor` incorrectly creating dummy directories during path write-permission checks.
* **Packaging Compliance:** Stripped `base-devel` from the PKGBUILD dependencies array, aligning strictly with official Arch Linux packaging guidelines.

---

## Upgrading & Installation

If you are installing ATHA for the first time:

```bash
git clone https://aur.archlinux.org/atha.git
cd atha
makepkg -si

```

If you are upgrading an existing installation via your AUR helper:

```bash
yay -Syu atha
```

Thank you to everyone who tested, reported issues, and contributed feedback. Keep your systems safe, stay transparent, and happy coding!
