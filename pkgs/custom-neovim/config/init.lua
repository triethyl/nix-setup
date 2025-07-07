-- Require utilities.
require("utilities")

-- Require config parts.
require("options")
require("mappings")
require("autocommands")
require("neovide")

-- Require plugin configs.
-- UI Plugins:
require("plugins.lualine")
require("plugins.tabby")
require("plugins.telescope")

-- LSP Plugins:
require("plugins.lspconfig")

-- Misc Plugins:
require("plugins.presence")
