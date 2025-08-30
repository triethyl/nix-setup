return {
  "presence.nvim",
  lazy = false,
  after = function ()
    require('presence').setup({
      neovim_image_text = "Neovim Text Editor",
    })
  end
}
