local link_highlight = Utils.link_highlight

vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
  callback = function()
    -- Fixes some colorschemes having borderless floating windows.
    if vim.g.colors_name == "carbonfox" then

      link_highlight("VertSplit", "Variable")

      -- link_highlight("FloatBorder", "Comment")

      -- Telescope-specific highlights
      -- link_highlight("TelescopeBorder", "Comment")
      -- link_highlight("TelescopeResultsTitle", "Variable")
      -- link_highlight("TelescopePreviewTitle", "Variable")
      -- link_highlight("TelescopePromptTitle", "Variable")
      -- link_highlight("TelescopePromptNormal", "Variable")
      -- link_highlight("TelescopePromptBorder", "Variable")
      -- link_highlight("TelescopePromptPrefix", "Variable")

      -- Snacks-specific highlights
      -- link_highlight("SnacksPickerDir", "SnacksPickerFile")
    end
  end,
})
