vim.g['sneak#label'] = 1

-- vim-sneak: replace f/F with 2-char jump
vim.keymap.set("n", "f", "<Plug>Sneak_s")
vim.keymap.set("n", "F", "<Plug>Sneak_S")
-- Note: n/N repeat search is handled in keymaps.lua (* / # search word under cursor)
vim.keymap.set("n", "s", "cl")
vim.keymap.set("v", "s", "c")
vim.keymap.set("n", "S", "cc")
