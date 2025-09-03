{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.features.gui.apps.steam;
in {
  options.features.gui.apps.steam.enable = lib.mkEnableOption "steam";
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    hardware.steam-hardware.enable = true;
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [
      mangohud
      winetricks
      wine-wayland
    ];

    # Steam Launch Options
    # Add this to 3D games:
    # LD_PRELOAD="" gamescope --force-grab-cursor --backend sdl -bf -W 1600 -H 900 -- %command%
    # Add this to 2D games:
    # LD_PRELOAD="" gamescope -bf -W 1600 -H 900 -- %command%
  };
}
