#!/bin/bash

# ==============================================================================
# Script: sshfs_mount.sh
# Description: Persistent SSHFS mount script with dotfile config support.
#              Perfect for mounting Ubuntu/Arch servers to macOS securely.
# ==============================================================================

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_error()  { echo -e "${RED}[ERROR]${NC} $1"; }
log_info()   { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success(){ echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn()   { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Check dependencies
if ! command -v sshfs &> /dev/null; then
    log_error "sshfs is not installed."
    echo "Please install it using Homebrew:"
    echo "  brew install --cask macfuse"
    echo "  brew install sshfs"
    exit 1
fi

# --- Config Directory Setup ---
CONFIG_DIR="$HOME/configs"
DOTFILE_CONFIG_DIR="$HOME/.dotfile/configs"

if [[ ! -d "$CONFIG_DIR" ]]; then
    log_warn "Config directory not found. Creating and linking to dotfiles..."
    mkdir -p "$DOTFILE_CONFIG_DIR"
    ln -s "$DOTFILE_CONFIG_DIR" "$CONFIG_DIR"
fi

CONFIG_FILE="$CONFIG_DIR/.sshfs_mount_config"

# --- Initialization Logic ---
init() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_warn "First-time setup detected for SSHFS."
        
        read -p "Enter Remote Server User (e.g., ubuntu): " input_user
        read -p "Enter Remote Server IP/Hostname (e.g., 192.168.1.100 or my-server.com): " input_ip
        read -p "Enter Remote Path to Mount (e.g., /home/ubuntu/projects or /): " input_remote_path
        read -p "Enter Local Mount Folder Name (e.g., RemoteServer): " input_mount_name
        read -p "Enter path to SSH Private Key (e.g., ~/.ssh/id_ed25519) [Leave blank for default]: " input_key
        
        # Default key fallback
        if [[ -z "$input_key" ]]; then
            input_key="~/.ssh/id_rsa"
        fi

        # Save config
        cat <<EOF > "$CONFIG_FILE"
REMOTE_USER="$input_user"
REMOTE_IP="$input_ip"
REMOTE_PATH="$input_remote_path"
LOCAL_MOUNT_POINT="$HOME/Desktop/$input_mount_name"
SSH_KEY_PATH="$input_key"
EOF
        
        log_success "Configuration saved to $CONFIG_FILE"
        echo "--------------------------------------------------"
    fi
}

# Run init if config doesn't exist
init

# Load variables
source "$CONFIG_FILE"

# Expand tilde in key path if it exists
SSH_KEY_PATH="${SSH_KEY_PATH/#\~/$HOME}"

# Usage Check
if [[ $# -ne 1 ]]; then
    log_error "Usage: $0 [mount|unmount|init]"
    exit 1
fi

# --- Core Functions ---

mount_remote_drive() {
    # 1. Check if SSH is reachable
    log_info "Testing SSH connection to $REMOTE_IP..."
    if ! ssh -i "$SSH_KEY_PATH" -o ConnectTimeout=5 -q "$REMOTE_USER@$REMOTE_IP" exit; then
        log_error "Cannot connect to $REMOTE_IP via SSH. Check your connection or SSH keys."
        exit 1
    fi

    # 2. Prepare Mount Point
    if [[ ! -d "$LOCAL_MOUNT_POINT" ]]; then
        log_warn "Creating mount point: $LOCAL_MOUNT_POINT"
        mkdir -p "$LOCAL_MOUNT_POINT"
    fi

    # 3. Check if already mounted
    if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_warn "Already mounted at $LOCAL_MOUNT_POINT."
        open "$LOCAL_MOUNT_POINT"
        exit 0
    fi

    log_info "Mounting $REMOTE_USER@$REMOTE_IP:$REMOTE_PATH to $LOCAL_MOUNT_POINT..."
    
    # 4. Execute SSHFS Mount
    # Options used:
    # -o volname: Sets the display name in Finder
    # -o reconnect: Automatically attempts to reconnect if connection drops
    # -o ServerAliveInterval=15: Keeps connection alive
    # -o defer_permissions: Let the remote server handle permissions natively
    
    if sshfs "$REMOTE_USER@$REMOTE_IP:$REMOTE_PATH" "$LOCAL_MOUNT_POINT" \
        -o IdentityFile="$SSH_KEY_PATH" \
        -o volname="$(basename "$LOCAL_MOUNT_POINT")" \
        -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 \
        -o defer_permissions; then
        
        log_success "Mounted successfully!"
        open "$LOCAL_MOUNT_POINT"
    else
        log_error "Mount failed."
        exit 1
    fi
}

unmount_remote_drive() {
    if ! mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_warn "Drive is not mounted."
        exit 0
    fi

    log_info "Unmounting $LOCAL_MOUNT_POINT..."
    
    if umount "$LOCAL_MOUNT_POINT" 2>/dev/null || diskutil unmount force "$LOCAL_MOUNT_POINT"; then
        log_success "Unmounted successfully."
        # Optional: Remove the empty directory after unmounting
        rmdir "$LOCAL_MOUNT_POINT" 2>/dev/null
    else
        log_error "Failed to unmount. Files might be in use."
        exit 1
    fi
}

case "$1" in
    mount)   mount_remote_drive ;;
    unmount) unmount_remote_drive ;;
    init)    rm -f "$CONFIG_FILE" && init ;;
    *)       log_error "Invalid command." ; exit 1 ;;
esac