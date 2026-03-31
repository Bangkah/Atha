#!/bin/bash

# ATHA Update Command
# Update system packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"
source "$(dirname "$0")/lib/progress.sh"

validate_command pacman

print_info "atha v2.0 - lightweight package manager"
print_processing "Updating system"
log "System update requested"
echo ""

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
    echo ""
    print_success "System updated successfully"
else
    log "System update failed"
    die "System update failed"
fi
