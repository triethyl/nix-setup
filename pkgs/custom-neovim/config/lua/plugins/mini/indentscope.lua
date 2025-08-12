require("mini.indentscope").setup()

-- Don't work in terminal or help windows.
local f = function(args) vim.b[args.buf].miniindentscope_disable = true end
vim.api.nvim_create_autocmd('Filetype', { pattern = 'help', callback = f })
vim.api.nvim_create_autocmd('TermOpen', {callback = f})
