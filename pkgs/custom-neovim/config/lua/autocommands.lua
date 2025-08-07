-- Autocommands

-- start terminal in insert mode
-- vim.api.nvim_create_autocmd("TermOpen", {
--   callback = function()
--     vim.cmd "startinsert!"
--   end,
-- })

-- Equalize Splits when resized
-- vim.api.nvim_create_autocmd({"VimResized", "WinEnter"}, {
--   callback = function()
--     vim.cmd.wincmd("=")
--   end,
-- })
