#!/bin/bash

# ==============================================================================
# Script: mount.sh
# Description: Unified mount script for SMB and SSHFS with interactive selection.
#              Supports persistent configuration with dotfile config support.
# ==============================================================================

set -e

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# --- Config Directory Setup ---
CONFIG_DIR="$HOME/configs"
DOTFILE_CONFIG_DIR="$HOME/.dotfile/configs"

ensure_config_dir() {
    if [[ ! -d "$CONFIG_DIR" ]]; then
        log_warn "Config directory not found. Linking to dotfiles..."
        mkdir -p "$DOTFILE_CONFIG_DIR"
        ln -s "$DOTFILE_CONFIG_DIR" "$CONFIG_DIR"
    fi
}

# --- Help Message ---
show_help() {
    cat << EOF | sed 's/\\033\[/\x1b[/g'
${BLUE}Mount Utility - Unified SMB and SSHFS Mount Manager${NC}

${GREEN}USAGE:${NC}
    $0 [OPTIONS] [COMMAND]

${GREEN}OPTIONS:${NC}
    -h, --help          Show this help message
    -t, --type TYPE     Mount type: 'smb' or 'sshfs' (skip interactive selection)

${GREEN}COMMANDS:${NC}
    mount               Mount the remote drive
    unmount             Unmount the remote drive
    init                Reinitialize configuration
    status              Show current mount status

${GREEN}MOUNT TYPES:${NC}
    ${YELLOW}smb${NC}    - SMB/CIFS mount (Windows file sharing, NAS devices)
                        Best for: Local network Windows PCs, Synology/QNAP NAS

    ${YELLOW}sshfs${NC}  - SSH File System (secure remote mounting over SSH)
                        Best for: Remote Linux servers, cloud VMs, secure connections

${GREEN}EXAMPLES:${NC}
    $0                        # Interactive mode (choose mount type)
    $0 -t smb mount           # Mount SMB share directly
    $0 --type sshfs unmount   # Unmount SSHFS mount
    $0 -t smb init            # Reinitialize SMB configuration
    $0 status                 # Check mount status

${GREEN}CONFIGURATION:${NC}
    SMB Config:   $CONFIG_DIR/.smb_mount_config
    SSHFS Config: $CONFIG_DIR/.sshfs_mount_config

EOF
}

# --- Configuration Functions ---

init_smb_config() {
    local config_file="$CONFIG_DIR/.smb_mount_config"
    
    log_warn "SMB First-time setup"
    echo ""
    read -p "Enter Remote IP (e.g. 192.168.10.7): " input_ip
    read -p "Enter Remote Username: " input_user
    read -p "Enter Remote Share Name (exact case): " input_share
    read -p "Enter Local Mount Name (e.g. Win_G): " input_mount_name

    cat <<EOF > "$config_file"
REMOTE_IP="$input_ip"
REMOTE_USER="$input_user"
REMOTE_SHARE="$input_share"
LOCAL_MOUNT_POINT="/Volumes/$input_mount_name"
EOF

    log_success "SMB configuration saved to $config_file"
}

init_sshfs_config() {
    local config_file="$CONFIG_DIR/.sshfs_mount_config"
    
    log_warn "SSHFS First-time setup"
    echo ""
    read -p "Enter Remote Server User (e.g., ubuntu): " input_user
    read -p "Enter Remote Server IP/Hostname (e.g., 192.168.1.100): " input_ip
    read -p "Enter Remote Path to Mount (e.g., /home/ubuntu/projects): " input_remote_path
    read -p "Enter Local Mount Folder Name (e.g., RemoteServer): " input_mount_name
    read -p "Enter path to SSH Private Key (e.g., ~/.ssh/id_ed25519) [Leave blank for default]: " input_key

    # Default key fallback
    if [[ -z "$input_key" ]]; then
        input_key="~/.ssh/id_rsa"
    fi

    cat <<EOF > "$config_file"
REMOTE_USER="$input_user"
REMOTE_IP="$input_ip"
REMOTE_PATH="$input_remote_path"
LOCAL_MOUNT_POINT="$HOME/Desktop/$input_mount_name"
SSH_KEY_PATH="$input_key"
EOF

    log_success "SSHFS configuration saved to $config_file"
}

