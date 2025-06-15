{
  pkgs,
  inputs,
}:
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;

  plugins = with pkgs.vimPlugins; let
    tangerine-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "tangerine-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "udayvir-singh";
        repo = "tangerine.nvim";
        tag = "v2.9";
        hash = "sha256-C4QmsW83SxTn+eIkCMWDnd/Vdc9Mb7yD7a0bYSiIRJI=";
      };
    };
    hibiscus-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "hibiscus-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "udayvir-singh";
        repo = "hibiscus.nvim";
        tag = "v1.7";
        hash = "sha256-fjdwT2rdDZ6OF4SByMrcvFNXhF4lhBwzmTLhpwgOQ6o=";
      };
    };
  in {
    dev.config = {
      pure = ./config;
      impure = "/home/culsans/Sync/setup/pkgs/custom-neovim";
    };
    start = [
      tangerine-nvim # Allow configuration in fennel.
      hibiscus-nvim # Adds extra fennel macros.

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

  luaFiles = [./config/init.lua];

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
