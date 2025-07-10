-- vim.keymap.set('n', '<space>d', vim.diagnostic.setloclist, {desc = "Add buffer diagnostics to the location list."})

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
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    local keymap = function(mode, key, desc, action)
      vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = desc})
    end

    keymap('n', 'gD', "Go to declaration", vim.lsp.buf.declaration)
    keymap('n', 'gd', "Go to definition", vim.lsp.buf.definition)
    keymap('n', 'gy', "Go to type definition", vim.lsp.buf.type_definition)
    keymap('n', 'gi', "Go to implementation", vim.lsp.buf.implementation)
    keymap('n', '<M-k>', "Signature Help", vim.lsp.buf.signature_help)
    keymap('i', '<M-k>', "Signature Help", vim.lsp.buf.signature_help)
    keymap('n', "<space>o", "Manage LSP workspace", "")
    keymap('n', '<space>oa', "Add Workspace Folder", vim.lsp.buf.add_workspace_folder)
    keymap('n', '<space>or', "Remove Workspace Folder", vim.lsp.buf.remove_workspace_folder)
    keymap('n', '<space>ol', "List Workspace Folders", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    keymap('n', '<space>r', "Rename Symbol", vim.lsp.buf.rename)
    keymap("n", "<leader>s", "Open symbol picker", ":Telescope lsp_document_symbols<cr>")
    keymap("n", "<leader>S", "Open workspace symbol picker", ":Telescope lsp_workspace_symbols<cr>")

    -- LSP Pickers
    keymap({'n', 'v'}, "<leader>a", "Perform code action", require("actions-preview").code_actions)
    keymap("n", "<leader>D", "Open workspace diagnostic picker", ":Pick diagnostic<cr>")
    keymap("n", "<leader>d", "Open diagnostic picker", [[:Pick diagnostic scope="current"<cr>]])

    keymap('n', 'gr', "Buffer References", vim.lsp.buf.references)
    keymap('n', '<localleader>f', "Format Buffer", function()
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
