# Commands

## install

```bash
atha install <pkg> [pkg2 ...]
```

Installs one or more packages. ATHA checks official repositories first, then falls back to AUR.

## remove

```bash
atha remove <pkg> [pkg2 ...]
```

Removes one or more installed packages.

## search

```bash
atha search <keyword>
```

Searches packages using pacman.

## update

```bash
atha update
```

Runs full system upgrade.

## list

```bash
atha list [installed|all]
```

Shows installed packages or a limited list of all packages.

## info

```bash
atha info <pkg>
```

Displays package metadata.

## doctor

```bash
atha doctor
```

Checks required dependencies and returns non-zero exit code if required tools are missing.
