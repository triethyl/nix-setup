return {
  {
    "blink.cmp",
    lazy = true,
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    before = function()
      require("lz.n").trigger_load("luasnip")
    end,
    after = function()
      require("blink.cmp").setup {
        snippets = { preset = 'luasnip' },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        cmdline = {
          keymap = { preset = 'inherit' },
          completion = { menu = { auto_show = true } },
        },
      }
    end,
  },
  {
    "luasnip",
    lazy = true,
    before = function ()
      vim.cmd.packadd("friendly-snippets")
    end,
    after = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  }
}
