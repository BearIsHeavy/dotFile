#!/bin/bash

# ==============================================================================
# Script: uninstall_mac_app.sh
# Description: Uninstalls a macOS app and thoroughly cleans up residual files
#              (logs, caches, preferences, application support data).
# Usage: ./uninstall_mac_app.sh "AppName" OR ./uninstall_mac_app.sh "/path/to/App.app"
# ==============================================================================

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if an argument was provided
if [ -z "$1" ]; then
    log_error "Please provide the name of the app or the path to the .app file."
    echo "Usage: $0 \"Google Chrome\""
    echo "       $0 \"/Applications/Google Chrome.app\""
    exit 1
fi

APP_INPUT="$1"
APP_PATH=""

# Determine the absolute path of the app
if [[ "$APP_INPUT" == /* && -d "$APP_INPUT" && "$APP_INPUT" == *.app ]]; then
    APP_PATH="$APP_INPUT"
else
    # Strip .app suffix if user provided it but didn't provide a full path
    APP_NAME_CLEAN=$(basename "$APP_INPUT" .app)
    
    # Look in standard Application directories
    if [ -d "/Applications/$APP_NAME_CLEAN.app" ]; then
        APP_PATH="/Applications/$APP_NAME_CLEAN.app"
    elif [ -d "$HOME/Applications/$APP_NAME_CLEAN.app" ]; then
        APP_PATH="$HOME/Applications/$APP_NAME_CLEAN.app"
    else
        log_error "Could not find application '$APP_NAME_CLEAN' in standard directories."
        exit 1
    fi
fi

APP_NAME=$(basename "$APP_PATH" .app)
PLIST_FILE="$APP_PATH/Contents/Info.plist"
BUNDLE_ID=""

# Extract the Bundle Identifier (Crucial for finding caches and preferences)
if [ -f "$PLIST_FILE" ]; then
    BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$PLIST_FILE" 2>/dev/null)
    log_info "Found App: $APP_NAME"
    if [ -n "$BUNDLE_ID" ]; then
        log_info "Bundle Identifier: $BUNDLE_ID"
    else
        log_warn "Could not extract Bundle Identifier. Searching by app name only."
    fi
else
    log_warn "Info.plist not found. Proceeding with name-based search only."
fi

echo "--------------------------------------------------"
log_info "Scanning for associated files and folders..."

# Define potential locations for residual files
declare -a SEARCH_PATHS
SEARCH_PATHS+=("$APP_PATH")

# Paths based on Bundle ID (Primary method for modern macOS apps)
if [ -n "$BUNDLE_ID" ]; then
    SEARCH_PATHS+=("$HOME/Library/Application Support/$BUNDLE_ID")
    SEARCH_PATHS+=("$HOME/Library/Caches/$BUNDLE_ID")
    SEARCH_PATHS+=("$HOME/Library/Preferences/$BUNDLE_ID.plist")
    SEARCH_PATHS+=("$HOME/Library/Preferences/ByHost/$BUNDLE_ID"*.plist)
    SEARCH_PATHS+=("$HOME/Library/Logs/$BUNDLE_ID")
    SEARCH_PATHS+=("$HOME/Library/Containers/$BUNDLE_ID")
    SEARCH_PATHS+=("$HOME/Library/Saved Application State/$BUNDLE_ID.savedState")
    SEARCH_PATHS+=("$HOME/Library/WebKit/$BUNDLE_ID")
    SEARCH_PATHS+=("$HOME/Library/HTTPStorages/$BUNDLE_ID")
    
    # Global paths (requires sudo to delete)
    SEARCH_PATHS+=("/Library/Application Support/$BUNDLE_ID")
    SEARCH_PATHS+=("/Library/Caches/$BUNDLE_ID")
    SEARCH_PATHS+=("/Library/Preferences/$BUNDLE_ID.plist")
    SEARCH_PATHS+=("/Library/Logs/$BUNDLE_ID")
fi

# Paths based strictly on App Name (Fallback for older apps or specific developer choices)
SEARCH_PATHS+=("$HOME/Library/Application Support/$APP_NAME")
SEARCH_PATHS+=("$HOME/Library/Caches/$APP_NAME")
SEARCH_PATHS+=("$HOME/Library/Preferences/$APP_NAME.plist")
SEARCH_PATHS+=("$HOME/Library/Logs/$APP_NAME")
SEARCH_PATHS+=("$HOME/Library/Saved Application State/$APP_NAME.savedState")
SEARCH_PATHS+=("/Library/Application Support/$APP_NAME")
SEARCH_PATHS+=("/Library/Caches/$APP_NAME")
SEARCH_PATHS+=("/Library/Logs/$APP_NAME")

# Filter paths to only those that actually exist on the disk
declare -a FILES_TO_DELETE

for path in "${SEARCH_PATHS[@]}"; do
    # Handle wildcard expansion for ByHost preferences
    for expanded_path in $path; do
        if [ -e "$expanded_path" ]; then
            # Ensure we don't accidentally add root or user home directory
            if [[ "$expanded_path" != "/" && "$expanded_path" != "$HOME" && "$expanded_path" != "$HOME/" ]]; then
                # Avoid duplicates
                if [[ ! " ${FILES_TO_DELETE[*]} " =~ " ${expanded_path} " ]]; then
                    FILES_TO_DELETE+=("$expanded_path")
                fi
            fi
        fi
    done
done

# If nothing was found (highly unlikely if the .app exists)
if [ ${#FILES_TO_DELETE[@]} -eq 0 ]; then
    log_warn "No files found to delete."
    exit 0
fi

# Display the files to the user
echo ""
echo -e "${YELLOW}The following files and directories will be PERMANENTLY DELETED:${NC}"
for file in "${FILES_TO_DELETE[@]}"; do
    echo "  - $file"
done
echo "--------------------------------------------------"

# Prompt for confirmation
read -p "Are you sure you want to proceed with deletion? (y/n): " confirm_ans < /dev/tty

if [[ ! $confirm_ans =~ ^(y|Y|yes|Yes)$ ]]; then
    log_warn "Operation cancelled by user. Nothing was deleted."
    exit 0
fi

# # Execute deletion
echo ""
log_info "Deleting files..."
REQUIRES_SUDO=false

for file in "${FILES_TO_DELETE[@]}"; do
    # Try to delete normally first
    if rm -rf "$file" 2>/dev/null; then
        echo -e "  ${GREEN}✓ Deleted:${NC} $file"
    else
        # If normal deletion fails, flag for sudo
        REQUIRES_SUDO=true
        echo -e "  ${YELLOW}✗ Permission denied:${NC} $file (Will attempt with sudo)"
    fi
done

# Handle files that require administrator privileges (common for /Applications or /Library)
if [ "$REQUIRES_SUDO" = true ]; then
    echo ""
    log_warn "Some files require administrator privileges to delete."
    # Prompting for sudo password
    for file in "${FILES_TO_DELETE[@]}"; do
        if [ -e "$file" ]; then
            sudo rm -rf "$file"
            if [ ! -e "$file" ]; then
                echo -e "  ${GREEN}✓ Deleted (sudo):${NC} $file"
            else
                echo -e "  ${RED}✗ Failed to delete:${NC} $file"
            fi
        fi
    done
fi

echo ""
log_success "Uninstallation of $APP_NAME complete!"