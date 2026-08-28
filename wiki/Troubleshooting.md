# Troubleshooting Guide

This guide covers common issues you might encounter while using ATHA and how to resolve them.

Whenever ATHA behaves unexpectedly, your first step should always be to run the built-in diagnostic tool:
```bash
atha doctor

```

---

## `pacman`: command not found

**Symptom:** Executing any ATHA command immediately fails stating `pacman` is missing.
**Solution:** ATHA strictly targets Arch Linux and its derivatives (Garuda, EndeavourOS, Manjaro). You must install and run ATHA on an Arch-based system where `pacman` is the native package manager.

## Permission denied while writing logs

**Symptom:** Errors appear stating ATHA cannot write to the log file.
**Solution:** ATHA attempts to write to `/tmp/atha.log` first. If that fails, it falls back to the user cache:

* `$XDG_CACHE_HOME/atha/atha.log`
* `~/.cache/atha/atha.log`

If log errors still appear, verify that the fallback directory is owned by and writable by your current user:

```bash
mkdir -p ~/.cache/atha
sudo chown -R $USER:$USER ~/.cache/atha

```

## `--plan` and `--dry-run` look similar

**Expected behavior:**

* `--plan` shows **decision analysis**: what will be installed, from where (Official vs AUR), download sizes, and why it was chosen.
* `--dry-run` shows **execution simulation**: the exact underlying bash commands that would run.

**Solution:** If both outputs look identical, you might be running an outdated version. Upgrade ATHA and retest:

```bash
yay -Syu atha
atha install --plan vim
atha install --dry-run vim

```

## Color codes show as raw text

**Symptom:** Terminal output displays raw ANSI escape sequences (e.g., `\033[1;31m`) instead of colored text.
**Solution:** ATHA automatically disables colors if it detects a non-interactive terminal or if the `NO_COLOR` environment variable is set.

* Make sure ATHA is executed within a standard `bash` TTY.
* If this happens only in one terminal profile, check your shell configuration files and `TERM` settings.

## `update` exits with an error

**Symptom:** Running `atha update` fails or exits prematurely.
**Solution:** Run these checks in order to isolate the issue:

```bash
atha doctor
sudo -v
pacman -V

```

If `atha doctor` reports a **database lock** (`/var/lib/pacman/db.lck`), ensure no other package manager is running, then safely remove it: `sudo rm /var/lib/pacman/db.lck`.

If dependency checks pass but the issue remains, include the latest log output when reporting a bug:

```bash
tail -n 50 /tmp/atha.log
tail -n 50 ~/.cache/atha/atha.log

```

## AUR installs an older version

**Symptom:** You just published or flagged an AUR update, but ATHA still pulls the old version.
**Solution:** If the AUR index is delayed, local package metadata may appear newer than remote. Wait a few minutes for AUR indexing to refresh and retry:

```bash
pacman -Qi atha
yay -Syu atha

```

## Permission denied (publickey) while pushing to AUR

*(Note: This applies to package maintainers and contributors)*
**Symptom:** Git push fails with SSH authentication errors when updating an AUR package.
**Solution:** Add your SSH public key in your AUR account settings, then retry the push.
Quick checks:

```bash
ssh -T aur@aur.archlinux.org
git remote -v

