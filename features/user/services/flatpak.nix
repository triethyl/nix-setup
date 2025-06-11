{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.features.services.flatpak;
in {
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  options.features.services.flatpak = {
    enable = lib.mkEnableOption "flatpak";
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "A list of flatpaks to install.";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.flatpak];
    services.flatpak = {
      enable = true;
      packages = cfg.packages;
      overrides.global.Context.sockets = ["wayland" "!x11" "!fallback-x11"];
    };
  };
}
