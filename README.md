# Dotfiles Configuration

Personal dotfiles for **Ubuntu/Debian** systems with automated setup.

---

## Quick Start

```bash
# 1. Install Git (may not be pre-installed on fresh systems)
sudo apt update && sudo apt install -y git

# 2. Clone the repository (MUST be ~/.dotfile)
cd ~
git clone <your-repo-url> .dotfile
cd .dotfile

# 3. Run the unified setup
bash main.sh
```

---

## Interactive Menu

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

### Options

| # | Feature | Description |
|---|---------|-------------|
| **1** | Full setup | One-click: packages → symlinks → modules → optional (VPN/Conda/Docker/UV) |
| **2** | Packages only | Run `scripts/requirements/ubuntu.sh` |
| **3** | Symlinks only | Link config files to `~` |
| **4** | Individual modules | Pick specific modules to install |
| **5** | Exit | Do nothing |

---

## Full Setup Flow

### Step 1: Install System Packages

`scripts/requirements/ubuntu.sh` installs:

| Category | Packages |
|----------|----------|
| **Version control** | `git` |
| **Network** | `curl`, `wget`, `httpie`, `net-tools`, `openssh-client`, `openssh-server` |
| **Editors** | `vim`, `neovim` |
| **Terminal** | `tmux`, `zsh` |
| **Build tools** | `build-essential`, `gcc`, `g++`, `make`, `cmake` |
| **Python/Node** | `python3`, `python3-pip`, `nodejs`, `npm` |
| **Search/Browse** | `ripgrep`, `fd-find`, `fzf`, `eza`, `bat`, `tree` |
| **Utilities** | `jq`, `htop`, `tldr`, `gnupg` |

### Step 2: Create Symlinks

| Source | Target |
|--------|--------|
| `.zsh/` | `~/.zsh/` |
| `generalConfig/.profile` | `~/.profile` |
| `generalConfig/.bashrc` | `~/.bashrc` |
| `generalConfig/.vimrc` | `~/.vimrc` |
| `generalConfig/.tmux.conf` | `~/.tmux.conf` |
| `zshconfig/.zshrc` | `~/.zshrc` |
| `zshconfig/.zshenv` | `~/.zshenv` |
| `zshconfig/.zlogin` | `~/.zlogin` |
| `zshconfig/.zprofile` | `~/.zprofile` |
| `bin/` | `~/bin/` |

Existing files are backed up to `.bak` automatically.

### Step 3: Auto-Setup Modules

| Module | Script | What it does |
|--------|--------|-------------|
| **Zsh** | `scripts/init/zsh.sh` | Installs zsh, zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search, z, offers to set as default shell |
| **Vim** | `scripts/init/vim.sh` | Installs vim-plug plugin manager |
| **Neovim** | `scripts/init/nvim.sh` | Downloads latest Neovim binary, symlinks `~/.config/nvim` |
| **Tools** | `scripts/init/tools.sh` | Installs tmux, shellcheck, eza, tealdeer (tldr replacement) |
| **Fonts** | `scripts/init/fonts.sh` | Downloads and installs 0xProto Nerd Font |

### Step 4: Optional Modules (interactive prompts)

After the auto-setup, you'll be asked:

```
VPN/Clash is optional. Install now? (y/N):
Conda (Anaconda) — install now? (y/N):
Docker CE — install now? (y/N):
UV (Python package manager) — install now? (y/N):
```

All default to **No** — select `y` only if you need them.

---

## Individual Modules (Menu Option 4)

| # | Module | Script |
|---|--------|--------|
| 1 | VPN | `scripts/init/vpn.sh` |
| 2 | Zsh | `scripts/init/zsh.sh` |
| 3 | Vim | `scripts/init/vim.sh` |
| 4 | Neovim | `scripts/init/nvim.sh` |
| 5 | Tools | `scripts/init/tools.sh` |
| 6 | Fonts | `scripts/init/fonts.sh` |
| 7 | Conda | `scripts/init/conda.sh` |
| 8 | Neovide | `scripts/init/neovide.sh` |
| 9 | UV | `scripts/init/uv.sh` |
| 10 | Docker | `scripts/init/docker.sh` |

---

## After Setup

### Reload Shell

```bash
source ~/.zshrc
```

Or simply exit and re-open the terminal.

### Neovim Plugins

```bash
nvim
# packer.nvim auto-installs on first launch
# Then run:
:PackerSync
```

