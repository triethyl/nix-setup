{ config, lib, pkgs, ... }: let
  cfg = config.features.gui.desktops.niri.parts.hyprlock;
in {
  options.features.gui.desktops.niri.parts.hyprlock.enable = lib.mkEnableOption "hyprlock";
  config = lib.mkIf cfg.enable {
    home.packages = [(
      pkgs.writers.writeNuBin "nirilock" /*nu*/ ''
        niri msg action do-screen-transition --delay-ms 500
        systemctl suspend
        hyprlock
      ''
    )];
    programs.niri.settings.window-rules = [
      {
        matches = [{ title = "hyprlock"; }];
        draw-border-with-background = false;
      }
    ];
    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          monitor = "";
          path = "${config.aesthetics.wallpaper}";
          blur_passes = 0;
          blur_size = 5;
        };
        label = {
          text = "$TIME";
          font_size = 65;
          font_family = "Cantarell Bold";

          position = "0, 0";
          halign = "center";
          valign = "center";
        };
        input-field = {
          size = "250, 50";
          position = "0, -80";
          outline_thickness = 0;
          placeholder_text = "";
        };
      };
    };
  };
}
