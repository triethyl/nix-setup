return {
  {
    "nightfox.nvim",
    -- lazy = false,
    event = "VimEnter",
    after = function ()
      require("nightfox").setup {
        options = {
          module_default = false,
          modules = {
            "mini",
            "treesitter",
          },
        },
      }
      vim.cmd.colorscheme("carbonfox")
    end
  },
}
