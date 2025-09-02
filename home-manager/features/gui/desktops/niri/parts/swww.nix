{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.desktops.niri.parts.swww;
in {
  options.features.gui.desktops.niri.parts.swww.enable = lib.mkEnableOption "swww";
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.swww];
  };
}
