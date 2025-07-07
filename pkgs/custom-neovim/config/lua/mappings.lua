-- Keymap function.
local keymap = function(mode, key, desc, action)
  vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = desc})
end

local mapkey = utils.mapkey

-- Map the leader key.
vim.g.mapleader = ' '

vim.keymap.set("n", "<C-c>", "gcc", {noremap = true, silent = true})

-- Pickers
keymap("n", "<leader>f", "Open file picker", ":Pick files<cr>")
keymap("n", "<leader>c", "Open recent file picker", ":Pick oldfiles<cr>")
keymap("n", "<leader>e", "Open file explorer", ":Pick explorer<cr>")
keymap("n", "<leader>b", "Open buffer picker", ":Pick buffers<cr>")
keymap("n", "<leader>/", "Open live grep picker", ":Pick grep_live<cr>")
keymap("n", "<leader>\\", "Open command palette", ":Pick commands<cr>")
keymap("n", "<leader>?", "Open help picker", ":Pick help<cr>")
keymap("n", "<leader>'", "Open last picker", ":Pick resume<cr>")

-- Tabs
keymap("n", "<leader>t", "Manage tabs", "")
keymap("n", "<leader>tt", "Open new tab", ":tabnew<cr>")
keymap("n", "<leader>tq", "Close tab", ":tabclose<cr>")
keymap("n", "<leader>tn", "Go to next tab", ":tabnext<cr>")
keymap("n", "<leader>tp", "Go to previous tab", ":tabprev<cr>")

-- QOL Keys
keymap("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
