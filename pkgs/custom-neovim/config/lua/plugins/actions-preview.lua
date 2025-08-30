return {
  "actions-preview.nvim",
  lazy = true,
  before = function ()
    require("lz.n").trigger_load("mini.pick")
  end,
  after = function ()
    require("actions-preview").setup {
      backend = { "minipick" },
    }
  end
}
