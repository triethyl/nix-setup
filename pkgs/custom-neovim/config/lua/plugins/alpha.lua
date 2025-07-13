local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = Art.misc.hydra

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "f", "  > Find file", ":cd $HOME | Telescope find_files<CR>" ),
    dashboard.button( "r", "  > Find recent file", ":Telescope oldfiles<CR>" ),
    dashboard.button( "s", "  > Load session", ":Telescope persisted<cr>" ),
    dashboard.button( "l", "  > Load last session", ":SessionLoadLast<cr>" ),
    dashboard.button( "q", "  > Quit", ":qa<CR>" ),
}

-- Center components.
dashboard.section.header.opts.position = "center"
dashboard.section.footer.opts.position = "center"

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Set options just for the dashboard.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.foldenable = false -- disable folding
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})

