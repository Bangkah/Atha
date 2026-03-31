#!/bin/bash

# ATHA Remove Command
# Remove packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

dry_run=0
auto_yes=0
packages=()

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run)
            dry_run=1
            ;;
        --yes)
            auto_yes=1
            ;;
        --*)
            die "Unknown option: $1"
            ;;
        *)
            packages+=("$1")
            ;;
    esac
    shift
done

if [ ${#packages[@]} -eq 0 ]; then
    die "Masukkan nama package"
fi

for pkg in "${packages[@]}"; do
    validate_package_name "$pkg"
done

print_info "atha v2.1 - lightweight package manager"
echo ""
print_warning "This will remove: ${packages[*]}"

if [ "$dry_run" -eq 1 ]; then
    for pkg in "${packages[@]}"; do
        record_history "remove" "$pkg" "official" "planned" "dry-run"
    done
    print_success "Dry-run completed"
    exit 0
fi

if [ "$auto_yes" -ne 1 ]; then
    read -p "Are you sure? (y/N) " -n 1 -r
    echo ""
fi

if [ "$auto_yes" -eq 1 ] || [[ $REPLY =~ ^[Yy]$ ]]; then
    validate_sudo
    print_processing "Removing: ${packages[*]}"
    log "Remove requested for packages: ${packages[*]}"
    echo ""

    sudo pacman -R "${packages[@]}"
    
    if [ $? -eq 0 ]; then
        for pkg in "${packages[@]}"; do
            record_history "remove" "$pkg" "official" "success" ""
        done
        log "Remove success for packages: ${packages[*]}"
        echo ""
        print_success "Package(s) removed successfully"
    else
        for pkg in "${packages[@]}"; do
            record_history "remove" "$pkg" "official" "failed" "pacman-remove"
        done
        log "Remove failed for packages: ${packages[*]}"
        die "Remove failed"
    fi
else
    for pkg in "${packages[@]}"; do
        record_history "remove" "$pkg" "official" "cancelled" "user-cancel"
    done
    log "Remove cancelled by user for packages: ${packages[*]}"
    print_info "Operation cancelled"
fi
