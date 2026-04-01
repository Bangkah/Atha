# Commands

## install

```bash
atha install [--dry-run] [--plan] [--yes] <pkg> [pkg2 ...]
```

Installs one or more packages. ATHA evaluates official repositories first and falls back to AUR when needed.

- `--plan` performs decision analysis: what will be installed, from where, and why.
- `--dry-run` performs execution simulation: which commands would run, without applying changes.

## remove

```bash
atha remove [--dry-run|--plan] [--yes] <pkg> [pkg2 ...]
```

Removes one or more installed packages.

- `--plan` explains removal decisions and expected impact.
- `--dry-run` previews remove commands and skips non-installed targets.

## search

```bash
atha search <keyword>
```

Searches packages by keyword using pacman.

## update

```bash
atha update [--dry-run|--plan]
```

Runs a full system upgrade via pacman.

- `--plan` shows update availability and reasoning-oriented summary.
- `--dry-run` previews update commands without modifying the system.

## list

```bash
atha list [installed|all]
```

Shows installed packages or a limited list of all available packages.

## info

```bash
atha info <pkg>
```

Displays package metadata from repositories.

## doctor

```bash
atha doctor
```

Checks required dependencies and returns non-zero exit code when required tools are missing.

Doctor also checks runtime readiness:

- pacman lock state
- writable cache/state paths
- DNS reachability for archlinux.org and aur.archlinux.org

## history

```bash
atha history [--limit N] [--full|--timeline|--summary] [--action <name>] [--status <name>]
```

Shows recent ATHA operations from local history state.

- `--timeline` prints concise chronological events.
- `--summary` prints counts by action and status.
- `--action` filters events by action (`install`, `remove`, `update`).
- `--status` filters events by status (`success`, `failed`, `planned`, `cancelled`, `skipped`).

## Notes

- Commands that modify system packages may require sudo privileges.
- AUR operations require build tooling such as `git` and `makepkg`.
- Use `--plan` when you want analysis and decision context.
- Use `--dry-run` when you want execution preview only.
