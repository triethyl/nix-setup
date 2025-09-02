{
  config,
  lib,
  ...
}: let
  cfg = config.features.gui.desktops.niri.parts.mako;
in {
  options.features.gui.desktops.niri.parts.mako.enable = lib.mkEnableOption "mako";
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        border-radius = 4;
        border-size = 3;
        # margin = "11";
        margin = "31";
        padding = "5";

        anchor = "top-center";

        ignore-timeout = true;
        default-timeout = 10000;
      };
    };
  };
}
