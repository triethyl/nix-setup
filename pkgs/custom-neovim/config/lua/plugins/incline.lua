local icons = require 'mini.icons'
require('incline').setup {
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    if filename == '' then
      filename = '[No Name]'
    end
    local ft_icon, ft_hl = icons.get("file", filename)
    local modified = vim.bo[props.buf].modified
    return {
      ft_icon and { ' ', ft_icon, ' ', gui = ft_hl } or '',
      ' ',
      { filename, gui = 'bold' },
      ' ',
      modified and '[+] ' or '',
    }
  end,
}
