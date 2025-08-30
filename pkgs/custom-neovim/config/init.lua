-- Improve startup time
vim.loader.enable()

-- Load plugins
require('lz.n').load('plugins')

-- Require config modules
require("options")
require("keymaps")
require("lsp")
require("statusline")
require("neovide")
