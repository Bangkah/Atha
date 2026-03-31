# Troubleshooting

## pacman: command not found

ATHA targets Arch Linux. Install and run ATHA on Arch.

## Permission denied while writing logs

ATHA writes to /tmp/atha.log when possible, then falls back to user cache:

- $XDG_CACHE_HOME/atha/atha.log
- ~/.cache/atha/atha.log

## Permission denied (publickey) while pushing to AUR

Add your SSH public key in your AUR account settings, then retry push.

## Color code shows as raw text

Make sure you run ATHA with bash and update to latest package version.
