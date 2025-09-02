{ config, lib, inputs, ... }: let
  cfg = config.features.gui.desktops.niri;
in {
  imports = [ inputs.niri.nixosModules.niri ];
  options.features.gui.desktops.niri.enable = lib.mkEnableOption "niri";
  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
