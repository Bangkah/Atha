#!/bin/bash

# ATHA Doctor Command
# Check required tools and environment

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

print_info "atha - safety and workflow layer for pacman"
print_processing "Checking system health"
log "Doctor check requested"

echo ""
missing_count=0
warning_count=0

check_path_writable() {
    local path=$1
    local label=$2
    local check_target="$path"

    if [ ! -d "$path" ]; then
        check_target="$(dirname "$path")"
    fi

    if [ -w "$check_target" ]; then
        print_success "$label writable: $path"
    else
        print_warning "$label not writable: $path"
        warning_count=$((warning_count + 1))
    fi
}

check_host() {
    local host=$1
    local has_timeout=0

    if command -v timeout >/dev/null 2>&1; then
        has_timeout=1
    fi

    if [ "$has_timeout" -eq 1 ]; then
        if timeout 2 getent hosts "$host" >/dev/null 2>&1; then
            print_success "DNS reachable: $host"
        else
            print_warning "DNS unresolved: $host"
            warning_count=$((warning_count + 1))
        fi
    else
        if getent hosts "$host" >/dev/null 2>&1; then
            print_success "DNS reachable: $host"
        else
            print_warning "DNS unresolved: $host"
            warning_count=$((warning_count + 1))
        fi
    fi
}

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

print_section "Core tools check"
check_cmd pacman
check_cmd sudo
check_cmd git
check_cmd makepkg

echo ""
print_section "Runtime checks"

if [ -f /var/lib/pacman/db.lck ]; then
    print_warning "pacman database lock exists (/var/lib/pacman/db.lck)"
    warning_count=$((warning_count + 1))
else
    print_success "pacman database lock not present"
fi

check_path_writable "${XDG_CACHE_HOME:-$HOME/.cache}/atha" "Cache directory"
check_path_writable "${XDG_STATE_HOME:-$HOME/.local/state}/atha" "State directory"

echo ""
print_section "Connectivity checks"
check_host "archlinux.org"
check_host "aur.archlinux.org"

echo ""
if [ "$missing_count" -eq 0 ]; then
    if [ "$warning_count" -eq 0 ]; then
        print_success "Doctor check completed (healthy)"
    else
        print_warning "Doctor completed with $warning_count warning(s)"
    fi
else
    print_warning "Doctor found $missing_count missing dependency(ies) and $warning_count warning(s)"
    exit 1
fi