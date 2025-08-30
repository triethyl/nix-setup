-- LSP Configs
-- Get more from https://github.com/neovim/nvim-lspconfig/tree/master/lsp

-- Lua LS
vim.lsp.config("lua_ls", {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
})
vim.lsp.enable("lua_ls")

-- Marksman LS
vim.lsp.config("marksman", {
  cmd = {"marksman", "server"},
  filetypes = {"markdown", "markdown.mdx"},
  root_markers = {".marksman.toml", ".git"},
})
vim.lsp.enable("marksman")

-- Nixd LS
vim.lsp.config("nixd", {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
})
vim.lsp.enable("nixd")

-- LSP Autocommands

-- Disable semantic tokens to stop weird highlighting.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local mapkey = function(mode, key, desc, action, plugin)
      local keymapper = plugin and require("lz.n").keymap(plugin).set or vim.keymap.set
      keymapper(mode, key, action, { noremap = true, silent = true, desc = desc })
    end

    -- LSP Pickers
    mapkey('n', "<leader>a", "Perform code action", ":lua require('actions-preview').code_actions()<cr>", "actions-preview.nvim")
    mapkey("n", "<leader>S", "Open workspace symbol picker", [[:Pick lsp scope="workspace_symbol"<cr>]], "mini.pick")
    mapkey("n", "<leader>s", "Open symbol picker", [[:Pick lsp scope="document_symbol"<cr>]], "mini.pick")
    mapkey("n", "<leader>I", "Open workspace diagnostic picker", [[:Pick diagnostic scope="all"<cr>]], "mini.pick")
    mapkey("n", "<leader>i", "Open diagnostic picker", [[:Pick diagnostic scope="current"<cr>]], "mini.pick")

    -- Goto Keys
    mapkey('n', 'gD', "Go to declaration", vim.lsp.buf.declaration)
    mapkey('n', 'gd', "Go to definition", vim.lsp.buf.definition)
    mapkey('n', 'go', "Go to type definition", vim.lsp.buf.type_definition)
    mapkey('n', 'gi', "Go to implementation", vim.lsp.buf.implementation)

    -- Other LSP Keys
    mapkey('n', 'gs', "Go to signature help", vim.lsp.buf.signature_help)
    mapkey('n', 'gR', "Go to buffer references", vim.lsp.buf.references)
    mapkey('n', '<leader>r', "Rename symbol", vim.lsp.buf.rename)
    mapkey('n', '<leader>h', "Format buffer", function()
      vim.lsp.buf.format { async = true }
    end)
  end,
})
