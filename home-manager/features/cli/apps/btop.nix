{ config, lib, ... }: let
  cfg = config.features.cli.apps.btop;
in {
  options.features.cli.apps.btop.enable = lib.mkEnableOption "btop";
  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        update_ms = 500;
      };
    };
  };
}
