#!/bin/bash

# ==============================================================================
# Script: manage_mount.sh
# Description: Improved persistent SMB mount script with dotfile config support.
# ==============================================================================

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_red()    { echo -e "${RED}ERROR: $1${NC}"; }
log_green()  { echo -e "${GREEN}$1${NC}"; }
log_yellow() { echo -e "${YELLOW}$1${NC}"; }

# --- Config Directory Setup ---
# Handling the symbolic link for dotfiles properly
CONFIG_DIR="$HOME/configs"
DOTFILE_CONFIG_DIR="$HOME/.dotfile/configs"

if [[ ! -d "$CONFIG_DIR" ]]; then
    log_yellow "Config directory not found. Linking to dotfiles..."
    # Create the target directory if it doesn't exist to prevent broken links
    mkdir -p "$DOTFILE_CONFIG_DIR"
    ln -s "$DOTFILE_CONFIG_DIR" "$CONFIG_DIR"
fi

CONFIG_FILE="$CONFIG_DIR/.remote_mount_config"

# --- Initialization Logic ---
init() {
if [[ ! -f "$CONFIG_FILE" ]]; then
    log_yellow "Welcome! First-time setup detected."
    
    read -p "Enter Remote IP (e.g. 192.168.10.7): " input_ip
    read -p "Enter Remote Username: " input_user
    read -p "Enter Remote Share Name (exact case): " input_share
    read -p "Enter Local Mount Name (e.g. Win_G): " input_mount_name
    
    # Save config (using full path to ensure it writes to the symlink target)
    cat <<EOF > "$CONFIG_FILE"
REMOTE_IP="$input_ip"
REMOTE_USER="$input_user"
REMOTE_SHARE="$input_share"
LOCAL_MOUNT_POINT="/Volumes/$input_mount_name"
EOF
    
    log_green "✅ Configuration saved to $CONFIG_FILE"
    echo "--------------------------------------------------"
fi
}
init

# Load variables
source "$CONFIG_FILE"

# Usage Check
if [[ $# -ne 1 ]]; then
    log_red "Usage: $0 [mount|unmount|init]"
    exit 1
fi

# --- Core Functions ---

mount_remote_drive() {
    # 1. Connectivity Check (Ping the IP first)
    if ! ping -c 1 -W 1 "$REMOTE_IP" &>/dev/null; then
        log_red "Cannot reach $REMOTE_IP. Is the Windows PC awake?"
        exit 1
    fi

    # 2. Prepare Mount Point
    if [[ ! -d "$LOCAL_MOUNT_POINT" ]]; then
        log_yellow "Creating mount point: $LOCAL_MOUNT_POINT"
        # Using sudo here solves the 'Permission denied' you saw earlier
        sudo mkdir -p "$LOCAL_MOUNT_POINT"
        sudo chown "$(whoami):staff" "$LOCAL_MOUNT_POINT"
    fi

    # 3. Check if already mounted
    if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_yellow "Already mounted at $LOCAL_MOUNT_POINT."
        exit 0
    fi

    log_green "Mounting //$REMOTE_USER@$REMOTE_IP/$REMOTE_SHARE..."
    
    # 4. Execute Mount
    # Added -o soft to prevent Finder hangs if the network drops
    if mount_smbfs -o soft "//$REMOTE_USER@$REMOTE_IP/$REMOTE_SHARE" "$LOCAL_MOUNT_POINT"; then
        log_green "✅ Success! Mounted."
        open "$LOCAL_MOUNT_POINT"
    else
        echo "mount_smbfs -o soft //${REMOTE_USER}@${REMOTE_IP}/${REMOTE_SHARE} ${LOCAL_MOUNT_POINT}"
        log_red "❌ Mount failed (Input/output error)."
        echo "Troubleshooting Tips:"
        echo "  1. Ensure 'File Sharing' is enabled in Windows Settings."
        echo "  2. Verify Share Name '$REMOTE_SHARE' is exactly correct (Case Sensitive)."
        echo "  3. Check Windows Firewall (allow SMB/Port 445)."
        exit 1
    fi
}

unmount_remote_drive() {
    
    if ! mount | grep -q -Ei "on $LOCAL_MOUNT_POINT"; then
        log_red "Drive is not mounted."
        log_yellow "[ * ] Please manual unmout specifical volume."
        log_yellow "[cmd] diskutil unmount /Volumes/G (e.g)"
        exit 0
    fi

    log_green "Ejecting $LOCAL_MOUNT_POINT..."
    if diskutil unmount "$LOCAL_MOUNT_POINT"; then
        log_green "✅ Unmounted successfully."
        [[ -d "$LOCAL_MOUNT_POINT" ]] && sudo rmdir "$LOCAL_MOUNT_POINT"
    else
        log_red "❌ Failed to eject. Files might be in use."
        exit 1
    fi
}

case "$1" in
    mount)   mount_remote_drive ;;
    unmount) unmount_remote_drive ;;
    init)    init ;;
    *)       log_red "Invalid command." ; exit 1 ;;
esac