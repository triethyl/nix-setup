local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end
vim.keymap.set("", "<f1>", toggle_profile)

-- Require utilities.
require("utilities")
require("art")

-- Require config parts.
require("options")
require("autocommands")
require("colorschemes")
require("neovide")
require("mappings")
require("statusline")
require("completion")
require("lsp")

-- UI Plugins:
require("plugins.mini.icons")
require("plugins.mini.tabline")
require("plugins.mini.clue")
require("plugins.mini.indentscope")
require("plugins.fidget")
require("plugins.treesitter")
require("plugins.mini.files")
require("plugins.incline")
require("plugins.auto-session")
require("plugins.gitsigns")
require("plugins.namu")
require("plugins.focus")

-- LSP Plugins:
require("plugins.actions-preview")

-- Utility Plugins:
require("plugins.mini.git")
require("plugins.mini.pairs")
require("plugins.ts-autotag")
require("plugins.comment")

-- Misc Plugins:
require("plugins.presence")
require("plugins.snacks")
-- require("hardtime").setup()
