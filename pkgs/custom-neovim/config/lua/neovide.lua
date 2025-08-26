if vim.g.neovide then
  vim.o.guifont = "CodeNewRoman Nerd Font:h12"
  vim.g.neovide_scale_factor = 0.8

  vim.g.neovide_floating_shadow = false

  -- Zoom keymaps.
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(0.05)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(-0.05)
  end)

  -- Standard terminal emulator keymaps.
  vim.api.nvim_set_keymap("c", "<sc-v>", "<C-R>+", { noremap = true }) -- Paste in command mode.
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true}) -- Paste in terminal mode.

	
  local positionAnimationLength = 0.2
  local scrollAnimationFarLines = 0.1
  local scrollAnimationLength = 0.1
  vim.g.neovide_position_animation_length = positionAnimationLength
  vim.g.neovide_scroll_animation_far_lines = scrollAnimationFarLines
  vim.g.neovide_scroll_animation_length = scrollAnimationLength

  -- Don't smooth scroll in terminals.
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function(args)
      local filetype = vim.api.nvim_buf_get_option(args.buf, "filetype")

     -- When entering terminal for first time I noticed the filetype is empty
      if filetype == '' or filetype == 'terminal' then
        vim.g.neovide_position_animation_length = 0
        vim.g.neovide_scroll_animation_far_lines = 0
        vim.g.neovide_scroll_animation_length = 0
      else
        vim.g.neovide_position_animation_length = positionAnimationLength
        vim.g.neovide_scroll_animation_far_lines = scrollAnimationFarLines
        vim.g.neovide_scroll_animation_length = scrollAnimationLength
      end
    end,
  })
end
