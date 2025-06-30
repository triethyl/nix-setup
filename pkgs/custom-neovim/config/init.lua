require 'tangerine'.setup {
  vimrc = "./init.fnl",
  source = "./fnl",
  target = "./lua",
  compiler = {
    verbose = false,
    hooks = { "oninit" }
  },
}
