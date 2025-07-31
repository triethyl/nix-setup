-- UI customizations without plugins.

-- Statusline

-- TODO: Components to add
--
-- mode
-- git diff
-- git branch
--
-- cwd
--
-- lsp diagnostics
-- lsp status
-- position %
-- location ##:##

-- Highlight pattern
local hi_pattern = '%%#%s#%s%%*'

local statusline_components = {

  micro_spacer = function()
    return " "
  end,

  spacer = function()
    return '%='
  end,

  old_diagnostic_status = function()
    local ok = ' λ '

    local ignore = {
      ['c'] = true, -- command mode
      ['t'] = true  -- terminal mode
    }

    local mode = vim.api.nvim_get_mode().mode

    if ignore[mode] then
      return ok
    end

    local levels = vim.diagnostic.severity
    local errors = #vim.diagnostic.get(0, {severity = levels.ERROR})
    if errors > 0 then
      return ' ✘ '
    end

    local warnings = #vim.diagnostic.get(0, {severity = levels.WARN})
    if warnings > 0 then
      return ' ▲ '
    end

    return ok
  end,

  diagnostic_status = function()
    return ""
  end,

  mode = function()
    -- Note that: \19 = ^S and \22 = ^V.
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
  end,

  git_branch = function()
    if vim.b.minigit_summary and vim.b.minigit_summary.head_name then
        return string.format('  %s ', vim.b.minigit_summary.head_name)
    else
        return '' -- Return an empty string or some default value if the branch name is not available
    end
  end

}

Statusline_component = function(name)
  return statusline_components[name]()
end

local get_component = function(name)
  return string.format('%%{%%v:lua.Statusline_component("%s")%%} ', name)
end

local statusline = {
  get_component("micro_spacer"),
  get_component("mode"),
  get_component("diagnostic_status"),
  get_component("git_branch"),
  get_component("spacer"), -- spacer
  '%{&filetype}', -- filetype
  ' %2p%%', -- progress %
  ' %3l:%-2c ' -- position
}

vim.o.statusline = table.concat(statusline, '')
