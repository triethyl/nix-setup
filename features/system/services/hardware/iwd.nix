{ config, pkgs, lib, ... }: let
  cfg = config.features.services.hardware.iwd;
in {
  options.features.services.hardware.iwd.enable = lib.mkEnableOption "iwd";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.impala ];
    networking.wireless.iwd = {
      enable = true;
      settings = {
        IPv6 = {
          Enabled = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };
}
