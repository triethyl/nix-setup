-- Keymap function.
local mapkey = Utils.mapkey

-- Map the leader key.
vim.g.mapleader = ' '

-- Pickers
mapkey("n", "<leader>f", "Open file picker", ":lua Snacks.picker.files()<cr>")
mapkey("n", "<leader>l", "Open recent file picker", ":lua Snacks.picker.recent()<cr>")
mapkey("n", "<leader>y", "Open clipboard history picker", ":lua Snacks.picker.cliphist()<cr>")
mapkey("n", "<leader>/", "Open live grep picker", ":lua Snacks.picker.grep()<cr>")
mapkey("n", "<leader>\\", "Open command palette", ":lua Snacks.picker.commands()<cr>")
mapkey("n", "<leader>?", "Open help picker", ":lua Snacks.picker.help()<cr>")
mapkey("n", "<leader>p", "Open picker picker", ":lua Snacks.picker.pickers()<cr>")
mapkey("n", "<leader>'", "Open last picker", ":lua Snacks.picker.resume()<cr>")
mapkey("n", "<leader><leader>", "Open smart picker", ":lua Snacks.picker.smart()<cr>")
mapkey("n", "<leader>z", "Open zoxide picker", ":lua Snacks.picker.zoxide()<cr>")
mapkey("n", "<leader>R", "Open treesitter picker", ":Namu treesitter<cr>")
mapkey("n", "<leader>k", "Open colorscheme picker", ":Namu colorscheme<cr>")

-- Dropbar
mapkey("n", "<leader>j", "Open dropdown", ":lua require('dropbar.api').pick()<cr>")

-- Tabs
mapkey("n", "<leader>t", "Manage tabs", "")
mapkey("n", "<leader>to", "Open new tab", ":tabnew<cr>")
mapkey("n", "<leader>tc", "Close tab", ":tabclose<cr>")
mapkey("n", "<leader>tt", "Go to next tab", ":tabnext<cr>")
mapkey("n", "<leader>tT", "Go to previous tab", ":tabprev<cr>")

-- Buffers
mapkey("n", "<leader>b", "Manage buffers", "")
mapkey("n", "<leader>bb", "Go to next buffer", ":bn<cr>")
mapkey("n", "<leader>bB", "Go to previous buffer", ":bp<cr>")
mapkey("n", "<leader>bc", "Delete current buffer", ":bd<cr>")
mapkey("n", "<leader>bp", "Open buffer picker", ":lua Snacks.picker.buffers()<cr>")
mapkey("n", "<leader>bg", "Open buffer live grep picker", ":lua Snacks.picker.grep_buffers()<cr>")

-- Windows
mapkey("n", "<leader>w", "Manage windows", "<C-w>")

-- Sessions
mapkey("n", "<leader>m", "Manage sessions", "")
mapkey("n", "<leader>mm", "Open session picker", ":Autosession search<cr>")
mapkey("n", "<leader>md", "Delete a session", ":Autosession delete<cr>")

-- Terminals
mapkey("n", "<leader>c", "Manage terminals", "")
mapkey("n", "<leader>cc", "Toggle terminal", ":lua Snacks.terminal.toggle()<cr>")
mapkey("n", "<leader>co", "Open new terminal", ":lua Snacks.terminal.open()<cr>")

-- Git
mapkey("n", "<leader>g", "Manage git", "")
mapkey("n", "<leader>gg", "Open lazygit", ":lua Snacks.lazygit()<cr>")
mapkey("n", "<leader>ga", "Add the current file", ":Git add %<cr>")
mapkey("n", "<leader>gs", "Open git status picker", ":lua Snacks.picker.git_status()<cr>")

-- Other leader keys
mapkey("n", "<leader>e", "Open file manager", ":lua MiniFiles.open()<cr>")

-- QOL Keys
mapkey("t", "<Esc><Esc>", "Exit terminal insert mode", "<C-\\><C-n>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.
mapkey("n", "<esc>", "Clear highlights", ":noh<cr>") -- Make esc clear highlights

-- Newline in normal mode.
mapkey('n', '<CR>', "Add newline below", 'm`o<Esc>``')
mapkey('n', '<S-CR>', "Add newline above", 'm`O<Esc>``')

-- Really delete
mapkey({"n", "v"}, "<leader>d", "Really delete", [["_d]])
mapkey({"n", "v"}, "<leader>x", "Really delete character", [["_x]])

-- Visual Movement Keys.
mapkey({"n", "v"}, "j", "Go down visually", "gj")
mapkey({"n", "v"}, "k", "Go up visually", "gk")

-- Exit neovim
mapkey("n", "<leader>q", "Save and exit neovim", function()
  vim.cmd("wa!")
  vim.cmd("qa!")
end)

mapkey("n", "<leader>Q", "Exit neovim", function()
  vim.cmd("qa!")
end)

-- Learn hjkl.
-- mapkey({"n", "v"}, "<left>", "Correct the keypress", function() print("Try pressing h instead.") end)
-- mapkey({"n", "v"}, "<down>", "Correct the keypress", function() print("Try pressing j instead.") end)
-- mapkey({"n", "v"}, "<up>", "Correct the keypress", function() print("Try pressing k instead.") end)
-- mapkey({"n", "v"}, "<right>", "Correct the keypress", function() print("Try pressing l instead.") end)
