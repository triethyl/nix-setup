local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})
