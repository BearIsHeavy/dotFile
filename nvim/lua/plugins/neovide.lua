-- config neovide
if vim.g.neovide then
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end

  -- UPDATED: neovide_transparency is deprecated.
  -- We use neovide_opacity (0.0 to 1.0) instead.
  vim.g.neovide_opacity = 0.8
  
  -- Internal variable used for the background color calculation below
  vim.g.transparency = 0.65

  vim.g.neovide_theme = 'dark'
  
  -- Setting background color with alpha (Hex format #RRGGBBAA)
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  
  vim.g.neovide_fullscreen = false
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end