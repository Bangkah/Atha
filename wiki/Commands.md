# Commands

## install

```bash
atha install [--dry-run] [--yes] <pkg> [pkg2 ...]
```

Installs one or more packages. ATHA builds an install plan first, checks official repositories, and falls back to AUR when required.

## remove

```bash
atha remove [--dry-run] [--yes] <pkg> [pkg2 ...]
```

Removes one or more installed packages.

## search

```bash
atha search <keyword>
```

Searches packages by keyword using pacman.

## update

```bash
atha update [--dry-run]
```

Runs a full system upgrade via pacman.

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

Checks required dependencies and returns a non-zero exit code when required tools are missing.

## history

```bash
atha history [--limit N] [--full]
```

Shows the recent ATHA operation timeline from the local history file.

## Notes

- Commands that modify system packages may require sudo privileges.
- AUR operations require build tooling such as git and makepkg.
- Use --dry-run on install, remove, and update for safe previews.
