{config, pkgs, lib, ...}: let
  cfg = config.homelab.cloud.syncthing;
in {
  options.homelab.cloud.syncthing = {
    enable = lib.mkEnableOption "syncthing";

  };
}
