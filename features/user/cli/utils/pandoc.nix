{ config, pkgs, lib, ... }: let
  cfg = config.features.cli.utils.pandoc;
in {
  options.features.cli.utils.pandoc.enable = lib.mkEnableOption "pandoc";
  config = lib.mkIf cfg.enable {
    programs.pandoc = {
      enable = true;
    };
    home.packages = with pkgs; [
      texliveSmall
    ];
  };
}