### Vim Plugins

```bash
vim +PlugInstall +qall
```

### Tmux Config

```bash
tmux source-file ~/.tmux.conf
```

### Zsh Plugins

Four plugins are installed and loaded automatically:

| Plugin | Effect |
|--------|--------|
| **zsh-autosuggestions** | Grey hints as you type, → to complete |
| **zsh-syntax-highlighting** | Commands turn green (valid) or red (invalid) in real-time |
| **zsh-history-substring-search** | ↑/↓ arrows search history by what you've typed |
| **z** | Smart directory jumper — `z proj` jumps to most-visited path containing "proj" |

---

## Directory Structure

```
.dotfile/
├── main.sh                     # Unified entry point (run this first)
│
├── scripts/
│   ├── bootstrap/              # Fresh OS bootstrap
│   │   └── ubuntu.sh           # Mirror/NVIDIA/firewall setup
│   ├── requirements/           # Package requirements
│   │   └── ubuntu.sh           # apt install list
│   └── init/                   # Module initialization
│       ├── vpn.sh              # VPN/Clash
│       ├── zsh.sh              # Zsh + plugins
│       ├── vim.sh              # Vim + vim-plug
│       ├── nvim.sh             # Neovim binary + config
│       ├── tools.sh            # tmux, eza, shellcheck, tealdeer
│       ├── fonts.sh            # Nerd Font download
│       ├── conda.sh            # Anaconda installer
│       ├── docker.sh           # Docker CE auto-install
│       ├── neovide.sh          # Neovide dependencies
│       ├── uv.sh               # UV Python package manager
│       └── colors.sh           # Color variables (sourced by other scripts)
│
├── generalConfig/              # Shell/terminal config
│   ├── .alias                  # Shell aliases
│   ├── .bashrc
│   ├── .profile
│   ├── .tmux.conf
│   └── .vimrc
│
├── zshconfig/                  # Zsh config
│   ├── .zshrc
│   ├── .zshenv
│   ├── .zlogin
│   ├── .zprofile
│   └── trigger.sh              # Dynamic prompt (git branch, proxy status, etc.)
│
├── nvim/                       # Neovim config
│   ├── init.lua
│   ├── coc-settings.json
│   ├── lua/
│   └── plugin/
│
├── bin/                        # Custom scripts
│   └── src/
│
├── vscode_config/              # VS Code settings
├── README.md
└── .gitignore
```

---

## Proxy Setup

When running `bash main.sh`, you'll be asked:

```
Do you need to configure a network proxy? (y/N):
```

If `y`, enter your proxy address (e.g. `127.0.0.1:7890`). This sets `http_proxy`/`https_proxy`/`all_proxy` for all subsequent operations (apt, git clone, curl, etc.).

---

## Troubleshooting

### Symlink creation fails

- Ensure you're running from the `.dotfile` directory
- Existing files are automatically backed up to `.bak`

### Package installation fails

```bash
sudo apt update
```

Then re-run `bash main.sh`.

### Neovim plugins fail

- Ensure network/proxy is configured
- Run `:checkhealth` inside Neovim for diagnostics

### Font display issues

- Install a Nerd Font (0xProto is included by this project)
- Set your terminal font to the installed Nerd Font

### Zsh auto-completion not working

- Ensure `~/.zsh/zsh-autosuggestions/` exists
- If not: `bash ~/.dotfile/scripts/init/zsh.sh`

### Docker commands require sudo

- After Docker install, you must re-login for the `docker` group to take effect
- Or run: `newgrp docker`

---

## Customization

### Per-Machine Config

Edit `zshconfig/.zprofile` for machine-specific settings. This file is git-ignored by default.

### Adding New Packages

Add to `scripts/requirements/ubuntu.sh`

---

## ⚠️ Known Limitations

| Item | Details |
|------|---------|
| **Repo path** | Must be cloned to `~/.dotfile` (`.bashrc` hardcodes this path) |
| **Conda init** | Commented out in `.bashrc` — run `conda init` manually after installing Anaconda |
| **Anaconda version** | `conda.sh` pins `Anaconda3-2024.10-1` — if the URL is stale, download manually |
| **setProxy alias** | Depends on `~/bin/enableProxy` which is not in this repo — create your own |
| **tealdeer (tldr)** | Requires Rust/cargo — if not available, install manually: `cargo install tealdeer` |

---

## License

Personal configuration files. Feel free to use and modify for your own setup.
