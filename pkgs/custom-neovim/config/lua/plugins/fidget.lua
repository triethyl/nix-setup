return {
  "fidget.nvim",
  lazy = false,
  after = function ()
    require("fidget").setup()
  end
}
