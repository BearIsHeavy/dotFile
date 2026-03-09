# Unified Vim Keybindings Reference

This document provides a unified keybinding reference for seamless switching between **Neovim**, **IDEA Vim**, and **VSCode Vim**.

## Common Settings (All Editors)

| Setting | Value | Description |
|---------|-------|-------------|
| Leader Key | `<Space>` | Primary modifier for custom bindings |
| Line Numbers | `set number` | Show absolute line numbers |
| Relative Numbers | `set relativenumber` | Show relative line numbers |
| Search | `incsearch`, `hlsearch` | Incremental search with highlighting |
| Case Sensitivity | `ignorecase`, `smartcase` | Smart case-insensitive search |
| Scroll Offset | `scrolloff=5` | Keep 5 lines visible at top/bottom |
| Insert Mode Exit | `jj` | Exit insert mode quickly |

---

## LSP Navigation (Code Intelligence)

| Keys | Action | Neovim | IDEA Vim | VSCode Vim |
|------|--------|--------|----------|------------|
| `gh` | Hover documentation | `vim.lsp.buf.hover()` | `QuickImplementations` | `editor.action.showHover` |
| `gd` | Go to definition | `vim.lsp.buf.definition()` | `GotoDeclaration` | `editor.action.revealDefinition` |
| `gD` | Go to declaration | `vim.lsp.buf.declaration()` | `GotoDeclaration` | `editor.action.revealDeclaration` |
| `gi` | Go to implementation | `vim.lsp.buf.implementation()` | `GotoImplementation` | `editor.action.goToImplementation` |
| `gr` | Find references | `vim.lsp.buf.references()` | `FindUsages` | `references-view.findReferences` |
| `gR` | Rename symbol | `vim.lsp.buf.rename()` | `RenameElement` | `editor.action.rename` |
| `gs` | Signature help | `vim.lsp.buf.signature_help()` | `ParameterInfo` | `editor.action.triggerParameterHints` |
| `gf` | Format code | `vim.lsp.buf.format()` | `ReformatCode` | `editor.action.formatDocument` |

---

## Diagnostics

| Keys | Action | Neovim | IDEA Vim | VSCode Vim |
|------|--------|--------|----------|------------|
| `[d` | Previous diagnostic | `vim.diagnostic.goto_prev()` | `PreviousError` | `editor.action.marker.prevInFile` |
| `]d` | Next diagnostic | `vim.diagnostic.goto_next()` | `NextError` | `editor.action.marker.nextInFile` |
| `<leader>dl` | Open diagnostic list | `vim.diagnostic.setloclist()` | - | - |

---

## UI & File Management

| Keys | Action | Neovim | IDEA Vim | VSCode Vim |
|------|--------|--------|----------|------------|
| `<leader>e` | Toggle file explorer | `NvimTreeToggle` | `ActivateProjectToolWindow` | `workbench.view.explorer` |
| `<leader>f` | Find files | `Telescope find_files` | `GotoFile` | `workbench.action.quickOpen` |
| `<leader>ff` | Fuzzy find files | `Telescope find_files` | - | - |
| `<leader>fg` | Live grep | `Telescope live_grep` | - | - |
| `<leader>fb` | List buffers | `Telescope buffers` | - | - |
| `<leader>fh` | Help tags | `Telescope help_tags` | - | - |
| `<leader>w` | Close buffer/editor | `:bd` | `CloseContent` | `workbench.action.closeActiveEditor` |
| `H` | Previous buffer/editor | `:bprevious` | `PreviousTab` | `workbench.action.previousEditorInGroup` |
| `L` | Next buffer/editor | `:bnext` | `NextTab` | `workbench.action.nextEditorInGroup` |

---

## Refactoring & Code Actions

| Keys | Action | Neovim | IDEA Vim | VSCode Vim |
|------|--------|--------|----------|------------|
| `<leader>rn` | Rename symbol | `vim.lsp.buf.rename()` | `RenameElement` | `editor.action.rename` |
| `<leader>ca` | Code actions / Quick fix | `vim.lsp.buf.code_action()` | `ShowIntentionActions` | `editor.action.quickFix` |

---

## General Navigation & Editing

| Keys | Action | All Editors |
|------|--------|-------------|
| `<Esc>` | Clear search highlight | `:nohl` |
| `jj` (insert mode) | Exit to normal mode | `<Esc>` |
| `j` / `k` | Move by visual lines | `gj` / `gk` |
| `K` | Insert line break | `i<CR><ESC>` |
| `<leader>d` | Delete line | `dd` |

---

## Visual Mode Bindings

| Keys | Action | Description |
|------|--------|-------------|
| `p` / `P` | Paste without polluting clipboard | Uses `"_dP` to avoid overwriting register |
| `j` / `k` | Visual line movement | Moves by visual lines, not buffer lines |
| `<leader>rn` | Rename symbol | Rename selected symbol |
| `gf` | Format selection | Format selected code |
| `J` / `K` | Move selected lines | Move block up/down |

---

## VSCode Native Override Simulations

These keys are handled natively by VSCode, so Neovim simulates the behavior:

| Keys | Action | Neovim |
|------|--------|--------|
| `<C-s>` | Save file | `:w` |
| `<C-a>` | Select all | `ggVG` |
| `<C-f>` | Find in buffer | `Telescope current_buffer_fuzzy_find` |

---

## Window & Buffer Management (Neovim)

| Keys | Action |
|------|--------|
| `<leader>sh` | Split horizontal |
| `<leader>sv` | Split vertical |
| `<leader>k` | Next buffer |
| `<leader>j` | Previous buffer |
| `<C-h/j/k/l>` | Navigate windows (tmux-style) |

---

## Terminal Management (Neovim)

| Keys | Action |
|------|--------|
| `<C-`>` (normal) | Open terminal in split |
| `<C-`>` (terminal) | Close terminal |

---

## Configuration Files

| Editor | Configuration File |
|--------|-------------------|
| **Neovim** | `~/.dotfile/nvim/init.lua` + `lua/core/` + `lua/plugins/` |
| **IDEA Vim** | `~/.dotfile/.ideavimrc` |
| **VSCode Vim** | `~/.dotfile/settings.json` |
| **macOS Vim** | `~/.dotfile/generalConfig/.vimrc` |

---

## Setup Instructions

### Neovim
1. Install Neovim 0.8+
2. Clone this dotfiles repository
3. Symlink: `ln -s ~/.dotfile/nvim ~/.config/nvim`
4. Run `:PackerSync` to install plugins

### IDEA Vim
1. Open Settings → Vim Emulation
2. Enable Vim emulation
3. Set config file to `~/.dotfile/.ideavimrc`

### VSCode Vim
1. Install **Vim** extension (vscodevim.vim)
2. Copy settings from `~/.dotfile/settings.json` to your VSCode settings

---

## Notes

- All editors use `<Space>` as the leader key
- Clipboard behavior varies: VSCode Vim uses its own register; IDEA Vim uses system clipboard
- `j`/`k` movement works on visual lines (wrapping-aware) in all editors
- LSP features require language servers to be installed and configured
