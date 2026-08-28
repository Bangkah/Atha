#!/bin/bash

# Source colors
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

LOG_FILE="${ATHA_LOG_FILE:-/tmp/atha.log}"
STATE_DIR="${ATHA_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/atha}"
HISTORY_FILE="$STATE_DIR/history.log"
LOG_READY=0
STATE_READY=0

init_log_file() {
    local cache_dir candidate

    candidate="$LOG_FILE"
    if touch "$candidate" 2>/dev/null; then
        LOG_FILE="$candidate"
        LOG_READY=1
        return
    fi

    cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/atha"
    if mkdir -p "$cache_dir" 2>/dev/null; then
        candidate="$cache_dir/atha.log"
        if touch "$candidate" 2>/dev/null; then
            LOG_FILE="$candidate"
            LOG_READY=1
            return
        fi
    fi

    LOG_FILE="/dev/null"
    LOG_READY=1
}

init_state_dir() {
    if [ "$STATE_READY" -eq 1 ]; then
        return
    fi

    if mkdir -p "$STATE_DIR" 2>/dev/null; then
        touch "$HISTORY_FILE" 2>/dev/null || true
    else
        HISTORY_FILE="/dev/null"
    fi

    STATE_READY=1
}

is_root() {
    if [ "$EUID" -ne 0 ]; then
        return 1
    fi
    return 0
}

package_exists() {
    local pkg=$1
    pacman -Ss "^$pkg$" &>/dev/null
    return $?
}

print_success() {
    printf "%b\n" "${GREEN}[atha] ✅ $1${RESET}"
}

print_error() {
    printf "%b\n" "${RED}[atha] ❌ $1${RESET}"
}

print_info() {
    printf "%b\n" "${BLUE}[atha] ℹ️  $1${RESET}"
}

print_warning() {
    printf "%b\n" "${YELLOW}[atha] ⚠️  $1${RESET}"
}

print_processing() {
    printf "%b\n" "${BLUE}[atha] 🔄 $1${RESET}"
}

print_section() {
    echo ""
    printf "%b\n" "${BLUE}==> $1${RESET}"
}

format_bytes() {
    local bytes=$1

    if ! [[ "$bytes" =~ ^[0-9]+$ ]]; then
        echo "$bytes"
        return
    fi

    awk -v bytes="$bytes" '
    BEGIN {
        split("B KiB MiB GiB TiB", unit)
        i = 1
        val = bytes
        while (val >= 1024 && i < 5) {
            val /= 1024
            i++
        }
        if (i == 1) {
            printf "%d %s", val, unit[i]
        } else {
            printf "%.2f %s", val, unit[i]
        }
    }'
}

log() {
    local message=$1
    if [ "$LOG_READY" -ne 1 ]; then
        init_log_file
    fi
    printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$message" >> "$LOG_FILE" 2>/dev/null || true
}

record_history() {
    local action=$1
    local target=$2
    local source=${3:-unknown}
    local status=${4:-unknown}
    local detail=${5:-}

    if [ "$STATE_READY" -ne 1 ]; then
        init_state_dir
    fi

    printf "%s|%s|%s|%s|%s|%s\n" \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$action" \
        "$target" \
        "$source" \
        "$status" \
        "$detail" >> "$HISTORY_FILE" 2>/dev/null || true
}

die() {
    log "ERROR: $1"
    print_error "$1"
    exit 1
}