#!/bin/bash

# ATHA Colors Library
if [ -n "${_ATHA_COLORS_LOADED:-}" ]; then
    return 0
fi
_ATHA_COLORS_LOADED=1

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    RED=$'\033[1;31m'
    GREEN=$'\033[1;32m'
    YELLOW=$'\033[1;33m'
    BLUE=$'\033[1;34m'
    MAGENTA=$'\033[1;35m'
    CYAN=$'\033[1;36m'
    WHITE=$'\033[1;37m'
    RESET=$'\033[0m'
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    CYAN=""
    WHITE=""
    RESET=""
fi