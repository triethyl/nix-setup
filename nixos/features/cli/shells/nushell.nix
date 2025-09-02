{ config, pkgs, lib, ... }: let
  cfg = config.features.cli.shells.nushell;
in {
  options.features.cli.shells.nushell.enable = lib.mkEnableOption "nushell";
  config = lib.mkIf cfg.enable {
    environment.shells = [ pkgs.nushell ];
    users.defaultUserShell = pkgs.nushell;
    environment.systemPackages = [ pkgs.nushell ];
  };
}
