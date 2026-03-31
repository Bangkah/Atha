#!/bin/bash

GREEN="\e[32m"
NC="\e[0m"

echo -e "${GREEN}[atha] Updating system...${NC}"

sudo pacman -Syu --noconfirm
