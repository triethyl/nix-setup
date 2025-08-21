{
  pkgs,
  inputs,
}:
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  plugins = with pkgs.vimPlugins; {
    dev.config = {
      pure = ./config;
      impure = "/home/culsans/Sync/setup/pkgs/custom-neovim/config";
    };
    start = [
      # Not lazy loaded.
      lz-n # Lazy loader
      nvim-treesitter.withAllGrammars # All treesitter grammars
      vim-nix # Indentation for nix files
    ];
    opt = [
      # Lazy loaded.

      # UI Plugins
      mini-clue
      mini-pick
      mini-statusline
      mini-files
      mini-extra
      plenary-nvim
      nvim-colorizer-lua
      heirline-nvim

      # Completion Plugins
      blink-cmp
      luasnip
      friendly-snippets

      # Utility Plugins
      mini-pairs
      comment-nvim

      # Git Plugins
      mini-git
      mini-diff
      neogit

      # Colorschemes
      mini-base16
      nightfox-nvim
      vim-gruvbox8
    ];
  };
  luaFiles = [./config/init.lua];
  extraBinPath = with pkgs; [
    # LSP Servers
    lua-language-server

    # Extra Utils
    ripgrep
    gcc
    fd
  ];
}
