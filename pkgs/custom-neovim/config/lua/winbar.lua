-- Custom Winbar

-- Wherher to use icons.
local use_icons = true

-- Utility functions for components.
local utils = {}

-- The width of the winbar.
utils.linewidth = function ()
  return vim.api.nvim_win_get_width(0)
end

utils.component_takes_percentage = function (comp_width, percentage)
  return comp_width > (percentage/100) * utils.linewidth()
end

-- Highlighting Shortcut
local hi_pattern = '%%#%s#%s%%*'

-- Define Components
local components = {}

-- Filename component
components.filename = function (args)
  args = args or {}
  local before = args.before or ""
  local after = args.after or ""

  return before.."%f %m"..after
end

-- Git status component
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

-- Diagnostics component
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

-- Define winbar
local winbar = function ()
  return {
    components.filename({before = " "}),
    components.git_status(),
    components.diagnostics(),
  }
end

-- Gaps between components.
local gaps = " "

-- Process and apply statusline.
Winbar_builder = function ()
  --get a table of all the winbar strings
  local winbar_strings = winbar()

  -- Remove empty strings to prevent concat issues
  for i = #winbar_strings, 1, -1 do
    if winbar_strings[i] == "" then
      table.remove(winbar_strings, i)
    end
  end

  -- Concatentate strings with gaps
  return table.concat(winbar_strings, gaps)
end

vim.o.winbar = "%{%v:lua.Winbar_builder()%}"
