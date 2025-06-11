{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.features.gui.desktops.niri;
  aes = config.aesthetics;
in {
  imports = [
    inputs.niri.homeModules.niri
    ./keybinds.nix
  ];
  options.features.gui.desktops.niri.enable = lib.mkEnableOption "niri";
  config = lib.mkIf cfg.enable {
    features.gui.desktops.niri.parts = {
      waybar.enable = true;
      fuzzel.enable = true;
      selectors.enable = true;
      swww.enable = true;
      mako.enable = true;
      ignis.enable = true;
      hyprlock.enable = true;
    };
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.system}.niri-unstable;
      settings = {
        outputs = {
          "Samsung Electric Company SAMSUNG 0x00000001" = {
            enable = true;
            scale = 1.5;
          };
        };
        spawn-at-startup = [
          # Status Bar
          {command = ["waybar"];}

          # Wallpaper Daemon
          {command = ["swww-daemon"];}

          # Allows x apps to be used in wayland.
          {command = ["${lib.getExe pkgs.xwayland-satellite}"];}

          # Logs the clipboard for use in utilities.
          {command = ["${pkgs.wl-clipboard}/bin/wl-paste" "--watch" "${pkgs.cliphist}/bin/cliphist" "store"];}
        ];
        environment = {
          DISPLAY = ":0"; # Important for Xwayland.
        };
        window-rules = [
          {
            geometry-corner-radius = let
              radius = 4.0;
            in {
              top-left = radius;
              top-right = radius;
              bottom-left = radius;
              bottom-right = radius;
            };
            clip-to-geometry = true;
            default-column-width.proportion = 1. / 3.;
          }
          {
            # Prevent Tor from being screen captured.
            matches = [{app-id = "Tor Browser";}];
            block-out-from = "screen-capture";
          }
        ];
        switch-events = {
          lid-close.action.spawn = ["hyprlock"];
        };
        prefer-no-csd = true;
        overview = {
          backdrop-color = "#${aes.scheme.base01}";
        };
        layout = {
          gaps = 14;
          insert-hint.enable = false;
          shadow = {
            enable = true;
            softness = 10;
            spread = 5;
            offset = {
              x = 0;
              y = 0;
            };
          };
          focus-ring = {
            enable = true;
            width = 3;
            active.color = "#${aes.scheme.base09}";
          };
          border = {
            enable = false;
            width = 3;
            inactive.color = "#${aes.scheme.base03}";
            active.color = "#${aes.scheme.base08}";
          };
          struts = {
            # left = -1;
            # right = -1;

            left = 20;
            right = 20;
            top = 20;
            bottom = 20;
          };
          always-center-single-column = false;
          empty-workspace-above-first = true;
        };
        input.keyboard.xkb.options = ''
          caps:escape,
          compose:ins
        '';
        hotkey-overlay.skip-at-startup = true;
        input = {
          touchpad = {
            click-method = "clickfinger";
          };
        };
      };
    };
  };
}
