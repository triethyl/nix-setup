{ config, lib, ... }: let
  cfg = config.features.cli.utils.git;
in {
  options.features.cli.utils.git.enable = lib.mkEnableOption "git";
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = "culsans@vivaldi.net";
      userName = "culsans";
    };
  };
}
