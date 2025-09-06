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
    ];
    opt = [
      # Can be lazy loaded.

      # UI Plugins
      nvim-treesitter.withAllGrammars # All treesitter grammars
      mini-clue
      mini-pick
      mini-files
      mini-extra
      plenary-nvim # UI library
      markview-nvim # Previews for markdown and more
      actions-preview-nvim # Preview lsp actions

      # Completion Plugins
      blink-cmp
      luasnip
      friendly-snippets

      # Utility Plugins
      mini-pairs
      comment-nvim
      auto-session
      zoxide-vim
      vim-nix # Indentation for nix files
      calendar-vim

      # Git Plugins
      mini-git
      mini-diff
      neogit

      # Misc Plugins
      presence-nvim # Discord RPC for nvim.
      cellular-automaton-nvim # Fun useless plugin.

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
    marksman
    nixd

    # Extra Utils
    ripgrep
    gcc
    fd
  ];
}
