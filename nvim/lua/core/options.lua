local opt = vim.opt

-- line number
vim.opt.relativenumber = true
vim.opt.number = true

-- retract
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- anti-wrap
opt.wrap = false

-- cursor line
opt.cursorline = true

-- use mouse
opt.mouse:append("a")

-- clipboard
opt.clipboard:append("unnamedplus")

-- default new window is at right and below place
opt.splitright = true
opt.splitbelow = true

-- search 
opt.ignorecase = true
opt.smartcase = true

-- appearence
opt.termguicolors = true
opt.signcolumn = "yes"

-- Theme
vim.cmd[[colorscheme tokyonight-moon]]

-- fold code
opt.foldmethod = 'indent'

