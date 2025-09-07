{config, lib, ...}: let
  cfg = config.homelab.core.caddy;
in {
  options.homelab.core.caddy = {
    enable = lib.mkEnableOption "caddy";
  };
  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      email = "culsans@vivaldi.net";
      virtualHosts = {
        "culsans.site".extraConfig = ''
          respond "Hello"
        '';
      };
    };
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
