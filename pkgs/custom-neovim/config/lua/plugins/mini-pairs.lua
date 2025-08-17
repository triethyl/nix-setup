return {
  "mini.pairs",
  lazy = true,
  event = "InsertEnter",
  after = function()
    require("mini.pairs").setup()
  end
}
