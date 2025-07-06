{
  pkgs,
  inputs,
}:
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;

  plugins = with pkgs.vimPlugins; {
    dev.config = {
      pure = ./nvim;
    };
    start = [
      # Core Plugins
      mini-nvim # Ton of small modules.
      nvim-lspconfig # Adds lsp presets.
      # actions-preview-nvim # Adds a selector for LSP actions.
      nvim-treesitter.withAllGrammars # All treesitter grammars.
      # tabby-nvim # Tab bar.
      # friendly-snippets # Extra snippets.

      # Colorschemes
      oxocarbon-nvim # IBM Carbon themes.
      rose-pine # Rose Pine themes.
      kanagawa-nvim # Kanagawa themes.
      everforest # Green themes.
      nordic-nvim # Warm dark nordic theme.

      # Miscellaneous Plugins
      presence-nvim # Discord RPC for nvim.
      cellular-automaton-nvim # Fun useless plugin.
    ];
    opt = [];
  };

  # luaFiles = [./config/init.lua];

  extraLuaPackages = lua:
    with lua; [
      fennel
    ];

  extraBinPath = with pkgs; [
    # LSP Servers
    lua-language-server # Lua LS
    fennel-ls # Fennel LS
    nixd # Nix LS
    marksman # Markdown LS

    # Formatters
    alejandra # Nix Formatter

    # Extra Tools
    ripgrep
  ];
}
