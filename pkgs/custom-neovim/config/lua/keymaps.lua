-- Create keymap function
local mapkey = function(mode, key, desc, action, plugin)
  local keymapper = plugin and require("lz.n").keymap(plugin).set or vim.keymap.set 
  keymapper(mode, key, action, {noremap = true, silent = true, desc = desc})
end

-- Set the leader key
vim.g.mapleader = " "

-- Pickers
mapkey("n", "<leader>f", "Open file picker", ":Pick files<cr>", "mini.pick")
mapkey("n", "<leader>o", "Open old file picker", ":Pick oldfiles<cr>", "mini.pick")
mapkey("n", "<leader>/", "Open live grep picker", ":Pick grep_live<cr>", "mini.pick")

-- File manager
mapkey("n", "<leader>e", "Open file manager", ":lua MiniFiles.open()<cr>", "mini.files")
