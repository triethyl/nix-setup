{config, pkgs, lib, ...}: let
  cfg = config.homelab;
in {
  imports = [
    ./core
    ./cloud
    ./dev
  ];
  options.homelab = {
    enable = lib.mkEnableOption "homelab";
  };
}
