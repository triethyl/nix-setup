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
    ];
    opt = [
      # Lazy loaded.
      mini-clue
      mini-pick
      mini-statusline
      mini-files
      mini-extra
      comment-nvim
      vim-nix
      nightfox-nvim
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
