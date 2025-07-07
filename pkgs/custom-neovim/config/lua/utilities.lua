utils = {}

utils.mapkey = function(mode, key, desc, action)
  vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = desc})
end
