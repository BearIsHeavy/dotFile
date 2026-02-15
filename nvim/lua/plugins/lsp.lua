require("mason").setup({
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
    "pyright", -- Python
    "clangd",  -- C/C++
    "ts_ls",   -- JavaScript/TypeScript (formerly tsserver)
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use setup_handlers to automatically configure all servers installed via Mason.
-- This is cleaner and avoids repetitive `require("lspconfig").server.setup` calls.
require("mason-lspconfig").setup_handlers({
  -- 1. The default handler: This function is called for every installed server
  -- that doesn't have a specific configuration key below.
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,

  -- 2. Specific override for Lua (lua_ls)
  -- We add this to fix the common "Undefined global 'vim'" warning.
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
})