{ config, lib, ... }: let
  cfg = config.features.services.hardware.networkmanager;
in {
  options.features.services.hardware.networkmanager.enable = lib.mkEnableOption "networkmanager";
  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
