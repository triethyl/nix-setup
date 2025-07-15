{pkgs, ...}: {
  plenary-nvim-git = pkgs.vimPlugins.plenary-nvim.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "emmanueltouzery";
      repo = "plenary.nvim";
      rev = "7750bc895a1f06aa7a940f5aea43671a74143be0";
      sha256 = "sha256-9Un7ekhBxcnmFE1xjCCFTZ7eqIbmXvQexpnhduAg4M0=";
    };
  }); # go back to regular plenary when this commit is merged: https://github.com/nvim-lua/plenary.nvim/pull/649
  which-key-nvim-git = pkgs.vimPlugins.which-key-nvim.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "cameronr";
      repo = "which-key.nvim";
      rev = "ab1a3b0d3005a95507ba6c18b96531d430370885";
      sha256 = "sha256-Zbs+Xd6kGfR+s/f6xhxXBdKJA2N4WqcJDPWVkGaM7S0=";
    };
  }); # go back to regular which-key when this commit is merged: https://github.com/folke/which-key.nvim/pull/974
}
