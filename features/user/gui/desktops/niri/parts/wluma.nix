{ config, lib, ... }: let
  cfg = config.features.gui.desktops.niri.parts.wluma;
in {
  options.features.gui.desktops.niri.parts.wluma.enable = lib.mkEnableOption "wluma";
  config = lib.mkIf cfg.enable {
    services.wluma = {
      enable = true;
      systemd.enable = true;
    };
  };
}
