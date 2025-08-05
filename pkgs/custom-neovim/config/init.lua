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

-- Require plugin configs.
-- UI Plugins:
require("plugins.tabby")
require("plugins.mini.clue")
require("plugins.mini.indentscope")
require("plugins.mini.notify")
require("plugins.treesitter")
require("plugins.mini.files")
require("plugins.dropbar")
require("plugins.auto-session")
-- require("plugins.vimade")

-- LSP Plugins:
require("plugins.lspconfig")
require("plugins.actions-preview")

-- Utility Plugins:
require("plugins.mini.git")

-- Misc Plugins:
require("plugins.presence")
require("plugins.snacks")
-- require("hardtime").setup()
