{ config, lib, ... }: let
  cfg = config.features.gui.apps.obs;
in {
  options.features.gui.apps.obs.enable = lib.mkEnableOption "obs";
  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
