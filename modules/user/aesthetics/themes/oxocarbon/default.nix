{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.aesthetics.themes.oxocarbon;
in {
  options.aesthetics.themes.oxocarbon.enable = lib.mkEnableOption "oxocarbon theme";
  config = lib.mkMerge [
    (
      lib.mkIf cfg.enable {
        aesthetics = {
          wallpaper = ./wallpapers/landscape/salt-flats.jpg;
          wallpapersDir = ./wallpapers;
          scheme = {
            base00 = "161616";
            base01 = "262626";
            base02 = "393939";
            base03 = "525252";
            base04 = "dde1e6";
            base05 = "f2f4f8";
            base06 = "ffffff";
            base07 = "08bdba";
            base08 = "3ddbd9";
            base09 = "78a9ff";
            base0A = "ee5396";
            base0B = "33b1ff";
            base0C = "ff7eb6";
            base0D = "42be65";
            base0E = "be95ff";
            base0F = "82cfff";
          };
          font = {
            name = "CodeNewRoman Nerd Font";
            package = pkgs.nerd-fonts.code-new-roman;
          };
          # font = {
          #   name = "Kirsch Nerd Font";
          #   size = "22";
          #   package = inputs.kirsch.packages.x86_64-linux.kirsch-nerd;
          # };
        };
        # home.pointerCursor = {
        #   package = pkgs.oreo-cursors-plus;
        #   name = "oreo_spark_black_bordered_cursors";
        #   size = 22;
        # };
        home.pointerCursor = {
          package = pkgs.qogir-icon-theme;
          name = "Qogir-Dark";
          size = 22;
        };
      }
    )
    (
      lib.mkIf config.aesthetics.targets.helix.enable {
        aesthetics.targets.helix.theme = "oxocarbon";
        home.file."helix-oxocarbon-theme" = {
          target = ".config/helix/themes/oxocarbon.toml";
          source = ./helix-theme.toml;
        };
      }
    )
  ];
}
