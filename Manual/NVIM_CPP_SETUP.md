# C/C++ Development Setup Guide for Neovim

This guide explains how to set up your Neovim configuration for C/C++ development.

## Configuration Location

Your Neovim config is located at `~/.dotfile/nvim/`. Symlink it to:

```bash
ln -s ~/.dotfile/nvim/init.lua ~/.config/nvim/init.lua
```

## Prerequisites

### 1. Install LLVM/Clang

**macOS:**
```bash
brew install llvm
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install llvm clang clang-tools
```

**Linux (Arch):**
```bash
sudo pacman -S llvm clang clang-tools-extra
```

### 2. Install Codelldb (for debugging)

```bash
# Using Mason (recommended - will be installed automatically)
# Or manually download from: https://github.com/vadimcn/codelldb/releases
```

### 3. Install Build Tools

**macOS:**
```bash
xcode-select --install
```

**Linux:**
```bash
sudo apt install build-essential gdb
```

## Neovim Plugin Installation

After installing prerequisites, run in Neovim:

```vim
:PackerSync
```

This will install:
- `clangd` - Language server for C/C++
- `nvim-dap` - Debug Adapter Protocol
- `nvim-dap-ui` - Debug UI
- `codelldb` - LLDB-based debugger

## Keymaps

### LSP Navigation (C/C++)

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `gR` | Rename symbol |
| `gh` | Hover documentation |
| `gs` | Signature help |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>dl` | Open diagnostic list |

### Debugging

| Keymap | Description |
|--------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dc` | Continue debugging |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dL` | Run last debug config |
| `<leader>dq` | Terminate debugging |
| `<leader>dp` | Pause debugging |
| `<leader>du` | Toggle debug UI |
| `<leader>de` | Evaluate expression |

## Project Setup

### 1. Create `compile_commands.json`

Clangd requires a `compile_commands.json` file for proper code intelligence.

**For CMake projects:**
```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build
ln -s build/compile_commands.json .
```

**For Make projects:**
Use [compdb](https://github.com/Sarcasm/compdb) or create manually.

**For simple projects:**
Create a `.clangd` file in your project root (see template below).

### 2. Project Template `.clangd`

```yaml
---
CompileFlags:
  Add: [-std=c++17, -Wall, -Wextra]
...
```

## Debugging Setup

### 1. Compile with debug symbols

```bash
g++ -g -O0 main.cpp -o build/main
# or
cmake -DCMAKE_BUILD_TYPE=Debug -B build
```

### 2. Start debugging

1. Press `<leader>db` to set a breakpoint
2. Press `<leader>dc` to start debugging
3. The debug UI will open automatically

## Troubleshooting

### clangd not found
Ensure LLVM/Clang is installed and in your PATH:
```bash
which clangd
```

### Debugging not working
1. Ensure your binary is compiled with `-g` flag
2. Check that codelldb is installed: `:Mason`
3. Verify the executable path when prompted

### Slow completions
1. Ensure `compile_commands.json` exists
2. Check background indexing: `:LspInfo`
3. Restart clangd: `:LspRestart clangd`

## Recommended Extensions

Consider adding these to your `lsp.lua` for additional languages:
- `rust_analyzer` - Rust
- `cmake` - CMake support
- `bashls` - Bash scripting
