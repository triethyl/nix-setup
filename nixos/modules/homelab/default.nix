{config, pkgs, lib, ...}: let
  cfg = config.homelab;
in {
  imports = [
    ./core
    ./cloud
  ];
  options.homelab = {
    enable = lib.mkEnableOption "homelab";
  };
}
