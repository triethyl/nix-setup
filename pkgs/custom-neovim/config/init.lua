-- Require utilities.
require("utilities")
require("art")

-- Require config parts.
require("options")
require("mappings")
require("autocommands")
require("colorscheme")
require("neovide")

-- Require plugin configs.
-- UI Plugins:
require("plugins.lualine")
require("plugins.tabby")
require("plugins.telescope")
require("plugins.alpha")
require("plugins.which-key")

-- LSP Plugins:
require("plugins.lspconfig")

-- Misc Plugins:
require("plugins.presence")
