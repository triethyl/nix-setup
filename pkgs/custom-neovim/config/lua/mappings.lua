-- Keymap function.
local mapkey = utils.mapkey

-- Map the leader key.
vim.g.mapleader = ' '

-- Pickers
mapkey("n", "<leader>f", "Open file picker", Snacks.picker.files)
mapkey("n", "<leader>c", "Open recent file picker", Snacks.picker.recent)
mapkey("n", "<leader>e", "Open file explorer", Snacks.picker.explorer)
mapkey("n", "<leader>b", "Open buffer picker", Snacks.picker.buffers)
mapkey("n", "<leader>B", "Open buffer live grep picker", Snacks.picker.grep_buffers)
mapkey("n", "<leader>y", "Open clipboard history picker", Snacks.picker.cliphist)
mapkey("n", "<leader>/", "Open live grep picker", Snacks.picker.grep)
mapkey("n", "<leader>\\", "Open command palette", Snacks.picker.commands)
mapkey("n", "<leader>?", "Open help picker", Snacks.picker.help)
mapkey("n", "<leader>p", "Open picker picker", Snacks.picker.pickers)
mapkey("n", "<leader>'", "Open last picker", Snacks.picker.resume)

-- Commenting.
mapkey("n", "<C-c>", "Comment line", ":norm gcc<cr>")
mapkey("v", "<C-c>", "Comment line", ":norm gc<cr>")

-- Tabs
mapkey("n", "<leader>t", "Manage tabs", "")
mapkey("n", "<leader>tt", "Open new tab", ":tabnew<cr>")
mapkey("n", "<leader>tq", "Close tab", ":tabclose<cr>")
mapkey("n", "<leader>tn", "Go to next tab", ":tabnext<cr>")
mapkey("n", "<leader>tp", "Go to previous tab", ":tabprev<cr>")

-- Sessions
mapkey("n", "<leader>s", "Manage sessions", "")
mapkey("n", "<leader>ss", "Open session picker", ":SessionSelect<cr")

-- QOL Keys
mapkey("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.
mapkey("n", "<esc>", "Clear highlights", ":noh<cr>") -- Make esc clear highlights

-- Visual Movement Keys.
mapkey({"n", "v"}, "j", "Go down visually", "gj")
mapkey({"n", "v"}, "k", "Go up visually", "gk")

-- Learn hjkl.
mapkey({"n", "v"}, "<left>", "Correct the keypress", function() print("Try pressing h instead.") end)
mapkey({"n", "v"}, "<down>", "Correct the keypress", function() print("Try pressing j instead.") end)
mapkey({"n", "v"}, "<up>", "Correct the keypress", function() print("Try pressing k instead.") end)
mapkey({"n", "v"}, "<right>", "Correct the keypress", function() print("Try pressing l instead.") end)
