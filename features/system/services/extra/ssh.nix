{ config, lib, ... }: let
  cfg = config.features.services.extra.ssh;
in {
  options.features.services.extra.ssh.enable = lib.mkEnableOption "ssh";
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
