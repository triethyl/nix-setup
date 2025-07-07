-- General Settings
vim.o.winborder = 'rounded'
vim.o.showmode = false
vim.o.icm = 'split'
vim.o.cia = 'abbr,kind,menu'
vim.o.mouse = ""
vim.o.number = true -- set numbered lines
vim.o.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.clipboard = "unnamedplus" -- use system clipboard
vim.o.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize' -- Things to save with the session. 
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return '<c-y>' end
  return '<cr>'
end, { expr = true }) -- Make enter complete command.

-- Indention
local indent = 2
vim.o.autoindent = true -- auto indentation
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = indent -- the number of spaces inserted for each indentation
vim.o.smartindent = true -- make indenting smarter
vim.o.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
vim.o.tabstop = indent -- insert 2 spaces for a tab
vim.o.shiftround = true -- use multiple of shiftwidth when indenting with "<" and ">"

-- Backups
vim.o.backup = false -- create a backup file
vim.o.swapfile = false -- creates a swapfile
vim.o.writebackup = false -- if a file is being edited by another program, it is not allowed to be edited

-- Search
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.smartcase = true -- smart case

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Set folder to treesitter.
vim.o.foldlevel = 99 -- Don't fold initially.
vim.o.foldnestmax = 4 -- Don't fold if more than 4 folds deep.
vim.o.foldtext = "" -- Color text in folds.

-- Set Colorscheme
vim.cmd.colorscheme("oxocarbon")
vim.o.termguicolors = true

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "CodeNewRoman Nerd Font:h12"
  vim.g.neovide_scale_factor = 0.8

  -- Zoom keymaps.
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1/1.1)
  end)

  -- Standard terminal emulator keymaps.
  vim.api.nvim_set_keymap("c", "<sc-v>", "<C-R>+", { noremap = true }) -- Paste in command mode.
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true}) -- Paste in terminal mode.
end
