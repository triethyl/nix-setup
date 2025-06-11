{ config, lib, ... }: let
  cfg = config.features.services.bundles.printing;
in {
  options.features.services.bundles.printing.enable = lib.mkEnableOption "printing";
  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
