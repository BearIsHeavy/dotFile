require'nvim-treesitter.configs'.setup {
  ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "python", "typescript", "rust", "markdown", "markdown_inline" },

  highlight = { enable = true },
  indent = { enable = true },
}
