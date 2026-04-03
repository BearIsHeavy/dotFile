# Dotfiles Configuration

Personal dotfiles configuration for **Ubuntu/Debian** systems.

## Directory Structure

```
.dotfile/
├── main.sh                     # Unified entry point (run this first)
│
├── scripts/                    # All setup scripts
│   ├── bootstrap/              # Fresh OS bootstrap
│   │   └── ubuntu.sh
│   │
│   ├── requirements/           # Package requirements
│   │   └── ubuntu.sh
│   │
│   └── init/                   # Module initialization
│       ├── vpn.sh              # VPN configuration
│       ├── zsh.sh              # Zsh setup
│       ├── vim.sh              # Vim setup
│       ├── nvim.sh             # Neovim setup
│       ├── tools.sh            # Additional tools
│       ├── fonts.sh            # Terminal fonts
│       ├── conda.sh            # Conda setup
│       ├── colors.sh           # Color variables
│       ├── neovide.sh          # Neovide setup
│       └── uv.sh               # UV Python package manager
│
├── generalConfig/              # Configuration files
│   ├── .alias
│   ├── .bashrc
│   ├── .profile
│   ├── .tmux.conf
│   └── .vimrc
│
├── zshconfig/                  # Zsh configuration
│   ├── .zlogin
│   ├── .zshenv
│   ├── .zshrc
│   └── trigger.sh
│
├── nvim/                       # Neovim configuration
│   ├── coc-settings.json
│   ├── init.lua
│   ├── lua/
│   └── plugin/
│
├── bin/                        # Custom scripts
│   └── src/
│
├── vscode_config/
├── README.md
└── .gitignore
```

---

## Quick Start

```bash
# Clone the repository
cd ~
git clone <your-repo-url> .dotfile
cd .dotfile

# Run the unified setup
bash main.sh
```

---

## Usage

### Interactive Menu

Running `bash main.sh` will show an interactive menu:

```
========================================
  Dotfiles Setup
  OS: Ubuntu 24.04 LTS
========================================

Please select an option:
  1) Full setup (recommended)
  2) Install packages only
  3) Create symlinks only
  4) Setup individual modules
  5) Exit
```

### Full Setup

Option 1 will:
1. Install system packages
2. Create symlinks for config files
3. Setup all modules (VPN, Zsh, Vim, Neovim, Tools, Fonts)

### Individual Modules

Option 4 allows you to setup specific modules:
- VPN
- Zsh
- Vim
- Neovim
- Tools
- Fonts
- Conda
- Neovide
- UV (Python package manager)

---

## Manual Setup

### Install Packages

```bash
bash scripts/requirements/ubuntu.sh
```

### Create Symlinks

```bash
bash main.sh  # Select option 3
```

### Setup Individual Module

```bash
bash scripts/init/vpn.sh
bash scripts/init/zsh.sh
bash scripts/init/vim.sh
bash scripts/init/nvim.sh
bash scripts/init/tools.sh
bash scripts/init/fonts.sh
```

---

## Recommended Setup Order

1. **VPN** (if behind firewall - needed for GitHub access)
   ```bash
   bash scripts/init/vpn.sh
   ```

2. **Full Setup**
   ```bash
   bash main.sh
   ```

---

## Troubleshooting

### Common Issues

1. **Symlink creation fails**
   - Ensure you're running from the `.dotfile` directory
   - Check if target files already exist in `$HOME`

2. **Package installation fails**
   - Run `sudo apt update` first

3. **Neovim plugins fail to install**
   - Ensure VPN/proxy is configured if behind a firewall
   - Check internet connection

4. **Font display issues**
   - Install a Nerd Font (e.g., JetBrains Mono Nerd Font)
   - Configure your terminal to use the installed font

### Error Codes

| Code | Module | Description |
|------|--------|-------------|
| 2 | main.sh | Wrong working directory |

---

## Customization

### Per-Machine Configuration

Edit `zshconfig/.zprofile` for machine-specific settings. This file is git-ignored by default.

### Adding New Packages

Add to `scripts/requirements/ubuntu.sh`

---

## License

Personal configuration files. Feel free to use and modify for your own setup.
