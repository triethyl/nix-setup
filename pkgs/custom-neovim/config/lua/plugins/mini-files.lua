return {
  "mini.files",
  lazy = true,
  after = function()
    require("mini.files").setup {
      mappings = {
        close = "<esc>",
      },
      windows = {
        preview = true,
      },
    }
  end
}
