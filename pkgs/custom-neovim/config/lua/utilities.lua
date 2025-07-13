utils = {}

utils.mapkey = function(mode, key, desc, action)
  vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = desc})
end

utils.generate_theme_from_lualine = function()
  local auto_theme = require("lualine.themes.auto")
  return {
    modes = {
      normal = auto_theme.normal.a.bg,
      insert = auto_theme.insert.a.bg,
      visual = auto_theme.visual.a.bg,
      replace = auto_theme.replace.a.bg,
      command = auto_theme.command.a.bg,
      inactive = auto_theme.inactive.a.bg,
    },
    text = {
      dark = auto_theme.normal.a.fg,
      light = auto_theme.normal.c.fg,
    },
    background = auto_theme.normal.c.bg,
  }
end

