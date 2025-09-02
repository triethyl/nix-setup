{
  config,
  lib,
  ...
}: let
  cfg = config.features.services.extra.udisks2;
in {
  options.features.services.extra.udisks2.enable = lib.mkEnableOption "udisks2";
  config = lib.mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
