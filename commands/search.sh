#!/bin/bash

# ATHA Search Command
# Search for packages in repository

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

SEARCH_TERM=$1

if [ -z "$SEARCH_TERM" ]; then
    die "Masukkan nama package untuk dicari"
fi

print_info "atha - safety and workflow layer for pacman"
print_processing "Searching: $SEARCH_TERM"
log "Search requested with term: $SEARCH_TERM"
echo ""

# Search in repository
results="$(pacman -Ss "$SEARCH_TERM" 2>/dev/null)"

if [ -n "$results" ]; then
    printf '%s\n' "$results" | sed -n '1,30p'
    log "Search success for term: $SEARCH_TERM"
    echo ""
    print_success "Search complete"
else
    log "Search no results: $SEARCH_TERM"
    die "No packages found for: $SEARCH_TERM"
fi
