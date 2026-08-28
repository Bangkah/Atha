#!/bin/bash

# ATHA Validators Library
if [ -n "${_ATHA_VALIDATORS_LOADED:-}" ]; then
    return 0
fi
_ATHA_VALIDATORS_LOADED=1

if ! command -v die &>/dev/null; then
    source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"
fi

validate_package_name() {
    local pkg=$1
    
    if [ -z "$pkg" ]; then
        die "Package name tidak boleh kosong"
    fi
    
    if ! [[ $pkg =~ ^[a-zA-Z0-9._+@-]+$ ]]; then
        die "Invalid package name: $pkg"
    fi
    
    return 0
}

validate_command() {
    local cmd=$1
    
    if ! command -v "$cmd" &>/dev/null; then
        die "Command not found: $cmd"
    fi
    
    return 0
}

validate_sudo() {
    if is_root; then
        return 0
    fi

    if ! command -v sudo &>/dev/null; then
        die "sudo tidak ditemukan. Jalankan sebagai root atau install sudo"
    fi

    if ! sudo -n true 2>/dev/null; then
        print_warning "This command requires sudo"
        if ! sudo -v; then
            die "Failed to get sudo access"
        fi
    fi
}