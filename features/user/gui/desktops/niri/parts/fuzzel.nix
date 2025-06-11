{ config, lib, ... }: let
  cfg = config.features.gui.desktops.niri.parts.fuzzel;
  aes = config.aesthetics;
in {
  options.features.gui.desktops.niri.parts.fuzzel.enable = lib.mkEnableOption "fuzzel";
  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          width = 20;
          #terminal = config.custom.libraries.default-applications.terminal-emulator.command;
        };
        border = {
          width = 3;
          radius = 4;
        };
        colors = with aes.scheme; {
          background = "${base00}ff";
          selection = "${base00}ff";
          selection-text = "${base0C}ff";
          selection-match = "${base0E}ff";
          match = "${base0E}ff";
          border = "${base0C}ff";
          text = "${base05}ff";
        };
      };
    };
  };
}
