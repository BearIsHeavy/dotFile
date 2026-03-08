# Unified Vim Keybindings Reference

This document provides a unified keybinding reference for seamless switching between **IDEA Vim** and **VSCode Vim**.

## Common Settings (Both Editors)

| Setting | Value | Description |
|---------|-------|-------------|
| Leader Key | `<Space>` | Primary modifier for custom bindings |
| Line Numbers | `set number` | Show absolute line numbers |
| Relative Numbers | `set relativenumber` | Show relative line numbers |
| Search | `incsearch`, `hlsearch` | Incremental search with highlighting |
| Case Sensitivity | `ignorecase`, `smartcase` | Smart case-insensitive search |
| Scroll Offset | `scrolloff=5` | Keep 5 lines visible at top/bottom |

## Core Navigation Keybindings

| Keys | Action | IDEA Command | VSCode Command |
|------|--------|--------------|----------------|
| `gh` | Show hover/type info | `QuickImplementations` | `editor.action.showHover` |
| `gd` | Go to definition | `GotoDeclaration` | `editor.action.revealDefinition` |
| `gi` | Go to implementation | `GotoImplementation` | `editor.action.goToImplementation` |
| `gr` | Find references | `FindUsages` | `references-view.findReferences` |
| `gf` | Format document | `ReformatCode` | `editor.action.formatDocument` |

## UI & File Management

| Keys | Action | IDEA Command | VSCode Command |
|------|--------|--------------|----------------|
| `<Space>e` | Open explorer/project view | `ActivateProjectToolWindow` | `workbench.view.explorer` |
| `<Space>f` | Quick open / Find file | `GotoFile` | `workbench.action.quickOpen` |
| `<Space>w` | Close current tab/editor | `CloseContent` | `workbench.action.closeActiveEditor` |
| `H` | Previous tab/editor | `PreviousTab` | `workbench.action.previousEditorInGroup` |
| `L` | Next tab/editor | `NextTab` | `workbench.action.nextEditorInGroup` |

## Refactoring & Actions

| Keys | Action | IDEA Command | VSCode Command |
|------|--------|--------------|----------------|
| `<Space>rn` | Rename symbol | `RenameElement` | `editor.action.rename` |
| `<Space>ca` | Quick fix / intentions | `ShowIntentionActions` | `editor.action.quickFix` |
| `<Esc>` | Clear search highlight | `:noh` | `:nohl` |

## Visual Mode Bindings

| Keys | Action | Description |
|------|--------|-------------|
| `p` / `P` | Paste without polluting clipboard | Uses `"_dP` to avoid overwriting register |
| `j` / `k` | Visual line movement | Moves by visual lines, not buffer lines (`gj`/`gk`) |
| `<Space>rn` | Rename | Rename selected symbol |
| `gf` | Format | Format selected code |

## Insert Mode

| Keys | Action |
|------|--------|
| `jj` | Exit to normal mode |

## Editor-Specific Configuration Files

- **IDEA**: `~/.dotfile/idea_config/.ideavimrc`
- **VSCode**: `~/.dotfile/vscode_setting/settings.json`

## Setup Instructions

### IDEA
1. Open IDEA Settings → Vim Emulation
2. Set config file to `~/.dotfile/idea_config/.ideavimrc`

### VSCode
1. Install **Vim** extension (vscodevim.vim)
2. Add to your `settings.json`:
```json
{
  "vim.leader": "<space>",
  "vim.useSystemClipboard": false,
  "vim.insertModeKeyBindings": [
    { "before": ["j", "j"], "after": ["<Esc>"] }
  ]
}
```

## Notes

- Both editors use `<Space>` as the leader key
- Clipboard behavior: VSCode Vim uses its own register by default; IDEA Vim uses system clipboard
- `j`/`k` movement works on visual lines (wrapping-aware) in both editors
