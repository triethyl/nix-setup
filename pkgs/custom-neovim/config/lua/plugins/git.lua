return {
  {
    "mini-git", -- fsr this is named mini-git?
    lazy = false,
    cmd = "Git",
    after = function()
      require("mini.git").setup()
    end
  },
  {
    "mini.diff",
    lazy = false,
    after = function()
      require("mini.diff").setup()
    end
  },
  {
    "neogit",
    lazy = true,
    cmd = "Neogit",
    after = function()
      vim.cmd.packadd("plenary.nvim")
      require("neogit").setup {
        kind = "floating",
        mappings = {
          status = {
            ["<esc>"] = "Close",
            ["<space>"] = "Toggle",
          },
        },
      }
    end
  },
}
