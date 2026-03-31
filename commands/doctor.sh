#!/bin/bash

# ATHA Doctor Command
# Check required tools and environment

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

print_info "atha v2.1 - lightweight package manager"
print_processing "Checking system health"
log "Doctor check requested"

echo ""
missing_count=0

check_cmd() {
    local cmd=$1
    if command -v "$cmd" >/dev/null 2>&1; then
        print_success "$cmd OK"
        log "Doctor: $cmd OK"
    else
        print_error "$cmd missing"
        log "Doctor: $cmd missing"
        missing_count=$((missing_count + 1))
    fi
}

check_cmd pacman
check_cmd sudo
check_cmd git
check_cmd makepkg

echo ""
if [ "$missing_count" -eq 0 ]; then
    print_success "Doctor check completed"
else
    print_warning "Doctor found $missing_count missing dependency(ies)"
    exit 1
fi
