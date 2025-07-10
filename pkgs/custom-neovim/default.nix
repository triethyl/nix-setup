{
  pkgs,
  inputs,
}: let
  plenary-nvim-git = pkgs.vimPlugins.plenary-nvim.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "emmanueltouzery";
      repo = "plenary.nvim";
      rev = "7750bc895a1f06aa7a940f5aea43671a74143be0";
      sha256 = "sha256-9Un7ekhBxcnmFE1xjCCFTZ7eqIbmXvQexpnhduAg4M0=";
    };
  }); # go back to regular plenary when this commit is merged: https://github.com/nvim-lua/plenary.nvim/pull/649
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
        telescope-nvim # Picker.
        # plenary-nvim # General Library.
        plenary-nvim-git
        alpha-nvim # Dashboard.
        persisted-nvim # Session manager.

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

    luaFiles = [./config/init.lua];

    extraBinPath = with pkgs; [
      # LSP Servers
      lua-language-server # Lua LS
      nixd # Nix LS
      marksman # Markdown LS

      # Formatters
      alejandra # Nix Formatter

      # Extra Tools
      ripgrep
      fd
    ];
  }
