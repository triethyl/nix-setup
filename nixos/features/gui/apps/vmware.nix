{ config, lib, ... }: let
  cfg = config.features.gui.apps.vmware;
in {
  options.features.gui.apps.vmware.enable = lib.mkEnableOption "vmware";
  config = lib.mkIf cfg.enable {
    virtualisation.vmware.host.enable = true;
  };
}
