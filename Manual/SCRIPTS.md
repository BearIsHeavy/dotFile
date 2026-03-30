# Utility Scripts

This document describes the utility scripts in the `bin/` directory.

## Scripts Overview

| Script | Description |
|--------|-------------|
| `mount.sh` | Unified SMB and SSHFS mount manager |
| `enableProxy.sh` | Configure system proxy settings |
| `uninstall_mac_app.sh` | Completely uninstall macOS applications |

## Usage

### mount.sh

Unified mount script supporting both SMB (Windows/NAS) and SSHFS (SSH mounting).

```bash
# Interactive mode (choose mount type)
./bin/mount.sh

# Show help
./bin/mount.sh -h

# Mount SMB share directly
./bin/mount.sh -t smb mount

# Unmount SSHFS
./bin/mount.sh -t sshfs unmount

# Reinitialize configuration
./bin/mount.sh -t smb init

# Check mount status
./bin/mount.sh status
```

**Mount Types:**

| Type | Description | Best For |
|------|-------------|----------|
| `smb` | SMB/CIFS mount | Windows file sharing, NAS devices (Synology, QNAP) |
| `sshfs` | SSH File System | Remote Linux servers, cloud VMs, secure connections |

**Configuration Files:**
- SMB: `~/configs/.smb_mount_config`
- SSHFS: `~/configs/.sshfs_mount_config`

**Prerequisites for SSHFS:**
```bash
brew install --cask macfuse
brew install sshfs
```

### enableProxy.sh

Configure proxy settings with persistent configuration.

```bash
# Enable proxy (interactive mode)
eval $(bash ~/.dotfile/bin/enableProxy.sh)
```

**Note:** This script uses interactive prompts to configure proxy settings. It does NOT accept command-line arguments like `on` or `off`. On first run, it will prompt for the proxy IP address and save it to `~/configs/.proxy_config` for future use.

### uninstall_mac_app.sh

Completely uninstall macOS applications, removing all associated files.

```bash
./bin/uninstall_mac_app.sh <ApplicationName>
```

**Example:**
```bash
./bin/uninstall_mac_app.sh "Google Chrome"
```

This script removes:
- Application bundle from `/Applications`
- Preferences and support files from `~/Library`
- Caches and logs

## Setup

Ensure scripts are executable:

```bash
chmod +x ~/.dotfile/bin/*.sh
```

Add to your PATH by adding this to `.zshrc`:

```bash
export PATH="$HOME/.dotfile/bin:$PATH"
```
