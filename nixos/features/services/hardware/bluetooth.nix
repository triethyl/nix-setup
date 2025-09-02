{ config, pkgs, lib, ... }: let
  cfg = config.features.services.hardware.bluetooth;
in {
  options.features.services.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.bluetui ];
    services.blueman = {
      enable = true;
    };
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.pulseaudio = {
      package = pkgs.pulseaudioFull;
    };
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
