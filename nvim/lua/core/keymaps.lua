vim.g.mapleader = " "
local keymap = vim.keymap

-- =========================================================
-- VS Code / IDEA Vim Consistency Mappings
-- =========================================================

-- Insert Mode: Exit with jj
keymap.set("i", "jj", "<ESC>")

-- Normal Mode: Clear highlight with ESC
keymap.set("n", "<Esc>", ":nohl<CR>")

-- Normal Mode: Delete line with <leader>d (matches VS Code "dd" behavior)
keymap.set("n", "<leader>d", "dd")

-- Normal Mode: Insert line break with K
keymap.set("n", "K", "i<CR><ESC>")


-- =========================================================
-- VS Code Native Override Simulations ("vim.handleKeys": false)
-- =========================================================

-- Ctrl+S: Save File
keymap.set({ "n", "i", "v" }, "<C-s>", "<ESC>:w<CR>")

-- Ctrl+A: Select All
keymap.set({ "n", "i", "v" }, "<C-a>", "<ESC>ggVG")

-- Ctrl+F: Find (using Telescope)
keymap.set({ "n", "i", "v" }, "<C-f>", "<ESC>:Telescope current_buffer_fuzzy_find<CR>")


-- =========================================================
-- Code Navigation & Info (Aligned with VSCode and IDEA Vim)
-- =========================================================

-- gh: Hover documentation
keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover documentation" })

-- gd: Go to definition
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })

-- gD: Go to declaration
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" })

-- gi: Go to implementation
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })

-- gr: Find references
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find references" })

-- gR: Rename symbol
keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- gs: Signature help
keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })

-- gf: Format code
keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format code" })

-- Diagnostic navigation
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Open diagnostic list" })


-- =========================================================
-- UI Controls (Aligned with VSCode and IDEA Vim)
-- =========================================================

-- <leader>e: Toggle file explorer (NvimTree)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- <leader>f: Find file (using Telescope)
keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- <leader>rn: Rename symbol
keymap.set({ "n", "v" }, "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- <leader>ca: Show code actions / quick fix
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })

-- <leader>w: Close current buffer
keymap.set("n", "<leader>w", ":bd<CR>", { desc = "Close buffer" })

-- L / H: Switch to next / previous buffer
keymap.set("n", "L", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous buffer" })


-- =========================================================
-- Clipboard Behavior (VS Code Style)
-- =========================================================

-- When pasting in visual mode, do not overwrite register
keymap.set("v", "p", '"_dP')
keymap.set("v", "P", '"_dP')

-- Make j/k move by visual lines (VS Code default behavior)
keymap.set({ "n", "v" }, "j", "gj")
keymap.set({ "n", "v" }, "k", "gk")


-- =========================================================
-- General Neovim Enhancements
-- =========================================================

-- View mode: Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Window Splitting
keymap.set("n", "<leader>sh", "<C-w>v", { desc = "Split horizontal" })
keymap.set("n", "<leader>sv", "<C-w>s", { desc = "Split vertical" })

-- Buffer Navigation (alternative)
keymap.set("n", "<leader>k", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>j", ":bprevious<CR>", { desc = "Previous buffer" })

-- Search Navigation
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")


-- =========================================================
-- Terminal Management
-- =========================================================

-- Normal Mode: Open terminal in a horizontal split
keymap.set("n", "<C-`>", ":split | terminal<CR>i", { silent = true })

-- Terminal Mode: Force close the terminal buffer and window
keymap.set("t", "<C-`>", "<C-\\><C-n>:bd!<CR>", { silent = true })