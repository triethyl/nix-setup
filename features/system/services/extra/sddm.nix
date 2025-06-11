{ config, pkgs, lib, ... }: let
  cfg = config.features.services.extra.sddm;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      # Background = ./background.png;
    };
  };
in {
  options.features.services.extra.sddm.enable = lib.mkEnableOption "sddm";
  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = [ sddm-astronaut ];
      };
      # xserver.enable = true;
    };
    environment.systemPackages = [ sddm-astronaut ];
  };
}
