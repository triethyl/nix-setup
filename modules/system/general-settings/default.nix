{ config, pkgs, lib, ... }: let
  cfg = config.general-settings;
in {
  options.general-settings = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "system hostname";
    };
    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "system locale";
    };
    timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/New_York";
      description = "system timezone";
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "24.11";
      description = "nixos stateversion";
    };
  };
  config = {
    environment.systemPackages = [ pkgs.home-manager ];
    system.stateVersion = cfg.stateVersion;
    nixpkgs.config.allowUnfree = true;
    networking.hostName = cfg.hostname;
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.locale;
      LC_IDENTIFICATION = cfg.locale;
      LC_MEASUREMENT = cfg.locale;
      LC_MONETARY = cfg.locale;
      LC_NAME = cfg.locale;
      LC_NUMERIC = cfg.locale;
      LC_PAPER = cfg.locale;
      LC_TELEPHONE = cfg.locale;
      LC_TIME = cfg.locale;
    };
  };
}
