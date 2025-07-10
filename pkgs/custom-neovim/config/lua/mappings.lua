-- Keymap function.
local mapkey = utils.mapkey

-- Map the leader key.
vim.g.mapleader = ' '

-- Pickers
mapkey("n", "<leader>f", "Open file picker", ":Telescope find_files<cr>")
mapkey("n", "<leader>c", "Open recent file picker", ":Telescope oldfiles<cr>")
-- mapkey("n", "<leader>e", "Open file explorer", ":Pick explorer<cr>")
mapkey("n", "<leader>b", "Open buffer picker", ":Telescope buffers<cr>")
mapkey("n", "<leader>/", "Open live grep picker", ":Telescope live_grep<cr>")
mapkey("n", "<leader>\\", "Open command palette", ":Telescope commands<cr>")
mapkey("n", "<leader>?", "Open help picker", ":Telescope help<cr>")
mapkey("n", "<leader>'", "Open last picker", ":Telescope resume<cr>")

-- Tabs
mapkey("n", "<leader>t", "Manage tabs", "")
mapkey("n", "<leader>tt", "Open new tab", ":tabnew<cr>")
mapkey("n", "<leader>tq", "Close tab", ":tabclose<cr>")
mapkey("n", "<leader>tn", "Go to next tab", ":tabnext<cr>")
mapkey("n", "<leader>tp", "Go to previous tab", ":tabprev<cr>")

-- QOL Keys
mapkey("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.
mapkey("n", "<esc>", "Clear highlights", ":noh<cr>") -- Make esc clear highlights
