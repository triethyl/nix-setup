local general_theme = utils.generate_theme_from_lualine()
local colors = {
  current = { fg = general_theme.modes.insert, bg = general_theme.background, style = 'bold'},
  not_current = { fg = general_theme.text.light, bg = general_theme.background };
  fill = { bg = general_theme.background };
};
local theme = {
  fill = colors.fill,
  head = colors.fill,
  current_tab = colors.current,
  tab = colors.not_current,
  win = colors.fill,
  tail = colors.fill,
}
require('tabby').setup({
  line = function(line)
    return {
      {
        -- { '  ', hl = theme.head },
        -- line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep('', hl, theme.fill),
          -- tab.is_current() and '' or '󰆣',
          tab.number(),
          tab.name(),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep('', theme.win, theme.fill),
          -- win.is_current() and '' or '',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      {
        line.sep('', theme.tail, theme.fill),
        { '  ', hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})
