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
  namu-nvim-git = pkgs.vimUtils.buildVimPlugin {
    name = "namu-nvim";
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "bassamsdata";
      repo = "namu.nvim";
      tag = "v0.6.0";
      sha256 = "sha256-ywKb/VVNSa/LtiQaSO2lqff2ujupIcc9P9AJg/p6mKw=";
    };
  };
  profile-nvim-git = pkgs.vimUtils.buildVimPlugin {
    name = "profiler-nvim";
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "profile.nvim";
      rev = "30433d7513f0d14665c1cfcea501c90f8a63e003";
      sha256 = "sha256-2Mk6VbC+K/WhTWF+yHyDhQKJhTi2rpo8VJsnO7ofHXs=";
    };
  };
}
