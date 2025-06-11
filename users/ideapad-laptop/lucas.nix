{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "lucas";
    homeDirectory = "/home/lucas";
    stateVersion = "23.11";

    packages = with pkgs; [
      tor-browser
      onlyoffice-desktopeditors
      calibre

      # My custom neovim package.
      custom-neovim
      neovide
    ];
  };
  aesthetics = {
    enable = true;
    enableAllTargets = true;
    hasGui = true;
    theme = "oxocarbon";
  };
  programs.helix.package = lib.mkForce pkgs.helix; # Building helix takes too much power
  features = {
    gui = {
      apps = {
        foot.enable = true;
        librewolf.enable = true;
        qutebrowser.enable = true;
      };
      desktops.niri.enable = true;
    };
    cli = {
      shells.nushell.enable = true;
      apps = {
        btop.enable = true;
        helix.enable = true;
        zellij.enable = true;
      };
      utils = {
        git.enable = true;
        pandoc.enable = true;
        ssh.enable = true;
      };
      bundles = {
        go-env.enable = true;
      };
      scripts = {
        spiral.enable = true;
      };
    };
    services = {
      udiskie.enable = true;
    };
  };
}
