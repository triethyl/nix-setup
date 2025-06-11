{ config, lib, ... }: let
  cfg = config.features.services.core.systemd-boot;
in {
  options.features.services.core.systemd-boot.enable = lib.mkEnableOption "systemd-boot";
  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
