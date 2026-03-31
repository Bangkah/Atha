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

echo ""
print_info "atha v2.1 - lightweight package manager"
print_processing "Starting installation flow"
echo ""

plan_lines=()
actionable_count=0

for pkg in "${packages[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        plan_lines+=("$pkg|skip|installed")
        continue
    fi

    actionable_count=$((actionable_count + 1))
    if pacman -Si "$pkg" &>/dev/null; then
        plan_lines+=("$pkg|install|official")
    else
        plan_lines+=("$pkg|install|aur")
    fi
done

print_processing "Install plan"
for line in "${plan_lines[@]}"; do
    IFS='|' read -r pkg action source <<< "$line"
    if [ "$action" = "skip" ]; then
        print_warning "$pkg -> already installed (skip)"
    else
        print_info "$pkg -> install from $source"
    fi
done
echo ""

if [ "$dry_run" -eq 1 ]; then
    log "Install dry-run requested for packages: ${packages[*]}"
    for line in "${plan_lines[@]}"; do
        IFS='|' read -r pkg action source <<< "$line"
        if [ "$action" = "skip" ]; then
            record_history "install" "$pkg" "$source" "skipped" "dry-run"
        else
            record_history "install" "$pkg" "$source" "planned" "dry-run"
        fi
    done
    print_success "Dry-run completed"
    exit 0
fi

if [ "$actionable_count" -eq 0 ]; then
    print_warning "Nothing to install"
    exit 0
fi

if [ "$auto_yes" -ne 1 ]; then
    read -p "Proceed with installation? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Operation cancelled"
        log "Install cancelled by user for packages: ${packages[*]}"
        exit 0
    fi
fi

for pkg in "${packages[@]}"; do
    log "Install requested for package: $pkg"

    if pacman -Qi "$pkg" &>/dev/null; then
        print_warning "$pkg already installed"
        log "Skip install (already installed): $pkg"
        record_history "install" "$pkg" "installed" "skipped" "already-installed"
        continue
    fi

    if pacman -Si "$pkg" &>/dev/null; then
        print_processing "Installing $pkg from official repository"
        log "Source detected for $pkg: official"
        progress_bar

        validate_sudo
        sudo pacman -S "$pkg"
        rc=$?
        source_type="official"
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
        source_type="aur"

        rm -rf "$build_dir"
        current_build_dir=""
    fi

    if [ $rc -eq 0 ]; then
        print_success "$pkg installed"
        log "Install success: $pkg"
        record_history "install" "$pkg" "$source_type" "success" ""
    else
        log "Install failed: $pkg"
        record_history "install" "$pkg" "$source_type" "failed" "exit=$rc"
        die "Failed install $pkg"
    fi
done

echo ""
print_success "Install process completed"
