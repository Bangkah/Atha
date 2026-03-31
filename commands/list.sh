#!/bin/bash

# ATHA List Command
# List installed or available packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

LIST_TYPE=${1:-installed}

print_info "atha - safety and workflow layer for pacman"
log "List requested: $LIST_TYPE"

case $LIST_TYPE in
    installed)
        print_processing "Listing installed packages"
        echo ""
        pacman -Q
        ;;
    all)
        print_processing "Listing repository packages"
        echo ""
        pacman -Sl | head -50
        print_info "Showing first 50 packages (use pacman -Sl to see all)"
        ;;
    *)
        die "Invalid list type: $LIST_TYPE (use: installed|all)"
        ;;
esac
