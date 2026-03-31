#!/bin/bash

# ATHA Update Command
# Update system packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"
source "$(dirname "$0")/lib/progress.sh"

validate_command pacman

dry_run=0
while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run)
            dry_run=1
            ;;
        --*)
            die "Unknown option: $1"
            ;;
        *)
            die "Unknown argument: $1"
            ;;
    esac
    shift
done

print_info "atha v2.1 - lightweight package manager"
print_processing "Updating system"
log "System update requested"
echo ""

if [ "$dry_run" -eq 1 ]; then
    print_info "Dry-run mode: preview only"
    print_info "Would run: sudo pacman -Syu"
    record_history "update" "system" "official" "planned" "dry-run"
    print_success "Dry-run completed"
    exit 0
fi

# Check privileges and run update
if is_root; then
    update_cmd=(pacman -Syu)
else
    validate_sudo
    update_cmd=(sudo pacman -Syu)
fi

progress_bar

# Run system update
"${update_cmd[@]}"

if [ $? -eq 0 ]; then
    log "System update success"
    record_history "update" "system" "official" "success" ""
    echo ""
    print_success "System updated successfully"
else
    log "System update failed"
    record_history "update" "system" "official" "failed" "pacman-syu"
    die "System update failed"
fi
