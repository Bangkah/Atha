#!/bin/bash

# ATHA Search Command
# Search for packages in official repository & AUR

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

SEARCH_TERM=$1

if [ -z "$SEARCH_TERM" ]; then
    die "Masukkan nama package untuk dicari"
fi

print_info "atha - safety and workflow layer for pacman"
print_processing "Searching official repositories: $SEARCH_TERM"
log "Search requested with term: $SEARCH_TERM"
echo ""

results="$(pacman -Ss "$SEARCH_TERM" 2>/dev/null)"

if [ -n "$results" ]; then
    print_section "Official Repository Results"
    printf '%s\n' "$results" | head -n 30
    
    total_lines="$(printf '%s\n' "$results" | wc -l)"
    if [ "$total_lines" -gt 30 ]; then
        echo ""
        print_info "Showing first 15 results (use 'pacman -Ss $SEARCH_TERM' to see all $total_lines lines)"
    fi
    log "Search success in official repo for term: $SEARCH_TERM"
    echo ""
    print_success "Search complete"
    exit 0
fi

print_warning "No packages found in official repositories. Checking AUR..."
echo ""

if command -v curl >/dev/null 2>&1; then
    aur_results="$(curl -s "https://aur.archlinux.org/rpc/v5/search/${SEARCH_TERM}" 2>/dev/null)"
    
    if command -v jq >/dev/null 2>&1 && [ -n "$aur_results" ]; then
        count="$(echo "$aur_results" | jq '.resultcount')"
        if [ "$count" -gt 0 ]; then
            print_section "AUR Results ($count found)"
            echo "$aur_results" | jq -r '.results[] | "aur/" + .Name + " " + .Version + "\n    " + (.Description // "No description")' | head -n 30
            
            if [ "$count" -gt 15 ]; then
                echo ""
                print_info "Showing first 15 AUR results"
            fi
            log "Search success in AUR for term: $SEARCH_TERM"
            echo ""
            print_success "Search complete"
            exit 0
        fi
    fi
fi

log "Search no results: $SEARCH_TERM"
die "No packages found for: $SEARCH_TERM (official or AUR)"