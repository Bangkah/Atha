#!/bin/bash

# Source colors
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

LOG_FILE="${ATHA_LOG_FILE:-/tmp/atha.log}"

# Check if running as root
is_root() {
    if [ "$EUID" -ne 0 ]; then
        return 1
    fi
    return 0
}

# Check if package exists in repo
package_exists() {
    local pkg=$1
    pacman -Ss "^$pkg$" &>/dev/null
    return $?
}

# Print success message
print_success() {
    echo -e "${GREEN}[atha] ✅ $1${RESET}"
}

# Print error message
print_error() {
    echo -e "${RED}[atha] ❌ $1${RESET}"
}

# Print info message
print_info() {
    echo -e "${BLUE}[atha] ℹ️  $1${RESET}"
}

# Print warning message
print_warning() {
    echo -e "${YELLOW}[atha] ⚠️  $1${RESET}"
}

# Print processing message
print_processing() {
    echo -e "${BLUE}[atha] 🔄 $1${RESET}"
}

# Write log line to log file
log() {
    local message=$1
    printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$message" >> "$LOG_FILE"
}

# Exit with error
die() {
    log "ERROR: $1"
    print_error "$1"
    exit 1
}

export -f is_root package_exists print_success print_error print_info print_warning print_processing log die
