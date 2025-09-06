return {
  "calendar.vim",
  lazy = true,
  cmd = "Calendar",
  before = function ()
    vim.cmd.let("g:calendar_cache_directory = '~/Sync/.calendar.vim'")
  end
}
