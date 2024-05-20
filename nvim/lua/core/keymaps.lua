vim.g.mapleader = " "
local keymap = vim.keymap

-- insert model
keymap.set("i", "jj", "<ESC>")


-- view model
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- normal model
keymap.set("n", "o", "o<ESC>")

-- --------- NORMAL -----------
keymap.set("n", "<leader>sh", "<C-w>v") -- Horizontal window
keymap.set("n", "<leader>sv", "<C-w>s") -- Vertical window

-- close a window
-- keymap.set("n", "<leader>w", "<C-w>c")

-- unset search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- set save file
keymap.set("n", "<C-S>", ":w<CR>")
keymap.set("i", "<C-S>", "<ESC>:w<CR>")

-- open termianl
keymap.set("n", "<leader>term", ":split term://zsh<CR>")

--  ---------------------PLUGINS-----------------------
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- nvim-tree close a buffer
keymap.set("n", "<leader>d", ":bd<CR>")

-- swithch buffer
keymap.set("n", "<leader>j", ":bnext<CR>")
keymap.set("n", "<leader>k", ":bprevious<CR>")

-- find next search result for utilize '/'
keymap.set("n", "n", "*")
keymap.set("n", "N", "#")

-- exit terminal model
keymap.set("t", "<C-t>", "<C-\\><C-n><C-w>k", {silent = true})

