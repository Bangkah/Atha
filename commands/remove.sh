#!/bin/bash

# ATHA Remove Command
# Remove packages

source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/validators.sh"

validate_command pacman

dry_run=0
plan_only=0
auto_yes=0
packages=()
remove_targets=()

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run)
            dry_run=1
            ;;
        --plan)
            plan_only=1
            ;;
        --yes)
            auto_yes=1
            ;;
        --*)
            die "Unknown option: $1"
            ;;
        *)
            packages+=("$1")
            ;;
    esac
    shift
done

if [ ${#packages[@]} -eq 0 ]; then
    die "Masukkan nama package"
fi

for pkg in "${packages[@]}"; do
    validate_package_name "$pkg"
done

print_info "atha - safety and workflow layer for pacman"
echo ""

installed_count=0
missing_count=0

plan_lines=()
for pkg in "${packages[@]}"; do
    if pacman -Qi "$pkg" >/dev/null 2>&1; then
        remove_targets+=("$pkg")
        installed_count=$((installed_count + 1))
        plan_lines+=("$pkg|remove|official|installed package")
    else
        missing_count=$((missing_count + 1))
        plan_lines+=("$pkg|skip|official|not installed")
    fi
done

if [ ${#remove_targets[@]} -eq 0 ]; then
    if [ "$plan_only" -eq 1 ]; then
        print_section "PLAN: Decision Analysis"
        for line in "${plan_lines[@]}"; do
            IFS='|' read -r pkg action source reason <<< "$line"
            echo "  - $pkg -> skip"
            echo "    reason: $reason"
            record_history "remove" "$pkg" "official" "skipped" "plan:$reason"
        done
        echo ""
        print_info "Summary: remove=$installed_count skip=$missing_count"
        print_success "Plan completed (no changes applied)"
    elif [ "$dry_run" -eq 1 ]; then
        print_section "DRY-RUN: Execution Simulation"
        for line in "${plan_lines[@]}"; do
            IFS='|' read -r pkg action source reason <<< "$line"
            record_history "remove" "$pkg" "official" "skipped" "dry-run:$reason"
        done
        print_info "No package changes will be applied"
        print_info "Execution summary: remove=$installed_count skip=$missing_count"
        print_success "Dry-run completed (no changes applied)"
    else
        print_section "Execution Plan"
        for pkg in "${packages[@]}"; do
            record_history "remove" "$pkg" "official" "skipped" "not-installed"
        done
        print_info "Summary: remove=$installed_count skip=$missing_count"
        print_warning "Nothing to remove"
    fi
    exit 0
fi

if [ "$plan_only" -eq 1 ]; then
    print_section "PLAN: Decision Analysis"
    for line in "${plan_lines[@]}"; do
        IFS='|' read -r pkg action source reason <<< "$line"
        if [ "$action" = "skip" ]; then
            echo "  - $pkg -> skip"
            echo "    reason: $reason"
            record_history "remove" "$pkg" "official" "skipped" "plan:$reason"
        else
            echo "  - $pkg -> remove"
            echo "    reason: $reason"
            record_history "remove" "$pkg" "official" "planned" "plan:$reason"
        fi
    done

    print_section "PLAN: Transaction Impact"

    tx_output="$(pacman -Rns --print --print-format '%n|%s' "${remove_targets[@]}" 2>/dev/null || true)"
    tx_total=0

    if [ -n "$tx_output" ]; then
        print_info "Transaction impact (remove + unneeded dependencies):"
        while IFS='|' read -r tx_pkg tx_size; do
            [ -z "$tx_pkg" ] && continue
            echo "  - $tx_pkg ($(format_bytes "$tx_size"))"
            tx_total=$((tx_total + tx_size))
        done <<< "$tx_output"
        print_info "Estimated transaction size impact (freed space): $(format_bytes "$tx_total")"
    else
        for pkg in "${remove_targets[@]}"; do
            installed_size="$(pacman -Qi "$pkg" 2>/dev/null | awk -F': *' '/Installed Size/ {print $2; exit}')"
            if [ -n "$installed_size" ]; then
                print_info "Estimated freed size for $pkg: $installed_size"
            else
                print_warning "Unable to simulate remove dependency tree for $pkg"
            fi
        done
    fi

    echo ""
    print_info "Summary: remove=$installed_count skip=$missing_count"
    print_success "Plan completed (no changes applied)"
    exit 0
fi

if [ "$dry_run" -eq 1 ]; then
    print_section "DRY-RUN: Execution Simulation"
    print_info "No package changes will be applied"
    print_info "Would execute: sudo pacman -Rns ${remove_targets[*]}"

    for line in "${plan_lines[@]}"; do
        IFS='|' read -r pkg action source reason <<< "$line"
        if [ "$action" = "skip" ]; then
            print_warning "$pkg -> already absent (skip)"
            record_history "remove" "$pkg" "$source" "skipped" "dry-run:$reason"
        else
            print_info "$pkg -> would execute: sudo pacman -Rns $pkg"
            record_history "remove" "$pkg" "$source" "planned" "dry-run:$reason"
        fi
    done

    echo ""
    print_info "Execution summary: remove=$installed_count skip=$missing_count"
    print_success "Dry-run completed (no changes applied)"
    exit 0
fi

print_section "Execution Plan"
print_info "Targets: ${remove_targets[*]}"
print_info "Summary: remove=$installed_count skip=$missing_count"

for line in "${plan_lines[@]}"; do
    IFS='|' read -r pkg action source reason <<< "$line"
    if [ "$action" = "skip" ]; then
        record_history "remove" "$pkg" "$source" "skipped" "$reason"
    fi
done

if [ "$auto_yes" -ne 1 ]; then
    read -p "Are you sure you want to remove these packages and unneeded dependencies? (y/N) " -n 1 -r
    echo ""
fi

if [ "$auto_yes" -eq 1 ] || [[ $REPLY =~ ^[Yy]$ ]]; then
    validate_sudo
    print_processing "Removing: ${remove_targets[*]}"
    log "Remove requested for packages: ${remove_targets[*]}"
    echo ""

    pacman_remove_flags=("-Rns")
    if [ "$auto_yes" -eq 1 ]; then
        pacman_remove_flags+=("--noconfirm")
    fi

    sudo pacman "${pacman_remove_flags[@]}" "${remove_targets[@]}"
    
    if [ $? -eq 0 ]; then
        for pkg in "${remove_targets[@]}"; do
            record_history "remove" "$pkg" "official" "success" ""
        done
        log "Remove success for packages: ${remove_targets[*]}"
        echo ""
        print_success "Package(s) removed successfully"
    else
        for pkg in "${remove_targets[@]}"; do
            record_history "remove" "$pkg" "official" "failed" "pacman-remove"
        done
        log "Remove failed for packages: ${remove_targets[*]}"
        die "Remove failed"
    fi
else
    for pkg in "${remove_targets[@]}"; do
        record_history "remove" "$pkg" "official" "cancelled" "user-cancel"
    done
    log "Remove cancelled by user for packages: ${remove_targets[*]}"
    print_info "Operation cancelled"
fi