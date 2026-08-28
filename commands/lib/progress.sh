#!/bin/bash

# ATHA Progress Animation Library
if [ -n "${_ATHA_PROGRESS_LOADED:-}" ]; then
    return 0
fi
_ATHA_PROGRESS_LOADED=1

if [ -z "${BLUE:-}" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

progress_bar() {
    local duration=${1:-100}
    local step=5
    
    for ((i=0; i<=100; i+=step)); do
        printf "\r%b" "${BLUE}[atha]${RESET} 🔄 Progress: ${i}%%"
        sleep 0.03
    done
    
    printf "\r%b\n" "${BLUE}[atha]${RESET} 🔄 Progress: 100%%"
}

spinner() {
    local pid=$1
    local msg=${2:-"Processing..."}
    local spin='|/-\'
    local i=0

    printf "\033[?25l"
    
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\r%b %s %s" "${BLUE}[atha]${RESET}" "${spin:$i:1}" "$msg"
        sleep 0.1
    done

    printf "\r\033[K"
    printf "\033[?25h"
}