return {
  "mini.statusline",
  lazy = false,
  after = function()
    MiniStatusline = require("mini.statusline")

    local hi_pattern = '%%#%s#%s%%*'

    local custom_sections = {

      git = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) then return '' end

        local summary = vim.b.minigit_summary and vim.b.minigit_summary.head_name or nil
        if summary == nil then return '' end

        local use_icons = MiniStatusline.config.use_icons
        local icon = args.icon or (use_icons and ' ' or 'Git: ')
        return " " .. icon .. (summary == '' and '-' or summary)
      end,

      diff = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) then return '' end

        if not vim.b.minidiff_summary then
          return ''
        end

        if not vim.b.minidiff_summary.add then
          return ''
        end

        if not vim.b.minidiff_summary.change then
          return ''
        end

        if not vim.b.minidiff_summary.delete then
          return ''
        end

        local use_icons = MiniStatusline.config.use_icons

        local status = {}

        local add_icon = use_icons and " " or "+"
        local change_icon = use_icons and " " or "~"
        local delete_icon = use_icons and " " or "-"

        local summary = vim.b.minidiff_summary

        if summary.add > 0 then
          table.insert(status, hi_pattern:format("Added", ("%s%s"):format(add_icon, summary.add)))
        end

        if summary.change > 0 then
          table.insert(status, hi_pattern:format("Changed", ("%s%s"):format(change_icon, summary.change)))
        end

        if summary.delete > 0 then
          table.insert(status, hi_pattern:format("Removed", ("%s%s"):format(delete_icon, summary.delete)))
        end

        summary = table.concat(status, " ")

        if summary == "" then return "" end

        local icon = args.icon or (use_icons and '' or 'Diff: ')
        return " " .. icon .. (summary == '' and '-' or summary)
      end,

      diagnostics = function(args)
        if MiniStatusline.is_truncated(args.trunc_width) then return '' end

        local use_icons = MiniStatusline.config.use_icons

        local diagnostics = {}

        local error_icon = use_icons and " " or "E"
        local warning_icon = use_icons and " " or "W"
        local info_icon = use_icons and " " or "I"
        local hint_icon = use_icons and " " or "H"

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

        vim.defer_fn(vim.cmd.redrawstatus, 500)

        -- Don't show diagnostics in insert mode.
        if MiniStatusline.section_mode({}):find "Insert" then
          return ""
        end

        local icon = args.icon or (use_icons and '' or 'Diag: ')

        local status = table.concat(diagnostics, " ")

        if status == "" then return "" end

        return " " .. icon .. status
      end,

      location = function()
        return '%2l:%-2c'
      end

    }

    MiniStatusline.setup {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git           = custom_sections.git({ trunc_width = 40 })
          local diff          = custom_sections.diff({ trunc_width = 75 })
          local diagnostics   = custom_sections.diagnostics({ trunc_width = 75 })
          local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location      = custom_sections.location()

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            { hl = 'MiniStatuslineFilename',  strings = { git, diff, diagnostics } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFilename', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { location } },
          })
        end
      },
    }
  end
}
