return {
  {
    -- when in doubt, this plugin is the cause of cpu issues.
    "blink.cmp",
    -- enabled = false,
    lazy = true,
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    after = function()
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- vim.cmd.packadd("luasnip")
      -- vim.cmd.packadd("friendly-snippets")

      require("blink.cmp").setup {
        -- snippets = { preset = 'luasnip' },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
      }

    end,
  },
}
