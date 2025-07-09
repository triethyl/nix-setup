local starter = require('mini.starter')
local my_items = {
  { name = 'Item #1 from function', action = "echo 'Item #1'", section = '' },
  { name = [[Another item in 'Section 1']], action = 'lua print(math.random() + 10)', section = '' },
}
starter.setup({
  evaluate_single = true,
  header = table.concat(art.misc.hydra, "\n"),
  footer = "",
  items = my_items,
  content_hooks = {
    -- starter.gen_hook.adding_bullet(),
    -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
    starter.gen_hook.aligning('center', 'center'),
    starter.gen_hook.padding(0, 0),
  },
})

