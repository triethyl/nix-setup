require("focus").setup {
  enable = true,
  split = {
    -- bufnew = true,
  },
  ui = {
    winhighlight = true, -- Highlight focused and unfocused windows
    signcolumn = false, -- Signcolumn on all windows
    -- cursorline = false,
  },
}

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "picker",
  callback = function(args)
    vim.b[args.buf].cursorline = false
  end,
})
