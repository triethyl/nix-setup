{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.bundles.video;
in {
  options.features.gui.bundles.video.enable = lib.mkEnableOption "video";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive
    ];
    features.gui.apps.obs.enable = true;
  };
}
