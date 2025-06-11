{ config, pkgs, lib, ... }: let
  cfg = config.features.cli.scripts.spiral;
in {
  options.features.cli.scripts.spiral.enable = lib.mkEnableOption "spiral";
  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.writers.writeNuBin "sp" (builtins.readFile ./spiral.nu))
    ];
  };
}
