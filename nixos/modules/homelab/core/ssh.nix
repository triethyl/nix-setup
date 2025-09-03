{config, lib, ...}: let
  cfg = config.homelab.core.ssh;
in {
  options.homelab.core.ssh = {
    enable = lib.mkEnableOption "ssh";
  };
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
