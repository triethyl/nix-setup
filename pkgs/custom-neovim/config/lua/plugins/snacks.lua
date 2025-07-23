require("snacks").setup {
  bigfile = { enabled = true },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
  lazygit = {
    enabled = true,
    config = {
      quitOnTopLevelReturn = true,
    },
  },
}
