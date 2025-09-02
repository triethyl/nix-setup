{pkgs, ...}: {
  home = {
    username = "culsans";
    homeDirectory = "/home/culsans";
    stateVersion = "23.11";

    packages = with pkgs; [
      tor-browser
      prismlauncher
      onlyoffice-desktopeditors
      calibre
      vintagestory
    ];
  };
  nixpkgs.config.permittedInsecurePackages = ["dotnet-runtime-wrapped-7.0.20" "dotnet-runtime-7.0.20"];
  aesthetics = {
    enable = true;
    enableAllTargets = true;
    hasGui = true;
    theme = "oxocarbon";
  };
  features = {
    gui = {
      apps = {
        foot.enable = true;
        librewolf.enable = true;
        qutebrowser.enable = true;
        vesktop.enable = true;
        mpv.enable = true;
      };
      bundles = {
        video.enable = true;
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
