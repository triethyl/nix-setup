-- Custom Statusline

-- Whether to use icons.
local use_icons = true

-- Utility functions for components.
local utils = {}

-- The width of the statusline.
utils.linewidth = function ()
  if vim.o.laststatus == 3 then
    return vim.o.columns
  else
    return vim.api.nvim_win_get_width(0)
  end
end

utils.component_takes_percentage = function (comp_width, percentage)
  return comp_width > (percentage/100) * utils.linewidth()
end

-- Highlighting Shortcut
local hi_pattern = '%%#%s#%s%%*'

-- Define Components
local components = {}

components.mode = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  -- Convert mode to string
  local mode_to_str = {
      ['n'] = 'NORMAL',
      ['no'] = 'OP-PENDING',
      ['nov'] = 'OP-PENDING',
      ['noV'] = 'OP-PENDING',
      ['no\22'] = 'OP-PENDING',
      ['niI'] = 'NORMAL',
      ['niR'] = 'NORMAL',
      ['niV'] = 'NORMAL',
      ['nt'] = 'NORMAL',
      ['ntT'] = 'NORMAL',
      ['v'] = 'VISUAL',
      ['vs'] = 'VISUAL',
      ['V'] = 'VISUAL',
      ['Vs'] = 'VISUAL',
      ['\22'] = 'VISUAL',
      ['\22s'] = 'VISUAL',
      ['s'] = 'SELECT',
      ['S'] = 'SELECT',
      ['\19'] = 'SELECT',
      ['i'] = 'INSERT',
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = 'REPLACE',
      ['Rc'] = 'REPLACE',
      ['Rx'] = 'REPLACE',
      ['Rv'] = 'VIRT REPLACE',
      ['Rvc'] = 'VIRT REPLACE',
      ['Rvx'] = 'VIRT REPLACE',
      ['c'] = 'COMMAND',
      ['cv'] = 'VIM EX',
      ['ce'] = 'EX',
      ['r'] = 'PROMPT',
      ['rm'] = 'MORE',
      ['r?'] = 'CONFIRM',
      ['!'] = 'SHELL',
      ['t'] = 'TERMINAL',
  }

  -- Get the respective string to display.
  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

  -- Set the highlight group and text.
  local mode_text = "?"
  local hl = 'DiagnosticWarn'

  if mode:find 'NORMAL' then
      hl = 'DiagnosticInfo'
      mode_text = "N"
  elseif mode:find 'PENDING' then
      hl = 'DiagnosticInfo'
      mode_text = "P"
  elseif mode:find 'VISUAL' then
      hl = 'DiagnosticHint'
      mode_text = "V"
  elseif mode:find 'REPLACE' then
      hl = 'DiagnosticError'
      mode_text = "R"
  elseif mode:find 'INSERT' or mode:find 'SELECT' then
      hl = 'DiagnosticOk'
      mode_text = "I"
  elseif mode:find 'COMMAND' or mode:find 'TERMINAL' or mode:find 'EX' then
      hl = 'DiagnosticHint'
      mode_text = "C"
  end

  -- Construct the component.
  return hi_pattern:format(hl, string.format(before..'%s'..after, mode_text))
end

components.location = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  return before.."%(%l/%L%): %c"..after
end

