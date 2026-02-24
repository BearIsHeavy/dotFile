vim.g.mapleader = " "
local keymap = vim.keymap

-- =========================================================
-- VS Code Consistency Mappings (Source: settings.json)
-- =========================================================

-- Insert Mode: Exit with jj
keymap.set("i", "jj", "<ESC>")

-- Normal Mode: Delete line with <leader>d 
-- (CHANGED: Previously mapped to :bd<CR>. Now matches VS Code "dd" behavior)
keymap.set("n", "<leader>d", "dd")

-- Normal Mode: Clear highlight with <C-n>
-- (CHANGED: Matches VS Code :nohl. Previous <leader>nh removed for consistency)
keymap.set("n", "<C-n>", ":nohl<CR>")

-- Normal Mode: Insert line break with K
-- (CHANGED: Matches VS Code "lineBreakInsert". Standard Vim 'K' is hover.)
keymap.set("n", "K", "i<CR><ESC>")


-- =========================================================
-- VS Code Native Override Simulations ("vim.handleKeys": false)
-- =========================================================
-- These keys are handled by VS Code natively, so we simulate that behavior in Neovim.

-- Ctrl+S: Save File
keymap.set({ "n", "i", "v" }, "<C-s>", "<ESC>:w<CR>")

-- Ctrl+A: Select All
-- (ADDED: Neovim default is increment. VS Code native is Select All.)
keymap.set({ "n", "i", "v" }, "<C-a>", "<ESC>ggVG")

-- Ctrl+F: Find
-- (ADDED: Neovim default is PageDown. VS Code native is Find.)
-- We use Telescope for a rich "Find" experience similar to VS Code's widget.
keymap.set({ "n", "i", "v" }, "<C-f>", "<ESC>:Telescope current_buffer_fuzzy_find<CR>")

-- gd: Go to Definition
-- (ADDED: Matches VS Code native "Go to Definition" via LSP)
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")


-- =========================================================
-- General Neovim Enhancements (Preserved if non-conflicting)
-- =========================================================

-- View mode: Move text up and down (Enhanced J/K behavior)
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Window Splitting
keymap.set("n", "<leader>sh", "<C-w>v") -- Horizontal split
keymap.set("n", "<leader>sv", "<C-w>s") -- Vertical split

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Buffer Navigation
keymap.set("n", "<leader>k", ":bnext<CR>")
keymap.set("n", "<leader>j", ":bprevious<CR>")

-- Since we mapped <leader>d to 'dd' (VS Code style), we need a new key to close buffers.
-- Mapped to <leader>x (Common convention)
keymap.set("n", "<leader>x", ":bd<CR>")

-- Search Navigation
-- (REVERTED: Your previous config mapped 'n' to '*'. I reverted this to standard 'next'
-- because your VS Code config does not override 'n', implying standard behavior.)
keymap.set("n", "n", "nzzzv") -- Keep search result centered
keymap.set("n", "N", "Nzzzv")

-- =========================================================
-- Terminal Management
-- =========================================================

-- Normal Mode: Open terminal in a horizontal split and immediately enter insert mode
keymap.set("n", "<C-`>", ":split | terminal<CR>i", { silent = true })

-- Terminal Mode: Force close the terminal buffer and window with the same shortcut
keymap.set("t", "<C-`>", "<C-\\><C-n>:bd!<CR>", { silent = true })

-- (Optional) Escape to Normal mode without killing the terminal process
-- keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true })