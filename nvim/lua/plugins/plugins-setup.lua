-- auto-install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Reload neovim whenever you save the plugins-setup.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use("wbthomason/packer.nvim")
  use("folke/tokyonight.nvim") -- Theme

  use {
    'nvim-lualine/lualine.nvim',  -- Status bar
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }  -- status bar icons
  }

  use("nvim-tree/nvim-tree.lua")  -- document tree
  use("nvim-tree/nvim-web-devicons") --documnet tree icons

  use ("christoomey/vim-tmux-navigator") -- use ctl-hjkl to local window
  use ("nvim-treesitter/nvim-treesitter") -- high light syntax
  
  -- REMOVED: p00f/nvim-ts-rainbow (Deprecated/Broken)
  -- Optional Replacement: use "HiPhish/rainbow-delimiters.nvim"

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",  -- Bridge between mason and lspconfig
    "neovim/nvim-lspconfig"
  }

  -- auto-complete
  use ("hrsh7th/nvim-cmp")
  use ("hrsh7th/cmp-nvim-lsp")
  use ("hrsh7th/cmp-buffer")  -- source for text in buffer
  use ("hrsh7th/cmp-path") -- file path

  use ("L3MON4D3/LuaSnip") -- snippets engine
  use ("saadparwaiz1/cmp_luasnip")
  use ("rafamadriz/friendly-snippets")

  use ("numToStr/Comment.nvim") -- gcc and gc comments
  use ("windwp/nvim-autopairs") -- auto-complete bracket

  use ("akinsho/bufferline.nvim") -- buffer split line
  use ("lewis6991/gitsigns.nvim") -- left prompt for git

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ("justinmk/vim-sneak")

  -- REMOVED: coc.nvim (Conflict with nvim-cmp)

  if packer_bootstrap then
    require('packer').sync()
  end
end)