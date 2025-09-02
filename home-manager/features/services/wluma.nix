{ config, pkgs, lib, ... }: let
  cfg = config.features.services.wluma;
in {
  options.features.services.wluma.enable = lib.mkEnableOption "wluma";
  config = lib.mkIf cfg.enable {
    services.wluma = {
      enable = true;
      systemd.enable = true;
    };
  };
}
