#!/bin/bash

# Source colors if not already sourced
if [ -z "$BLUE" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

# Simple progress bar
progress_bar() {
    local duration=${1:-100}
    local step=5
    
    for ((i=0; i<=100; i+=step)); do
        printf "\r${BLUE}[atha]${RESET} 🔄 Progress: %d%%" "$i"
        sleep 0.03
    done
    
    printf "\r${BLUE}[atha]${RESET} 🔄 Progress: 100%%\n"
}

# Spinner animation
spinner() {
    local pid=$1
    local spin='-\|/'
    local i=0
    
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\r${BLUE}[atha]${RESET} ${spin:$i:1} Processing..."
        sleep 0.1
    done
    printf "\r                      \r"
}

export -f progress_bar spinner
