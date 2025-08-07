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
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local mapkey = Utils.mapkey

    -- Workspace management
    mapkey('n', "<leader>o", "Manage LSP workspace", "")
    mapkey('n', '<leader>oa', "Add Workspace Folder", vim.lsp.buf.add_workspace_folder)
    mapkey('n', '<leader>or', "Remove Workspace Folder", vim.lsp.buf.remove_workspace_folder)
    mapkey('n', '<leader>ol', "List Workspace Folders", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)

    -- LSP Pickers
    mapkey('n', "<leader>a", "Perform code action", ":lua require('actions-preview').code_actions()<cr>")
    mapkey("n", "<leader>I", "Open workspace diagnostic picker", ":lua Snacks.picker.diagnostics()<cr>")
    mapkey("n", "<leader>i", "Open diagnostic picker", [[:lua Snacks.picker.diagnostics_buffer()<cr>]])
    mapkey("n", "<leader>s", "Open symbol picker", ":lua Snacks.picker.lsp_symbols()<cr>")
    mapkey("n", "<leader>S", "Open workspace symbol picker", ":lua Snacks.picker.lsp_workspace_symbols()<cr>")

    -- Goto Keys
    mapkey('n', 'gD', "Go to declaration", vim.lsp.buf.declaration)
    mapkey('n', 'gd', "Go to definition", vim.lsp.buf.definition)
    mapkey('n', 'go', "Go to type definition", vim.lsp.buf.type_definition)
    mapkey('n', 'gi', "Go to implementation", vim.lsp.buf.implementation)

    -- Other LSP Keys
    mapkey('n', 'gs', "Signature Help", vim.lsp.buf.signature_help)
    mapkey('n', 'gr', "Buffer References", vim.lsp.buf.references)
    mapkey('n', '<leader>r', "Rename Symbol", vim.lsp.buf.rename)
    mapkey('n', '<leader>h', "Format Buffer", function()
      vim.lsp.buf.format { async = true }
    end)
  end,
})

local lspconfig = require('lspconfig')

-- Configure individual lsps
lspconfig.nil_ls.setup {}
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
lspconfig.marksman.setup {}
