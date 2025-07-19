local generate_lualine_theme = function()
  local colors = Utils.generate_theme_from_highlight_groups()
  return {
    normal = {
      a = {bg = colors.modes.normal, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.normal, fg = colors.text.dark, gui = 'bold'},
    },
    insert = {
      a = {bg = colors.modes.insert, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.insert, fg = colors.text.dark, gui = 'bold'},
    },
    visual = {
      a = {bg = colors.modes.visual, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.visual, fg = colors.text.dark, gui = 'bold'},
    },
    replace = {
      a = {bg = colors.modes.replace, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.replace, fg = colors.text.dark, gui = 'bold'},
    },
    command = {
      a = {bg = colors.modes.command, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.command, fg = colors.text.dark, gui = 'bold'},
    },
    inactive = {
      a = {bg = colors.modes.inactive, fg = colors.text.dark, gui = 'bold'},
      b = {bg = colors.background, fg = colors.text.light},
      c = {bg = colors.background, fg = colors.text.light},
      x = {bg = colors.background, fg = colors.text.light},
      y = {bg = colors.background, fg = colors.text.light},
      z = {bg = colors.modes.inactive, fg = colors.text.dark, gui = 'bold'},
    },
  };
end

require('lualine').setup {
  options = {
    theme = generate_lualine_theme(),
    component_separators = "",
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '', rignt = '' }, right_padding = 2 } }, -- { left = '', rignt = '' }
    lualine_b = { 'filename', 'diff' },
    lualine_c = { 'branch' },
    lualine_x = { {'diagnostics', sources = { 'nvim_lsp' } } },
    lualine_y = { 'lsp_status', 'progress' },
    lualine_z = {
      { 'location', separator = { left = '', right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'location' },
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     setup_lualine()
--     print "colorscheme changed"
--   end,
-- })
