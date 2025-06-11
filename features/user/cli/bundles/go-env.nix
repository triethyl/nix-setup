{ config, pkgs, lib, ... }: let
  cfg = config.features.cli.bundles.go-env;
in {
  options.features.cli.bundles.go-env.enable = lib.mkEnableOption "go-env";
  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GOPATH = "~/.go";
    };
    home.packages = with pkgs; [
      go
      gopls
    ];
  };
}
