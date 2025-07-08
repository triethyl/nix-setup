local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = art.misc.hydra

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Find recent file", ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "Load session", ""),
    dashboard.button( "q", "  > Quit", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
