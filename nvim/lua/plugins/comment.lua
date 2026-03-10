require('Comment').setup({
  ---Add a space b/w comment and the line
  padding = true,
  ---Whether the cursor should stay at its position
  sticky = true,
  ---Lines to be ignored while comment/uncomment.
  ignore = '^$',
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  ---LHS of extra mappings
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
})
