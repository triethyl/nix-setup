{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.features.gui.apps.librewolf;
in {
  options.features.gui.apps.librewolf.enable = lib.mkEnableOption "librewolf";
  config = lib.mkIf cfg.enable {
    # programs.librewolf = {
    #   enable = true;
    #   settings = {
    #     "browser.tabs.inTitlebar" = 0;
    #   };
    # };
    home.packages = [ pkgs.librewolf-bin ];
  };
}
