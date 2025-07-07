local auto_theme = require("lualine.themes.auto")

local colors = {
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
  backdrop = auto_theme.normal.c.bg,
}

local custom_auto_theme = {
  normal = {
    a = {bg = colors.modes.normal, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.normal, fg = colors.text.dark, gui = 'bold'},
  },
  insert = {
    a = {bg = colors.modes.insert, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.insert, fg = colors.text.dark, gui = 'bold'},
  },
  visual = {
    a = {bg = colors.modes.visual, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.visual, fg = colors.text.dark, gui = 'bold'},
  },
  replace = {
    a = {bg = colors.modes.replace, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.replace, fg = colors.text.dark, gui = 'bold'},
  },
  command = {
    a = {bg = colors.modes.command, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.command, fg = colors.text.dark, gui = 'bold'},
  },
  inactive = {
    a = {bg = colors.modes.inactive, fg = colors.text.dark, gui = 'bold'},
    b = {bg = colors.backdrop, fg = colors.text.light},
    c = {bg = colors.backdrop, fg = colors.text.light},
    x = {bg = colors.backdrop, fg = colors.text.light},
    y = {bg = colors.backdrop, fg = colors.text.light},
    z = {bg = colors.modes.inactive, fg = colors.text.dark, gui = 'bold'},
  },
};

require('lualine').setup {
  options = {
    theme = custom_auto_theme,
    component_separators = "",
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '', rignt = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center components here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { left = '', right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
