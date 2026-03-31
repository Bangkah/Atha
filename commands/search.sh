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

print_info "atha v2.1 - lightweight package manager"
print_processing "Searching: $SEARCH_TERM"
log "Search requested with term: $SEARCH_TERM"
echo ""

# Search in repository
pacman -Ss "$SEARCH_TERM" | head -30

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    log "Search success for term: $SEARCH_TERM"
    echo ""
    print_success "Search complete"
else
    log "Search failed for term: $SEARCH_TERM"
    die "Search failed"
fi
