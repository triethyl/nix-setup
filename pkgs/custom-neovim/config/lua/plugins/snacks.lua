require("snacks").setup {
  bigfile = { enabled = true },
  picker = { enabled = true },
  lazygit = {
    enabled = true,
    config = {
      quitOnTopLevelReturn = true,
    },
  },
}
