#!/bin/bash

set -e

echo "[atha] Installing Atha..."

REPO="https://github.com/Bangkah/Atha.git"
ARCHIVE_URL="https://github.com/Bangkah/Atha/archive/refs/tags/v2.2.2.tar.gz"
TMP_DIR="/tmp/atha"
SRC_DIR=""

require_cmd() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "[atha] Missing dependency: $1"
		exit 1
	fi
}

require_cmd sudo
require_cmd tar

have_cmd() {
	command -v "$1" >/dev/null 2>&1
}

cleanup() {
	rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# cleanup
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# source fetch
if have_cmd git; then
	echo "[atha] Fetching source via git..."
	git clone "$REPO" "$TMP_DIR/repo"
	SRC_DIR="$TMP_DIR/repo"
elif have_cmd curl; then
	echo "[atha] Fetching source via curl..."
	curl -fsSL "$ARCHIVE_URL" -o "$TMP_DIR/atha.tar.gz"
	tar -xzf "$TMP_DIR/atha.tar.gz" -C "$TMP_DIR"
	SRC_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name "Atha-*" | head -n 1)"
elif have_cmd wget; then
	echo "[atha] Fetching source via wget..."
	wget -qO "$TMP_DIR/atha.tar.gz" "$ARCHIVE_URL"
	tar -xzf "$TMP_DIR/atha.tar.gz" -C "$TMP_DIR"
	SRC_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name "Atha-*" | head -n 1)"
else
	echo "[atha] Missing dependency: install one of git, curl, or wget"
	exit 1
fi

if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR" ]; then
	echo "[atha] Failed to prepare source directory"
	exit 1
fi

# install
sudo mkdir -p /usr/lib/atha
sudo cp -r "$SRC_DIR/commands" /usr/lib/atha/
sudo cp "$SRC_DIR/atha" /usr/bin/atha

# permission
sudo chmod +x /usr/bin/atha
sudo find /usr/lib/atha/commands -type f -name "*.sh" -exec chmod +x {} \;

echo "[atha] Installation complete!"
