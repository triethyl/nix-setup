{ config, lib, ... }: let
  cfg = config.features.server.ssh;
in {
  options.features.server.ssh.enable = lib.mkEnableOption "sshd";
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 2200 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  }; 
}
