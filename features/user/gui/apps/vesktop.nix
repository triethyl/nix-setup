{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.apps.vesktop;
in {
  options.features.gui.apps.vesktop.enable = lib.mkEnableOption "vesktop";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [(vesktop.override { withSystemVencord = false; })];
  };
}
