# Command Reference

ATHA wraps standard `pacman` and AUR commands into intuitive, readable workflows. 

## install

```bash
atha install [--dry-run] [--plan] [--yes] <pkg> [pkg2 ...]

```

Installs one or more packages. ATHA evaluates official repositories first, groups them into a single efficient batch transaction, and seamlessly falls back to AUR compilation when needed.

* `--plan`: Performs decision analysis (what will be installed, from where, dependency impact, and download size) without applying changes.
* `--dry-run`: Previews the exact underlying commands that would run.
* `--yes`: Skips interactive confirmation prompts (passes `--noconfirm` to `pacman`).

## remove

```bash
atha remove [--dry-run|--plan] [--yes] <pkg> [pkg2 ...]

```

Removes one or more installed packages. Under the hood, ATHA uses `pacman -Rns` to cleanly remove the target packages along with their unneeded dependencies (orphans) and configuration files.

* `--plan`: Explains removal decisions and calculates the estimated storage space that will be freed.
* `--dry-run`: Previews remove commands and automatically skips non-installed targets.
* `--yes`: Skips interactive confirmation prompts.

## search

```bash
atha search <keyword>

```

Searches for packages by keyword.
ATHA queries the official repositories first. If no results are found, it automatically queries the AUR via RPC API.

## update

```bash
atha update [--dry-run|--plan] [--yes]

```

Runs a full system upgrade for official repository packages.

* `--plan`: Safely checks for updates using `checkupdates` (preventing partial upgrade risks) and displays a reasoning-oriented summary. Also warns about outdated AUR/local packages.
* `--dry-run`: Previews update commands without modifying the system.
* `--yes`: Skips interactive confirmation prompts.

## list

```bash
atha list [installed|explicit|aur|all] [--limit N]

```

Lists packages available or currently installed on the system.

* `installed`: All packages currently on the system (default).
* `explicit`: Packages manually installed by the user.
* `aur`: Foreign packages installed from the AUR.
* `all`: Available packages in the repositories (requires `--limit`).
* `--limit N`: Restricts the output to *N* lines for readability.

## info

```bash
atha info <pkg>

```

Displays detailed package metadata. ATHA checks the official sync database first, falls back to the local database, and finally queries the AUR RPC API if the package is foreign.

## doctor

```bash
atha doctor

```

Diagnoses your ATHA and system environment health. Exits with a non-zero code when critical tools are missing.

Doctor checks runtime readiness:

* Required dependencies (`pacman`, `git`, `sudo`, `makepkg`).
* Stale `pacman` database lock state (`/var/lib/pacman/db.lck`).
* Writable cache and state directory paths.
* DNS reachability for `archlinux.org` and `aur.archlinux.org`.

## history

```bash
atha history [--limit N] [--full|--timeline|--summary] [--action <name>] [--status <name>]

```

Shows recent ATHA operations from the local history state.

* `--timeline`: Prints concise, chronological events.
* `--summary`: Prints aggregated counts by action and status.
* `--action`: Filters events by action (`install`, `remove`, `update`).
* `--status`: Filters events by status (`success`, `failed`, `planned`, `cancelled`, `skipped`).
* `--limit N`: Limits the output to the most recent *N* matched entries (default: 20).

## Operational Notes

* Commands that modify system packages require `sudo` privileges (ATHA handles privilege escalation natively).
* AUR build operations require `base-devel`, `git`, and `makepkg`.
* AUR metadata fetching (`search` and `info`) requires `curl` and `jq`.
* Safe update planning requires `pacman-contrib`.
* Use `--plan` when you want analysis, decision context, and size estimations.
* Use `--dry-run` when you strictly want an execution preview.
