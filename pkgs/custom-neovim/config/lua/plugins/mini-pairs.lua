return {
  "mini.pairs",
  -- enabled = false,
  lazy = true,
  event = "InsertEnter",
  after = function()
    require("mini.pairs").setup()
  end
}
