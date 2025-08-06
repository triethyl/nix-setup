-- Statusline

-- TODO: Components to add
--
-- mode
-- git branch
--
-- cwd
--
-- lsp diagnostics
-- lsp status

-- Highlight pattern
local hi_pattern = '%%#%s#%s%%*'

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

local statusline_components = {}

statusline_components.micro_spacer = function()
  return " "
end

statusline_components.spacer = function()
  return '%='
end

statusline_components.diagnostic_status = function()
  local diagnostics = {}

  local errors = #vim.diagnostic.get(0, { severity = 1 })

  if errors > 0 then
    table.insert(diagnostics, "%#DiagnosticSignError# " .. tostring(errors))
  end

  local warnings = #vim.diagnostic.get(0, { severity = 2 })

  if warnings > 0 then
    table.insert(diagnostics, "%#DiagnosticSignWarn# " .. tostring(warnings))
  end

  local infos = #vim.diagnostic.get(0, { severity = 3 })

  if infos > 0 then
    table.insert(diagnostics, "%#DiagnosticSignInfo# " .. tostring(infos))
  end

  local hints = #vim.diagnostic.get(0, { severity = 4 })

  if hints > 0 then
    table.insert(diagnostics, "%#DiagnosticSignHint# " .. tostring(hints))
  end

  table.insert(diagnostics, "%#StatusLine#")

  vim.defer_fn(vim.cmd.redrawstatus, 500)

  -- Don't show diagnostics in insert mode.
  if mode_to_str[vim.api.nvim_get_mode().mode]:find "INSERT" then
    return ""
  end

  return table.concat(diagnostics, " ")
end

statusline_components.mode = function()
  -- Get the respective string to display.
  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

  -- Set the highlight group.
  local hl = 'MiniStatuslineModeOther'
  if mode:find 'NORMAL' then
      hl = 'MiniStatuslineModeNormal'
  elseif mode:find 'PENDING' then
      hl = 'MiniStatuslineModeNormal'
  elseif mode:find 'VISUAL' then
      hl = 'MiniStatuslineModeVisual'
  elseif mode:find 'REPLACE' then
      hl = 'MiniStatuslineModeReplace'
  elseif mode:find 'INSERT' or mode:find 'SELECT' then
      hl = 'MiniStatuslineModeInsert'
  elseif mode:find 'COMMAND' or mode:find 'TERMINAL' or mode:find 'EX' then
      hl = 'MiniStatuslineModeCommand'
  end

  -- Construct the component.
  return hi_pattern:format(hl, string.format(' %s ', mode))
end

statusline_components.position = function()
  -- Get the respective string to display.
  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

  -- Set the highlight group.
  local hl = 'MiniStatuslineModeOther'
  if mode:find 'NORMAL' then
      hl = 'MiniStatuslineModeNormal'
  elseif mode:find 'PENDING' then
      hl = 'MiniStatuslineModeNormal'
  elseif mode:find 'VISUAL' then
      hl = 'MiniStatuslineModeVisual'
  elseif mode:find 'REPLACE' then
      hl = 'MiniStatuslineModeReplace'
  elseif mode:find 'INSERT' or mode:find 'SELECT' then
      hl = 'MiniStatuslineModeInsert'
  elseif mode:find 'COMMAND' or mode:find 'TERMINAL' or mode:find 'EX' then
      hl = 'MiniStatuslineModeCommand'
  end

  -- Construct the component.
  return hi_pattern:format(hl, ' %2l:%-2c ')
end

statusline_components.git_branch = function()
  if vim.b.minigit_summary and vim.b.minigit_summary.head_name then
      return string.format(' %s ', vim.b.minigit_summary.head_name)
  else
      return '' -- Return an empty string or some default value if the branch name is not available
  end
end

statusline_components.git_status = function()
  if not vim.b.gitsigns_status_dict then
    return ''
  end

  local status = {}

  local gitsigns_status = vim.b.gitsigns_status_dict

  if gitsigns_status.added > 0 then
    table.insert(status, hi_pattern:format("Added", ("+%s"):format(gitsigns_status.added)))
  end

  if gitsigns_status.changed > 0 then
    table.insert(status, hi_pattern:format("Changed", ("+%s"):format(gitsigns_status.changed)))
  end

  if gitsigns_status.removed > 0 then
    table.insert(status, hi_pattern:format("Removed", ("+%s"):format(gitsigns_status.removed)))
  end

  return table.concat(status, " ")
end

statusline_components.working_directory = function()
  local text = vim.fn.getcwd()

  local parts = {}
  for part in string.gmatch(text, "[^/]+") do
    table.insert(parts, part)
  end

  -- replace /home/USER with ~/
  if #parts >= 3 then
    table.remove(parts, 1)
    table.remove(parts, 1)
    table.insert(parts, 1, "~")
  end

  text = table.concat(parts, "/")

  -- if the cwd takes up more than half the bar width, shorten it.
  if text:len() > (vim.api.nvim_win_get_width(0) / 2.5) then
    if #parts >= 1 then
      text = ".../" .. parts[#parts]
    end
  end
  return string.format(' %s ', text)
end

Statusline_component = function(name)
  return statusline_components[name]()
end

local get_component = function(name)
  return string.format('%%{%%v:lua.Statusline_component("%s")%%} ', name)
end

local statusline = {
  get_component("micro_spacer"),

  get_component("mode"),
  get_component("working_directory"),
  get_component("git_branch"),
  get_component("git_status"),
  get_component("diagnostic_status"),

  get_component("spacer"),

  ' %{&filetype} ', -- filetype
  '%2p%%  ', -- progress %
  get_component("position"),
}

vim.o.statusline = table.concat(statusline, '')
