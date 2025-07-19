-- Set colorscheme.
vim.cmd.colorscheme("carbonfox")

-- Set boolean to use patches.
local correct_borderless_windows = true

-- Enable good colors.
vim.o.termguicolors = true

-- Patches.
local link_highlight = function(first_highlight, second_highlight)
  vim.cmd.highlight {bang = true, "link", first_highlight, second_highlight}
end

vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
  callback = function()
    -- Fixes some colorschemes having borderless floating windows.
    if correct_borderless_windows then
      link_highlight("FloatBorder", "Comment")
      
      -- Telescope-specific highlights
      link_highlight("TelescopeBorder", "Comment")
      link_highlight("TelescopeResultsTitle", "Variable")
      link_highlight("TelescopePreviewTitle", "Variable")
      link_highlight("TelescopePromptTitle", "Variable")
      link_highlight("TelescopePromptNormal", "Variable")
      link_highlight("TelescopePromptBorder", "Variable")
      link_highlight("TelescopePromptPrefix", "Variable")

      -- Snacks-specific highlights
      -- link_highlight("SnacksPickerDir", "SnacksPickerFile")
    end
  end,
})
