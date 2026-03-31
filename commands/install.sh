#!/bin/bash

# ATHA Install Command
# Install packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"
source "$(dirname "$0")/lib/progress.sh"

validate_command pacman

current_build_dir=""
cleanup_on_exit() {
    if [ -n "$current_build_dir" ] && [ -d "$current_build_dir" ]; then
        rm -rf "$current_build_dir"
    fi
}
trap cleanup_on_exit EXIT

if [ $# -eq 0 ]; then
    die "Masukkan nama package"
fi

# Validate all package names
for pkg in "$@"; do
    validate_package_name "$pkg"
done

echo ""
print_info "atha v2.0 - lightweight package manager"
print_processing "Starting installation flow"
echo ""

for pkg in "$@"; do
    log "Install requested for package: $pkg"

    if pacman -Qi "$pkg" &>/dev/null; then
        print_warning "$pkg already installed"
        log "Skip install (already installed): $pkg"
        continue
    fi

    if pacman -Si "$pkg" &>/dev/null; then
        print_processing "Installing $pkg from official repository"
        log "Source detected for $pkg: official"
        progress_bar

        validate_sudo
        sudo pacman -S "$pkg"
        rc=$?
    else
        print_processing "Installing $pkg from AUR"
        log "Source detected for $pkg: aur"
        progress_bar

        validate_command git
        validate_command makepkg

        build_dir="$(mktemp -d "/tmp/atha-${pkg}-XXXXXX")"
        current_build_dir="$build_dir"
        log "AUR build directory: $build_dir"

        if ! git clone "https://aur.archlinux.org/${pkg}.git" "$build_dir/$pkg"; then
            die "Failed to clone AUR package: $pkg"
        fi

        (
            cd "$build_dir/$pkg" || exit 1
            makepkg -si --noconfirm
        )
        rc=$?

        rm -rf "$build_dir"
        current_build_dir=""
    fi

    if [ $rc -eq 0 ]; then
        print_success "$pkg installed"
        log "Install success: $pkg"
    else
        log "Install failed: $pkg"
        die "Failed install $pkg"
    fi
done

echo ""
print_success "Install process completed"
