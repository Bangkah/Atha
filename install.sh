#!/bin/bash

set -e

echo "[atha] Installing Atha..."

REPO="https://github.com/Bangkah/Atha.git"
TMP_DIR="/tmp/atha"

require_cmd() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "[atha] Missing dependency: $1"
		exit 1
	fi
}

require_cmd git
require_cmd sudo

cleanup() {
	rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# cleanup
rm -rf "$TMP_DIR"

# clone
git clone "$REPO" "$TMP_DIR"

# install
sudo mkdir -p /usr/lib/atha
sudo cp -r "$TMP_DIR/commands" /usr/lib/atha/
sudo cp "$TMP_DIR/atha" /usr/bin/atha

# permission
sudo chmod +x /usr/bin/atha
sudo find /usr/lib/atha/commands -type f -name "*.sh" -exec chmod +x {} \;

echo "[atha] Installation complete!"
