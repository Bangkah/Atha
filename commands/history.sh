#!/bin/bash

# ATHA History Command
# Show recent ATHA operations from local history file

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"

limit=20
full=0
timeline=0
summary=0
action_filter=""
status_filter=""

while [ $# -gt 0 ]; do
    case "$1" in
        --limit)
            shift
            if [ -z "$1" ] || ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
                die "Invalid --limit value (must be a positive integer)"
            fi
            limit="$1"
            ;;
        --full)
            full=1
            ;;
        --timeline)
            timeline=1
            ;;
        --summary)
            summary=1
            ;;
        --action)
            shift
            if [ -z "$1" ]; then
                die "Invalid --action value"
            fi
            action_filter="$1"
            ;;
        --status)
            shift
            if [ -z "$1" ]; then
                die "Invalid --status value"
            fi
            status_filter="$1"
            ;;
        *)
            die "Unknown option: $1"
            ;;
    esac
    shift
done

init_state_dir

print_info "atha - safety and workflow layer for pacman"
print_processing "Showing recent history"
log "History requested (limit=$limit full=$full timeline=$timeline summary=$summary action=$action_filter status=$status_filter)"

if [ ! -s "$HISTORY_FILE" ]; then
    echo ""
    print_warning "No history available yet"
    exit 0
fi

echo ""

history_data="$(cat "$HISTORY_FILE")"

if [ -n "$action_filter" ]; then
    history_data="$(printf "%s\n" "$history_data" | awk -F'|' -v a="$action_filter" '$2==a')"
fi

if [ -n "$status_filter" ]; then
    history_data="$(printf "%s\n" "$history_data" | awk -F'|' -v s="$status_filter" '$5==s')"
fi

history_data="$(printf "%s\n" "$history_data" | sed '/^\s*$/d')"

if [ -z "$history_data" ]; then
    print_warning "No history matched the selected filters"
    exit 0
fi

history_data="$(printf "%s\n" "$history_data" | tail -n "$limit")"

if [ "$summary" -eq 1 ]; then
    print_section "Summary by action"
    printf "%s\n" "$history_data" | awk -F'|' '{count[$2]++} END {for (k in count) printf "  - %s: %d\n", k, count[k]}' | sort
    print_section "Summary by status"
    printf "%s\n" "$history_data" | awk -F'|' '{count[$5]++} END {for (k in count) printf "  - %s: %d\n", k, count[k]}' | sort
elif [ "$timeline" -eq 1 ]; then
    printf "%s\n" "$history_data" | awk -F'|' '{
        detail=$6
        if (detail == "") detail="-"
        printf "[%s] %-7s %-20s status=%-9s source=%-8s detail=%s\n", $1, toupper($2), $3, $5, $4, detail
    }'
elif [ "$full" -eq 1 ]; then
    printf "%s\n" "$history_data" | awk -F'|' '{
        detail=$6
        if (detail == "") detail="-"
        printf "%-19s | %-7s | %-24s | %-8s | %-9s | %s\n", $1, $2, $3, $4, $5, detail
    }'
else
    printf "%s\n" "$history_data" | awk -F'|' '{
        printf "%-19s | %-7s | %-24s | %-8s | %-9s\n", $1, $2, $3, $4, $5
    }'
fi

echo ""
print_success "History shown"