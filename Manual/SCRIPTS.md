# Utility Scripts

This document describes the utility scripts in the `bin/` directory.

## Scripts Overview

| Script | Description |
|--------|-------------|
| `enableProxy.sh` | Configure system proxy settings |
| `SMB_mount.sh` | Mount SMB network shares |
| `SSHFS_mount.sh` | Mount remote filesystems via SSHFS |
| `uninstall_mac_app.sh` | Completely uninstall macOS applications |

## Usage

### enableProxy.sh

Enable or disable proxy settings for development environments.

```bash
# Enable proxy
./bin/enableProxy.sh on

# Disable proxy
./bin/enableProxy.sh off
```

### SMB_mount.sh

Mount SMB network shares on macOS.

```bash
./bin/SMB_mount.sh <server> <share> <mountpoint>
```

**Example:**
```bash
./bin/SMB_mount.sh 192.168.1.100 public /Volumes/smb-share
```

### SSHFS_mount.sh

Mount remote filesystems using SSHFS.

```bash
./bin/SSHFS_mount.sh <user@host> <remote-path> <local-mountpoint>
```

**Example:**
```bash
./bin/SSHFS_mount.sh user@server.com:/home/user/project ~/mnt/project
```

**Prerequisites:**
```bash
brew install macfuse sshfs
```

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
