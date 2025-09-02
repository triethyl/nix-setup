{ config, lib, ... }: let
  cfg = config.aesthetics.targets.zellij;
  aes = config.aesthetics;
in {
  options.aesthetics.targets.zellij.enable = lib.mkOption {
    type = lib.types.bool;
    default = aes.enableAllTargets;
    description = "Whether to enable the aesthetics zellij target.";
  };
  config = lib.mkIf (cfg.enable && config.programs.zellij.enable) { 
    programs.zellij.settings = {
      theme = "base16";
      themes.base16 = with aes.scheme; {
        bg = "#${base03}";
        fg = "#${base05}";
        red = "#${base08}";
        green = "#${base0B}";
        blue = "#${base0D}";
        yellow = "#${base0A}";
        magenta = "#${base0E}";
        orange = "#${base09}";
        cyan = "#${base0C}";
        black = "#${base00}";
        white = "#${base07}";
      };
    };
  };
}
