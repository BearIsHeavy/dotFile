-- Load the plugin manager setup (Keep this standard)
require("plugins.plugins-setup")

-- Load core settings
require("core.options")
require("core.keymaps")

-- Helper function to safely load plugin configs
-- If a plugin is not installed, this prevents Neovim from crashing
local function safe_require(module)
  local status_ok, _ = pcall(require, module)
  if not status_ok then
    return
  end
end

-- Safely load plugins (They will only load if installed)
safe_require("plugins.lualine")
safe_require("plugins/tokyonight")
safe_require("plugins/nvim-tree")
safe_require("plugins/treesitter")
safe_require("plugins/lsp")
safe_require("plugins/cmp")
safe_require("plugins/comment")
safe_require("plugins/autopairs")
safe_require("plugins/bufferline")
safe_require("plugins/gitsigns")
safe_require("plugins/telescope")
safe_require("plugins/vim-sneak")
safe_require("plugins/dap")

-- Neovide (Optional)
safe_require("plugins.neovide")