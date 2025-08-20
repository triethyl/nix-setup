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
mapkey("n", "<leader>b", "Open buffer picker", ":Pick buffers<cr>", "mini.pick")
mapkey("n", "<leader>k", "Open colorscheme picker", ":Pick colorschemes<cr>", "mini.pick")

-- File manager
mapkey("n", "<leader>e", "Open file manager", ":lua MiniFiles.open()<cr>", "mini.files")

-- Git
mapkey("n", "<leader>g", "Manage git", "")
mapkey("n", "<leader>gg", "Open neogit", ":Neogit<cr>", "neogit")
mapkey("n", "<leader>ga", "Git add", ":Git add %:p<cr>", "mini-git")
mapkey("n", "<leader>gr", "Git remove", ":Git rm %:p<cr>", "mini-git")
mapkey("n", "<leader>gc", "Git commit", ":Git commit<cr>", "mini-git")
mapkey("n", "<leader>gp", "Git pull", ":Git pull<cr>", "mini-git")
mapkey("n", "<leader>gP", "Git push", ":Git push<cr>", "mini-git")

-- Terminal
mapkey("n", "<leader>t", "Open terminal", ":botright terminal<cr>")

-- Really delete
mapkey({"n", "v"}, "<leader>d", "Really delete", [["_d]])
mapkey({"n", "v"}, "<leader>x", "Really delete character", [["_x]])

-- Visual Movement Keys.
mapkey({"n", "v"}, "j", "Go down visually", "gj")
mapkey({"n", "v"}, "k", "Go up visually", "gk")

-- QOL Keys
mapkey("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.
mapkey("n", "<esc>", "Clear highlights", ":noh<cr>") -- Make esc clear highlights
