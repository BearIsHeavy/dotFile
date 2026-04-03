-- Disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
