return {
  "nvim-colorizer.lua",
  lazy = false,
  after = function ()
    require("colorizer").setup()
  end
}
