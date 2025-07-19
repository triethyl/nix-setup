Utils = {}

Utils.mapkey = function(mode, key, desc, action)
  vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = desc})
end

Utils.generate_theme_from_highlight_groups = function()
  local get_highlight_colors = function(group)
    local raw_colors = vim.api.nvim_get_hl(0, {name = group})
    local decimal_to_hex = function(decimal_color)
      if decimal_color == nil then return nil end
      return string.format("#%06X", decimal_color)
    end
    return {
      fg = decimal_to_hex(raw_colors.fg),
      bg = decimal_to_hex(raw_colors.bg),
    }
  end
  return {
    modes = {
      normal = get_highlight_colors("MiniStatuslineModeNormal").bg,
      insert = get_highlight_colors("MiniStatuslineModeInsert").bg,
      visual = get_highlight_colors("MiniStatuslineModeVisual").bg,
      replace = get_highlight_colors("MiniStatuslineModeReplace").bg,
      command = get_highlight_colors("MiniStatuslineModeCommand").bg,
      inactive = get_highlight_colors("MiniStatuslineModeInactive").bg,
    },
    text = {
      dark = get_highlight_colors("MiniStatuslineModeNormal").fg,
      light = get_highlight_colors("Normal").fg,
    },
    background = get_highlight_colors("Normal").bg,
  }
end
