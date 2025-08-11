-- Autocommands

-- Equalize Splits when resized
vim.api.nvim_create_autocmd({"VimResized"}, {
  callback = function()
    -- vim.cmd.wincmd("=")
    vim.cmd("FocusAutoresize")
  end,
})
