return {
  "mini.files",
  -- enabled = false,
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
