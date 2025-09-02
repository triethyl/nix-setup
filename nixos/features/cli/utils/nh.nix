{ config, lib, ... }: let
  cfg = config.features.cli.utils.nh;
in {
  options.features.cli.utils.nh = {
    enable = lib.mkEnableOption "nh";
    flake = lib.mkOption {
      type = lib.types.str;
      description = "Absolute path to the flake.";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = cfg.flake;
    };
  };
}
