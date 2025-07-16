{
  pkgs,
  inputs,
}: let
  git-plugins = import ./git-plugins.nix {inherit pkgs;};
in
  inputs.mnw.lib.wrap pkgs {
    neovim = pkgs.neovim-unwrapped;
    plugins = with pkgs.vimPlugins; {
      dev.config = {
        pure = ./config;
      };
      start = [
        # Core Plugins
        mini-nvim # Ton of small modules.
        nvim-lspconfig # Adds lsp presets.
        actions-preview-nvim # Adds a selector for LSP actions.
        nvim-treesitter.withAllGrammars # All treesitter grammars.
        tabby-nvim # Tab bar.
        lualine-nvim # Status line.
        # plenary-nvim # General Library.
        # plenary-nvim-git
        alpha-nvim # Dashboard.
        persisted-nvim # Session manager.
        git-plugins.which-key-nvim-git
        snacks-nvim

        # Colorschemes
        oxocarbon-nvim # IBM Carbon themes.
        rose-pine # Rose Pine themes.
        kanagawa-nvim # Kanagawa themes.
        everforest # Green themes.
        nordic-nvim # Warm dark nordic theme.
        tokyonight-nvim
        nightfox-nvim

        # Miscellaneous Plugins
        presence-nvim # Discord RPC for nvim.
        cellular-automaton-nvim # Fun useless plugin.
        vim-wakatime # For hack club challenge.
      ];
      opt = [];
    };

    luaFiles = [./config/init.lua];

    extraBinPath = with pkgs; [
      # LSP Servers
      lua-language-server # Lua LS
      nixd # Nix LS
      nil
      marksman # Markdown LS

      # Formatters
      alejandra # Nix Formatter

      # Extra Tools
      ripgrep
      fd

      wakatime-cli
    ];
  }
