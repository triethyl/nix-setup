-- Set colorscheme.
vim.cmd.colorscheme("oxocarbon")

-- Set boolean to use patches.
local correct_borderless_windows = true

-- Patches.
local link_highlight = function(first_highlight, second_highlight)
  vim.cmd.highlight {bang = true, "link", first_highlight, second_highlight}
end

if correct_borderless_windows then
  link_highlight("TelescopeBorder", "Comment")
  link_highlight("TelescopeResultsTitle", "Comment")
  link_highlight("TelescopePreviewTitle", "Comment")
end
