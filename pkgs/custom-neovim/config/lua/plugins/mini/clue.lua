local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'v', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'v', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'v', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'v', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'v', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },
    -- { mode = 'n', keys = '<leader>w' },

    -- `z` key
    { mode = 'v', keys = 'z' },
    { mode = 'n', keys = 'z' },
  },

  clues = {
    { mode = {'n', 'v'}, keys = '<Leader>' },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    Utils.replaceInTable(miniclue.gen_clues.windows(), "<C%-w>", "<leader>w"),
    miniclue.gen_clues.z(),
  },

  window = {
    delay = 0,

    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
})
