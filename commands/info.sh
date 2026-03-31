#!/bin/bash

# ATHA Info Command
# Show package information

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

PKG=$1

[ -z "$PKG" ] && die "Masukkan nama package"

validate_package_name "$PKG"

print_info "atha v2.0 - lightweight package manager"
print_processing "Fetching package info: $PKG"
log "Info requested for package: $PKG"

echo ""
if pacman -Si "$PKG"; then
    log "Info success for package: $PKG"
else
    log "Info failed for package: $PKG"
    die "Package not found in official repository: $PKG"
fi
