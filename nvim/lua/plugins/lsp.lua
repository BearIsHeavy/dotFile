require("mason").setup({
    automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}

require("lspconfig").pyright.setup {}
