{ config, pkgs, lib, ... }: let
  cfg = config.features.services.hardware.pipewire;
in {
  options.features.services.hardware.pipewire.enable = lib.mkEnableOption "pipewire";
  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    environment.systemPackages = [ pkgs.git ]; # Fixes a weird error
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
