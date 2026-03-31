#!/bin/bash

# ATHA Remove Command
# Remove packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

if [ $# -eq 0 ]; then
    die "Masukkan nama package"
fi

# Validate all package names
for pkg in "$@"; do
    validate_package_name "$pkg"
done

# Validate sudo access
validate_sudo

print_info "atha v2.0 - lightweight package manager"
echo ""
print_warning "⚠️  This will remove: $@"
read -p "Are you sure? (y/N) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_processing "Removing: $@"
    log "Remove requested for packages: $*"
    echo ""
    
    sudo pacman -R "$@"
    
    if [ $? -eq 0 ]; then
        log "Remove success for packages: $*"
        echo ""
        print_success "Package(s) removed successfully"
    else
        log "Remove failed for packages: $*"
        die "Remove failed"
    fi
else
    log "Remove cancelled by user for packages: $*"
    print_info "Operation cancelled"
fi
