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
    win = {
      height = 0.8,
    },
  },
  input = {
    enabled = true,
  },
  terminal = {
    -- interactive = false,
    start_insert = true,
    auto_insert = true,
    win = {
      height = 0.2,
    },
    keys = {},
  },
}

-- Utils.mapkey("t", "<c-w>", "Manage windows", "<c-\\><c-o><c-w>")
