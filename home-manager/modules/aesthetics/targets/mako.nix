{
  config,
  lib,
  ...
}: let
  cfg = config.aesthetics.targets.mako;
  aes = config.aesthetics;
in {
  options.aesthetics.targets.mako.enable = lib.mkOption {
    type = lib.types.bool;
    default = aes.enableAllTargets && aes.hasGui;
    description = "Whether to enable the aesthetics mako target.";
  };
  config = lib.mkIf (cfg.enable && config.services.mako.enable) {
    services.mako.settings = with aes.scheme; {
      background-color = "#${base00}";
      border-color = "#${base0C}";
      text-color = "#${base05}";
      progress-color = "over #${base02}";
      font = "${aes.font.name} ${aes.font.size.small}";
    };
  };
}
