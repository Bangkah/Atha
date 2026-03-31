#!/bin/bash

# ATHA Update Command
# Update system packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"
source "$(dirname "$0")/lib/progress.sh"

validate_command pacman

dry_run=0
plan_only=0
while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run)
            dry_run=1
            ;;
        --plan)
            dry_run=1
            plan_only=1
            ;;
        --*)
            die "Unknown option: $1"
            ;;
        *)
            die "Unknown argument: $1"
            ;;
    esac
    shift
done

print_info "atha - safety and workflow layer for pacman"
print_processing "Updating system"
log "System update requested"
echo ""

if [ "$dry_run" -eq 1 ]; then
    if [ "$plan_only" -eq 1 ]; then
        print_section "Update Plan"
    else
        print_section "Dry-Run Preview"
    fi
    print_processing "Checking available updates"

    updates_output=""
    updates_count=0

    if command -v checkupdates >/dev/null 2>&1; then
        updates_output="$(checkupdates 2>/dev/null || true)"
    else
        updates_output="$(pacman -Qu 2>/dev/null || true)"
    fi

    if [ -n "$updates_output" ]; then
        printf "%s\n" "$updates_output"
        updates_count="$(printf "%s\n" "$updates_output" | sed '/^\s*$/d' | wc -l | tr -d ' ')"
        print_info "Pending updates: $updates_count"
    else
        print_info "No pending updates detected"
    fi

    run_cmd="sudo pacman -Syu"
    if is_root; then
        run_cmd="pacman -Syu"
    fi
    print_info "Would run: $run_cmd"

    mode_label="dry-run"
    if [ "$plan_only" -eq 1 ]; then
        mode_label="plan"
    fi
    record_history "update" "system" "official" "planned" "$mode_label count=$updates_count"
    print_success "Dry-run completed"
    exit 0
fi

# Check privileges and run update
if is_root; then
    update_cmd=(pacman -Syu)
else
    validate_sudo
    update_cmd=(sudo pacman -Syu)
fi

progress_bar

# Run system update
"${update_cmd[@]}"

if [ $? -eq 0 ]; then
    log "System update success"
    record_history "update" "system" "official" "success" ""
    echo ""
    print_success "System updated successfully"
else
    log "System update failed"
    record_history "update" "system" "official" "failed" "pacman-syu"
    die "System update failed"
fi
