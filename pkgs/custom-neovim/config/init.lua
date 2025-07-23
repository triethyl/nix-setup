-- Require utilities.
require("utilities")
require("art")

-- Require config parts.
require("options")
require("autocommands")
require("colorscheme")
require("neovide")
require("mappings")

-- Require plugin configs.
-- UI Plugins:
require("plugins.lualine")
require("plugins.tabby")
require("plugins.mini.clue")
require("plugins.mini.indentscope")
require("plugins.mini.notify")
require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini.files")

-- LSP Plugins:
require("plugins.lspconfig")
require("plugins.actions-preview")

-- Misc Plugins:
require("plugins.presence")
require("plugins.snacks")
-- require("hardtime").setup()
