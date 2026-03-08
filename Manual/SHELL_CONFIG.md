# Shell Configuration Guide

This document describes the shell configuration files in this dotfiles repository.

## Directory Structure

```
~/.dotfile/
├── zshconfig/          # Zsh-specific configuration
└── generalConfig/      # Cross-shell configuration
```

## Zsh Configuration (`zshconfig/`)

| File | Purpose |
|------|---------|
| `.zshrc` | Main zsh configuration - aliases, plugins, prompt |
| `.zprofile` | Login shell settings - PATH, environment |
| `.zshenv` | Environment variables for all zsh instances |
| `.zlogin` | Login shell initialization (loaded after .zprofile) |
| `trigger.sh` | Custom trigger scripts for zsh |

### Setup

```bash
# Symlink zsh configuration
ln -s ~/.dotfile/zshconfig/.zshrc ~/.zshrc
ln -s ~/.dotfile/zshconfig/.zprofile ~/.zprofile
ln -s ~/.dotfile/zshconfig/.zshenv ~/.zshenv
```

## General Configuration (`generalConfig/`)

Cross-platform shell configurations:

| File | Description |
|------|-------------|
| `.alias` | Common command aliases |
| `.bashrc` | Bash shell configuration |
| `.profile` | POSIX profile settings |
| `.tmux.conf` | Tmux terminal multiplexer |
| `.vimrc` | Vim editor (basic) |

### Key Aliases

Common aliases defined in `.alias`:

- Navigation shortcuts
- Git shortcuts
- Common command improvements

### Tmux Configuration

The `.tmux.conf` provides:

- Custom keybindings (prefix: `Ctrl-a`)
- Status bar customization
- Plugin support

## Usage

After symlinking, restart your terminal or run:

```bash
source ~/.zshrc
```

For tmux:

```bash
# Reload tmux configuration
tmux source-file ~/.tmux.conf
```
