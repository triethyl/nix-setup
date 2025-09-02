{ config, lib, ... }: let
  cfg = config.features.services.udiskie;
in {
  options.features.services.udiskie.enable = lib.mkEnableOption "udiskie";
  config = lib.mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
    };
    systemd.user.targets.tray = {
		  Unit = {
			  Description = "Home Manager System Tray";
			  Requires = [ "graphical-session-pre.target" ];
		  };
    };
  }; 
}
