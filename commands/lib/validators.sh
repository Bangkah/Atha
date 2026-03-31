#!/bin/bash

# Source utils and colors
source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

# Validate package name
validate_package_name() {
    local pkg=$1
    
    if [ -z "$pkg" ]; then
        die "Package name tidak boleh kosong"
    fi
    
    # Allow alphanumeric, dash, underscore, dot
    if ! [[ $pkg =~ ^[a-zA-Z0-9._-]+$ ]]; then
        die "Invalid package name: $pkg"
    fi
    
    return 0
}

# Validate command exists
validate_command() {
    local cmd=$1
    
    if ! command -v "$cmd" &>/dev/null; then
        die "Command not found: $cmd"
    fi
    
    return 0
}

# Check sudo availability
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

export -f validate_package_name validate_command validate_sudo
