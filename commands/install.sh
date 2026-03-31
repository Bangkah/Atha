#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

if [ $# -eq 0 ]; then
    echo -e "${RED}[atha] Package tidak boleh kosong${NC}"
    exit 1
fi

echo -e "${GREEN}[atha] Installing: $@${NC}"

sudo pacman -S --noconfirm "$@"
