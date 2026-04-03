local opt = vim.opt

-- line number
vim.opt.relativenumber = true
vim.opt.number = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
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

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- fold code
opt.foldmethod = 'indent'
