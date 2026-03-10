# Dotfiles Configuration

Personal dotfiles configuration supporting both **Ubuntu** and **Arch Linux** distributions.

## Directory Structure

```
.dotfile/
├── Ubuntu/                       # Ubuntu-specific files
│   ├── requirements_ubuntu.sh    # Ubuntu package requirements
│   ├── setup_ubuntu.sh           # Ubuntu setup entry point
│   ├── ubuntu_initial_script.sh  # Fresh Ubuntu install script
│   └── ubuntu_initial.sh         # Ubuntu post-install config
│
├── Arch/                         # Arch-specific files
│   ├── requirements_arch.sh      # Arch package requirements
│   ├── setup_arch.sh             # Arch setup entry point
│   ├── arch_install.sh           # Fresh Arch install script
│   └── arch_initial.sh           # Arch post-install config
│
├── initial/                      # Shared initialization scripts
│   ├── build_dvwa.sh
│   ├── colors.sh
│   ├── conda.sh
│   ├── neovide.sh
│   ├── nvim.sh
│   ├── otherCommand.sh
│   ├── terminal_fonts.sh
│   ├── vim.sh
│   ├── vpn.sh
│   └── zsh.sh
│
├── generalConfig/                # Shared configuration files
│   ├── .alias
│   ├── .bashrc
│   ├── .profile
│   ├── .tmux.conf
│   └── .vimrc
│
├── zshconfig/                    # Zsh configuration
│   ├── .zlogin
│   ├── .zprofile
│   ├── .zshenv
│   ├── .zshrc
│   └── trigger.sh
│
├── nvim/                         # Neovim configuration
│   ├── coc-settings.json
│   ├── init.lua
│   ├── lua/
│   └── plugin/
│
├── .zsh/                         # Zsh plugins
│   ├── spaceship/
│   └── zsh-autosuggestions/
│
├── bin/                          # Custom scripts
│   ├── shell/
│   ├── src/
│   └── workshop/
│
├── main.sh                       # Symlink creator (shared)
├── README.md
├── .gitignore
└── bug_fixes.log
```

---

## Quick Start

### Ubuntu / Debian

```bash
# Clone the repository
cd ~
git clone <your-repo-url> .dotfile
cd .dotfile

# Run the Ubuntu setup script
bash Ubuntu/setup_ubuntu.sh
```

### Arch Linux / Manjaro

```bash
# Clone the repository
cd ~
git clone <your-repo-url> .dotfile
cd .dotfile

# Run the Arch setup script
bash Arch/setup_arch.sh
```

---

## Installation Guide

### Fresh OS Installation

#### Ubuntu

1. **Install Ubuntu** (22.04 LTS or later recommended)
2. **Run initial setup script:**
   ```bash
   cd ~/path/to/.dotfile/Ubuntu
   bash ubuntu_initial_script.sh
   ```
3. **Configure dotfiles:**
   ```bash
   cd ~/path/to/.dotfile
   bash Ubuntu/setup_ubuntu.sh
   ```

#### Arch Linux

1. **Install Arch Linux** (follow the [Arch Wiki Installation Guide](https://wiki.archlinux.org/title/Installation_guide))
2. **Run initial setup script:**
   ```bash
   cd ~/path/to/.dotfile/Arch
   bash arch_install.sh
   ```
3. **Configure desktop environment (optional):**
   ```bash
   cd ~/path/to/.dotfile/Arch
   bash arch_initial.sh
   ```
4. **Configure dotfiles:**
   ```bash
   cd ~/path/to/.dotfile
   bash Arch/setup_arch.sh
   ```

---

## Manual Setup (Advanced)

### Step 1: Install System Packages

**Ubuntu:**
```bash
bash Ubuntu/requirements_ubuntu.sh
```

**Arch Linux:**
```bash
bash Arch/requirements_arch.sh
```

### Step 2: Create Symlinks

```bash
bash main.sh
```

This will create symlinks for:
- `.profile`
- `.bashrc`
- `.vimrc`
- `.tmux.conf`
- `.zshrc`
- `.zshenv`
- `.zlogin`
- `.zsh/`
- `bin/`

### Step 3: Configure Individual Modules

Each module can be configured independently:

| Module | Script | Error Code |
|--------|--------|------------|
| VPN | `initial/vpn.sh` | 11 |
| Zsh | `initial/zsh.sh` | 12 |
| Vim | `initial/vim.sh` | 13 |
| Neovim | `initial/nvim.sh` | 14 |
| Other Tools | `initial/otherCommand.sh` | 15 |
| Terminal Fonts | `initial/terminal_fonts.sh` | 16 |

---

## Recommended Setup Order

1. **VPN Setup** (Recommended first - needed for GitHub access in some regions)
   ```bash
   bash initial/vpn.sh
   ```

2. **Zsh Configuration**
   ```bash
   bash initial/zsh.sh
   ```

3. **Vim Configuration**
   ```bash
   bash initial/vim.sh
   ```

4. **Neovim Configuration**
   ```bash
   bash initial/nvim.sh
   ```

5. **Additional Tools**
   ```bash
   bash initial/otherCommand.sh
   ```

6. **Terminal Fonts**
   ```bash
   bash initial/terminal_fonts.sh
   ```

---

## Distribution-Specific Notes

### Ubuntu

- Package manager: `apt`
- Tested on: Ubuntu 22.04 LTS, 24.04 LTS
- Default shell: Bash (Zsh needs to be installed)

### Arch Linux

- Package manager: `pacman` + `yay` (AUR helper)
- Tested on: Arch Linux (latest)
- Default shell: Bash (Zsh needs to be installed)
- AUR packages are installed automatically via `yay`

---

## Troubleshooting

### Common Issues

1. **Symlink creation fails**
   - Ensure you're running from the `.dotfile` directory
   - Check if target files already exist in `$HOME`

2. **Package installation fails**
   - Ubuntu: Run `sudo apt update` first
   - Arch: Run `sudo pacman -Sy` first

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
| 11 | vpn.sh | VPN setup failed |
| 12 | zsh.sh | Zsh setup failed |
| 13 | vim.sh | Vim setup failed |
| 14 | nvim.sh | Neovim setup failed |
| 15 | otherCommand.sh | Additional tools setup failed |

---

## Customization

### Per-Machine Configuration

Edit `zshconfig/.zprofile` for machine-specific settings. This file is git-ignored by default.

### Adding New Packages

- **Ubuntu:** Add to `Ubuntu/requirements_ubuntu.sh`
- **Arch:** Add to `Arch/requirements_arch.sh`

---

## License

Personal configuration files. Feel free to use and modify for your own setup.

---

## Contributing

This is a personal dotfiles repository. If you find any issues, feel free to open an issue or submit a PR.
