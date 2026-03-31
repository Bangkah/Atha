# Troubleshooting

## pacman: command not found

ATHA targets Arch Linux. Install and run ATHA on Arch-based systems where pacman is available.

## Permission denied while writing logs

ATHA writes to /tmp/atha.log when possible, then falls back to user cache:

- $XDG_CACHE_HOME/atha/atha.log
- ~/.cache/atha/atha.log

If log errors still appear, verify the fallback path is writable by your current user.

## Permission denied (publickey) while pushing to AUR

Add your SSH public key in your AUR account settings, then retry push.

Quick checks:

```bash
ssh -T aur@aur.archlinux.org
git remote -v
```

## Color code shows as raw text

Make sure ATHA is executed with bash and update to the latest package version.

## update exits with error

Run these checks in order:

```bash
atha doctor
sudo -v
pacman -V
```

If dependency checks pass but the issue remains, include the latest log output when reporting:

```bash
tail -n 100 /tmp/atha.log
tail -n 100 ~/.cache/atha/atha.log
```
