#!/bin/bash

# ==============================================================================
# Script: set_proxy.sh
# Description: Manages shell proxy settings with persistent configuration.
# Usage: eval $(bash set_proxy.sh)
# ==============================================================================

# ANSI Color Codes (Sent to stderr to avoid breaking eval)
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_green()  { echo -e "${GREEN}$1${NC}" >&2; }
log_yellow() { echo -e "${YELLOW}$1${NC}" >&2; }

# ASCII Art (Sent to stderr)
echo "
__________   __   __                   __          
\______   \_/  |__/  |_____________    ____ |  | __  
 |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /  
 |    |    \ |  |  |  |  |  | \// __ \\  \___|    <   
 |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
        \/                         \/     \/     \/  
" >&2

# --- Config Setup ---
CONFIG_DIR="$HOME/configs"
CONFIG_FILE="$CONFIG_DIR/.proxy_config"

# Ensure config directory exists
if [[ ! -d "$CONFIG_DIR" ]]; then
    mkdir -p "$CONFIG_DIR"
fi

# --- Detection Logic ---
get_default_host_ip() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "127.0.0.1"
    else
        if command -v ip >/dev/null 2>&1; then
            ip route show | grep -i default | awk '{ print $3 }'
        else
            echo "127.0.0.1"
        fi
    fi
}

# --- Initialization / Loading ---
if [[ -f "$CONFIG_FILE" ]]; then
    # We source it here to get the variable into this script's memory
    source "$CONFIG_FILE"
    log_green "Loaded saved proxy IP: $SAVED_PROXY_IP"
    read -r -p "Do you want to change this IP? (y/n): " change_ans < /dev/tty
else
    change_ans="y"
fi

if [[ $change_ans =~ ^(y|Y) ]]; then
    default_ip=$(get_default_host_ip)
    log_yellow "Detected default IP: $default_ip"
    read -r -p "Enter proxy IP [Enter for $default_ip]: " input_ip < /dev/tty
    
    proxy_ip=${input_ip:-$default_ip}
    
    # Save to config
    echo "SAVED_PROXY_IP=\"$proxy_ip\"" > "$CONFIG_FILE"
    SAVED_PROXY_IP="$proxy_ip"
    log_green "Configuration saved to $CONFIG_FILE"
fi

# --- Output for eval ---
# This part is sent to stdout so 'eval' can capture it.
echo "export https_proxy=http://$SAVED_PROXY_IP:7890"
echo "export http_proxy=http://$SAVED_PROXY_IP:7890"
echo "export all_proxy=socks5://$SAVED_PROXY_IP:7890"