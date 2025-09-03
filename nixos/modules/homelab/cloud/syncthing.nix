{config, pkgs, lib, ...}: let
  cfg = config.homelab.cloud.syncthing;
in {
  options.homelab.cloud.syncthing = {
    enable = lib.mkEnableOption "syncthing";
    user = lib.mkOption {
      type = lib.types.str;
      description = "The username of syncthing's user";
    };
  };
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = cfg.user;
      dataDir = "/home/${cfg.user}/Sync";
      configDir = "/home/${cfg.user}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "thinkpad-laptop" = { 
  	        id = "3Q4DMGC-SMMRYXG-UNQMGLK-74ST7NF-KVBAFXB-6D2LM2D-UEHBLVW-J2C2CAB"; 
  	      };
          "nzxt-desktop" = {
            id = "2TPKPXD-LO7OL7V-GP5HOUM-2P5SUEQ-XST4UYJ-S2Z56PP-IM66IIT-GLUNLAX";
          };
          # "samsung-tablet" = {
          #   id = "ZKL25GJ-TKM2E6Y-VQSBAW5-TVG7RWM-RRAUEVA-ZOJZNCM-F3ARZUU-TPK7CA6";
          # };
        };
        folders = {
          "Main" = {
            path = "/home/${cfg.user}/Sync";
  	        devices = [ "thinkpad-laptop" "nzxt-desktop" ];
  	      };
        };
      };
    };
    environment.systemPackages = [ pkgs.syncthing ];
    # Use this command to get id: syncthing cli show system | from json | get myID
  };
}
