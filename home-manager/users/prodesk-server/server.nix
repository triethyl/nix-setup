{pkgs, ...}: {

  # General config.
  home = {
    username = "server";
    homeDirectory = "/home/server";
    stateVersion = "23.11";

    packages = with pkgs; [
      custom-neovim
      neovide
    ];
  };

  # Configure aesthetic.
  aesthetics = {
    enable = true;
    enableAllTargets = true;
    hasGui = false;
    theme = "oxocarbon";
  };

  # Enable features.
  features = {
    cli = {
      shells.nushell.enable = true;
      apps = {
        btop.enable = true;
        zellij.enable = true;
        lazygit.enable = true;
      };
      utils = {
        git.enable = true;
        ssh.enable = true;
      };
    };
    services = {
      udiskie.enable = true;
    };
  };
}