load_smb_config() {
    local config_file="$CONFIG_DIR/.smb_mount_config"
    if [[ ! -f "$config_file" ]]; then
        init_smb_config
    fi
    source "$config_file"
    # Expand tilde in paths
    SSH_KEY_PATH="${SSH_KEY_PATH/#\~/$HOME}"
}

load_sshfs_config() {
    local config_file="$CONFIG_DIR/.sshfs_mount_config"
    if [[ ! -f "$config_file" ]]; then
        init_sshfs_config
    fi
    source "$config_file"
    # Expand tilde in key path
    SSH_KEY_PATH="${SSH_KEY_PATH/#\~/$HOME}"
}

# --- SMB Functions ---

smb_mount() {
    load_smb_config

    # Connectivity Check
    if ! ping -c 1 -W 1 "$REMOTE_IP" &>/dev/null; then
        log_error "Cannot reach $REMOTE_IP. Is the remote machine awake?"
        exit 1
    fi

    # Prepare Mount Point
    if [[ ! -d "$LOCAL_MOUNT_POINT" ]]; then
        log_warn "Creating mount point: $LOCAL_MOUNT_POINT"
        sudo mkdir -p "$LOCAL_MOUNT_POINT"
        sudo chown "$(whoami):staff" "$LOCAL_MOUNT_POINT"
    fi

    # Check if already mounted
    if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_warn "Already mounted at $LOCAL_MOUNT_POINT."
        exit 0
    fi

    log_info "Mounting //$REMOTE_USER@$REMOTE_IP/$REMOTE_SHARE..."

    if mount_smbfs -o soft "//$REMOTE_USER@$REMOTE_IP/$REMOTE_SHARE" "$LOCAL_MOUNT_POINT"; then
        log_success "Success! Mounted at $LOCAL_MOUNT_POINT"
        open "$LOCAL_MOUNT_POINT"
    else
        log_error "Mount failed (Input/output error)."
        echo "Troubleshooting Tips:"
        echo "  1. Ensure 'File Sharing' is enabled in Windows Settings."
        echo "  2. Verify Share Name '$REMOTE_SHARE' is exactly correct (Case Sensitive)."
        echo "  3. Check Windows Firewall (allow SMB/Port 445)."
        exit 1
    fi
}

smb_unmount() {
    load_smb_config

    if ! mount | grep -qEi "on $LOCAL_MOUNT_POINT"; then
        log_error "Drive is not mounted."
        log_warn "To manually unmount: diskutil unmount $LOCAL_MOUNT_POINT"
        exit 0
    fi

    log_info "Ejecting $LOCAL_MOUNT_POINT..."
    if diskutil unmount "$LOCAL_MOUNT_POINT"; then
        log_success "Unmounted successfully."
        [[ -d "$LOCAL_MOUNT_POINT" ]] && sudo rmdir "$LOCAL_MOUNT_POINT"
    else
        log_error "Failed to eject. Files might be in use."
        exit 1
    fi
}

# --- SSHFS Functions ---

