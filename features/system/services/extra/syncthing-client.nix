{ config, pkgs, lib, ... }: let
  cfg = config.features.services.extra.syncthing-client;
in {
  options.features.services.extra.syncthing-client = {
    enable = lib.mkEnableOption "syncthing"; 
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of syncthing's user";
    };
  };
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = cfg.username;
      dataDir = "/home/${cfg.username}/Sync";
      configDir = "/home/${cfg.username}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "prodesk-server" = { 
	          id = "SBH4S2T-B7KVAAI-BKBOQKZ-YSNQDSM-TKXPV6O-OSZUD3O-N6USL6L-DHL3BAK"; 
	        };
        };
        folders = {
          "Main" = {
            path = "/home/${cfg.username}/Sync";
  	        devices = [ "prodesk-server" ];
          };
        };
      };
    };
    environment.systemPackages = [ pkgs.syncthing ];
  };
}
