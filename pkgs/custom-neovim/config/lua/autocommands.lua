-- Autocommands

-- Use relative line number in normal mode and absolute in insert mode
-- vim.opt.number = true
-- local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})
-- vim.api.nvim_create_autocmd(
--   { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
--   {
--      group = numbertoggle,
--      callback = function()
--        if vim.opt.number and vim.api.nvim_get_mode() ~= "i" then
--           vim.opt.relativenumber = true
--        end
--      end,
--   }
-- )

-- vim.api.nvim_create_autocmd(
--   { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
--   {
--      group = numbertoggle,
--      callback = function()
--        if vim.opt.number then
--           vim.opt.relativenumber = false
--           vim.cmd("redraw")
--        end
--      end,
--   }
-- )

 -- start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd "startinsert!"
  end,
})
