{ config, lib, ... }: let
  cfg = config.aesthetics.targets.helix;
  aes = config.aesthetics;
in {
  options.aesthetics.targets.helix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = aes.enableAllTargets;
      description = "Whether to enable the aesthetics helix target.";
    };
    theme = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "The name of the theme to use for helix.";
    };
  };
  config = lib.mkIf (cfg.enable && config.programs.helix.enable) {
    programs.helix.settings.theme = "custom-default";
    home.file."helix-theme" = {
      target = ".config/helix/themes/custom-default.toml";
      text = /*toml*/ ''
        inherits = "${cfg.theme}"
        "ui.background" = { }
        "ui.statusline" = { bg = "" }
      '';
    };
  };
}
