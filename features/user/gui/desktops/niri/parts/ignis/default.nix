{ config, pkgs, lib, inputs, ... }: let
  cfg = config.features.gui.desktops.niri.parts.ignis;
in {
  options.features.gui.desktops.niri.parts.ignis.enable = lib.mkEnableOption "ignis";
  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.ignis.packages.${pkgs.system}.ignis
      pkgs.python3
    ];
    # home.file."ignis-config" = {
    #   target = ".config/ignis/config.py";
    #   src = ./config.py;
    # };
    # home.file."ignis-style" = {
    #   target = ".config/ignis/style.scss";
    #   text = /*scss*/ ''
          
    #   '';
    # };
  };
}
