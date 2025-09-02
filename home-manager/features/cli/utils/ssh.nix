{ config, lib, ... }: let
  cfg = config.features.cli.utils.ssh;
in {
  options.features.cli.utils.ssh.enable = lib.mkEnableOption "ssh";
  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "culsans.site" = {
          hostname = "culsans.site";
          user = "server";
          port = 2200;
        };
        "git.culsans.site" = {
          hostname = "culsans.site";
        };
      };
    };
  };
}
