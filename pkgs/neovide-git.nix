{pkgs}:
pkgs.neovide.overrideAttrs (old: {
  version = "git";
  src = pkgs.fetchFromGitHub {
    owner = "neovide";
    repo = "neovide";
    rev = "627956990b4d85a2a98a13e0c50da2155d15cd72";
    sha256 = "sha256-WwLEL6GyLLPbGEJrpSRLTJr+CqevZZ5MBZNUbXLWn3I=";
  };
})