sshfs_mount() {
    # Check dependencies
    if ! command -v sshfs &> /dev/null; then
        log_error "sshfs is not installed."
        echo "Install using Homebrew:"
        echo "  brew install --cask macfuse"
        echo "  brew install sshfs"
        exit 1
    fi

    load_sshfs_config

    # Check SSH connectivity
    log_info "Testing SSH connection to $REMOTE_IP..."
    if ! ssh -i "$SSH_KEY_PATH" -o ConnectTimeout=5 -q "$REMOTE_USER@$REMOTE_IP" exit; then
        log_error "Cannot connect to $REMOTE_IP via SSH. Check connection or SSH keys."
        exit 1
    fi

    # Prepare Mount Point
    if [[ ! -d "$LOCAL_MOUNT_POINT" ]]; then
        log_warn "Creating mount point: $LOCAL_MOUNT_POINT"
        mkdir -p "$LOCAL_MOUNT_POINT"
    fi

    # Check if already mounted
    if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_warn "Already mounted at $LOCAL_MOUNT_POINT."
        open "$LOCAL_MOUNT_POINT"
        exit 0
    fi

    log_info "Mounting $REMOTE_USER@$REMOTE_IP:$REMOTE_PATH..."

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

sshfs_unmount() {
    load_sshfs_config

    if ! mount | grep -q "on $LOCAL_MOUNT_POINT"; then
        log_warn "Drive is not mounted."
        exit 0
    fi

    log_info "Unmounting $LOCAL_MOUNT_POINT..."

    if umount "$LOCAL_MOUNT_POINT" 2>/dev/null || diskutil unmount force "$LOCAL_MOUNT_POINT"; then
        log_success "Unmounted successfully."
        rmdir "$LOCAL_MOUNT_POINT" 2>/dev/null
    else
        log_error "Failed to unmount. Files might be in use."
        exit 1
    fi
}

# --- Interactive Selection ---

select_mount_type() {
    echo ""
    echo "Select mount type:"
    echo "  1) SMB (Windows file sharing, NAS)"
    echo "  2) SSHFS (Secure SSH mounting)"
    echo ""
    read -p "Enter choice [1-2]: " choice

    case "$choice" in
        1) MOUNT_TYPE="smb" ;;
        2) MOUNT_TYPE="sshfs" ;;
        *) log_error "Invalid choice."; exit 1 ;;
    esac
}

show_status() {
    echo ""
    log_info "=== Mount Status ==="
    echo ""
    
    # Check SMB
    if [[ -f "$CONFIG_DIR/.smb_mount_config" ]]; then
        source "$CONFIG_DIR/.smb_mount_config"
        if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
            log_success "SMB: Mounted at $LOCAL_MOUNT_POINT"
        else
            log_info "SMB: Not mounted (config: $LOCAL_MOUNT_POINT)"
        fi
    else
        log_warn "SMB: Not configured"
    fi

    # Check SSHFS
    if [[ -f "$CONFIG_DIR/.sshfs_mount_config" ]]; then
        source "$CONFIG_DIR/.sshfs_mount_config"
        if mount | grep -q "on $LOCAL_MOUNT_POINT"; then
            log_success "SSHFS: Mounted at $LOCAL_MOUNT_POINT"
        else
            log_info "SSHFS: Not mounted (config: $LOCAL_MOUNT_POINT)"
        fi
    else
        log_warn "SSHFS: Not configured"
    fi
    echo ""
}

# --- Main Logic ---

MOUNT_TYPE=""
COMMAND=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -t|--type)
            MOUNT_TYPE="$2"
            shift 2
            ;;
        mount|unmount|init|status)
            COMMAND="$1"
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            echo "Use --help for usage information."
            exit 1
            ;;
    esac
done

# Ensure config directory exists
ensure_config_dir

# Handle status command separately (no mount type needed)
if [[ "$COMMAND" == "status" ]]; then
    show_status
    exit 0
fi

# Interactive mode: select mount type if not specified
if [[ -z "$MOUNT_TYPE" ]]; then
    select_mount_type
fi

# Validate mount type
if [[ "$MOUNT_TYPE" != "smb" && "$MOUNT_TYPE" != "sshfs" ]]; then
    log_error "Invalid mount type: $MOUNT_TYPE"
    echo "Use -t smb or -t sshfs"
    exit 1
fi

# Execute command
case "$COMMAND" in
    mount)
        if [[ "$MOUNT_TYPE" == "smb" ]]; then
            smb_mount
        else
            sshfs_mount
        fi
        ;;
    unmount)
        if [[ "$MOUNT_TYPE" == "smb" ]]; then
            smb_unmount
        else
            sshfs_unmount
        fi
        ;;
    init)
        if [[ "$MOUNT_TYPE" == "smb" ]]; then
            rm -f "$CONFIG_DIR/.smb_mount_config"
            init_smb_config
        else
            rm -f "$CONFIG_DIR/.sshfs_mount_config"
            init_sshfs_config
        fi
        ;;
    status)
        show_status
        ;;
    "")
        # No command provided, show help
        show_help
        ;;
    *)
        log_error "Invalid command: $COMMAND"
        exit 1
        ;;
esac
