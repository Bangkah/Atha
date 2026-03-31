#!/bin/bash

# ATHA History Command
# Show recent ATHA operations from local history file

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

limit=20
full=0
timeline=0

while [ $# -gt 0 ]; do
    case "$1" in
        --limit)
            shift
            if [ -z "$1" ] || ! [[ "$1" =~ ^[0-9]+$ ]]; then
                die "Invalid --limit value"
            fi
            limit="$1"
            ;;
        --full)
            full=1
            ;;
        --timeline)
            timeline=1
            ;;
        *)
            die "Unknown option: $1"
            ;;
    esac
    shift
done

init_state_dir

print_info "atha v2.1 - lightweight package manager"
print_processing "Showing recent history"
log "History requested (limit=$limit full=$full)"

if [ ! -s "$HISTORY_FILE" ]; then
    echo ""
    print_warning "No history available yet"
    exit 0
fi

echo ""
if [ "$timeline" -eq 1 ]; then
    tail -n "$limit" "$HISTORY_FILE" | awk -F'|' '{
        printf "[%s] %s %s (%s, %s)\n", $1, toupper($2), $3, $4, $5
    }'
elif [ "$full" -eq 1 ]; then
    tail -n "$limit" "$HISTORY_FILE" | awk -F'|' '{
        printf "%-19s | %-7s | %-24s | %-8s | %-7s | %s\n", $1, $2, $3, $4, $5, $6
    }'
else
    tail -n "$limit" "$HISTORY_FILE" | awk -F'|' '{
        printf "%-19s | %-7s | %-24s | %-8s | %-7s\n", $1, $2, $3, $4, $5
    }'
fi

echo ""
print_success "History shown"
