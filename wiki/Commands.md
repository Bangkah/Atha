# Commands

## install

```bash
atha install [--dry-run] [--plan] [--yes] <pkg> [pkg2 ...]
```

Installs one or more packages. ATHA builds a plan first, checks official repositories, and falls back to AUR when required.

- `--plan` is decision analysis mode: shows install decisions with reasons, source selection, transaction simulation, and AUR reachability checks.
- `--dry-run` is execution simulation mode: shows exact commands that would run without modifying the system.

## remove

```bash
atha remove [--dry-run|--plan] [--yes] <pkg> [pkg2 ...]
```

Removes one or more installed packages.

- `--plan` shows remove decisions with reasons and transaction impact simulation.
- `--dry-run` shows exact remove commands that would execute and skips missing packages.

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

- `--plan` is decision analysis mode: shows which updates are available and why.
- `--dry-run` is execution simulation mode: shows update list and exact update command.

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
- Use `--dry-run` on install, remove, and update for safe previews.
- Use `--plan` to inspect planned actions before execution.
