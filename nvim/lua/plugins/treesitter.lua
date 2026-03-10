require'nvim-treesitter.configs'.setup {
  -- Added "cpp" to ensure installed list
  ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "python", "typescript", "rust", "markdown", "markdown_inline" }, 

  highlight = { enable = true },
  indent = { enable = true },

  -- Removed broken rainbow configuration
}
