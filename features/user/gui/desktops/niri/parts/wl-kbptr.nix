{ config, lib, pkgs, inputs, ... }: let
  cfg = config.features.gui.desktops.niri.parts.wl-kbptr;
in {
  options.features.gui.desktops.niri.parts.wl-kbptr.enable = lib.mkEnableOption "wl-kbptr";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wl-kbptr ];
    home.file."wl-kbptr-config" = {
      target = ".config/wl-kbptr/config";
      text = ''
        
      '';
    };
  };
}
