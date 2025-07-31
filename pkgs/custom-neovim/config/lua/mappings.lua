-- Keymap function.
local mapkey = Utils.mapkey

-- Map the leader key.
vim.g.mapleader = ' '

-- Pickers
mapkey("n", "<leader>f", "Open file picker", ":lua Snacks.picker.files()<cr>")
mapkey("n", "<leader>l", "Open recent file picker", ":lua Snacks.picker.recent()<cr>")
mapkey("n", "<leader>b", "Open buffer picker", ":lua Snacks.picker.buffers()<cr>")
mapkey("n", "<leader>B", "Open buffer live grep picker", ":lua Snacks.picker.grep_buffers()<cr>")
mapkey("n", "<leader>y", "Open clipboard history picker", ":lua Snacks.picker.cliphist()<cr>")
mapkey("n", "<leader>/", "Open live grep picker", ":lua Snacks.picker.grep()<cr>")
mapkey("n", "<leader>\\", "Open command palette", ":lua Snacks.picker.commands()<cr>")
mapkey("n", "<leader>?", "Open help picker", ":lua Snacks.picker.help()<cr>")
mapkey("n", "<leader>p", "Open picker picker", ":lua Snacks.picker.pickers()<cr>")
mapkey("n", "<leader>'", "Open last picker", ":lua Snacks.picker.resume()<cr>")
mapkey("n", "<leader><leader>", "Open smart picker", ":lua Snacks.picker.smart()<cr>")

-- Tabs
mapkey("n", "<leader>t", "Manage tabs", "")
mapkey("n", "<leader>tt", "Open new tab", ":tabnew<cr>")
mapkey("n", "<leader>tc", "Close tab", ":tabclose<cr>")
mapkey("n", "<leader>tn", "Go to next tab", ":tabnext<cr>")
mapkey("n", "<leader>tp", "Go to previous tab", ":tabprev<cr>")

-- Windows
mapkey("n", "<leader>w", "Manage windows", "<C-w>")

-- Sessions
mapkey("n", "<leader>s", "Manage sessions", "")
mapkey("n", "<leader>sw", "Save current session", ":SessionSave<cr>")
mapkey("n", "<leader>ss", "Switch and save session", ":SessionSave<cr> <bar> :SessionSelect<cr>")
mapkey("n", "<leader>sp", "Open session picker", ":SessionSelect<cr>")
mapkey("n", "<leader>sd", "Delete current session", ":SessionDelete<cr>")
mapkey("n", "<leader>sl", "Open last session", ":SessionLoadLast<cr>")

-- Terminals
mapkey("n", "<leader>c", "Manage terminals", "")

-- Git
mapkey("n", "<leader>g", "Open lazygit", ":lua Snacks.lazygit()<cr>")

-- Other leader keys
mapkey("n", "<leader>e", "Open file manager", ":lua MiniFiles.open()<cr>")

-- QOL Keys
mapkey("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.
mapkey("n", "<esc>", "Clear highlights", ":noh<cr>") -- Make esc clear highlights
mapkey("n", "<leader>q", "Close buffer", ":bd<cr>")
mapkey("n", "<leader>Q", "Force close buffer", ":bd!<cr>")
mapkey({"n", "v"}, "<leader>d", "Really delete", [["_d]])

-- Visual Movement Keys.
-- mapkey({"n", "v"}, "j", "Go down visually", "gj")
-- mapkey({"n", "v"}, "k", "Go up visually", "gk")

-- Learn hjkl.
-- mapkey({"n", "v"}, "<left>", "Correct the keypress", function() print("Try pressing h instead.") end)
-- mapkey({"n", "v"}, "<down>", "Correct the keypress", function() print("Try pressing j instead.") end)
-- mapkey({"n", "v"}, "<up>", "Correct the keypress", function() print("Try pressing k instead.") end)
-- mapkey({"n", "v"}, "<right>", "Correct the keypress", function() print("Try pressing l instead.") end)
