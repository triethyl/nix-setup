return {
  "heirline.nvim",
  lazy = false,
  after = function ()
    -- Extra stuff from heirline.
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local using_icons = true

    -- Define Colors
    local colors = {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      light_gray = utils.get_highlight("Visual").bg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("diffDeleted").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      git_change = utils.get_highlight("diffChanged").fg,
    }

    -- Define components table.
    local components = {}

    -- Mode Component
    components.mode = {
      init = function (self)
        self.mode = vim.fn.mode(1)
      end,
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "N",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "V",
          vs = "Vs",
          V = "V_",
          Vs = "Vs",
          ["\22"] = "^V",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "I",
          ic = "Ic",
          ix = "Ix",
          R = "R",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "C",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
        mode_colors = {
          n = "red" ,
          i = "green",
          v = "cyan",
          V =  "cyan",
          ["\22"] =  "cyan",
          c =  "orange",
          s =  "purple",
          S =  "purple",
          ["\19"] =  "purple",
          R =  "orange",
          r =  "orange",
          ["!"] =  "red",
          t =  "red",
        },
      },
      provider = function (self)
        return "%2("..self.mode_names[self.mode].."%)"
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bold = true, }
      end,
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function ()
          vim.cmd.redrawstatus()
        end)
      },
    }

    -- Location Component
    components.location = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      provider = "%7(%l/%L%): %c",
    }

    -- Progress component.
    components.progress ={
      static = {
          sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
          -- Another variant, because the more choice the better.
          -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
      },
      provider = function(self)
          local curr_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_line_count(0)
          local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
          return string.rep(self.sbar[i], 2)
      end,
      hl = { fg = "blue", bg = "light_gray" },
    }

    -- Diagnostics component
    vim.diagnostic.config({
     signs = {
       text = {
         [vim.diagnostic.severity.ERROR] = using_icons and ' ' or "E",
         [vim.diagnostic.severity.WARN] = using_icons and ' ' or "W",
         [vim.diagnostic.severity.INFO] = using_icons and ' ' or "I",
         [vim.diagnostic.severity.HINT] = using_icons and ' ' or "H",
       },
     },
    })

    components.diagnostics = {
      condition = conditions.has_diagnostics,
      -- Example of defining custom LSP diagnostic icons, you can copypaste in your config:

      init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      update = { "DiagnosticChanged", "BufEnter" },

      {
          provider = function(self)
              -- 0 is just another output, we can decide to print it or not!
              -- local error_icon = using_icons and ' ' or "E"
              local error_icon = (vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR]) or ""
              return self.errors > 0 and (error_icon .. self.errors .. " ")
          end,
          hl = { fg = "diag_error" },
      },
      {
          provider = function(self)
              -- local warn_icon = using_icons and ' ' or "W"
              local warn_icon = (vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN]) or ""
              return self.warnings > 0 and (warn_icon .. self.warnings .. " ")
          end,
          hl = { fg = "diag_warn" },
      },
      {
          provider = function(self)
              -- local info_icon = using_icons and ' ' or "I"
              local info_icon = (vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO]) or ""
              return self.info > 0 and (info_icon .. self.info .. " ")
          end,
          hl = { fg = "diag_info" },
      },
      {
          provider = function(self)
              -- local hint_icon = using_icons and ' ' or "H"
              local hint_icon = (vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT]) or ""
              return self.hints > 0 and (hint_icon .. self.hints)
          end,
          hl = { fg = "diag_hint" },
      },
    }

    -- Working directory component
    components.cwd = {
      provider = function()
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        if not conditions.width_percent_below(#cwd, 0.25) then
          cwd = vim.fn.pathshorten(cwd)
        end
        local trail = cwd:sub(-1) == '/' and '' or "/"
        return cwd  .. trail
      end,
      hl = { fg = "blue", bold = true },
    }

    -- Git component.
    components.git_status = {
      condition = conditions.is_git_repo,

      init = function (self)
        self.summary = vim.b.minigit_summary and vim.b.minigit_summary.head_name or nil
      end,

      {
        provider = function (self)
          -- Get git summary.
          if self.summary == nil then return '' end


        end,
      },
    }

    components.git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.minidiff_summary
        print (self.status_dict)
        self.head = vim.b.minigit_summary and vim.b.minigit_summary.head_name or ""
        self.has_changes = self.status_dict.add ~= 0 or self.status_dict.delete ~= 0 or self.status_dict.change ~= 0
      end,

      hl = { fg = "orange" },

      {   -- git branch name
        provider = function(self)
          return " " .. self.head
        end,
        hl = { bold = true }
      },
      -- You could handle delimiters, icons and counts similar to Diagnostics
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = "("
      },
      {
        provider = function(self)
          local count = self.status_dict.add or 0
          print (count)
          return count > 0 and ("+" .. count)
        end,
        hl = { fg = "git_add" },
      },
      {
        provider = function(self)
          local count = self.status_dict.delete or 0
          return count > 0 and ("-" .. count)
        end,
        hl = { fg = "git_del" },
      },
      {
        provider = function(self)
          local count = self.status_dict.change or 0
          return count > 0 and ("~" .. count)
        end,
        hl = { fg = "git_change" },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ")",
      },
    }

    -- Spacers
    local space = {provider = " "}
    local dynamic_space = {provider = "%="}

    -- Assemble statusline.
    local statusline = {
      components.mode, space,
      components.git, space,
      components.cwd, space,
      components.diagnostics,

      dynamic_space,

      components.location, space,
      components.progress,
    }

    -- Setup heirline.
    require("heirline").setup {
      opts = {
        colors = colors,
      },
      statusline = statusline,
    }
  end
}
