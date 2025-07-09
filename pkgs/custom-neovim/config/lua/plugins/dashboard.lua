require('dashboard').setup {
  theme = "doom",
  config = {
    header = art.misc.hydra,
    center = {
      {
        icon = " ",
        desc = "Find file",
        key = "f",
        action = ":cd $HOME | Telescope find_files<cr>",
      },
    },
    vertical_center = true,
  },
}
