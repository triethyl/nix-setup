{ config, pkgs, lib, ... }: let
  cfg = config.aesthetics;
in {
  options.aesthetics = {
    enable = lib.mkEnableOption "aesthetics";
    theme = lib.mkOption {
      type = lib.types.str;
      description = "The name of the theme to use.";
      default = "oxocarbon";
    };
    hasGui = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to theme gui apps. (can break if no gui)";
      default = false;
    };
    enableAllTargets = lib.mkEnableOption "all targets";
    wallpapersDir = lib.mkOption {
      type = lib.types.path;
      description = "Where to find wallpapers.";
    };
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Where to find the default wallpaper.";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "CodeNewRoman Nerd Font";
        description = "The font to use.";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nerd-fonts.code-new-roman;
        description = "The font package to use.";
      };
      size = {
        small = lib.mkOption {
          type = lib.types.str;
          default = "10";
          description = "The size of the font to use for small text. (e.g. terminals)";
        };
        medium = lib.mkOption {
          type = lib.types.str;
          default = "14";
          description = "The size of the font to use for medium text. (e.g. waybar)";
        };
        large = lib.mkOption {
          type = lib.types.str;
          default = "18";
          description = "The size of the font to use for large text.";
        };        
      };
    };
    scheme = let
      mkHexOption = {}: lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "ffffff";
        description = "A hex color";
      };
    in {
      base00 = mkHexOption {};
      base01 = mkHexOption {};
      base02 = mkHexOption {};
      base03 = mkHexOption {};
      base04 = mkHexOption {};
      base05 = mkHexOption {};
      base06 = mkHexOption {};
      base07 = mkHexOption {};
      base08 = mkHexOption {};
      base09 = mkHexOption {};
      base0A = mkHexOption {};
      base0B = mkHexOption {};
      base0C = mkHexOption {};
      base0D = mkHexOption {};
      base0E = mkHexOption {};
      base0F = mkHexOption {};
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      description = "Opacity";
      default = 1.0;
    };
  };
  config = lib.mkIf cfg.enable {
    aesthetics.themes.${cfg.theme}.enable = true;

    home.packages = [ cfg.font.package ];
    fonts.fontconfig.enable = true;
  };
}
