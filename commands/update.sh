#!/bin/bash

# ATHA Update Command
# Update system packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"
source "$(dirname "$0")/lib/progress.sh"

print_info "atha v2.0 - lightweight package manager"
print_processing "Updating system"
log "System update requested"
echo ""

# Check sudo access
validate_sudo
progress_bar

# Run system update
sudo pacman -Syu

if [ $? -eq 0 ]; then
    log "System update success"
    echo ""
    print_success "System updated successfully"
else
    log "System update failed"
    die "System update failed"
fi
