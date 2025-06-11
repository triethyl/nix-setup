{ config, pkgs, lib, ... }: 
let 
  cfg = config.features.gui.desktops.niri.parts.waybar;
  aes = config.aesthetics;
in {
  options.features.gui.desktops.niri.parts.waybar.enable = lib.mkEnableOption "waybar";
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        bar = {
          layer = "top";
          position = "bottom";
          height = 32;
          modules-left = [ "battery" "network" "backlight" "pulseaudio" ];
          modules-center = [ "niri/workspaces" ];
          modules-right = [ "clock#date" "clock#time" ];
          "clock#date" = {
            format = " {:%A, %B %d}";
          };
          "clock#time" = {
            format = "  {:%I:%M}";
          };
          pulseaudio = {
            format = " {volume}%";
            format-muted = " {volume}%";
          };
          network = {
            format = "{essid}";
            format-wifi = "{icon} {essid}";
            format-ethernet = "󰈀 Ethernet";
            format-disconnected = "󰤭 Disconnected";
            format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          };
          battery = {
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          backlight = {
            format = " {percent}%";
          };
          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              default = "";
              active = "";
              /*
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
              "11" = "11";
              "12" = "12";
              */
            };
          };
        };
      };
      style = let
        border-radius = "4";
        padding = "12";
      in /*css*/ ''
        @define-color background-color #${aes.scheme.base00}; 
        @define-color border-color #${aes.scheme.base0C};
        @define-color text-color #${aes.scheme.base05};
        * {
          font-family: ${aes.font.name};
          font-weight: 600;
          font-size: ${aes.font.size.medium}px;
        }
        window#waybar {
          background-color: transparent;
        }
        #clock.time, #clock.date, #backlight, #pulseaudio, #battery, #network {
          background-color: @background-color;
          color: @text-color;
          border-radius: ${border-radius}px;
          border-width: 0px;
          border-color: @border-color;
          padding: 0px ${padding}px;
        }
        #backlight, #pulseaudio, #battery, #network {
          margin: 0px 0px ${padding} ${padding};
        }
        #workspaces {
          background-color: @background-color;
          color: @background-color;
          border-radius: ${border-radius}px;
          border-width: 0px;
          border-color: @border-color;
          padding: 0px 0px;
          margin-bottom: ${padding}px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 4px;
          margin: 4px 4px;
          border-radius: ${border-radius}px;
          color: @background-color;
          background: @text-color;
          opacity: 0.5;
          transition: all 0.3s cubic-bezier(.25,.1,.25,1);
        }
        #workspaces button.active {
          font-weight: bold;
          padding: 0px 4px;
          margin: 4px 4px;
          border-radius: ${border-radius}px;
          color: @background-color;
          background: @text-color;
          transition: all 0.3s cubic-bezier(.25,.1,.25,1);
          opacity: 1.0;
          min-width: 40px;
        }
        #workspaces button:hover {
          font-weight: bold;
          border-radius: ${border-radius}px;
          color: @background-color;
          background: @text-color;
          opacity: 0.8;
          transition: all 0.3s cubic-bezier(.25,.1,.25,1);
        }
        #clock.date, #clock.time {
          margin: 0px ${padding} ${padding} 0px
        }
      '';
    };
  };
}
