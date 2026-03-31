#!/bin/bash

set -e

echo "[atha] Installing Atha..."

REPO="https://github.com/USERNAME/atha.git"
TMP_DIR="/tmp/atha"

# cleanup
rm -rf $TMP_DIR

# clone
git clone $REPO $TMP_DIR

# install
sudo mkdir -p /usr/lib/atha
sudo cp -r $TMP_DIR/commands /usr/lib/atha/
sudo cp $TMP_DIR/atha /usr/bin/atha

# permission
sudo chmod +x /usr/bin/atha

echo "[atha] Installation complete!"
