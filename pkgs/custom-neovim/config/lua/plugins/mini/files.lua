require("mini.files").setup {
  mappings = {
    close       = '<esc>',
    go_in       = 'L',
    go_in_plus  = '<c-l>',
    go_out      = 'H',
    go_out_plus = '<c-h>',
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<bs>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },
  windows = {
    preview = true,
  },
}
