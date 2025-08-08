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
require("lsp")
require("completion")

-- UI Plugins:
require("plugins.mini.tabline")
require("plugins.mini.clue")
require("plugins.mini.indentscope")
require("plugins.mini.notify")
require("plugins.treesitter")
require("plugins.mini.files")
require("plugins.dropbar")
require("plugins.auto-session")
require("plugins.gitsigns")
require("plugins.namu")

-- LSP Plugins:
require("plugins.actions-preview")

-- Utility Plugins:
require("plugins.mini.git")
require("plugins.mini.pairs")
require("plugins.ts-autotag")

-- Misc Plugins:
require("plugins.presence")
require("plugins.snacks")
-- require("hardtime").setup()