components.progress = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  -- Neovide breaks this component.
  if vim.g.neovide then return "" end

  local sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
  local curr_line = vim.api.nvim_win_get_cursor(0)[1] or 0
  local lines = vim.api.nvim_buf_line_count(0) or 0
  local i = math.floor((curr_line - 1) / lines * #sbar) + 1
  -- if i == nil then return "" end
  local prog = string.rep(sbar[i], 2)
  return before..hi_pattern:format("Visual", prog)..after
end

components.cwd = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  local cwd = vim.fn.getcwd(0)
  cwd = vim.fn.fnamemodify(cwd, ":~")
  if utils.component_takes_percentage(#cwd, 40) then cwd = vim.fn.pathshorten(cwd) end
  if utils.component_takes_percentage(#cwd, 80) then return "" end
  local trail = cwd:sub(-1) == '/' and '' or "/"
  return before..cwd..trail..after
end

components.diagnostics = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  -- Define icons
  local error_icon = use_icons and " " or "E"
  local warning_icon = use_icons and " " or "W"
  local info_icon = use_icons and " " or "I"
  local hint_icon = use_icons and " " or "H"

  -- Create empty diagnostics table
  local diagnostics = {}

  -- Count diagnostics
  local errors = #vim.diagnostic.get(0, { severity = 1 })

  if errors > 0 then
    table.insert(diagnostics, hi_pattern:format("DiagnosticSignError", ("%s%s"):format(error_icon, errors)))
  end

  local warnings = #vim.diagnostic.get(0, { severity = 2 })

  if warnings > 0 then
    table.insert(diagnostics, hi_pattern:format("DiagnosticSignWarn", ("%s%s"):format(warning_icon, warnings)))
  end

  local infos = #vim.diagnostic.get(0, { severity = 3 })

  if infos > 0 then
    table.insert(diagnostics, hi_pattern:format("DiagnosticSignInfo", ("%s%s"):format(info_icon, infos)))
  end

  local hints = #vim.diagnostic.get(0, { severity = 4 })

  if hints > 0 then
    table.insert(diagnostics, hi_pattern:format("DiagnosticSignHint", ("%s%s"):format(hint_icon, hints)))
  end

  -- Don't show diagnostics in insert mode.
  if vim.api.nvim_get_mode().mode:find "i" then
    return ""
  end

  local icon = use_icons and '' or 'diag: '

  local status = hi_pattern:format("Statusline", table.concat(diagnostics, " "))

  return before..icon..status..after
end

components.git_branch = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  if not vim.b.minigit_summary then return "" end
  local branch = vim.b.minigit_summary.head_name or ""
  local icon = use_icons and " " or "branch: "
  return before..icon..branch..after
end

components.git_status = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  if not vim.b.minidiff_summary then return "" end

  local summary = vim.b.minidiff_summary

  local status = {}

  local add_icon = use_icons and " " or "+"
  local change_icon = use_icons and " " or "~"
  local delete_icon = use_icons and " " or "-"

  if (summary.add or 0) > 0 then
    table.insert(status, hi_pattern:format("Added", ("%s%s"):format(add_icon, summary.add)))
  end
  if (summary.change or 0) > 0 then
    table.insert(status, hi_pattern:format("Changed", ("%s%s"):format(change_icon, summary.change)))
  end
  if (summary.delete or 0) > 0 then
    table.insert(status, hi_pattern:format("Removed", ("%s%s"):format(delete_icon, summary.delete)))
  end

  return before..table.concat(status, " ")..after
end

components.tab_counter = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  local num_tabs = #vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()

  if num_tabs == 1 then return "" end

  local icon = use_icons and "󰓩 " or "tab: "

  return before..icon..current_tab.."/"..num_tabs..after
end

-- Define Statusline
local statusline = function ()
  return {
    components.mode({before = " "}),
    components.git_branch(),
    components.git_status(),
    components.cwd(),

    "%=",

    components.diagnostics(),
    components.tab_counter(),
    components.location({after = vim.g.neovide and " " or ""}),
    components.progress({after = ""}),
  }
end

-- Gaps between components.
local gaps = "  "

-- Process and apply statusline.
Statusline_builder = function ()
  --get a table of all the statusline strings
  local statusline_strings = statusline()

  -- Remove empty strings to prevent concat issues
  for i = #statusline_strings, 1, -1 do
    if statusline_strings[i] == "" then
      table.remove(statusline_strings, i)
    end
  end

  -- Concatentate strings with gaps
  return table.concat(statusline_strings, gaps)
end

vim.o.statusline = "%{%v:lua.Statusline_builder()%}"
