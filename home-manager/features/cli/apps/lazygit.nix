{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.apps.lazygit;
in {
  options.features.cli.apps.lazygit.enable = lib.mkEnableOption "lazygit";
  config = lib.mkIf cfg.enable {
    programs.lazygit.enable = true;
  };
}
