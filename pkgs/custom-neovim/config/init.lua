-- Require utilities.
require("utilities")
require("art")

-- Require config parts.
require("options")
require("autocommands")
require("colorscheme")
require("neovide")

-- Require plugin configs.
-- UI Plugins:
require("plugins.lualine")
require("plugins.tabby")
require("plugins.which-key")
require("plugins.snacks")
-- require("plugins.alpha")
require("plugins.mini.clue")
require("plugins.mini.indentscope")
require("plugins.mini.notify")

-- LSP Plugins:
require("plugins.lspconfig")

-- Misc Plugins:
require("plugins.presence")

-- Require mappings last.
require("mappings")
