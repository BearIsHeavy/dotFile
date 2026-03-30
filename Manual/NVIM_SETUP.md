# Neovim Setup Guide

This guide documents the Neovim configuration, installed plugins, and their usage.

## Table of Contents

1. [Installation](#installation)
2. [Directory Structure](#directory-structure)
3. [Plugins Overview](#plugins-overview)
4. [Keybindings](#keybindings)
5. [Plugin Usage Guide](#plugin-usage-guide)

---

## Installation

### Prerequisites

```bash
# macOS
brew install neovim

# Install language servers (optional but recommended)
brew install lua-language-server  # Lua
brew install pyright            # Python
brew install clangd             # C/C++
brew install typescript         # JavaScript/TypeScript
brew install ripgrep            # For Telescope live_grep
```

### Setup

```bash
# Clone dotfiles (if not already done)
git clone <your-repo> ~/.dotfile

# Symlink Neovim config
ln -s ~/.dotfile/nvim ~/.config/nvim

# Open Neovim and install plugins
nvim
:PackerSync
```

---

## Directory Structure

```
~/.dotfile/nvim/
├── init.lua              # Main entry point
├── lua/
│   ├── core/
│   │   ├── options.lua   # Editor options
│   │   └── keymaps.lua   # Keybindings
│   └── plugins/
│       ├── plugins-setup.lua  # Plugin definitions
│       ├── lsp.lua            # LSP configuration
│       ├── cmp.lua            # Auto-completion
│       ├── telescope.lua      # Fuzzy finder
│       ├── nvim-tree.lua      # File explorer
│       ├── treesitter.lua     # Syntax highlighting
│       ├── bufferline.lua     # Buffer tabs
│       ├── lualine.lua        # Status line
│       ├── gitsigns.lua       # Git signs
│       ├── comment.lua        # Comment toggling
│       ├── autopairs.lua      # Auto pairs
│       ├── tokyonight.lua     # Color scheme
│       ├── vim-sneak.lua      # Enhanced motion
│       └── dap.lua            # Debugger
└── .clangd                 # Clangd configuration
```

---

## Plugins Overview

| Plugin | Purpose |
|--------|---------|
| **packer.nvim** | Plugin manager |
| **tokyonight.nvim** | Color scheme |
| **lualine.nvim** | Status bar |
| **nvim-tree.lua** | File explorer |
| **nvim-treesitter** | Syntax highlighting |
| **mason.nvim** | LSP package manager |
| **nvim-lspconfig** | LSP configuration |
| **nvim-cmp** | Auto-completion |
| **LuaSnip** | Snippets engine |
| **Comment.nvim** | Comment toggling |
| **nvim-autopairs** | Auto-close brackets |
| **bufferline.nvim** | Buffer tabs |
| **gitsigns.nvim** | Git integration |
| **telescope.nvim** | Fuzzy finder |
| **vim-sneak** | Enhanced motion |
| **nvim-dap** | Debug adapter protocol |
| **vim-tmux-navigator** | Tmux/window navigation |

---

## Keybindings

### Leader Key: `<Space>`

### General

| Keys | Action |
|------|--------|
| `jj` (insert) | Exit insert mode |
| `<Esc>` | Clear search highlight |
| `<leader>d` | Delete line |
| `K` | Insert line break |

### LSP Navigation

| Keys | Action |
|------|--------|
| `gh` | Hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `gR` | Rename symbol |
| `gs` | Signature help |
| `gf` | Format code |
| `[d` / `]d` | Previous/Next diagnostic |

### File Management

| Keys | Action |
|------|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>f` | Find files (Telescope) |
| `<leader>ff` | Fuzzy find files (same as `<leader>f`) |
| `<leader>fg` | Live grep in project |
| `<leader>fb` | List buffers |
| `<leader>fh` | Help tags |
| `<leader>w` | Close buffer |
| `H` / `L` | Previous/Next buffer |

### Code Actions

| Keys | Action |
|------|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |

### VSCode-Style Overrides

| Keys | Action |
|------|--------|
| `<C-s>` | Save file |
| `<C-a>` | Select all |
| `<C-f>` | Find in buffer |

### Window Management

| Keys | Action |
|------|--------|
| `<leader>sh` | Split horizontal |
| `<leader>sv` | Split vertical |
| `<C-h/j/k/l>` | Navigate windows |

### Terminal

| Keys | Action |
|------|--------|
| `<C-`>` (normal) | Open terminal |
| `<C-`>` (terminal) | Close terminal |

---

## Plugin Usage Guide

### 1. Tokenight (Color Scheme)

A beautiful, dark theme optimized for readability.

### 2. Lualine (Status Bar)

Displays mode, file info, git status, and LSP diagnostics.

### 3. Nvim-Tree (File Explorer)

A modern file explorer sidebar.

**Commands:**
- `:NvimTreeToggle` - Toggle explorer
- `:NvimTreeOpen` - Open explorer
- `:NvimTreeClose` - Close explorer

**Keybindings (inside NvimTree):**
| Key | Action |
|-----|--------|
| `<CR>` | Open file |
| `o` | Open in horizontal split |
| `v` | Open in vertical split |
| `a` | Create file/directory |
| `r` | Rename file |
| `d` | Delete file |
| `h` | Close directory |
| `l` | Open directory |

### 4. Treesitter (Syntax Highlighting)

Provides better syntax highlighting based on AST.

**Supported Languages:** vim, bash, c, cpp, javascript, json, lua, python, typescript, rust, markdown

### 5. Mason + LSPconfig (Language Servers)

**Commands:**
- `:Mason` - Open Mason UI
- `:MasonInstall <pkg>` - Install language server

**Installed Servers:** lua_ls, pyright, clangd, ts_ls

### 6. Nvim-CMP (Auto-Completion)

**Keybindings (insert mode):**
| Key | Action |
|-----|--------|
| `<Tab>` | Next completion |
| `<S-Tab>` | Previous completion |
| `<CR>` | Confirm selection |
| `<C-f>` | Scroll docs forward |
| `<C-b>` | Scroll docs backward |
| `<C-e>` | Abort completion |

### 7. Comment.nvim

| Keys | Action |
|------|--------|
| `gcc` | Toggle comment on current line |
| `gc` + motion | Comment motion |
| `gc` (visual) | Comment selected lines |

### 8. Nvim-Autopairs

Auto-closes `()`, `[]`, `{}`, `""`, `''`.

### 9. Bufferline (Buffer Tabs)

| Keys | Action |
|------|--------|
| `L` | Next buffer |
| `H` | Previous buffer |

### 10. Gitsigns (Git Integration)

Shows git changes: `+` (added), `~` (changed), `_` (deleted).

### 11. Telescope (Fuzzy Finder)

| Keys | Action |
|------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>fh` | Help tags |

### 12. Vim-Sneak (Enhanced Motion)

| Keys | Action |
|------|--------|
| `s<char><char>` | Jump forward to 2-char sequence |
| `S<char><char>` | Jump backward |

### 13. Nvim-DAP (Debugger)

Debugging with DAP protocol.

### 14. Vim-Tmux-Navigator

| Keys | Action |
|------|--------|
| `<C-h/j/k/l>` | Navigate windows/tmux panes |

---

## Customization

- **Add plugins:** Edit `lua/plugins/plugins-setup.lua`, then `:PackerSync`
- **Modify keybindings:** Edit `lua/core/keymaps.lua`
- **Change options:** Edit `lua/core/options.lua`
- **LSP config:** Edit `lua/plugins/lsp.lua`

---

## Troubleshooting

```vim
:PackerCompile        " Fix plugin loading
:PackerSync           " Sync plugins
:LspInfo              " Check LSP status
:Mason                " Manage language servers
```
