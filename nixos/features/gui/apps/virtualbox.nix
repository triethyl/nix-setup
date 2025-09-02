{ config, lib, ... }: let
  cfg = config.features.gui.apps.virtualbox;
in {
  options.features.gui.apps.virtualbox.enable = lib.mkEnableOption "virtualbox";
  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
  };
}
