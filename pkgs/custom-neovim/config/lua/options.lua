-- General
vim.o.clipboard = "unnamedplus" -- use system clipboard
vim.o.mouse = "" -- Don't use mouse
vim.o.timeout = false -- Disable key combo timeout

-- UI
vim.o.winborder = 'rounded' -- rounded window borders where possible.
vim.o.showtabline = 0 -- whether to only show tabline if there is more than one tab.
vim.o.laststatus = 3 -- only have one statusline at the bottom of the window.
vim.o.showmode = false -- don't show the mode in the commandline.
vim.o.ruler = false -- don't show #,# in the commandline.
vim.o.number = true -- set absolute numbered lines 
vim.o.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.winbar = " %f %m"

-- Finding
vim.o.gdefault = true -- Replace globally by default

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Set folder to treesitter.
vim.o.foldlevel = 99 -- Don't fold initially.
vim.o.foldnestmax = 4 -- Don't fold if more than 4 folds deep.
vim.o.foldtext = "" -- Color text in folds.

-- Thick window borders.
vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

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

-- Enable persistent undo
vim.o.undofile = true

-- Autocommands

-- Prevent Comments on Newlines
-- c: wrap text to textwidth, r: add comment when pressing enter in insert mode, o: add comment when pressing o
vim.api.nvim_create_autocmd("BufEnter", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end, }) 
