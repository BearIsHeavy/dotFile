# Dotfiles - macOS Development Environment

A curated collection of configuration files and scripts for setting up a productive macOS development environment.

## Quick Start

```bash
# Clone the repository
git clone git@github.com:<your-username>/dotfiles.git ~/.dotfile

# Source the configurations (or restart your terminal)
source ~/.dotfile/generalConfig/.zshrc
```

## Project Structure

```
~/.dotfile/
├── README.md                 # This file - project overview
├── Manual/                   # Documentation & guides
├── bin/                      # Custom shell scripts
├── configs/                  # Cached configuration data
├── generalConfig/            # Cross-platform configurations
├── nvim/                     # Neovim configuration
└── zshconfig/                # Zsh shell configuration
```

## Configuration Modules

### Shell & Terminal (`zshconfig/`)
Zsh shell configuration with plugins and aliases for enhanced productivity.

- `.zshrc` - Main zsh configuration
- `.zprofile` - Login shell settings
- `.zshenv` - Environment variables

### General Configurations (`generalConfig/`)
Cross-platform configuration files:

| File | Description |
|------|-------------|
| `.alias` | Shell command aliases |
| `.bashrc` | Bash shell configuration |
| `.profile` | Profile settings |
| `.tmux.conf` | Tmux terminal multiplexer |
| `.vimrc` | Vim editor settings |

### Neovim (`nvim/`)
Modern Neovim configuration with Lua-based setup:

- LSP support for multiple languages
- Debugging with DAP
- Plugin management

See [Manual/NVIM_CPP_SETUP.md](Manual/NVIM_CPP_SETUP.md) for C/C++ development setup.

### Editor Vim Emulation
Unified Vim keybindings for seamless switching between editors:

| Editor | Config File |
|--------|-------------|
| IntelliJ IDEA | `idea_config/.ideavimrc` |
| VSCode | `vscode_setting/settings.json` |

See [Manual/VIM_KEYBINDINGS.md](Manual/VIM_KEYBINDINGS.md) for complete keybinding reference.

### Scripts (`bin/`)
Utility scripts for common tasks:

| Script | Description |
|--------|-------------|
| `enableProxy.sh` | Configure proxy settings |
| `SMB_mount.sh` | Mount SMB network shares |
| `SSHFS_mount.sh` | Mount remote filesystems via SSHFS |
| `uninstall_mac_app.sh` | Clean uninstall macOS applications |

## Documentation

Detailed guides and references are available in the [`Manual/`](Manual/) directory:

| Document | Description |
|----------|-------------|
| [VIM_KEYBINDINGS.md](Manual/VIM_KEYBINDINGS.md) | Unified Vim keybindings for IDEA and VSCode |
| [NVIM_CPP_SETUP.md](Manual/NVIM_CPP_SETUP.md) | Neovim C/C++ development environment setup |
| [SHELL_CONFIG.md](Manual/SHELL_CONFIG.md) | Shell configuration guide (zsh, tmux, aliases) |
| [SCRIPTS.md](Manual/SCRIPTS.md) | Utility scripts reference |

## Prerequisites

- macOS (primary target)
- Homebrew (package manager)
- Git

## Installation Notes

1. **Homebrew Packages** (recommended):
   ```bash
   brew install neovim tmux ripgrep fzf
   ```

2. **Font**: Install a Nerd Font (e.g., FiraCode Nerd Font) for proper icon rendering.

3. **Symlink Configurations**:
   ```bash
   ln -s ~/.dotfile/generalConfig/.vimrc ~/.vimrc
   ln -s ~/.dotfile/generalConfig/.tmux.conf ~/.tmux.conf
   ```

## License

Personal configuration files - feel free to adapt for your own use.
