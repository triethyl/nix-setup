{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.apps.foot;
in {
  options.features.gui.apps.foot.enable = lib.mkEnableOption "foot";
  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.pad = "0x4";
      };
    };
  };
}
