require("mini.tabline").setup {
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and '[+] ' or ''
    return MiniTabline.default_format(buf_id, label) .. suffix
  end
}

local link_hl = Utils.link_highlight

vim.api.nvim_create_autocmd({"Colorscheme", "VimEnter"}, {

  callback = function()
    -- Change colors.
    link_hl("MiniTablineHidden", "MiniStatuslineFilename")
    link_hl("MiniTablineVisible", "MiniStatuslineFilename")
    link_hl("MiniTablineVisible", "Italic")
    -- link_hl("MiniTablineCurrent", "MiniFilesCursorLine")
    link_hl("MiniTablineCurrent", "Bold")

    -- Make modified buffers the same color.
    link_hl("MiniTablineModifiedHidden", "MiniTablineHidden")
    link_hl("MiniTablineModifiedVisible", "MiniTablineVisible")
    link_hl("MiniTablineCurrent", "MiniFilesCursorLine")
    link_hl("MiniTablineModifiedCurrent", "MiniTablineCurrent")
  end,
})
