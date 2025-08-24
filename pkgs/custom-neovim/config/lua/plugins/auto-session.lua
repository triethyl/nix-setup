return {
  "auto-session",
  lazy = false,
  after = function ()
    require("auto-session").setup()
  end
}
