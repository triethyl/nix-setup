return {
  {
    "nightfox.nvim",
    enabled = true,
    lazy = false,
    after = function ()
      vim.cmd.colorscheme("carbonfox")
    end
  },
  {
    "vim-gruvbox8",
    enabled = false,
    lazy = false,
    after = function ()
      vim.cmd.colorscheme("gruvbox8")
    end
  },
}
