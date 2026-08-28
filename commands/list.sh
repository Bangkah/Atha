#!/bin/bash

# ATHA List Command
# List installed or available packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

LIST_TYPE="installed"
LIMIT=50

while [ $# -gt 0 ]; do
    case "$1" in
        installed|all|explicit|aur)
            LIST_TYPE="$1"
            ;;
        --limit)
            shift
            if [ -n "$1" ] && [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
                LIMIT="$1"
            fi
            ;;
        *)
            die "Invalid list type or option: $1 (use: installed|explicit|aur|all)"
            ;;
    esac
    shift
done

print_info "atha - safety and workflow layer for pacman"
log "List requested: $LIST_TYPE (limit=$LIMIT)"

case $LIST_TYPE in
    installed)
        print_processing "Listing all installed packages"
        echo ""
        pacman -Q
        ;;
    explicit)
        print_processing "Listing explicitly installed packages (user-installed)"
        echo ""
        pacman -Qe
        ;;
    aur)
        print_processing "Listing foreign/AUR packages"
        echo ""
        pacman -Qm
        ;;
    all)
        print_processing "Listing repository packages (limit $LIMIT)"
        echo ""
        pacman -Sl | head -n "$LIMIT"
        echo ""
        print_info "Showing first $LIMIT packages (use 'atha list all --limit N' for more)"
        ;;
    *)
        die "Invalid list type: $LIST_TYPE"
        ;;
esac